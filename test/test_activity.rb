require 'helper'

class TestActivity < Test::Unit::TestCase
  
  context "A PivotalAPI::Activity" do 
  
    setup do
      @activity = PivotalAPI::Activity.from_json([{
            project_id: 1,
            occurred_at: "2016-08-17T11:03:53-04:00",
            highlight: "some-string",
            primary_resources: [{foo: "bar"}],
            changes: [{abc: "123"}],
            guid: "123abc",
            kind: "some-kind",
            performed_by_id: 2,
            performed_by: {
              id: 2,
              name: "John Appleseed",
              initials: "JA",
              email: "john@email.com",
              username: "johnapple"
            },
            message: "some message",
            project_version: 3
          }])
    end

    should "have a valid project_id" do
      assert_equal(1, @activity[0].project_id)
    end
    
    should "have a valid occurred_at date" do
      assert_equal(DateTime.parse("2016-08-17T11:03:53-04:00"), @activity[0].occurred_at)
    end
    
    should "have a valid highlight" do
      assert_equal("some-string", @activity[0].highlight)
    end
    
    should "have valid primary_resources" do
      assert_equal("bar", @activity[0].primary_resources[0][:foo])
    end
    
    should "have valid changes" do
      assert_equal("123", @activity[0].changes[0][:abc])
    end
    
    should "have a valid guid" do
      assert_equal("123abc", @activity[0].guid)
    end
    
    should "have a valid kind" do
      assert_equal("some-kind", @activity[0].kind)
    end
    
    should "have a valid performed_by_id" do
      assert_equal(2, @activity[0].performed_by_id)
    end
    
    should "have a valid performed_by person" do
      person = @activity[0].performed_by
      assert_equal(2, person.id)
      assert_equal("John Appleseed", person.name)
      assert_equal("JA", person.initials)
      assert_equal("john@email.com", person.email)
      assert_equal("johnapple", person.username)
    end
    
    should "have a valid message" do
      assert_equal("some message", @activity[0].message)
    end
    
    should "have a valid project_version" do
      assert_equal(3, @activity[0].project_version)
    end
    
  end
end
