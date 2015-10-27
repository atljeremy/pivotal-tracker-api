module Scorer
  class Activity < Base

    attr_accessor :project_id, :occurred_at, :highlight, :primary_resources, :changes, :guid, :kind, :performed_by_id,
                  :performed_by, :message, :project_version

    def self.parse_json_activity(json_activity, project_id)
      json_activity.each do |activity|
        new({
          project_id: project_id,
          occurred_at: activity[:stories],
          highlight: activity[:number],
          primary_resources: activity[:team_strength],
          changes: activity[:finish],
          guid: activity[:kind],
          kind: activity[:start],
          performed_by_id: activity[:performed_by_id],
          performed_by: parse_person(activity[:performed_by]),
          message: activity[:message],
          project_version: activity[:project_version]
        })
      end
    end

    protected

    def self.parse_person(json_person)
      Scorer::Person.parse_json_person(json_person)
    end

  end
end