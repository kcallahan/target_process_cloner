
module TargetProcessUtilities

  def all_remote_projects
    TargetProcess::Project.all({take: 1000})
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


  def map_remote_project_to_local_object(project_id)
    remote_project = retrieve_remote_project(project_id)

    working_project = Project.new
    working_project.id = project_id
    working_project.name = remote_project.name
    working_project.owner = remote_project.owner[:id]
    working_project.source_remote_id = project_id

    working_project
  end
  
  def brew_acid(ids = [])
    TargetProcess.context({ids: ids.join(',')})[:acid]
  end

  ['Project','Epic','Feature','User_Story'].each do |entity|
    entity.gsub!('_','')
    define_method("retrieve_remote_#{entity.downcase}") do |argument|
      eval "TargetProcess::#{entity}.find(#{argument})"
    end
  end

  ['Epic','Feature','User_Story'].each do |entity|
    define_method("all_remote_#{entity.downcase.pluralize}_for_project") do |argument|
      eval "acid = brew_acid([#{argument}]); TargetProcess::#{entity.gsub('_','')}.all({take: 1000, acid: #{acid})"
    end
  end

  def map_remote_epics_to_local_objects(project)
    remote_epics_list = all_remote_epics_for_project(project.source_remote_id)
    remote_epics_list.each do |epic_json|
      if epic_json.id > 0 && epic_json.resource_type == "Epic"
        local_epic = map_remote_epic_to_local_object(project, epic_json)
      end
    end
  end

  def map_remote_features_to_local_objects(project)
    remote_features_list = all_remote_features_for_project(project.source_remote_id)
    remote_features_list.each do |feature_json|
      if feature_json.id > 0 && feature_json.resource_type == "Feature"
        local_feature = map_remote_feature_to_local_object(project, feature_json)
      end
    end
  end

  def map_remote_user_stories_to_local_objects(project)
    remote_user_stories_list = all_remote_user_stories_for_project(project.source_remote_id)
    remote_user_stories_list.each do |user_story_json|
      if user_story_json.id > 0 && user_story_json.resource_type == "UserStory"
        local_user_story = map_remote_user_story_to_local_object(project, user_story_json)
      end
    end
  end




  def map_remote_epic_to_local_object(project, remote_epic_json)
    working_epic = Epic.new
    working_epic.project_id = project.id
    working_epic.name = remote_epic_json.name
    working_epic.owner = remote_epic_json.owner[:id]
    working_epic.source_remote_id = remote_epic_json.id
    working_epic.numeric_priority = remote_epic_json.numeric_priority
    working_epic.save
  end

  def map_remote_feature_to_local_object(project, remote_feature_json)
    working_feature = Feature.new
    working_feature.project_id = project.id
    epic = Epic.where(source_remote_id: remote_feature_json.epic[:id]).first
    working_feature.epic_id = epic.id unless epic.nil?
    working_feature.name = remote_feature_json.name
    working_feature.owner = remote_feature_json.owner[:id]
    working_feature.source_remote_id = remote_feature_json.id
    working_feature.numeric_priority = remote_feature_json.numeric_priority
    working_feature.save
  end

  def map_remote_user_story_to_local_object(project, remote_user_story_json)
    working_user_story = UserStory.new
    working_user_story.project_id = project.id
    feature = Feature.where(source_remote_id: remote_user_story_json.feature[:id]).first
    working_user_story.feature_id = feature.id unless feature.nil?
    working_user_story.name = remote_user_story_json.name
    working_user_story.owner = remote_user_story_json.owner[:id]
    working_user_story.source_remote_id = remote_user_story_json.id
    working_user_story.numeric_priority = remote_user_story_json.numeric_priority
    working_user_story.save
  end

end