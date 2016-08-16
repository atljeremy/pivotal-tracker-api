require 'helper'

class TestIteration < Test::Unit::TestCase
  context "A PitvotalAPI::Iteration" do
    
    setup do      
      @iteration = PivotalAPI::Iteration.from_json({
        project_id: 123,
        stories: [{
            id: 99,
            url: "http://www.url.com",
            project_id: 123,
            name: "story name",
            description: "story description",
            # other fields purposely left out - they are tested in test_story.rb
          },
          {
            id: 101,
            url: "http://www.urltwo.com",
            project_id: 123,
            name: "another story name",
            description: "another story description",
            # other fields purposely left out - they are tested in test_story.rb
          }],
        story_ids: [99, 101],
        number: 54,
        team_strength: 0.75,
        finish: "some-finish-date",
        kind: "iteration",
        start: "some-start-date"
      })
    end
  
    should "have a valid project id" do
      assert_equal(123, @iteration.project_id)
    end
    
    should "have valid stories" do
      assert_equal(2, @iteration.stories.count)
      assert_equal(99, @iteration.stories[0].id)
      assert_equal(101, @iteration.stories[1].id)
      assert_equal(123, @iteration.stories[0].project_id)
      assert_equal(123, @iteration.stories[1].project_id)
      assert_equal("story name", @iteration.stories[0].name)
      assert_equal("another story name", @iteration.stories[1].name)
    end
    
    should "have valid story_ids" do
      assert_equal([99, 101], @iteration.story_ids)
    end
    
    should "have a valid number" do
      assert_equal(54, @iteration.number)
    end
    
    should "have a valid team_strength" do
      assert_equal(0.75, @iteration.team_strength)
    end
    
    should "have a valid finish date string" do
      assert_equal("some-finish-date", @iteration.finish)
    end
    
    should "have a valid start date string" do
      assert_equal("some-start-date", @iteration.start)
    end
    
    should "have a valid kind" do
      assert_equal("iteration", @iteration.kind)
    end
    
  end
  
  context "An array of PitvotalAPI::Iteration's" do
    
    setup do
      @iteration = PivotalAPI::Iterations.from_json([{
        project_id: 123,
        stories: [{
            id: 99,
            url: "http://www.url.com",
            project_id: 123,
            name: "story name",
            description: "story description",
            # other fields purposely left out - they are tested in test_story.rb
          },
          {
            id: 101,
            url: "http://www.urltwo.com",
            project_id: 123,
            name: "another story name",
            description: "another story description",
            # other fields purposely left out - they are tested in test_story.rb
          }],
        story_ids: [99, 101],
        number: 54,
        team_strength: 0.75,
        finish: "some-finish-date",
        kind: "iteration",
        start: "some-start-date"
      },
      {
        project_id: 123,
        stories: [{
            id: 104,
            url: "http://www.urlthree.com",
            project_id: 123,
            name: "story name three",
            description: "story description five",
            # other fields purposely left out - they are tested in test_story.rb
          },
          {
            id: 105,
            url: "http://www.urlfour.com",
            project_id: 123,
            name: "story name four",
            description: "story description four",
            # other fields purposely left out - they are tested in test_story.rb
          }],
        story_ids: [104, 105],
        number: 54,
        team_strength: 0.97,
        finish: "some-finish-date-two",
        kind: "iteration",
        start: "some-start-date-two"
      }])
    end
  
    should "have a valid project id" do
      assert_equal(123, @iteration[0].project_id)
      
      assert_equal(123, @iteration[1].project_id)
    end
    
    should "have valid stories" do
      assert_equal(2, @iteration[0].stories.count)
      assert_equal(99, @iteration[0].stories[0].id)
      assert_equal(123, @iteration[0].stories[0].project_id)
      
      assert_equal(2, @iteration[1].stories.count)
      assert_equal(104, @iteration[1].stories[0].id)
      assert_equal(123, @iteration[1].stories[0].project_id)
    end
    
    should "have valid story_ids" do
      assert_equal([99, 101], @iteration[0].story_ids)
      
      assert_equal([104, 105], @iteration[1].story_ids)
    end
    
    should "have a valid number" do
      assert_equal(54, @iteration[0].number)
      
      assert_equal(54, @iteration[1].number)
    end
    
    should "have a valid team_strength" do
      assert_equal(0.75, @iteration[0].team_strength)
      
      assert_equal(0.97, @iteration[1].team_strength)
    end
    
    should "have a valid finish date string" do
      assert_equal("some-finish-date", @iteration[0].finish)
      
      assert_equal("some-finish-date-two", @iteration[1].finish)
    end
    
    should "have a valid start date string" do
      assert_equal("some-start-date", @iteration[0].start)
      
      assert_equal("some-start-date-two", @iteration[1].start)
    end
    
    should "have a valid kind" do
      assert_equal("iteration", @iteration[0].kind)
      
      assert_equal("iteration", @iteration[1].kind)
    end
    
  end
end