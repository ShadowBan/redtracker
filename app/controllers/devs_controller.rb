class DevsController < ApplicationController
  # GET /devs
  # GET /devs.json
  def index
    @devs = Dev.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devs }
    end
  end

  # GET /devs/1
  # GET /devs/1.json
  def show
    @dev = Dev.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dev }
    end
  end

  # GET /devs/new
  # GET /devs/new.json
  def new
    @dev = Dev.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dev }
    end
  end

  # GET /devs/1/edit
  def edit
    @dev = Dev.find(params[:id])
  end

  # POST /devs
  # POST /devs.json
  def create
    @dev = Dev.new(params[:dev])

    respond_to do |format|
      if @dev.save
        format.html { redirect_to @dev, notice: 'Dev was successfully created.' }
        format.json { render json: @dev, status: :created, location: @dev }
      else
        format.html { render action: "new" }
        format.json { render json: @dev.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devs/1
  # PUT /devs/1.json
  def update
    @dev = Dev.find(params[:id])

    respond_to do |format|
      if @dev.update_attributes(params[:dev])
        format.html { redirect_to @dev, notice: 'Dev was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dev.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devs/1
  # DELETE /devs/1.json
  def destroy
    @dev = Dev.find(params[:id])
    @dev.destroy

    respond_to do |format|
      format.html { redirect_to devs_url }
      format.json { head :no_content }
    end
  end
end
