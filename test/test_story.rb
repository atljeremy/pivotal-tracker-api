require 'helper'

class TestActivity < Test::Unit::TestCase
  
  context "A PivotalAPI::Story" do
    
    setup do
      @story = PivotalAPI::Story.from_json({
        id: 1,
        url: "http://www.url.com",
        project_id: 123,
        name: "story name",
        description: "story description",
        story_type: "feature",
        estimate: 13,
        current_state: "accepted",
        created_at: "2016-08-17T11:03:53-04:00",
        updated_at: "2016-08-17T11:03:53-04:00",
        kind: "story",
        integration_id: 5,
        deadline: "2016-08-17T11:03:53-04:00",
        external_id: 222,
        accepted_at: "2016-08-19T11:03:53-04:00",
        task_ids: [432],
        tasks: [{
          project_id: 123, 
          story_id: 1, 
          id: 432, 
          description: "task description", 
          position: 1, 
          complete: false, 
          created_at: "2016-08-17T11:03:53-04:00"
        }],
        comment_ids: [63],
        comments: [{
            project_id: 123,
            story_id: 1,
            epic_id: 88,
            id: 63,
            text: "some comment text", 
            person: {
              id: 99,
              name: "Gary Appleseed",
              initials: "GA",
              email: "gary@email.com",
              username: "garyapple"
            }, 
            created_at: "2016-08-17T11:03:53-04:00",
            updated_at: "2016-08-17T11:03:53-04:00",
            file_attachments: [{
              filename: "filename.jpg", 
              id: 333, 
              created_at: "2016-08-09T18:55:58Z", 
              uploaded_by: {
                id: 99,
                name: "Gary Appleseed",
                initials: "GA",
                email: "gary@email.com",
                username: "garyapple"
              }, 
              big_url: "http://www.bigurl.com",
              width: 300, 
              height: 450, 
              download_url: "http://www.downloadurl.com", 
              thumbnail_url: "http://www.thumbnailurl.com",
              size: 1598,
              content_type: "image/jpeg" 
            }],
            google_attachment_ids: [45, 97, 105], 
            commit_identifier: "271921wuwwui2u3uewweiweed3e",
            commit_type: "github",
            kind: "comment"
          }],
        requested_by_id: 2,
        requested_by: {
            id: 2,
            name: "Mike Appleseed",
            initials: "MA",
            email: "mike@email.com",
            username: "mikeapple"
          },
        owner_ids: [3, 4],
        owners: [{
            id: 3,
            name: "John Appleseed",
            initials: "JA",
            email: "john@email.com",
            username: "johnapple"
          },
          {
            id: 4,
            name: "Sam Appleseed",
            initials: "SA",
            email: "sam@email.com",
            username: "sameapple"
          }],
        follower_ids: [2, 3, 4],
        followers: [{
            id: 2,
            name: "Mike Appleseed",
            initials: "MA",
            email: "mike@email.com",
            username: "mikeapple"
          },
          {
            id: 3,
            name: "John Appleseed",
            initials: "JA",
            email: "john@email.com",
            username: "johnapple"
          },
          {
            id: 4,
            name: "Sam Appleseed",
            initials: "SA",
            email: "sam@email.com",
            username: "sameapple"
          }],
        label_ids: [20, 30],
        labels: [{
            id: 20,
            name: "label-one",
            project_id: 123,
            created_at: "2016-08-17T11:03:53-04:00",
            updated_at: "2016-08-17T11:03:53-04:00",
            counts: 3,
            kind: "label"
          },
          {
            id: 30,
            name: "label-two",
            project_id: 123,
            created_at: "2016-08-17T11:03:53-04:00",
            updated_at: "2016-08-17T11:03:53-04:00",
            counts: 4,
            kind: "label"
          }],
        transitions: [{
            state: "accepted",
            story_id: 1,
            project_id: 2,
            project_version: 3,
            occurred_at: "2016-08-19T11:04:53-04:00",
            performed_by_id: 4,
            kind: "some-kind"
          },{
            state: "finished",
            story_id: 1,
            project_id: 2,
            project_version: 3,
            occurred_at: "2016-08-19T11:03:53-04:00",
            performed_by_id: 4,
            kind: "some-kind"
          },{
            state: "started",
            story_id: 1,
            project_id: 2,
            project_version: 3,
            occurred_at: "2016-08-17T11:03:53-04:00",
            performed_by_id: 4,
            kind: "some-kind"
          }]
      })
    end
    
    should "have a valid id" do
      assert_equal(1, @story.id)
    end
    
    should "have a valid project_id" do
      assert_equal(123, @story.project_id)
    end
    
    should "have a valid url" do
      assert_equal("http://www.url.com", @story.url)
    end
    
    should "have a valid name" do
      assert_equal("story name", @story.name)
    end
    
    should "have a valid description" do
      assert_equal("story description", @story.description)
    end
    
    should "have a valid story_type" do
      assert_equal("feature", @story.story_type)
    end
    
    should "have a valid estimate" do
      assert_equal(13, @story.estimate)
    end
    
    should "have accurately determined if story is overdue?" do
      assert_equal(true, @story.overdue?)
      @story.estimate = 40
      assert_equal(false, @story.overdue?)
    end
    
    should "have a valid current_state" do
      assert_equal("accepted", @story.current_state)
    end
    
    should "have a valid created_at date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.created_at)
    end
    
    should "have a valid updated_at date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.updated_at)
    end
    
    should "have a valid kind" do
      assert_equal("story", @story.kind)
    end
    
    should "have a valid integration_id" do
      assert_equal(5, @story.integration_id)
    end
    
    should "have a valid deadline date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.deadline)
    end
    
    should "have a valid external_id" do
      assert_equal(222, @story.external_id)
    end
    
    should "have a valid accepted_at date" do
      assert_equal(DateTime.parse("2016-08-19T11:03:53-04:00"), @story.accepted_at)
    end
    
    should "have a valid requested_by_id" do
      assert_equal(2, @story.requested_by_id)
    end
    
    should "have a valid requested_by person" do
      assert_equal("Mike Appleseed", @story.requested_by.name)
    end
    
    should "have a valid owner_ids" do
      assert_equal([3, 4], @story.owner_ids)
    end
    
    should "have valid owners" do
      assert_equal("John Appleseed", @story.owners[0].name)
      assert_equal("Sam Appleseed", @story.owners[1].name)
    end
    
    should "have a valid comment_ids" do
      assert_equal([63], @story.comment_ids)
    end
    
    should "have valid comments" do
      assert_equal("some comment text", @story.comments[0].text)
    end
    
    should "have a valid follower_ids" do
      assert_equal([2, 3, 4], @story.follower_ids)
    end
    
    should "have valid followers" do
      assert_equal("Mike Appleseed", @story.followers[0].name)
      assert_equal("John Appleseed", @story.followers[1].name)
      assert_equal("Sam Appleseed", @story.followers[2].name)
    end
    
    should "have a valid label_ids" do
      assert_equal([20, 30], @story.label_ids)
    end
    
    should "have valid labels" do
      assert_equal("label-one", @story.labels[0].name)
      assert_equal("label-two", @story.labels[1].name)
    end
    
    should "have valid transitions" do
      assert_equal("accepted", @story.transitions[0].state)
    end
    
    should "have a valid task_ids" do
      assert_equal([432], @story.task_ids)
    end
    
    should "have valid tasks" do
      assert_equal("task description", @story.tasks[0].description)
    end
    
  end
  
  
  context "An array of PivotalAPI::Story's" do
    
    setup do
      stories = PivotalAPI::Stories.from_json([{
        id: 1,
        url: "http://www.url.com",
        project_id: 123,
        name: "story name",
        description: "story description",
        story_type: "feature",
        estimate: 13,
        current_state: "started",
        created_at: "2016-08-17T11:03:53-04:00",
        updated_at: "2016-08-17T11:03:53-04:00",
        kind: "story",
        integration_id: 5,
        deadline: "2016-08-17T11:03:53-04:00",
        external_id: 222,
        accepted_at: "2016-08-17T11:03:53-04:00",
        task_ids: [432],
        tasks: [{
          project_id: 123, 
          story_id: 1, 
          id: 432, 
          description: "task description", 
          position: 1, 
          complete: false, 
          created_at: "2016-08-17T11:03:53-04:00"
        }],
        comment_ids: [63],
        comments: [{
            project_id: 123,
            story_id: 1,
            epic_id: 88,
            id: 63,
            text: "some comment text", 
            person: {
              id: 99,
              name: "Gary Appleseed",
              initials: "GA",
              email: "gary@email.com",
              username: "garyapple"
            }, 
            created_at: "2016-08-17T11:03:53-04:00",
            updated_at: "2016-08-17T11:03:53-04:00",
            file_attachments: [{
              filename: "filename.jpg", 
              id: 333, 
              created_at: "2016-08-09T18:55:58Z", 
              uploaded_by: {
                id: 99,
                name: "Gary Appleseed",
                initials: "GA",
                email: "gary@email.com",
                username: "garyapple"
              }, 
              big_url: "http://www.bigurl.com",
              width: 300, 
              height: 450, 
              download_url: "http://www.downloadurl.com", 
              thumbnail_url: "http://www.thumbnailurl.com",
              size: 1598,
              content_type: "image/jpeg" 
            }],
            google_attachment_ids: [45, 97, 105], 
            commit_identifier: "271921wuwwui2u3uewweiweed3e",
            commit_type: "github",
            kind: "comment"
          }],
        requested_by_id: 2,
        requested_by: {
            id: 2,
            name: "Mike Appleseed",
            initials: "MA",
            email: "mike@email.com",
            username: "mikeapple"
          },
        owner_ids: [3, 4],
        owners: [{
            id: 3,
            name: "John Appleseed",
            initials: "JA",
            email: "john@email.com",
            username: "johnapple"
          },
          {
            id: 4,
            name: "Sam Appleseed",
            initials: "SA",
            email: "sam@email.com",
            username: "sameapple"
          }],
        follower_ids: [2, 3, 4],
        followers: [{
            id: 2,
            name: "Mike Appleseed",
            initials: "MA",
            email: "mike@email.com",
            username: "mikeapple"
          },
          {
            id: 3,
            name: "John Appleseed",
            initials: "JA",
            email: "john@email.com",
            username: "johnapple"
          },
          {
            id: 4,
            name: "Sam Appleseed",
            initials: "SA",
            email: "sam@email.com",
            username: "sameapple"
          }],
        label_ids: [20, 30],
        labels: [{
            id: 20,
            name: "label-one",
            project_id: 123,
            created_at: "2016-08-17T11:03:53-04:00",
            updated_at: "2016-08-17T11:03:53-04:00",
            counts: 3,
            kind: "label"
          },
          {
            id: 30,
            name: "label-two",
            project_id: 123,
            created_at: "2016-08-17T11:03:53-04:00",
            updated_at: "2016-08-17T11:03:53-04:00",
            counts: 4,
            kind: "label"
          }],
        transitions: [{
            state: "started",
            story_id: 1,
            project_id: 2,
            project_version: 3,
            occurred_at: "2016-08-17T11:03:53-04:00",
            performed_by_id: 4,
            kind: "some-kind"
          }]
      }])
      
      @story = stories[0]
    end
    
    should "have a valid id" do
      assert_equal(1, @story.id)
    end
    
    should "have a valid project_id" do
      assert_equal(123, @story.project_id)
    end
    
    should "have a valid url" do
      assert_equal("http://www.url.com", @story.url)
    end
    
    should "have a valid name" do
      assert_equal("story name", @story.name)
    end
    
    should "have a valid description" do
      assert_equal("story description", @story.description)
    end
    
    should "have a valid story_type" do
      assert_equal("feature", @story.story_type)
    end
    
    should "have a valid estimate" do
      assert_equal(13, @story.estimate)
    end
    
    should "have a valid current_state" do
      assert_equal("started", @story.current_state)
    end
    
    should "have a valid created_at date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.created_at)
    end
    
    should "have a valid updated_at date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.updated_at)
    end
    
    should "have a valid kind" do
      assert_equal("story", @story.kind)
    end
    
    should "have a valid integration_id" do
      assert_equal(5, @story.integration_id)
    end
    
    should "have a valid deadline date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.deadline)
    end
    
    should "have a valid external_id" do
      assert_equal(222, @story.external_id)
    end
    
    should "have a valid accepted_at date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @story.accepted_at)
    end
    
    should "have a valid requested_by_id" do
      assert_equal(2, @story.requested_by_id)
    end
    
    should "have a valid requested_by person" do
      assert_equal("Mike Appleseed", @story.requested_by.name)
    end
    
    should "have a valid owner_ids" do
      assert_equal([3, 4], @story.owner_ids)
    end
    
    should "have valid owners" do
      assert_equal("John Appleseed", @story.owners[0].name)
      assert_equal("Sam Appleseed", @story.owners[1].name)
    end
    
    should "have a valid comment_ids" do
      assert_equal([63], @story.comment_ids)
    end
    
    should "have valid comments" do
      assert_equal("some comment text", @story.comments[0].text)
    end
    
    should "have a valid follower_ids" do
      assert_equal([2, 3, 4], @story.follower_ids)
    end
    
    should "have valid followers" do
      assert_equal("Mike Appleseed", @story.followers[0].name)
      assert_equal("John Appleseed", @story.followers[1].name)
      assert_equal("Sam Appleseed", @story.followers[2].name)
    end
    
    should "have a valid label_ids" do
      assert_equal([20, 30], @story.label_ids)
    end
    
    should "have valid labels" do
      assert_equal("label-one", @story.labels[0].name)
      assert_equal("label-two", @story.labels[1].name)
    end
    
    should "have valid transitions" do
      assert_equal("started", @story.transitions[0].state)
    end
    
    should "have a valid task_ids" do
      assert_equal([432], @story.task_ids)
    end
    
    should "have valid tasks" do
      assert_equal("task description", @story.tasks[0].description)
    end
    
  end
end
