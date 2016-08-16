require 'helper'

class TestStoryTransition < Test::Unit::TestCase
  should "parse a valid json object into an instance of StoryTransition" do
    transition = PivotalAPI::StoryTransition.from_json({
          state: "started",
          story_id: 1,
          project_id: 2,
          project_version: 3,
          occurred_at: "2016-08-09T18:55:58Z",
          performed_by_id: 4,
          kind: "some-kind"
        })
        
    assert_equal(1, transition.story_id)
    assert_equal(2, transition.project_id)
    assert_equal(3, transition.project_version)
    assert_equal(4, transition.performed_by_id)
    assert_equal("started", transition.state)
    assert_equal(DateTime.parse("2016-08-09T18:55:58Z"), transition.occurred_at)
    assert_equal("some-kind", transition.kind)
  end
  
  should "parse a valid json array into an arrary of StoryTransition instances" do
    transitions = PivotalAPI::StoryTransition.from_json([{
        state: "started",
        story_id: 1,
        project_id: 2,
        project_version: 3,
        occurred_at: "2016-08-09T18:55:58Z",
        performed_by_id: 4,
        kind: "some-kind"
      },
      {
        state: "finished",
        story_id: 5,
        project_id: 6,
        project_version: 7,
        occurred_at: "2016-08-09T18:55:58Z",
        performed_by_id: 8,
        kind: "some-kind"
      },
      {
        state: "accepted",
        story_id: 9,
        project_id: 10,
        project_version: 11,
        occurred_at: "2016-08-09T18:55:58Z",
        performed_by_id: 12,
        kind: "some-kind"
      }
    ])
    
    assert_equal(3, transitions.count)
    
    assert_equal(1, transitions[0].story_id)
    assert_equal(2, transitions[0].project_id)
    assert_equal(3, transitions[0].project_version)
    assert_equal(4, transitions[0].performed_by_id)
    assert_equal("started", transitions[0].state)
    assert_equal(DateTime.parse("2016-08-09T18:55:58Z"), transitions[0].occurred_at)
    assert_equal("some-kind", transitions[0].kind)
    
    assert_equal(5, transitions[1].story_id)
    assert_equal(6, transitions[1].project_id)
    assert_equal(7, transitions[1].project_version)
    assert_equal(8, transitions[1].performed_by_id)
    assert_equal("finished", transitions[1].state)
    assert_equal(DateTime.parse("2016-08-09T18:55:58Z"), transitions[1].occurred_at)
    assert_equal("some-kind", transitions[1].kind)
    
    assert_equal(9, transitions[2].story_id)
    assert_equal(10, transitions[2].project_id)
    assert_equal(11, transitions[2].project_version)
    assert_equal(12, transitions[2].performed_by_id)
    assert_equal("accepted", transitions[2].state)
    assert_equal(DateTime.parse("2016-08-09T18:55:58Z"), transitions[2].occurred_at)
    assert_equal("some-kind", transitions[2].kind)
  end
end
