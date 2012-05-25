class AddTeamMemberViewController < UITableViewController
  def loadView
    self.tableView = UITableView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame, style:UITableViewStyleGrouped)
  end
  
  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    1
  end
  
  def viewDidLoad
    self.title = "Add Team Member"
    tableView.allowsSelection = false
  end
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("add member cell")
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:"add member cell") if cell.nil?
    
    textField = UITextField.alloc.initWithFrame([[cell.frame.origin.x+20, cell.frame.origin.y+13], [cell.frame.size.width-40, cell.frame.size.height ]])
    textField.placeholder = "Name of new team member"
    cell.addSubview(textField)
    cell
  end
end