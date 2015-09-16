
module TargetProcessUtilities

  def all_remote_projects
    TargetProcess::Project.all()
  end

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

  def retrieve_remote_project(project_id)
    TargetProcess::Project.find(project_id)
  end

  def map_remote_project_to_local_object(project_id)
    remote_project = retrieve_remote_project(project_id)

    working_project = Project.new
    working_project.id = project_id
    working_project.name = remote_project.name
    working_project.owner = remote_project.owner[:id]
    working_project.source_remote_id = project_id

    working_project
  end
  
  def self.create_new_remote_project(project)
    new_remote_project = TargetProcess::Project.new
    new_remote_project.resource_type = "Project"
    new_remote_project.name = project.name
    new_remote_project.owner = {:id => project.owner}
    new_remote_project.save
  end


  def all_remote_epics_for_project(remote_project_id)
    acid = brew_acid([remote_project_id])
    TargetProcess::Epic.all({acid: acid})
  end
  
  def retrieve_remote_epic(epic_id)
    TargetProcess::Epic.find(epic_id)
  end

  def map_remote_epics_to_local_objects(remote_project_id)
    remote_epics_list = all_remote_epics_for_project(remote_project_id)
    remote_epics_list.each do |epic_json|
      unless epic_json.attributes[:id] > 0
        local_epic = map_remote_epic_to_local_object(epic_json.attributes[:id])
        remote_epics_list.push local_epic
      end
    end
    remote_epics_list 
  end

  def map_remote_epic_to_local_object(source_remote_id)
    remote_epic = retrieve_remote_epic(source_remote_id)

    project = Project.where(source_remote_id: remote_epic.project[:id]).first

    working_epic = Epic.new
    working_epic.project_id = project.id
    working_epic.name = remote_epic.name
    working_epic.owner = remote_epic.owner[:id]
    working_epic.source_remote_id = remote_epic.id

    working_epic.save

    working_epic
  end

  def clone_project(remote_project_id)
    pending "write me"
  end

  def brew_acid(ids = [])
    TargetProcess.context({ids: ids.join(',')})[:acid]
  end

end