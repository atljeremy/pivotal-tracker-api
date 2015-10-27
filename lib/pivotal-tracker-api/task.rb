module Scorer
  class Task < Base

    attr_accessor :project_id, :story_id, :id, :description, :position, :complete, :created_at

    def self.parse_tasks(tasks, story)
      parsed_tasks = []
      tasks.each do |task|
        parsed_tasks << new({
            id: task[:id].to_i,
            description: task[:description],
            complete: task[:complete],
            created_at: DateTime.parse(task[:created_at].to_s).to_s,
            story_id: story[:id]
        })
      end if tasks

      parsed_tasks
    end
  end
end