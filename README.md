pivotal-tracker-api
===================

A Pivotal Tracker API gem that can be used to interface with the Pivotal Tracker API v5.

[![Gem](https://img.shields.io/gem/v/pivotal-tracker-api.svg?maxAge=2592000)](https://rubygems.org/gems/pivotal-tracker-api) [![Gem](https://img.shields.io/gem/dt/pivotal-tracker-api.svg?maxAge=2592000)](https://github.com/atljeremy/pivotal-tracker-api.git)

### Basic Example

```ruby
# Use your personal pivotal token
PivotalAPI::Service.set_token A_PIVOTAL_TOKEN
```

```ruby
# Authenticate a user using email / pass
@me = PivotalAPI::Me.retrieve('USERNAME', 'PASSWORD')
# Note: PivotalAPI::Me.retrieve will automatically set the api token so there is no need to use PivotalAPI::Service.set_token if you use PivotalAPI::Me.retrieve to login
```

```ruby
# If you login using PivotalAPI::Me.retrieve, you can simply ask your Me object for your projects.
@projects = @me.projects

# If you set your personal pivotal token manually using PivotalAPI::Service.set_token, you can get your projects using the following.
@projects = PivotalAPI::Projects.retrieve()
```

```ruby
# To get a specific project, use the following.
@project = PivotalAPI::Project.retrieve(PROJECT_ID)
```

```ruby
# Get a project's stories, this will return an array of PivotalAPI::Story instance's
@stories = @project.stories
```

```ruby
# Get a specific story for a project, this will return a PivotalAPI::Story instance
@story = @project.story(STORY_ID)
```

```ruby
# Get a story's comments, this will return an array of PivotalAPI::Comment instance's
@comments = @story.comments
```

```ruby
# Get a story's owners, this will return an array of PivotalAPI::Person instance's
@owners = @story.owners
```

```ruby
# Get a story's followers, this will return an array of PivotalAPI::Person instance's
@followers = @story.followers
```

```ruby
# Get a story's tasks, this will return an array of PivotalAPI::Task instance's
@tasks = @story.tasks
```

```ruby
# Get a story's transitions, this will return an array of PivotalAPI::StoryTransition instance's
@transitions = @story.transitions
```

```ruby
# Get a story's cycle time details, this will return ana array of PivotalAPI::CycleTimeDetails instance's
@cycle_time_details = @story.cycle_time_details
```

```ruby
# Get a project's activity, this will return an array of PivotalAPI::Activity instance's
@stories = @project.activity
```

```ruby
# Get a project's iterations, this will return an array of PivotalAPI::Iteration instance's
@iterations = @project.iterations
```

```ruby
# Get a project's current iteration
@iteration = @project.current_iteration
```

```ruby
# Get a project's next iteration
@iteration = @project.next_iteration
```

```ruby
# Get a project's previous iteration
@iteration = @project.previous_iteration
```

For additional infomation on how to interface with this gem and use it to communicate with the Pivotal Tracker API v5 see the [PivotalAPI::Service](https://github.com/atljeremy/pivotal-tracker-api/blob/master/lib/pivotal-tracker-api/service.rb) class and the [Service Tests](https://github.com/atljeremy/pivotal-tracker-api/blob/master/test/test_service.rb).

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

