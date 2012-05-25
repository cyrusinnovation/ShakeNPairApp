class EditTeamViewController < UITableViewController
  def loadView
    self.tableView = UITableView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame, style:UITableViewStyleGrouped)
  end

  def viewDidLoad
    view.allowsSelection = false
    self.title = "Edit Team"
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target:self, action:"doneEditing:")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:"showAddTeamMemberScreen:")
  end

  def doneEditing(sender)
    self.dismissViewControllerAnimated(true, completion:lambda do end) 
  end
  
  def showAddTeamMemberScreen(sender)
    self.navigationController.pushViewController(AddTeamMemberViewController.alloc.init, animated:true)
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
    TeamMemberStore.shared.team_members[sender.tag].included = sender.isOn
    TeamMemberStore.shared.save
  end
  
  #editing

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    if (UITableViewCellEditingStyleDelete == editingStyle)
      TeamMemberStore.shared.remove_team_member(TeamMemberStore.shared.team_members[indexPath.row])
      view.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationAutomatic)
    end
  end


  
end