class EditTeamViewController < UITableViewController
  def loadView
    self.tableView = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds, style:UITableViewStyleGrouped)
  end
  

  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    UIApplication.sharedApplication.delegate.team.size
  end
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("team member cell")
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:"team member cell") if cell.nil?
    
    cell.textLabel.text = UIApplication.sharedApplication.delegate.team[indexPath.row]
    inclusionSwitch = UISwitch.alloc.init
    inclusionSwitch.setOn(true, animated: false)
    inclusionSwitch.setTag(indexPath.row)
    inclusionSwitch.addTarget(self, action:"switchWasSwitched:", forControlEvents:UIControlEventValueChanged)
    cell.accessoryView = inclusionSwitch
    cell
  end
  
  def switchWasSwitched(sender)
    puts "switch was switched #{sender.tag}"
  end
end