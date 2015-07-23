module Scorer
  class Comment < Scorer::Base

    attr_accessor :project_id, :story_id, :id, :text, :author, :created_at, :updated_at, :file_attachments

    def self.fields
      ["person(#{Scorer::Person.fields.join(',')})", 'text', 'updated_at', 'id',
       'created_at', 'story_id', 'file_attachments']
    end

    def self.parse_json_comments(json_comments, story)
      comments = Array.new
      json_comments.each do |comment|
        person = Scorer::Person.parse_json_person(comment[:person]) if comment[:person]
        person = Scorer::Person.parse_json_person({
          id: '0',
          name: 'Unkown',
          initials: 'Unkown',
          username: 'Unkown',
          email: 'Unkown'
        }) if person.nil?
        file_attachments = []
        file_attachments = Scorer::Attachment.parse_attachments(comment[:file_attachments]) if comment[:file_attachments]
        comments << new({
          id: comment[:id].to_i,
          text: comment[:text],
          author: person,
          created_at: DateTime.parse(comment[:created_at].to_s).to_s,
          updated_at: DateTime.parse(comment[:updated_at].to_s).to_s,
          file_attachments: file_attachments
        })
      end
      comments
    end

  end
end
