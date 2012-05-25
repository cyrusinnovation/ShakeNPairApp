class ReverseViewController < UIViewController
  def init
    @topBar = UINavigationBar.alloc.initWithFrame([[0,0],[320,44]])
    @editView = EditTeamViewController.alloc.init
    super
  end
  
  def viewDidLoad

    navItem = UINavigationItem.alloc.initWithTitle("Edit Team")
    navItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target:self, action:"doneAction:")
    navItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:"doneAction:")
    @topBar.pushNavigationItem(navItem, animated: false)

    view.addSubview(@topBar)
    view.addSubview(@editView.view)   

  end
  
  def doneAction(sender)
    self.dismissViewControllerAnimated(true, completion:lambda do end) 
  end
end