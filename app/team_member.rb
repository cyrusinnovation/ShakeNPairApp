class TeamMember < NSManagedObject
  def self.entity
    @entity ||= begin
      entity = NSEntityDescription.alloc.init
      entity.name = 'TeamMember'
      entity.managedObjectClassName = 'TeamMember'
      entity.properties = 
        ['name', NSStringAttributeType, 
         'included', NSBooleanAttributeType 
        ].each_slice(2).map do |name, type|
            property = NSAttributeDescription.alloc.init
            property.name = name
            property.attributeType = type
            property.optional = false
            property
          end
      entity
    end
  end
  
  def included?
    self.included == 1
  end
  
  def new?
    self.managedObjectContext.nil?
  end  
end
