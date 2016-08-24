# PROPERTIES
# id int
#  —  Database id of the story. This field is read only. This field is always returned.
#
# project_id int
#  —  id of the project.
#
# name string[5000]
# Required On Create  —  Name of the story. This field is required on create.
#
# description string[20000]
#  —  In-depth explanation of the story requirements.
#
# story_type enumerated string
#  —  Type of story.
# Valid enumeration values: feature, bug, chore, release
#
# current_state enumerated string
#  —  Story's state of completion.
# Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled
#
# estimate float
#  —  Point value of the story.
#
# accepted_at datetime
#  —  Acceptance time.
#
# deadline datetime
#  —  Due date/time (for a release-type story).
#
# requested_by_id int
#  —  The id of the person who requested the story. In API responses, this attribute may be requested_by_id or requested_by.
#
# owned_by_id int
#  —  The id of the person who owns the story. In API responses, this attribute may be owned_by_id or owned_by.
#
# owner_ids List[int]
#  —  IDs of the current story owners. By default this will be included in responses as an array of nested structures, using the key owners. In API responses, this attribute may be owner_ids or owners.
#
# label_ids List[int]
#  —  IDs of labels currently applied to story. By default this will be included in responses as an array of nested structures, using the key labels. In API responses, this attribute may be label_ids or labels.
#
# task_ids List[int]
#  —  IDs of tasks currently on the story. This field is writable only on create. This field is excluded by default. In API responses, this attribute may be task_ids or tasks.
#
# follower_ids List[int]
#  —  IDs of people currently following the story. This field is excluded by default. In API responses, this attribute may be follower_ids or followers.
#
# comment_ids List[int]
#  —  IDs of comments currently on the story. This field is writable only on create. This field is excluded by default. In API responses, this attribute may be comment_ids or comments.
#
# created_at datetime
#  —  Creation time. This field is writable only on create.
#
# updated_at datetime
#  —  Time of last update. This field is read only.
#
# before_id int
#  —  ID of the story that the current story is located before. Null if story is last one in the project. This field is excluded by default.
#
# after_id int
#  —  ID of the story that the current story is located after. Null if story is the first one in the project. This field is excluded by default.
#
# integration_id int
#  —  ID of the integration API that is linked to this story. In API responses, this attribute may be integration_id or integration.
#
# external_id string[255]
#  —  The integration's specific ID for the story. (Note that this attribute does not indicate an association to another resource.)
#
# url string
#  —  The url for this story in Tracker. This field is read only.
#
# transitions List[story_transition]
#  —  All state transitions for the story. This field is read only. This field is excluded by default.
#
# cycle_time_details cycle_time_details
#  —  All information regarding a story's cycle time and state transitions (duration and occurrences). This field is read only. This field is excluded by default.
#
# kind string
#  —  The type of this object: story. This field is read only.

module PivotalAPI
  class Story < Base

    attr_accessor :project_id, :follower_ids, :followers, :updated_at, :current_state, 
                  :name, :comment_ids, :url, :story_type, :label_ids, :description, 
                  :requested_by_id, :external_id, :deadline, :owner_ids, :owners, 
                  :created_at, :estimate, :kind, :id, :task_ids, :integration_id, 
                  :accepted_at, :comments, :tasks, :has_attachments, :requested_by, 
                  :labels, :transitions, :after_id,
                  :before_id, :cycle_time_details

    def self.fields
      ['url', 'name', 'description', 'story_type',
       'estimate', 'current_state', 'requested_by',
       'owners', 'labels', 'integration_id',
       'deadline', "comments(#{PivotalAPI::Comment.fields.join(',')})", 
       'tasks', 'transitions', 'followers', 'cycle_time_details',
       'accepted_at']
    end
    
    def self.from_json(json)
      parse_json_story(json)
    end
    
    def hours
      return 0 if transitions.nil?
      duration_hrs = 0
      prev_transition = nil
      transitions.reverse.each do |transition|
        case transition.state
        when 'started'
          prev_transition = transition
        when 'finished'
          if prev_transition
            start_time = Time.parse(prev_transition.occurred_at.to_s)
            end_time = Time.parse(transition.occurred_at.to_s)
            duration_hrs += hours_between(start_time, end_time)
          end
          prev_transition = transition
        when 'delivered'
          if prev_transition
            start_time = Time.parse(prev_transition.occurred_at.to_s)
            end_time = Time.parse(transition.occurred_at.to_s)
            duration_hrs += hours_between(start_time, end_time)
          end
          prev_transition = transition
        when 'rejected'
          if prev_transition
            start_time = Time.parse(prev_transition.occurred_at.to_s)
            end_time = Time.parse(transition.occurred_at.to_s)
            duration_hrs += hours_between(start_time, end_time)
          end
          prev_transition = transition
        when 'accepted'
          if prev_transition
            start_time = Time.parse(prev_transition.occurred_at.to_s)
            end_time = Time.parse(transition.occurred_at.to_s)
            duration_hrs += hours_between(start_time, end_time)
          end
          prev_transition = transition
        end
      end
      
      if current_state != 'accepted' && prev_transition && prev_transition.state == 'started'
        return hours_between(Time.parse(prev_transition.occurred_at.to_s), Time.now)
      end
      
      duration_hrs
    end

    def overdue?
      return false if estimate < 0
      hours >= estimate
    end

    protected
    
    def hours_between(start_time, end_time)
      return 0 unless start_time && end_time
      seconds = start_time.business_time_until(end_time)
      minutes = seconds / 60
      hours = minutes / 60
      hours.round
    end
    
    def self.parse_json_story(json_story)
      estimate = json_story[:estimate] ? json_story[:estimate].to_i : -1
      parsed_story = new({
        id: json_story[:id].to_i,
        url: json_story[:url],
        project_id: json_story[:project_id],
        name: json_story[:name],
        description: json_story[:description],
        story_type: json_story[:story_type],
        estimate: estimate,
        current_state: json_story[:current_state],
        requested_by_id: json_story[:requested_by_id],
        requested_by: Person.from_json(json_story[:requested_by]),
        owner_ids: json_story[:owner_ids],
        owners: People.from_json(json_story[:owners]),
        follower_ids: json_story[:follower_ids],
        followers: People.from_json(json_story[:followers]),
        label_ids: json_story[:label_ids],
        labels: Labels.from_json(json_story[:labels]),
        integration_id: json_story[:integration_id],
        deadline: (DateTime.parse(json_story[:deadline]) if json_story[:deadline]),
        transitions: StoryTransitions.from_json(json_story[:transitions]),
        updated_at: (DateTime.parse(json_story[:updated_at]) if json_story[:updated_at]),
        created_at: (DateTime.parse(json_story[:created_at]) if json_story[:created_at]),
        comment_ids: json_story[:comment_ids],
        kind: json_story[:kind],
        task_ids: json_story[:task_ids],
        tasks: Tasks.from_json(json_story[:tasks]),
        accepted_at: (DateTime.parse(json_story[:accepted_at]) if json_story[:accepted_at]),
        cycle_time_details: CycleTimeDetails.from_json(json_story[:cycle_time_details]),
        external_id: json_story[:external_id]
      })

      parsed_story.comments = Comments.from_json(json_story[:comments])
      parsed_story.has_attachments = false
      if !parsed_story.comments.nil? && parsed_story.comments.count > 0
        parsed_story.comments.each do |note|
          if note.file_attachments.count > 0
            parsed_story.has_attachments = true
            break
          end
        end
      end
      
      parsed_story
    end

    def self.est_time_zone(time)
      time.in_time_zone("Eastern Time (US & Canada)")
    end

  end
  
  class Stories < Story
    
    def self.from_json(json)
      parse_json_stories(json)
    end
    
    protected
    
    def self.parse_json_stories(json_stories)
      stories = []
      json_stories.each { |story| stories << parse_json_story(story) }
      stories
    end
    
  end
end