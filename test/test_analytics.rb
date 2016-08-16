require 'helper'

class TestAnalytics < Test::Unit::TestCase
  
  context "A PivotalAPI::Analytics" do
  
    setup do
      @analytics = PivotalAPI::Analytics.from_json({
            stories_accepted: 5,
            bugs_created: 2,
            cycle_time: 343434,
            rejection_rate: 33.8,
            kind: "some-kind"
          })
    end
  
    should "have a valid stories_accepted count" do
      assert_equal(5, @analytics.stories_accepted)
    end
    
    should "have a valid bugs_created count" do
      assert_equal(2, @analytics.bugs_created)
    end
    
    should "have a valid cycle_time" do
      assert_equal(343434, @analytics.cycle_time)
    end
    
    should "have a valid rejection_rate" do
      assert_equal(33.8, @analytics.rejection_rate)
    end
    
    should "have a valid kind" do
      assert_equal("some-kind", @analytics.kind)
    end
    
  end
end