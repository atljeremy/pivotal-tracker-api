# PROPERTIES
# number int
#  —  Iteration number starting from 1 for the first iteration in the project. This field is read only. This field is always returned.
#
# project_id int
#  —  id of the project. This field is read only.
#
# length int
#  —  Iteration length in weeks.
#
# team_strength float
#  —  Iteration team strength, 1.0 is full-strength.
#
# story_ids List[int]
#  —  Array of stories contained in the iteration. This field is read only. By default this will be included in responses as an array of nested structures, using the key stories. In API responses, this attribute may be story_ids or stories.
#
# start datetime
#  —  Iteration start time. This field is read only.
#
# finish datetime
#  —  Iteration finish time. This field is read only.
#
# velocity float
#  —  The averaged number of points completed over a number of previous iterations, as determined by the project's velocity_averaged_over attribute. This field is read only. This field is excluded by default.
#
# points int
#  —  The number of points in the iteration. This field is read only. This field is excluded by default.
#
# effective_points float
#  —  The number of points in the iteration normalized by iteration length and team strength. This field is read only. This field is excluded by default.
#
# accepted daily_history_container
#  —  The daily summary of stories accepted in this iteration. This field is read only. This field is excluded by default.
#
# created daily_history_container
#  —  The number of stories created in this iteration by type. This field is read only. This field is excluded by default.
#
# analytics analytics
#  —  Analytics data for this iteration. This field is read only. This field is excluded by default.
#
# kind string
#  —  The type of this object: iteration. This field is read only.

module PivotalAPI
  class Iteration < Base

    attr_accessor :project_id, :length, :stories, :story_ids, :number, :team_strength, 
                  :finish, :kind, :start, :velocity, :points, :effective_points, :analytics

    def self.fields
      ['velocity', 'points', 'effective_points', 'analytics', "stories(#{Story.fields.join(',')})", 'team_strength', 
       'project_id', 'length', 'start', 'finish']
    end

    def self.from_json(json)
      parse_json_iteration(json)
    end
    
    protected

    def self.parse_json_iteration(json_iteration)
      new({
        project_id: json_iteration[:project_id].to_i,
        stories: Stories.from_json(json_iteration[:stories]),
        story_ids: json_iteration[:story_ids],
        number: json_iteration[:number],
        team_strength: json_iteration[:team_strength],
        finish: json_iteration[:finish],
        kind: json_iteration[:kind],
        start: json_iteration[:start]
      })
    end

  end
  
  class Iterations < Iteration
    
    def self.from_json(json)
      parse_json_iterations(json)
    end
    
    protected
    
    def self.parse_json_iterations(json_iterations)
      iterations = []
      json_iterations.each { |iteration| iterations << parse_json_iteration(iteration) }
      iterations
    end
    
  end
end