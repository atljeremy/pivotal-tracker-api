# state enumerated string
#  —  State the story transitioned to. This field is read only.
# Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled
#
# story_id int
#  —  ID of the story. This field is read only.
#
# project_id int
#  —  ID of the project. This field is read only.
#
# project_version int
#  —  The activity version of the story transition. This field is read only.
#
# occurred_at datetime
#  —  Time of the transition. This field is read only.
#
# performed_by_id int
#  —  ID of the person who performed the story transition. This field is read only.
#
# kind string
#  —  The type of this object: story_transition. This field is read only.

module PivotalAPI
  class StoryTransition < Base

    attr_accessor :state, :story_id, :project_id, :project_version, :occurred_at, :performed_by_id, :kind

    class << self
      
      def from_json(json)
        return nil unless json
        if json.is_a?(Array)
          parse_json_story_transitions(json)
        else
          parse_json_story_transition(json)
        end
      end

      def parse_json_story_transitions(json_story_transitions)
        transitions = []
        json_story_transitions.each do |transition|
          transitions << parse_json_story_transition(transition)
        end
        transitions
      end

      def parse_json_story_transition(json_story_transition)
        new({
          state: json_story_transition[:state],
          story_id: json_story_transition[:story_id].to_i,
          project_id: json_story_transition[:project_id].to_i,
          project_version: json_story_transition[:project_version].to_i,
          occurred_at: (DateTime.parse(json_story_transition[:occurred_at]) if json_story_transition[:occurred_at]),
          performed_by_id: json_story_transition[:performed_by_id].to_i,
          kind: json_story_transition[:kind]
        })
      end
      
    end

  end
  
  class StoryTransitions < StoryTransition
    
    class << self
      
      def from_json(json)
        return nil unless json
        parse_json_story_transitions(json)
      end

      def parse_json_story_transitions(story_transitions)
        transitions = []
        story_transitions.each { |transition| transitions << parse_json_story_transition(transition) }
        transitions
      end
      
    end
    
  end
end
