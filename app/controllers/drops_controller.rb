class DropsController < ApplicationController
  before_action :set_project
  before_action :set_drop, only: %i[ show edit update destroy ]

  
  # GET /drops or /drops.json
  def index
    @drops = @project.drops
  end

  # GET /drops/1 or /drops/1.json
  def show
  end

  # GET /drops/new
  def new
    @drop = Drop.new
  end

  # GET /drops/1/edit
  def edit
  end

  # POST /drops or /drops.json
  def create
    @drop = @project.drops.build(drop_params)
    #@drop = Drop.new(drop_params)

    respond_to do |format|
      if @drop.save
        format.html { redirect_to project_drops_path(@project), notice: "Drop was successfully created." }
        format.json { render :show, status: :created, location: @drop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drop.errors, status: :unprocessable_entity }
      end
      if params[:drop][:file].nil?
        flash[:notice] = "Please upload a file!"
        redirect_back(fallback_location: root_path)
        return
      end
    
    end
  end

  # PATCH/PUT /drops/1 or /drops/1.json
  def update
    respond_to do |format|
      if @drop.update(drop_params)
        format.html { redirect_to [@project, @drop], notice: "Drop was successfully updated." }
        format.json { render :show, status: :ok, location: @drop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drops/1 or /drops/1.json
  def destroy
    @drop.destroy

    respond_to do |format|
      format.html { redirect_to [@project, :drops], notice: "Drop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_drop
      @drop = Drop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drop_params
      params.require(:drop).permit(:title, :description, :file)
    end
end
