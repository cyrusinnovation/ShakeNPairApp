class TeamMemberStore < NSObject
  
  def self.shared
    @shared ||= TeamMemberStore.new
  end
  
  def team_members
    @team_members ||= begin
      request = NSFetchRequest.alloc.init
      request.entity = NSEntityDescription.entityForName('TeamMember', inManagedObjectContext:@context)

      error_ptr = Pointer.new(:object)
      data = @context.executeFetchRequest(request, error:error_ptr)
      if data == nil
        raise "Error when fetching data: #{error_ptr[0].description}"
      end
      data
    end
  end
  
  def create_team_member
    model = @context.persistentStoreCoordinator.managedObjectModel
    edesc = model.entitiesByName.objectForKey('TeamMember')
    team_member = NSManagedObject.alloc.initWithEntity(edesc, insertIntoManagedObjectContext:nil)
    team_member.name = ''
    team_member.included = true
    team_member
  end
  
  def remove_team_member(team_member)
    @context.deleteObject(team_member)
    save
  end
  
  def save_team_member(team_member)
    if team_member.new? and team_member.name != ""
      @context.insertObject(team_member)
    end
    save
  end



  def initialize
    model = NSManagedObjectModel.alloc.init
    model.entities = [TeamMember.entity]

    store = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(model)
    store_url = NSURL.fileURLWithPath(File.join(NSHomeDirectory(), 'Documents', 'Team.sqlite'))
    error_ptr = Pointer.new(:object)
    unless store.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:store_url, options:nil, error:error_ptr)
      raise "Can't add persistent SQLite store: #{error_ptr[0].description}"
    end

    context = NSManagedObjectContext.alloc.init
    context.persistentStoreCoordinator = store
    @context = context
  end
  
  def save
    error_ptr = Pointer.new(:object)
    unless @context.save(error_ptr)
      raise "Error when saving the model: #{error_ptr[0].description}"
    end
    @team_members = nil
  end
  
end