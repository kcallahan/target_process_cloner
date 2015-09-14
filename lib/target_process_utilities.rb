
module TargetProcessUtilities

  def map_remote_projects_to_local_objects
    remote_projects_list = all_remote_projects
    remote_projects_list.each do |project_json|
      unless project_json.attributes[:id] > 0
        local_project = map_remote_project_to_local_object(project_json.attributes[:id])
        remote_projects_list.push local_project
      end
    end
    remote_projects_list 
  end

  def all_remote_projects
    TargetProcess::Project.all()
  end

  def map_remote_project_to_local_object(project_id)
    remote_project = TargetProcess::Project.find(project_id)

    working_project = Project.new
    working_project.id = project_id
    working_project.name = remote_project.name
    working_project.owner = remote_project.owner[:id]
    working_project.source_remote_id = project_id

    working_project
  end
  
  def get_remote_epics_for_project(project_id)
    acid = brew_acid([project_id])
    TargetProcess::Epic.all({acid: acid})
  end

  def brew_acid(ids = [])
    TargetProcess.context({ids: ids.join(',')})[:acid]
  end

end