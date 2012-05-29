class HomeViewController < UITableViewController
  #framework methods
  
  def loadView
    super
    self.tableView = UITableView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame, style:UITableViewStyleGrouped)
  end


  def canBecomeFirstResponder 
    true
  end

  def viewDidAppear(animated)
    super
    self.becomeFirstResponder()
  end

  def viewWillDisappear(animated)
    self.resignFirstResponder()
    super
  end

  def viewDidLoad
    # display_pairs
    tableView.allowsSelection = false
    display_info_button
  end

  def motionEnded(motion, withEvent:event)
    redisplay_pairs
  end


  def numberOfSectionsInTableView(tableView)
    UIApplication.sharedApplication.delegate.current_pairing.size
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    UIApplication.sharedApplication.delegate.current_pairing[section].size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("home page cell")
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:"home page cell") if cell.nil?
    
    cell.textLabel.text = UIApplication.sharedApplication.delegate.current_pairing[indexPath.section][indexPath.row].name
    cell
  end

  #non-framework methods

  def display_pairs
    y = 40
    @pair_labels = []

    UIApplication.sharedApplication.delegate.current_pairing.each do |pair|
      label = make_pair_label(pair, y)
      label.alpha = 0
      @pair_labels << label
      view.addSubview(label)
      y += 40
    end

    @pair_labels.each_with_index do |label, index|
      UIView.animateWithDuration(0.2, delay:index, options:UIViewAnimationCurveLinear, animations:lambda do
          label.alpha = 1
      end, completion:lambda do |finished| end)
    end
  end

  def make_pair_label(pair, y)
    label = UILabel.alloc.initWithFrame([[0,y],[view.bounds.size.width,39]])
    label.text = (pair.size == 2) ? "#{pair.first.name} & #{pair.last.name}" : "#{pair.first.name}"
    label
  end

  def redisplay_pairs
    UIApplication.sharedApplication.delegate.reset_pairing()
    tableView.reloadData
  end  

  def transitionToEditScreen(sender)
    reverseViewController = UINavigationController.alloc.initWithRootViewController(EditTeamViewController.alloc.init)
    reverseViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
    self.presentViewController(reverseViewController, animated:true, completion:lambda do end )
  end
  
  def display_info_button
    editTeamButton = UIButton.buttonWithType(UIButtonTypeInfoLight)
    
    editTeamButton.frame = CGRectMake(self.tableView.frame.size.width - 30,
                                  self.tableView.frame.size.height - 50, 
                                  editTeamButton.frame.size.width, 
                                  editTeamButton.frame.size.height)
    editTeamButton.addTarget(self, action:"transitionToEditScreen:", forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(editTeamButton)
  end

end