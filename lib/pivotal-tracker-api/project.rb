module Scorer
  class Project < Base

    attr_accessor :updated_at, :bugs_and_chores_are_estimatable, :enable_planned_mode, :public, :story_ids, :name,
                  :iteration_length, :start_time, :version, :label_ids, :description, :profile_content,
                  :iteration_override_numbers, :velocity_averaged_over, :current_velocity, :point_scale_is_custom,
                  :epic_ids, :membership_ids, :integration_ids, :created_at, :week_start_day, :time_zone,
                  :shown_iterations_start_time, :has_google_domain, :kind, :id, :point_scale, :current_iteration_number,
                  :start_date, :number_of_done_iterations_to_show, :account_id, :labels

    class << self

      def fields
        ['description', 'labels', 'name']
      end

      def parse_json_projects(json_projects)
        projects = Array.new
        json_projects.each do |project|
          projects << parse_json_project(project)
        end
        projects
      end

      def parse_json_project(project)
        new({
          id: project[:id].to_i,
          name: project[:name],
          week_start_day: project[:week_start_day],
          point_scale: project[:point_scale],
          labels: parse_labels(project[:labels]),
          iteration_length: project[:iteration_length],
          current_velocity: project[:current_velocity]
        })
      end

      def parse_labels(labels)
        parsed_labels = ''
        labels.each do |label|
          parsed_labels = parsed_labels + "#{label[:name]},"
        end
        parsed_labels
      end
    end

    def initialize(attributes={})
      update_attributes(attributes)
    end

    def get_labels
      self.labels.split(',')
    end

  end
end