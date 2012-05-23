class EditTeamViewController < UITableViewController
  def loadView
    self.tableView = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds, style:UITableViewStyleGrouped)
  end

  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tv, numberOfRowsInSection:section)
    UIApplication.sharedApplication.delegate.team.size
  end
  
  def tableView(tv, cellForRowAtIndexPath:indexPath)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,reuseIdentifier:nil)
    
    cell.textLabel.text = UIApplication.sharedApplication.delegate.team[indexPath.row]
    cell.detailTextLabel.text = "hello"
    cell
  end
end