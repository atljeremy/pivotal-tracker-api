module Scorer
  class Iteration

    attr_accessor :project_id, :length, :planned, :stories, :story_ids, :number, :team_strength, :finish, :kind, :start

    def initialize(attributes={})
      update_attributes(attributes)
    end

    def self.parse_json_iteration_with_comments(json_iteration)
      parse_iteration(json_iteration, true)
    end

    def self.parse_json_iteration(json_iteration)
      parse_iteration(json_iteration, false)
    end

    protected

    def self.parse_iteration(json_iteration, with_comments)
      new({
        project_id: json_iteration[:project_id].to_i,
        stories: parse_stories(json_iteration[:stories], json_iteration[:project_id].to_i, with_comments),
        story_ids: json_iteration[:story_ids],
        number: json_iteration[:number],
        team_strength: json_iteration[:team_strength],
        finish: json_iteration[:finish],
        kind: json_iteration[:kind],
        start: json_iteration[:start]
      })
    end

    def self.parse_stories(stories, project_id, with_comments)
      story_ids = Array.new
      stories.each { |story| story_ids << story[:id].to_i if !story[:id].nil? }
      project = PivotalService.one_project(project_id)
      PivotalService.stories(project, true, with_comments, story_ids, Scorer::Story.fields)
    end

    def update_attributes(attrs)
      attrs.each do |key, value|
        self.send("#{key}=", value )
      end
    end

  end
end