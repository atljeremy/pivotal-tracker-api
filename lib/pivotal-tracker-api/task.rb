module Scorer
  class Task

    attr_accessor :project_id, :story_id, :story, :id, :description, :position, :complete, :created_at

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