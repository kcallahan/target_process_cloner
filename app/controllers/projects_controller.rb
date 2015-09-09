class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @remote_projects = map_and_save_remote_projects
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @remote_project = RemoteProject.find_by_id(params[:id])
    @project = Project.create(source_remote_id: params[:id], owner: @remote_project.owner)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :owner, :source_remote_id)
    end

  def map_and_save_remote_projects
    remote_projects = Array.new()
  
    TargetProcess::Project.all().each do |remote_project|
      project = RemoteProject.find_or_create_by(id: remote_project.id)
      project.name = remote_project.name
      project.owner = remote_project.owner[:id]
      project.save

      remote_projects.push project
    end

    remote_projects 
  end

end
