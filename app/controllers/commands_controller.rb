class CommandsController < ApplicationController
  before_action :set_command, only: [:show, :update, :destroy]

  # GET /commands
  # GET /commands.json
  def index
    @commands = Command.all
  end

  # GET /commands/1
  # GET /commands/1.json
  def show
  end

  # POST /commands
  # POST /commands.json
  def create
    @command = Command.new(command_params)

    if @command.save
      render :show, status: :created, location: @command
    else
      render json: @command.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /commands/1
  # PATCH/PUT /commands/1.json
  def update
    if @command.update(command_params)
      render :show, status: :ok, location: @command
    else
      render json: @command.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commands/1
  # DELETE /commands/1.json
  def destroy
    @command.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def command_params
      params.fetch(:command, {})
    end
end
