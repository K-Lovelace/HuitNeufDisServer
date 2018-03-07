class MarquagesController < ApplicationController
  before_action :set_marquage, only: [:show, :update, :destroy]

  # GET /marquages
  # GET /marquages.json
  def index
    @marquages = Marquage.all
  end

  # GET /marquages/1
  # GET /marquages/1.json
  def show
  end

  # POST /marquages
  # POST /marquages.json
  def create
    @marquage = Marquage.new(marquage_params)

    if @marquage.save
      render :show, status: :created, location: @marquage
    else
      render json: @marquage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marquages/1
  # PATCH/PUT /marquages/1.json
  def update
    if @marquage.update(marquage_params)
      render :show, status: :ok, location: @marquage
    else
      render json: @marquage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marquages/1
  # DELETE /marquages/1.json
  def destroy
    @marquage.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marquage
      @marquage = Marquage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marquage_params
      params.fetch(:marquage, {})
    end
end
