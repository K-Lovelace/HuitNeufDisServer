class ArmoiresController < ApplicationController
  before_action :set_armoire, only: [:show, :update, :destroy]

  # GET /armoires
  # GET /armoires.json
  def index
    @armoires = Armoire.all
  end

  # GET /armoires/1
  # GET /armoires/1.json
  def show
  end

  # POST /armoires
  # POST /armoires.json
  def create
    @armoire = Armoire.new(armoire_params)

    if @armoire.save
      render :show, status: :created, location: @armoire
    else
      render json: @armoire.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /armoires/1
  # PATCH/PUT /armoires/1.json
  def update
    if @armoire.update(armoire_params)
      render :show, status: :ok, location: @armoire
    else
      render json: @armoire.errors, status: :unprocessable_entity
    end
  end

  # DELETE /armoires/1
  # DELETE /armoires/1.json
  def destroy
    @armoire.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_armoire
      @armoire = Armoire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def armoire_params
      params.fetch(:armoire, {})
    end
end
