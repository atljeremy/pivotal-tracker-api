# PROPERTIES
# id int
#  —  Database id of the task. This field is read only. This field is always returned.
#
# story_id int
#  —  The id of the story to which the task is connected. This field is read only.
#
# description string[1000]
# Required On Create  —  Content of the task. This field is required on create.
#
# complete boolean
#  —  Flag showing the completion of the task.
#
# position int
#  —  Offset from the top of the task list. Positions start counting from 1 for the first task on a story.
#
# created_at datetime
#  —  Creation time. This field is read only.
#
# updated_at datetime
#  —  Time of last update. This field is read only.
#
# kind string
#  —  The type of this object: task. This field is read only.

module PivotalAPI
  class Task < Base

    attr_accessor :project_id, :story_id, :id, :description, :position, :complete, :created_at

    def self.from_json(json)
      return nil unless json
      parse_task(json)
    end

    protected
    
    def self.parse_task(task)
      new({
        id: task[:id].to_i,
        description: task[:description],
        complete: task[:complete],
        created_at: DateTime.parse(task[:created_at].to_s),
        story_id: task[:id]
      })
    end
  end
  
  class Tasks < Task
    
    def self.from_json(json)
      return nil unless json
      parse_tasks(json)
    end

    protected
    
    def self.parse_tasks(tasks)
      parsed_tasks = []
      tasks.each { |task| parsed_tasks << parse_task(task) }
      parsed_tasks
    end
    
  end
end