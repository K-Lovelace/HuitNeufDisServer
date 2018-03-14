class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :group_command]
  skip_before_action :verify_authenticity_token
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /group_command/1
  # GET /group_command/1.json
  # result
  #   Tableau d'éléments
  #     type
  #     id
  #     to_take
  #       number
  #       type
  #       id

  def group_command
    @user.get_commands!

    result = []
    armoires = []
    article_ids = []
    articles = []
    @user.commands.each do |command|
      command.articles.each_with_rel do |article, requires|
        if !article_ids.include?(article.id)
          articles << {
            article: article,
            nb: requires.quantity_left,
            quantity: requires.quantity_left
          }
          article_ids << article.id
        else
          articles[article_ids.index(article.id)][:nb] += requires.quantity_left
        end
      end
    end

    # Filter articles
    total_weight = 0.0
    articles.select do |article|
      art_weight = article[:article].weight * article[:nb]
      total_weight += art_weight
      total_weight <= @user.max_push
    end

    # Now we're sure that the user can get all the articles
    armoires_with_cases = []
    armoires_ids = []
    articles.each do |article|
      cases = article[:article].cases(:c).where("c.stock >= #{article[:nb]}").order('c.stock DESC').pluck(:c)
      if cases.length == 0
        nb_available = 0
        article[:article].cases.order('c.stock DESC').each do |c|
          break if nb_available + c.stock >= article[:nb]
          nb_taken += c.stock
          cases << c
        end
      end

      cases.each do |c|
        if !armoires_ids.include?(c.armoire.id)
          armoires_with_cases << {
            node: c.armoire,
            cases: [c]
          }
          armoires_ids << c.armoire.id
        else
          armoires_with_cases[armoires_ids.index(c.armoire.id)][:cases] << c
        end
      end
    end


    # Sort by nb_art and by node
    armoires_with_cases.sort! {|a,b|
      nb_art_a = a[:node].cases.match_to(a[:cases]).query_as(:c).match('(c)<-[:IN]-(a:Article)').with('DISTINCT a').with('COUNT(a) as nb_art').pluck('nb_art')
      nb_art_b = b[:node].cases.match_to(b[:cases]).query_as(:c).match('(c)<-[:IN]-(a:Article)').with('DISTINCT a').with('COUNT(a) as nb_art').pluck('nb_art')
      if nb_art_b == nb_art_a
        a[:node] <=> b[:node]
      else
        nb_art_b <=> nb_art_a
      end
    }

    # Take the first armoire as a reference: it's either the more interesting, or the closest
    armoire = armoires_with_cases.shift
    while armoires_with_cases.length > 0
      armoires << {
        node: armoire[:node],
        to_pick: armoire[:cases].map { |c|
          article = articles.select { |a| a[:article].id == c.article.id }.first
          quantity = article[:quantity] > c.stock ? c.stock : article[:quantity]
          return nil if quantity <= 0
          article[:quantity] -= c.stock
          {
            case: c,
            nb: article[:nb],
            article: article[:article]
          }
        }
      }

      # remove cases that contains articles that are already taken
      armoires_with_cases.delete_if do |a|
        a[:cases].reject! {|c| articles[articles.index { |art| art[:article].id == c.article.id }][:quantity] <= 0 }
        a[:cases].length == 0
      end

      # What is the next armoire?
      prev_armoire = nil
      next_armoire = nil
      armoires_with_cases.each do |a|
        if (a[:node] <=> armoire[:node]) == -1 # a is lower than armoire
          prev_armoire = a
        else
          next_armoire = a
          break
        end
      end

      if prev_armoire.nil?
        armoire = next_armoire
      elsif next_armoire.nil?
        armoire = prev_armoire
      else
        distance_prev = prev_armoire[:node].path_to(armoire[:node]).length
        distance_next = next_armoire[:node].path_to(armoire[:node]).length
        armoire = distance_prev <= distance_next ? prev_armoire : next_armoire
      end

      armoires_with_cases.delete(armoire)

      # break if armoire.nil?
    end
    result = build_path(armoires)
    # return render json: result
    result = result.map{|node|
      to_pick = nil
      unless node[:to_pick].nil?
        to_pick = []
        node[:to_pick].each do |a|
          to_pick << {
            id: a[:case].id,
            section: a[:case].section,
            stock: a[:case].stock,
            etagere: a[:case].etagere,
            url: case_url(a[:case]),
            article: {
              name: a[:article].name,
              id: a[:article].id,
              nb: a[:nb]
            }
          }
        end
      end

      {
        type: node[:node].class.name,
        name: node[:node].name,
        allee: node[:node].allee,
        id: node[:node].id,
        numero: node[:node].numero,
        to_pick: to_pick
      }
    }
    render json: result
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {}).permit(:name, :max_carry, :max_push)
    end


    def build_path(armoires)
      # sort armoire by allee
      sorted_armoires = armoires.sort {|a, b| a[:node] <=> b[:node]}
      armoires = []
      sorted_armoires.each do |a|
        armoires << {
          node: a[:node],
          to_pick: a[:to_pick]
        }
      end

      # find entry
      door = Porte.find_by(allee: armoires.first[:node].allee)
      door = Porte.find_by(allee: (armoires.first[:node].allee.ord-1).chr) unless door.entry
      result = [{
        node: door
      }]
      while armoires.length > 0
        node = result.last
        armoire = armoires.shift
        # return armoires
        path = node[:node].path_to(armoire[:node])

        path << armoire
        result += path
      end

      # find exit
      door = Porte.find_by(allee: result.last[:node].allee)
      door = Porte.find_by(allee: (result.last[:node].allee.ord+1).chr) if door.entry

      path = result.last[:node].path_to(door)

      path << {
        node: door
      }
      result += path

      result
    end
end
