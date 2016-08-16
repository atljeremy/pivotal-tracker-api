require 'helper'

class TestAnalytics < Test::Unit::TestCase
  
  
  context "A PivotalAPI::CycleTimeDetails" do
    
    setup do
      @cycle_time_details = PivotalAPI::CycleTimeDetails.from_json({
          total_cycle_time: 12345, 
          started_time: 1111111111, 
          started_count: 2, 
          finished_time: 2222222222, 
          finished_count: 3, 
          delivered_time: 3333333333, 
          delivered_count: 4, 
          rejected_time: 4444444444, 
          rejected_count: 5, 
          story_id: 33, 
          kind: "some-kind"
          })
    end
    
    should "have a valid total_cycle_time" do
      assert_equal(12345, @cycle_time_details.total_cycle_time)
    end
    
    should "have a valid started_time" do
      assert_equal(1111111111, @cycle_time_details.started_time)
    end
    
    should "have a valid started_count" do
      assert_equal(2, @cycle_time_details.started_count)
    end
    
    should "have a valid finished_time" do
      assert_equal(2222222222, @cycle_time_details.finished_time)
    end
    
    should "have a valid finished_count" do
      assert_equal(3, @cycle_time_details.finished_count)
    end
    
    should "have a valid delivered_time" do
      assert_equal(3333333333, @cycle_time_details.delivered_time)
    end
    
    should "have a valid delivered_count" do
      assert_equal(4, @cycle_time_details.delivered_count)
    end
    
    should "have a valid rejected_time" do
      assert_equal(4444444444, @cycle_time_details.rejected_time)
    end
    
    should "have a valid rejected_count" do
      assert_equal(5, @cycle_time_details.rejected_count)
    end
    
    should "have a valid story_id" do
      assert_equal(33, @cycle_time_details.story_id)
    end
    
    should "have a valid kind" do
      assert_equal("some-kind", @cycle_time_details.kind)
    end
  
  end
end