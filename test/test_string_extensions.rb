require 'helper'

class TestActivity < Test::Unit::TestCase
  
  context "Appending query params" do 

    should "should append limit, offset, and fields as expected" do
      url = "/projects/12345/stories"
      query_params = {
        limit: 1,
        offset: 2,
        fields: PivotalAPI::Comment.fields
      }
      url.append_pivotal_params(query_params)
      expected_url = "/projects/12345/stories?limit=1&offset=2"
      expected_url += "&fields=person(name,id,initials,email,username,kind),text,updated_at,id," \
                      "created_at,story_id,file_attachments,google_attachment_ids,commit_identifier,commit_type,kind"
      assert_equal(expected_url, url)
    end
    
    should "should append filters" do
      url = "/projects/12345/stories"
      query_params = {
        limit: 1,
        offset: 2,
        filter: {
          includedone: true,
          id: [1,2,3,4,5]
        }
      }
      url.append_pivotal_params(query_params)
      expected_url = "/projects/12345/stories?limit=1&offset=2&filter=includedone%3Atrue%20id%3A1,2,3,4,5"
      assert_equal(expected_url, url)
    end
    
  end
end
