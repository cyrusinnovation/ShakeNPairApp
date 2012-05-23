class HomeViewController < UIViewController
  
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
    puts view.subviews
  end
  
  def display_pairs
     y = 40
     @pair_labels = []

     UIApplication.sharedApplication.delegate.current_pairing.each do |pair|
       label = make_pair_label(pair, y)
       @pair_labels << label
       view.addSubview(label)
       y += 40
     end
  end
  
  def make_pair_label(pair, y)
    label = UILabel.alloc.initWithFrame([[40,y],[200,20]])
    label.text = (pair.size == 2) ? "#{pair.first} & #{pair.last}" : "#{pair.first}"
    label
  end

  def redisplay_pairs
    UIApplication.sharedApplication.delegate.reset_pairing()
    @pair_labels.each do |pair_label|
      pair_label.removeFromSuperview()
    end
    
    display_pairs
  end
  
  def motionEnded(motion, withEvent:event)
    redisplay_pairs()
  end
end