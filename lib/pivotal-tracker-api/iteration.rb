module Scorer
  class Iteration < Base

    attr_accessor :project_id, :length, :planned, :stories, :story_ids, :number, :team_strength, :finish, :kind, :start

    def self.parse_json_iteration(json_iteration, include_done)
      new({
        project_id: json_iteration[:project_id].to_i,
        stories: parse_stories(json_iteration[:stories], json_iteration[:project_id].to_i, include_done),
        story_ids: json_iteration[:story_ids],
        number: json_iteration[:number],
        team_strength: json_iteration[:team_strength],
        finish: json_iteration[:finish],
        kind: json_iteration[:kind],
        start: json_iteration[:start]
      })
    end

    protected

    def self.parse_stories(stories, project_id, include_done)
      story_ids = Array.new
      stories.each { |story| story_ids << story[:id].to_i if !story[:id].nil? }
      project = PivotalService.one_project(project_id)
      PivotalService.stories(project, true, story_ids, Scorer::Story.fields, include_done)
    end

  end
end