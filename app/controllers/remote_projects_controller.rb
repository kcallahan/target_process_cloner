class RemoteProjectsController < ApplicationController
  before_action :set_remote_project, only: [:show, :edit, :update, :destroy]

  # GET /remote_projects
  # GET /remote_projects.json
  def index
    @remote_projects = RemoteProject.all
  end

  # GET /remote_projects/1
  # GET /remote_projects/1.json
  def show
  end

  # GET /remote_projects/new
  def new
    @remote_project = RemoteProject.new
  end

  # GET /remote_projects/1/edit
  def edit
  end

  # POST /remote_projects
  # POST /remote_projects.json
  def create
    @remote_project = RemoteProject.new(remote_project_params)

    respond_to do |format|
      if @remote_project.save
        format.html { redirect_to @remote_project, notice: 'Remote project was successfully created.' }
        format.json { render :show, status: :created, location: @remote_project }
      else
        format.html { render :new }
        format.json { render json: @remote_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remote_projects/1
  # PATCH/PUT /remote_projects/1.json
  def update
    respond_to do |format|
      if @remote_project.update(remote_project_params)
        format.html { redirect_to @remote_project, notice: 'Remote project was successfully updated.' }
        format.json { render :show, status: :ok, location: @remote_project }
      else
        format.html { render :edit }
        format.json { render json: @remote_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remote_projects/1
  # DELETE /remote_projects/1.json
  def destroy
    @remote_project.destroy
    respond_to do |format|
      format.html { redirect_to remote_projects_url, notice: 'Remote project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remote_project
      @remote_project = RemoteProject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remote_project_params
      params[:remote_project]
    end
end
