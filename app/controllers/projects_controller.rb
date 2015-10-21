require 'target_process_integration_toolkit'

class ProjectsController < ApplicationController
  include TargetProcessIntegrationToolkit

  before_filter :require_session

  # GET /projects
  # GET /projects.json
  def index
    @remote_projects = RemoteEntityCollection.new({:resource_type => 'Project'}) #map_remote_projects_to_local_objects
  end

  # GET /projects/new
  def new
    store_source_remote_id params[:source_remote_id] if session[:source_remote_id].nil?
    @remote_project = TargetProcess::Project.find(session[:source_remote_id])
    @project = Project.new({:source_remote_id => session[:source_remote_id]})

    render :edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @remote_project = TargetProcess::Project.find(session[:source_remote_id])
    @project = Project.new(project_params)

    if params[:project][:name].blank?
      redirect_to new_project_url, notice: "Project name cannot be blank"
    end

    respond_to do |format|
      if @project.save
        @project.clean_up_local_db
        format.html { redirect_to projects_url, notice: 'Project was successfully created! Go to Target Process and refresh to see...' }
        format.json { render :index, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def store_source_remote_id(source_remote_id)
      session[:source_remote_id] = source_remote_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :source_remote_id)
    end
    
end
