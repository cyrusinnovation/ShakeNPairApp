class EditTeamViewController < UITableViewController
  def loadView
    frame = UIScreen.mainScreen.applicationFrame
    self.tableView = UITableView.alloc.initWithFrame([[frame.origin.x, frame.origin.y+20],[frame.size.width, frame.size.height]], style:UITableViewStyleGrouped)
  end
  

  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    TeamMemberStore.shared.team_members.length
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
  
end