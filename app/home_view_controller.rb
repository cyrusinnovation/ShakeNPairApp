class HomeViewController < UIViewController

  #framework methods

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
    display_pairs
    display_info_button
  end

  def motionEnded(motion, withEvent:event)
    redisplay_pairs
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
    @pair_labels.each do |pair_label|
      pair_label.removeFromSuperview()
    end
    @pair_labels = nil

    display_pairs
  end  

  def transitionToEditScreen(sender)
    editTeamViewController = UINavigationController.alloc.initWithRootViewController(EditTeamViewController.alloc.init)
    editTeamViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
    self.presentViewController(editTeamViewController, animated:true, completion:lambda do end )
  end
  
  def display_info_button
    editTeamButton = UIButton.buttonWithType(UIButtonTypeInfoLight)
    
    editTeamButton.frame = CGRectMake(view.bounds.size.width - 30,
                                  view.bounds.size.height - 30, 
                                  editTeamButton.bounds.size.width, 
                                  editTeamButton.bounds.size.height)
    editTeamButton.addTarget(self, action:"transitionToEditScreen:", forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(editTeamButton)
  end

end