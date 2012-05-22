describe "Application 'ShakeNPair'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end
  
  it "should shuffle them" do
    @app.delegate.team.should == ["Jon", "Laura", "Matt", "Moss", "Nick"]
    
    current_pairing = @app.delegate.current_pairing.flatten
    @app.delegate.team.each do |team_member| 
      current_pairing.include?(team_member).should == true
    end
  end
  
  it "should shuffle differently on subsequent shuffles" do
    first_pairing = @app.delegate.current_pairing
    @app.delegate.reset_pairing
    second_pairing = @app.delegate.current_pairing
    
    first_pairing.should != second_pairing
  end
end
