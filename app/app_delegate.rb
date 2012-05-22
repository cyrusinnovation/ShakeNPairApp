class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    application.applicationSupportsShakeToEdit = true;
    
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = HomeViewController.alloc.init
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    

    true
  end
  
  def team
    ["Jon", "Laura", "Matt", "Moss", "Nick"]
  end
  
  def current_pairing
    @current_pairing ||= team.shuffle.each_slice(2).to_a
  end
  
  def reset_pairing
    @current_pairing = nil
  end
  

end
