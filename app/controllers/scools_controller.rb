class ScoolsController < ApplicationController
  # GET /scools
  # GET /scools.json
  def index
    @scools = Scool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scools }
    end
  end

  # GET /scools/1
  # GET /scools/1.json
  def show
    @scool = Scool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scool }
    end
  end

  # GET /scools/new
  # GET /scools/new.json
  def new
    @scool = Scool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scool }
    end
  end

  # GET /scools/1/edit
  def edit
    @scool = Scool.find(params[:id])
  end

  # POST /scools
  # POST /scools.json
  def create
    @scool = Scool.new(params[:scool])

    respond_to do |format|
      if @scool.save
        format.html { redirect_to @scool, notice: 'Scool was successfully created.' }
        format.json { render json: @scool, status: :created, location: @scool }
      else
        format.html { render action: "new" }
        format.json { render json: @scool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scools/1
  # PUT /scools/1.json
  def update
    @scool = Scool.find(params[:id])

    respond_to do |format|
      if @scool.update_attributes(params[:scool])
        format.html { redirect_to @scool, notice: 'Scool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scools/1
  # DELETE /scools/1.json
  def destroy
    @scool = Scool.find(params[:id])
    @scool.destroy

    respond_to do |format|
      format.html { redirect_to scools_url }
      format.json { head :no_content }
    end
  end
end
