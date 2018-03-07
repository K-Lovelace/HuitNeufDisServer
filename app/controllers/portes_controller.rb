class PortesController < ApplicationController
  before_action :set_porte, only: [:show, :update, :destroy]

  # GET /portes
  # GET /portes.json
  def index
    @portes = Porte.all
  end

  # GET /portes/1
  # GET /portes/1.json
  def show
  end

  # POST /portes
  # POST /portes.json
  def create
    @porte = Porte.new(porte_params)

    if @porte.save
      render :show, status: :created, location: @porte
    else
      render json: @porte.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /portes/1
  # PATCH/PUT /portes/1.json
  def update
    if @porte.update(porte_params)
      render :show, status: :ok, location: @porte
    else
      render json: @porte.errors, status: :unprocessable_entity
    end
  end

  # DELETE /portes/1
  # DELETE /portes/1.json
  def destroy
    @porte.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_porte
      @porte = Porte.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def porte_params
      params.fetch(:porte, {})
    end
end
