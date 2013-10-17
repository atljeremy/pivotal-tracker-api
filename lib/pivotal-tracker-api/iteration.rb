module Scorer
  class Iteration

    attr_accessor :project_id, :length, :planned, :stories, :story_ids, :number, :team_strength, :finish, :kind, :start

    def initialize(attributes={})
      update_attributes(attributes)
    end

    def self.parse_json_iteration(json_iteration)
      new({
        project_id: json_iteration[:project_id].to_i,
        stories: parse_stories(json_iteration[:stories], json_iteration[:project_id].to_i),
        story_ids: json_iteration[:story_ids],
        number: json_iteration[:number],
        team_strength: json_iteration[:team_strength],
        finish: json_iteration[:finish],
        kind: json_iteration[:kind],
        start: json_iteration[:start]
      })
    end

    protected

    def self.parse_stories(stories, project_id)
      story_ids = Array.new
      stories.each { |story| story_ids << story[:id].to_i if !story[:id].nil? }
      project = PivotalService.one_project(project_id)
      PivotalService.stories(project, true, story_ids, Scorer::Story.fields)
    end

    def update_attributes(attrs)
      attrs.each do |key, value|
        self.send("#{key}=", value )
      end
    end

  end
end