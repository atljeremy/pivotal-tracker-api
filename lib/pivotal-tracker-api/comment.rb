# PROPERTIES
# id int
#  —  Database id of the comment. This field is read only. This field is always returned.
#
# story_id int
#  —  The id of the story to which the comment is attached (will be absent if comment attached to an epic. This field is read only.
#
# epic_id int
#  —  The id of the epic to which the comment is attached (will be absent if comment attached to a story. This field is read only.
#
# text string[20000]
#  —  Content of the comment. This field is writable only on create.
#
# person_id int
#  —  The id of the comment creator. This field is writable only on create. In API responses, this attribute may be person_id or person.
#
# created_at datetime
#  —  Creation time. This field is read only.
#
# updated_at datetime
#  —  Updated time. (Comments are updated by removing one of their attachments.) This field is read only.
#
# file_attachment_ids List[int]
#  —  IDs of any file attachments associated with the comment. This field is writable only on create. This field is excluded by default. In API responses, this attribute may be file_attachment_ids or file_attachments.
#
# google_attachment_ids List[int]
#  —  IDs of any google attachments associated with the comment. This field is writable only on create. This field is excluded by default. In API responses, this attribute may be google_attachment_ids or google_attachments.
#
# commit_identifier string[255]
#  —  Commit Id on the remote source control system for the comment. Present only on comments that were created by a POST to the source commits API endpoint. This field is writable only on create. (Note that this attribute does not indicate an association to another resource.)
#
# commit_type string[255]
#  —  String identifying the type of remote source control system if Pivotal Tracker can determine it. Present only on comments that were created by a POST to the source commits API endpoint. This field is writable only on create.
#
# kind string
#  —  The type of this object: comment. This field is read only.

module PivotalAPI
  class Comment < Base

    attr_accessor :project_id, :story_id, :epic_id, :id, :text, :person, 
                  :created_at, :updated_at, :file_attachments, 
                  :google_attachment_ids, :commit_identifier, :commit_type, 
                  :kind

    def self.fields
      ["person(#{PivotalAPI::Person.fields.join(',')})", 'text', 'updated_at', 'id',
       'created_at', 'story_id', 'file_attachments', 'google_attachment_ids',
       'commit_identifier', 'commit_type', 'kind']
    end
    
    def self.from_json(json)
      parse_json_comment(json)
    end
    
    def self.parse_json_comment(comment)
      person = PivotalAPI::Person.from_json(comment[:person]) if comment[:person]
      person = PivotalAPI::Person.unkown if person.nil?
      new({
        id: comment[:id].to_i,
        text: comment[:text],
        person: person,
        created_at: DateTime.parse(comment[:created_at].to_s),
        updated_at: DateTime.parse(comment[:updated_at].to_s),
        file_attachments: PivotalAPI::FileAttachment.from_json(comment[:file_attachments]),
        commit_identifier: comment[:commit_identifier],
        google_attachment_ids: comment[:google_attachment_ids],
        commit_type: comment[:commit_type],
        kind: comment[:kind]
      })
    end

  end
  
  class Comments < Comment
    def self.from_json(json)
      parse_json_comments(json) if json.is_a?(Array)
    end
    
    def self.parse_json_comments(json_comments)
      comments = []
      json_comments.each { |comment| comments << parse_json_comment(comment) }
      comments
    end
  end
end
