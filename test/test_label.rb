require 'helper'

class TestLabel < Test::Unit::TestCase
  
  context "A PivotalAPI::Label" do
    
    setup do
      @label = PivotalAPI::Label.from_json({
            id: 1,
            project_id: 2,
            name: "some-label",
            created_at: "2016-08-09T18:55:58Z",
            updated_at: "2016-08-09T18:55:58Z",
            counts: 4,
            kind: "some-kind"
          })
    end
  
    should "should have valid attributes" do
      assert_equal(1, @label.id)
      assert_equal(2, @label.project_id)
      assert_equal("some-label", @label.name)
      assert_equal(DateTime.parse("2016-08-09T18:55:58Z"), @label.created_at)
      assert_equal(DateTime.parse("2016-08-09T18:55:58Z"), @label.updated_at)
      assert_equal(4, @label.counts)
      assert_equal("some-kind", @label.kind)
    end
  end
end