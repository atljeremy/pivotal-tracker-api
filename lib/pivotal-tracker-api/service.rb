require 'json'

module PivotalAPI
  class Service

    class << self

      def set_token(token)
        PivotalAPI::Client.token = token
      end

      def get_me
        response = PivotalAPI::Client.get("/me")
        json_me = JSON.parse(response, {:symbolize_names => true})
        PivotalAPI::Me.from_json(json_me)
      end


      def me(username, password)
        PivotalAPI::Client.username = username
        PivotalAPI::Client.password = password
        response = PivotalAPI::Client.ssl_get("/me")
        json_me = JSON.parse(response, {:symbolize_names => true})
        me = PivotalAPI::Me.from_json(json_me)
        PivotalAPI::Client.token = me.api_token
        me
      end

      def activity(opts={})
        # opts:
        #  :project_id - REQUIRED - A valid pivotal project ID
        #  :story_id - OPTIONAL - A valid pivotal story ID. NOTE: Optional if requesting project activity. Required if requesting story activity.
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for each activity
        #  :parameters - OPTIONAL - See list of parameters here https://www.pivotaltracker.com/help/api/rest/v5#Activity
        #
        #  Default Parameters: {limit: 20}

        raise ArgumentError.new("missing required key/value :project_id") unless opts[:project_id]

        project_id = opts[:project_id]
        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:limit] = 20 unless opts[:parameters][:limit]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        api_url = "/projects/#{project_id}/"
        api_url += "stories/#{opts[:story_id]}/" if opts[:story_id]
        api_url += "activity?"
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get(api_url)
        json_activity = JSON.parse(response, {:symbolize_names => true})
        PivotalAPI::Activity.from_json(json_activity)
      end

      def comments(project_id, story, fields)
        # opts:
        #  :project_id - REQUIRED - A valid pivotal project ID
        #  :story_id - REQUIRED - A valid pivotal story ID
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for each activity
        #  :parameters - OPTIONAL - See list of parameters here https://www.pivotaltracker.com/help/api/rest/v5#Activity
        #
        #  Default Parameters: {limit: 20}

        raise ArgumentError.new("missing required key/value :project_id") unless opts[:project_id]
        raise ArgumentError.new("missing required key/value :story_id") unless opts[:story_id]

        project_id = opts[:project_id]
        story_id = opts[:story_id]
        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:limit] = 20 unless opts[:parameters][:limit]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        api_url = "/projects/#{project_id}/stories/#{story_id}/comments"
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get_with_caching(api_url)
        json_comments = JSON.parse(response, {:symbolize_names => true})
        PivotalAPI::Comments.from_json(json_comments)
      end

      def projects(opts={})
        # opts:
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for each project

        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        api_url = '/projects'
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get(api_url)
        json_projects = JSON.parse(response, {:symbolize_names => true})
        PivotalAPI::Projects.from_json(json_projects)
      end

      def project(opts={})
        # opts:
        #  :project_id - REQUIRED - A valid pivotal project ID
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for the project

        raise ArgumentError.new("missing required key/value :project_id") unless opts[:project_id]

        project_id = opts[:project_id]
        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        return @project if !@project.nil? && @project.id == project_id.to_i

        api_url = "/projects/#{project_id}"
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get(api_url)
        json_project = JSON.parse(response, {:symbolize_names => true})
        @project = PivotalAPI::Project.from_json(json_project)
      end

      def iterations(opts={})
        # opts:
        #  :project_id - REQUIRED - A valid pivotal project ID
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for each iteration
        #  :parameters - OPTIONAL - See list of parameters here https://www.pivotaltracker.com/help/api/rest/v5#Iterations
        #
        #  Default Parameters: {scope: 'current', limit: 1, offset: 0}

        raise ArgumentError.new("missing required key/value :project_id") unless opts[:project_id]

        project_id = opts[:project_id]
        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:scope] = 'current' unless opts[:parameters][:scope]
        opts[:parameters][:limit] = 1 unless opts[:parameters][:limit]
        opts[:parameters][:offset] = 0 unless opts[:parameters][:offset]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        api_url = "/projects/#{project_id}/iterations"
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get_with_caching(api_url)
        json_iterations = JSON.parse(response, {:symbolize_names => true})
        PivotalAPI::Iterations.from_json(json_iterations)
      end

      def stories(opts={})
        # opts:
        #  :project_id - REQUIRED - A valid pivotal project ID
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for each story
        #  :parameters - OPTIONAL - See list of parameters here https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_get

        raise ArgumentError.new("missing required key/value :project_id") unless opts[:project_id]

        project_id = opts[:project_id]
        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:limit] = 20 unless opts[:parameters][:limit]
        opts[:parameters][:offset] = 0 unless opts[:parameters][:offset]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        api_url = "/projects/#{project_id}/stories"
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get(api_url)
        json_story = JSON.parse(response, {:symbolize_names => true})
        PivotalAPI::Stories.from_json(json_story)
      end

      def story(opts={})
        # opts:
        #  :project_id - REQUIRED - A valid pivotal project ID
        #  :story_id - REQUIRED - A valid pivotal story ID
        #  :fields - OPTIONAL - specific fields to ask pivotal to return for each story

        raise ArgumentError.new("missing required key/value :project_id") unless opts[:project_id]
        raise ArgumentError.new("missing required key/value :story_id") unless opts[:story_id]

        project_id = opts[:project_id]
        story_id = opts[:story_id]
        opts[:parameters] = {} unless opts[:parameters]
        opts[:parameters][:fields] = opts[:fields] if opts[:fields] && opts[:parameters][:fields].nil?

        api_url = "/projects/#{project_id}/stories/#{story_id}"
        api_url.append_pivotal_params(opts[:parameters])

        puts "\n****** URL: #{api_url}\n\n"

        response = PivotalAPI::Client.get(api_url)
        load_story_from_response(response)
      end

      def update_story(story_id, project_id, updates={})
        raise ArgumentError.new("missing required parameter project_id") unless project_id
        raise ArgumentError.new("missing required parameter sotry_id") unless story_id

        api_url = "/projects/#{project_id}/stories/#{story_id}"
        PivotalAPI::Client.put(api_url, updates)
      end

      def create_story(project_id, attrs={})
        raise ArgumentError.new("missing required parameter project_id") unless project_id

        api_url = "/projects/#{project_id}/stories"
        response = PivotalAPI::Client.post(api_url, attrs)
        load_story_from_response(response)
      end

      private
        def load_story_from_response(response)
          json_story = JSON.parse(response, {:symbolize_names => true})
          PivotalAPI::Story.from_json(json_story)
        end
    end
  end
end
