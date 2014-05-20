class ScoolsController < ApplicationController
  before_action :set_scool, only: [:show, :edit, :update, :destroy]

  # GET /scools
  # GET /scools.json
  def index
    @scools = Scool.order("id DESC").page(params[:page])
  end

  # GET /scools/1
  # GET /scools/1.json
  def show
  end

  # GET /scools/new
  def new
    @scool = Scool.new
  end

  # GET /scools/1/edit
  def edit
  end

  # POST /scools
  # POST /scools.json
  def create
    @scool = Scool.new(scool_params)

    respond_to do |format|
      if @scool.save
        format.html { redirect_to @scool, notice: 'Scool was successfully created.' }
        format.json { render :show, status: :created, location: @scool }
      else
        format.html { render :new }
        format.json { render json: @scool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scools/1
  # PATCH/PUT /scools/1.json
  def update
    respond_to do |format|
      if @scool.update(scool_params)
        format.html { redirect_to @scool, notice: 'Scool was successfully updated.' }
        format.json { render :show, status: :ok, location: @scool }
      else
        format.html { render :edit }
        format.json { render json: @scool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scools/1
  # DELETE /scools/1.json
  def destroy
    @scool.destroy
    respond_to do |format|
      format.html { redirect_to scools_url, notice: 'Scool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scool
      @scool = Scool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scool_params
      params.require(:scool).permit(:name, :telephone, :url, :profile_image_url, :description, :location , :latitude, :longitude)
    end
end
