class EditTeamViewController < UITableViewController
  def loadView
    frame = UIScreen.mainScreen.applicationFrame
    self.tableView = UITableView.alloc.initWithFrame([[frame.origin.x, frame.origin.y+20],[frame.size.width, frame.size.height]], style:UITableViewStyleGrouped)
  end

  def viewDidLoad
    view.allowsSelection = false
  end

  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    TeamMemberStore.shared.team_members.length
  end
  
  def tableView(tableView, canEditRowAtIndexPath:indexPath)
    true
  end
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("team member cell")
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:"team member cell") if cell.nil?
    
    
    team_member = TeamMemberStore.shared.team_members[indexPath.row]
    cell.textLabel.text = team_member.name
    inclusionSwitch = UISwitch.alloc.init
    inclusionSwitch.setOn(team_member.included?, animated: false)
    inclusionSwitch.setTag(indexPath.row)
    inclusionSwitch.addTarget(self, action:"switchWasSwitched:", forControlEvents: UIControlEventValueChanged)
    cell.accessoryView = inclusionSwitch
    cell
  end
  
  def switchWasSwitched(sender)
    puts "switching"
    TeamMemberStore.shared.team_members[sender.tag].included = sender.isOn
    TeamMemberStore.shared.save
  end
  
  #editing

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    if (UITableViewCellEditingStyleDelete == editingStyle)
      TeamMemberStore.shared.remove_team_member(TeamMemberStore.shared.team_members[indexPath.row])
      view.reloadData
    end
  end


  
end