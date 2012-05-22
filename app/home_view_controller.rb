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
  
  def viewWillAppear(animated)
    super
    puts "view will appear"
    
    current_pairing = UIApplication.sharedApplication.delegate.current_pairing
    
    y = 40
    
    current_pairing.each do |pair|
      view.addSubview(make_pair_label(pair, y))
      y += 40
    end
  end
  

  
  def make_pair_label(pair, y)
    label = UILabel.alloc.initWithFrame([[40,y],[200,20]])
    label.text = (pair.size == 2) ? "#{pair.first} & #{pair.last}" : "#{pair.first}"
    label
  end

  def motionBegan(motion, withEvent:event)
    puts "got a began motion"

  end
  
  def motionEnded(motion, withEvent:event)
    puts "got a end motion"
    UIApplication.sharedApplication.delegate.reset_pairing()

    self.viewWillAppear(false)
    
    puts "done end motion"
  end
end