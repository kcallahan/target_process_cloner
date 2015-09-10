
module TargetProcessUtilities
  include TargetProcess

  def map_remote_projects_to_local_objects
    TargetProcess::Project.all().each do |project_json|
      project = map_remote_project_to_local_object(project_json.attributes[:id])
      remote_projects.push project
    end

    remote_projects 
  end

  def map_remote_project_to_local_object(project_id)
    remote_project = TargetProcess::Project.find(project_id)

    project = Project.new
    project.id = remote_project.id
    project.name = remote_project.name
    project.owner = remote_project.owner[:id]

    project
  end
  
  def get_remote_epics_for_project(project_id)
    acid = brew_acid([project_id])
    TargetProcess::Epic.all({acid: acid})
  end

  def brew_acid(ids = [])
    TargetProcess.context({ids: ids.join(',')})[:acid]
  end

end