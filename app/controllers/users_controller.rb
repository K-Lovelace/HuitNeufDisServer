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
    @user.commands = [Command.find('a6ba835f-6e15-4364-a6bd-28286de876eb')]
    result = []
    # Get all articles
    armoires = []
    article_ids = []
    @user.commands.each do |command|
      command.articles.each_with_rel do |article, requires|
        if !article_ids.include?(article.id)
          armoires << {
            node: article.cases.first.armoire,
            to_pick: {
              article: article,
              nb: requires.quantity_left,
              case: article.cases.first,
            }
          }
          article_ids << article.id
        else
          armoires[article_ids.index(article.id)][:to_pick][:nb] += requires.quantity_left
        end
      end
    end

    result = build_path(armoires)

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
      armoires.sort! {|a, b| a[:node] <=> b[:node]}
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
