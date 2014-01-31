module Scorer
  class Comment

    attr_accessor :story, :project_id, :story_id, :id, :text, :author, :created_at, :updated_at

    def self.fields
      ['person', 'text', 'updated_at', 'id', 'created_at', 'story_id']
    end

    def self.parse_json_comments(json_comments, story)
      comments = Array.new
      json_comments.each do |comment|
        person = Scorer::Person.parse_json_person({id: '0', name: 'Unkown', initials: 'Unkown', username: 'Unkown', email: 'Unkown'})
        if comment[:person]
          person = Scorer::Person.parse_json_person(comment[:person])
        end
        comments << new({
          id: comment[:id].to_i,
          text: comment[:text],
          author: person,
          created_at: DateTime.parse(comment[:created_at].to_s).to_s,
          updated_at: DateTime.parse(comment[:updated_at].to_s).to_s,
          story: story
        })
      end
      comments
    end

    def initialize(attributes={})
      if attributes[:owner]
        self.story = attributes.delete(:owner)
        self.project_id = self.story.project_id
        self.story_id = self.story.id
      end

      update_attributes(attributes)
    end

    protected

    def update_attributes(attrs)
      attrs.each do |key, value|
        self.send("#{key}=", value.is_a?(Array) ? value.join(',') : value )
      end
    end

  end
end
