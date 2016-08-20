# PROPERTIES
# guid string
#  —  Project id and version of the activity. This field is read only. This field is always returned.
#
# project_version int
#  —  The version of the activity. This field is read only. This field is always returned.
#
# message string
#  —  Description of the activity. This field is read only.
#
# highlight string
#  —  Boldface portion of the message. This field is read only.
#
# changes List[object]
#  —  The set of changes. This field is read only.
#
# primary_resources List[object]
#  —  The primary resource(s) affected by this command. This field is read only.
#
# project_id int
#  —  id of the project. This field is read only. By default this will be included in responses as a nested structure, using the key project.
#
# performed_by_id int
#  —  id of the person who performed this change. This field is read only. By default this will be included in responses as a nested structure, using the key performed_by.
#
# occurred_at datetime
#  —  Time of the activity. This field is read only.
#
# kind string
#  —  Thevalue of 'kind' will reflect the specific type of activity that an activity resource represents. The value will be a string that ends in '_activity' and which starts with a name based on the change which occurred. This field is read only.
 
module PivotalAPI
  class Activity < Base

    attr_accessor :project_id, :occurred_at, :highlight, :primary_resources, 
                  :changes, :guid, :kind, :performed_by_id,
                  :performed_by, :message, :project_version

    def self.from_json(json)
      parse_json_activity(json) if json.is_a?(Array)
    end

    protected
    
    def self.parse_json_activity(json_activity)
      parsed_activity = []
      json_activity.each do |activity|
        parsed_activity << new({
          project_id: activity[:project_id].to_i,
          occurred_at: DateTime.parse(activity[:occurred_at].to_s),
          highlight: activity[:highlight],
          primary_resources: activity[:primary_resources],
          changes: activity[:changes],
          guid: activity[:guid],
          kind: activity[:kind],
          performed_by_id: activity[:performed_by_id],
          performed_by: Person.from_json(activity[:performed_by]),
          message: activity[:message],
          project_version: activity[:project_version]
        })
      end
      parsed_activity
    end

  end
end