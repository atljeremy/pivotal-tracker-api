require 'helper'

class TestMe < Test::Unit::TestCase
  
  context "A PivotalAPI::Me" do 
  
    setup do
      @me = PivotalAPI::Me.from_json({
        api_token: "VadersToken",
        created_at: "2016-08-09T12:00:05Z",
        email: "vader@deathstar.mil",
        has_google_identity: false,
        id: 101,
        initials: "DV",
        kind: "me",
        name: "Darth Vader",
        projects: [{
             kind: "membership_summary",
             id: 108,
             project_id: 98,
             project_name: "Learn About the Force",
             project_color: "8100ea",
             role: "owner",
             last_viewed_at: "2016-08-09T12:00:00Z"
         },
         {
             kind: "membership_summary",
             id: 101,
             project_id: 99,
             project_name: "Death Star",
             project_color: "8100ea",
             role: "member",
             last_viewed_at: "2016-08-09T12:00:00Z"
         }],
        receives_in_app_notifications: true,
        time_zone:
        {
           kind: "time_zone",
           olson_name: "America/Los_Angeles",
           offset: "-08:00"
        },
        updated_at: "2016-08-09T12:00:10Z",
        username: "vader"
      })
    end

    should "have a valid id" do
      assert_equal("VadersToken", @me.api_token)
    end
    
  end
end
