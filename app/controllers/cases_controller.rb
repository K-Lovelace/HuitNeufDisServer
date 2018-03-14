class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy, :take, :empty]

  # GET /cases
  # GET /cases.json
  def index
    if params[:problems].blank?
      @cases = Case.all
    else
      @cases = Case.as(:c).where('c.stock <= 1').pluck(:c)
      @cases.map!{|c| {
        id: c.id,
        name: c.name,
        stock: c.stock
      }}

      @cases.sort_by! {:name}

      render json: @cases
    end
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
  end

  def take
    params[:nb] ||= 1
    # user = User.find(params[:user])

    rel = user.commands.articles(:a, :rel).match_to(@case.article.id).pluck(:rel).first
    rel.quantity_left -= params[:nb]
    rel.save

    @case.stock -= params[:nb].to_i
    @case.save

    render json: @case, status: :SUCCESS
  end

  def empty
    @case.stock = 0
    @case.save

    render json: @case, status: :SUCCESS
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  # POST /cases.json
  def create
    @case = Case.new(case_params)

    respond_to do |format|
      if @case.save
        format.html { redirect_to @case, notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.fetch(:case, {})
    end
end
