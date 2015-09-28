module TargetProcessIntegrationToolkit

  class RemoteEntity
    attr_accessor :id, :project, :resource_type, :name, :description, :owner, :numeric_priority, :remote_entity

    def has_project?(resource_type)
      return true unless (resource_type.downcase == 'project' || resource_type.downcase == 'task')
      false
    end
  end

  class NewRemoteEntity < RemoteEntity

    def initialize(params)
      @resource_type = params[:resource_type]

      @remote_entity                  = new_target_process_entity
      @remote_entity.resource_type    = @resource_type
      @remote_entity.name             = params[:name]
      @remote_entity.description      = params[:description]
      @remote_entity.owner            = params[:owner]
      @remote_entity.numeric_priority = params[:numeric_priority]
      @remote_entity.project          = params[:project] if has_project? @resource_type
    end

    def save
      @remote_entity.save
    end

    private 

    def new_target_process_entity
      eval "TargetProcess::#{@resource_type}.new"
    end
  end

  class SourceRemoteEntity < RemoteEntity
    def initialize(resource_type, id)
      @resource_type = @resource_type

      @remote_entity        = eval "TargetProcess::#{resource_type}.find(#{id})"
      self.resource_type    = resource_type
      self.name             = @remote_entity.name
      self.description      = @remote_entity.description
      self.owner            = @remote_entity.owner
      self.numeric_priority = @remote_entity.numeric_priority
      self.project          = @remote_entity.project if has_project? @resource_type
    end
  end

  class RemoteEntityCollection
    attr_accessor :resource_type, :acid, :entities

    def initialize(args)
      @resource_type = args[:resource_type]      
      @acid          = brew_acid(args[:acid_ids]) if needs_acid?
      @entities      = retrieve_remote_entities
    end

    def retrieve_remote_entities
      acid_string = ", acid: {@acid}" if needs_acid?
      eval "TargetProcess::#{@resource_type}.all({take: 1000})"
    end

    private
    
    def needs_acid?
      return true unless @resource_type.downcase == "project"
      false
    end

    def brew_acid(ids = [])
      TargetProcess.context({ids: ids.join(',')})[:acid]
    end
  end
end