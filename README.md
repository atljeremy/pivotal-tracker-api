pivotal-tracker-api
===================

A Pivotal Tracker API gem that can be used to interface with the Pivotal Tracke API v5.

### Basic Example

```ruby
# Authenticate a user using email / pass
def get_user_token
  email = params[:email]
  pass = params[:pass]
  # This will set the @token in the Client class. Class caching must be enabled for the token to persist.
  # config.cache_classes = true
  token = Scorer::Client.token(email, pass)
  # do something with the token
end
```

```ruby
# Get all of the users Projects
def projects
  @projects = PivotalService.all_projects(Scorer::Project.fields)
end
```

```ruby
# Get only 1 of the users Projects
def project
  @project = PivotalService.one_project(params[:project_id], Scorer::Project.fields)
end
```

```ruby
# Get a Projects Stories by a specific Label
def stories_by_label
  project_label   = params[:project_label]
  @project_label  = CGI.escape(project_label) if project_label
  @stories = PivotalService.all_stories(@project_label, @project, Scorer::Story.fields) if @project_label
end
```

```ruby
# Get an Iteration and it's Stories
def get_iteration
  @project_id = params[:project_id]
  @project    = PivotalService.one_project(@project_id, Scorer::Project.fields)
  @iteration  = PivotalService.iterations(@project_id, 'current')
  @stories    = @iteration.stories
end
```

For additional infomation on how to interface with this gem and use it to communicate with the Pivotal Tracker API v5 see the [PivotalService](https://github.com/atljeremy/pivotal-tracker-api/blob/master/lib/pivotal-tracker-api/pivotal_service.rb) class.

### Contributing to pivotal-tracker-api
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2013 Jeremy Fox ([jeremyfox.me](http://www.jeremyfox.me)). See LICENSE.txt for
further details.

