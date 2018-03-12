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
    @user.commands = [Command.find('fc98003d-3d09-4c3e-9979-7d953bb336cd')]
    result = []
    # Get all articles
    articles = []
    article_ids = []
    @user.commands.each do |command|
      command.articles.each_with_rel do |article, requires|
        if !article_ids.include?(article.id)
          articles << {
            article: article,
            nb: requires.quantity_left,
            case: article.cases.first,
            armoire: article.cases.first.armoire
          }
          article_ids << article.id
        else
          articles[article_ids.index(article.id)][:nb] += requires.quantity_left
        end
      end
    end

    result = build_path(articles)

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


    def build_path(articles)
      result = []
      # sort articles by their closet
      articles.sort_by! {|article| [article[:armoire].allee, article[:armoire].numero]}
      # find entry
      door = Porte.find_by(allee: articles.first[:armoire].allee)
      door = Porte.find_by(allee: (articles.first[:armoire].allee.ord-1).chr) unless door.entry
      result.unshift(door)
      while articles.length > 0
        a = result.last
        b = articles.first
      end

      result
    end
end
