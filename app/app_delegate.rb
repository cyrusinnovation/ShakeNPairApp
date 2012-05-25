class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = HomeViewController.alloc.init
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible

    # load_test_data

    true
  end

  def load_test_data
    # ["Jon", "Laura", "Matt", "Moss", "Nick", "Another Matt", "Another Moss", "Will", "Jackie"].each do |name|
    #      member = TeamMemberStore.shared.create_team_member()
    #      member.name = name
    #      TeamMemberStore.shared.save_team_member(member)
    #    end
  end

  def current_pairing
    @current_pairing ||= TeamMemberStore.shared.team_members.collect{|u| u.name if u.included}.shuffle.shuffle.shuffle.each_slice(2).to_a
  end

  def reset_pairing
    @current_pairing = nil
  end

end
