require 'json'
require 'pry'

class PivotalService

  class << self

    def set_token(token)
      Scorer::Client.token = token
    end

    def all_projects(fields=[])
      api_url = append_fields('/projects', fields)
      response = Scorer::Client.get(api_url)
      json_projects = JSON.parse(response, {:symbolize_names => true})
      Scorer::Project.parse_json_projects(json_projects)
    end

    def one_project(id, fields=[])
      return @project if !@project.nil? && @project.id == id

      api_url = append_fields('/projects' + "/#{id}", fields)
      response = Scorer::Client.get(api_url)
      json_project = JSON.parse(response, {:symbolize_names => true})
      @project = Scorer::Project.parse_json_project(json_project)
    end

    def activity(project_id, story_id=0, limit=20)
      api_url = "/projects/#{project_id}/"
      api_url = api_url + "stories/#{story_id}/" if story_id > 0
      api_url = api_url + "activity?limit=#{limit}"
      response = Scorer::Client.get(api_url)
      json_activity = JSON.parse(response, {:symbolize_names => true})
      Scorer::Activity.parse_json_activity(json_activity, project_id)
    end

    def iterations(project_id, scope, fields=[], limit=1, offset=1)
      return @iterations if !@iterations.nil? && @iterations.last.project_id == project_id

      api_url = "/projects/#{project_id}/iterations?"

      if scope == 'current'
        api_url = append_scope(api_url, scope)
      elsif scope == 'done' || scope == 'backlog' || scope == 'current_backlog'
        api_url = append_limit_offset(api_url, limit, offset)
        api_url = append_scope(api_url, scope)
      else
        api_url = append_limit_offset(api_url, limit, offset)
      end

      api_url = append_fields(api_url, fields)
      response = Scorer::Client.get_with_caching(api_url)
      json_iterations = JSON.parse(response, {:symbolize_names => true})
      @iterations = []
      json_iterations.each do |iteration|
        @iterations << Scorer::Iteration.parse_json_iteration(iteration, (scope == 'done'))
      end
      @iterations
    end

    def all_stories(project_label, project, fields=[])
      api_url = append_fields('/projects' + "/#{project.id}/stories", fields)
      api_url = api_url + "&with_label=#{project_label}&with_state=unstarted&limit=100"
      response = Scorer::Client.get(api_url)
      json_stories = JSON.parse(response, {:symbolize_names => true})
      Scorer::Story.parse_json_stories(json_stories, project.id)
    end

    def one_story(project_label, project, fields=[])
      api_url = append_fields('/projects' + "/#{project.id}/stories", fields)
      api_url = api_url + "&with_label=#{project_label}&with_state=unstarted&limit=100"
      response = Scorer::Client.get(api_url)
      json_story = JSON.parse(response, {:symbolize_names => true})
      Scorer::Story.parse_json_story(json_story, project.id)
    end

    def stories(project, should_cache, ids=[], fields=[], include_done=false)
      @stories = Array.new
      api_url = append_fields('/projects' + "/#{project.id}/stories", fields)
      if api_url.rindex('?fields=')
        api_url = "#{api_url}&filter=includedone%3A#{include_done}%20id%3A"
      else
        api_url = "#{api_url}?filter=includedone%3A#{include_done}%20id%3A"
      end
      if ids.size == 1
        api_url = api_url + ids[0].to_s
        if should_cache
          response = Scorer::Client.get_with_caching(api_url)
        else
          response = Scorer::Client.get(api_url)
        end
        json_story = JSON.parse(response, {:symbolize_names => true})
        @stories << Scorer::Story.parse_json_story(json_story[0], project.id)
      else
        story_ids = ''
        ids.each do |id|
          story_ids = "#{story_ids}#{id}%2C"
        end
        api_url = api_url + story_ids
        if should_cache
          response = Scorer::Client.get_with_caching(api_url)
        else
          response = Scorer::Client.get(api_url)
        end
        json_stories = JSON.parse(response, {:symbolize_names => true})
        @stories = Scorer::Story.parse_json_stories(json_stories, project.id)
      end
    end

    def update_story(story_id, project_id, updates={})
      project = one_project(project_id, Scorer::Project.fields)
      api_url = '/projects' + "/#{project.id}/stories/#{story_id}"
      Scorer::Client.put(api_url, updates)
    end

    def comments(project_id, story, fields)
      api_url = append_fields('/projects' + "/#{project_id}/stories/#{story.id}/comments", fields)
      response = Scorer::Client.get_with_caching(api_url)
      json_comments = JSON.parse(response, {:symbolize_names => true})
      Scorer::Comment.parse_json_comments(json_comments, story)
    end

    private

    def append_fields(api_url, fields)
      url = api_url
      fields.each do |field|
        url = url.rindex('?fields=') ? url + ",#{field}" : url + "?fields=#{field}"
      end
      url
    end

    def append_scope(api_url, scope)
      api_url + "&scope=#{scope}"
    end

    def append_limit_offset(api_url, limit, offset)
      api_url + "&limit=#{limit}&offset=#{offset}"
    end

  end
end