class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  # GET /projects or /projects.json
  def index
    @projects = Project.where(user_id: current_user.id)
  end

  # GET /projects/1 or /projects/1.json
  def show
    allowed = false
    
    @project.project_admins.each do |project_admin|
      if current_user.id == project_admin.user_id
        allowed = true
        break
      end
    end
      if !allowed && @project.user != current_user
        redirect_to root_path, notice: 'You are not allowed to view this project'
      end
  end

  # GET /projects/new
  def new
    @project = current_user.projects.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.build(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    if current_user && @project.user == current_user
      @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to projects_url, alert: "You are not authorized to destroy this project."
    end
  end
  

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :body, :user_id)
    end
end

