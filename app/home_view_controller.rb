class HomeViewController < UIViewController
  
  
  
  def viewDidLoad
    first_pair = UILabel.alloc.initWithFrame([[40,40],[200,20]])
    first_pair.text = "Laura & Moss"
    view.addSubview(first_pair)
    
    second_pair = UILabel.alloc.initWithFrame([[40,80],[200,20]])
    second_pair.text = "Jim & Nick"
    view.addSubview(second_pair)

    third_pair = UILabel.alloc.initWithFrame([[40,120],[200,20]])
    third_pair.text = "Jon"
    view.addSubview(third_pair)

  end
  

end