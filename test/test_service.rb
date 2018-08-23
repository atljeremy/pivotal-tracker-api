require 'helper'

class TestService < Test::Unit::TestCase

  context "PivotalAPI::Service" do

    setup do
      PivotalAPI::Service.set_token "5c17c42f0f4c30cbc0c53ddd8f832e7b"
    end

    # should "get user info" do
    #   me = PivotalAPI::Me.retrieve('USERNAME', 'PASSWORD')
    #   assert_not_nil(me)
    #   assert_not_nil(me.api_token)
    # end

    # should "should get project, iteration, and stories" do
    #   project = PivotalAPI::Project.retrieve(1158374)
    #   iteration = project.iterations.first
    #   iteration.stories.each do |story|
    #     puts "------------------"
    #     puts "Story: #{story.name}\n
    #           status: #{story.current_state}\n
    #           overdue: #{story.overdue?}\n
    #           hours: #{story.hours}"
    #     puts "------------------"
    #   end
    #
    #   assert_not_nil(iteration)
    #   assert_not_nil(iteration.stories)
    # end

    # should "should get project and stories" do
    #   project = PivotalAPI::Project.retrieve(1158374)
    #   stories = project.stories()
    #   stories.each do |story|
    #     puts "------------------"
    #     puts "Story: #{story.name} - status: #{story.current_state} - overdue: #{story.overdue?}"
    #     puts "------------------"
    #   end
    #
    #   assert_not_nil(stories)
    # end

    # should "should get projects" do
    #   project = PivotalAPI::Projects.retrieve()
    #   project.each do |project|
    #     puts "------------------"
    #     puts "Project: #{project.name}"
    #     puts "------------------"
    #   end
    #
    #   assert_not_nil(project)
    # end

    # should "should get project activity" do
    #   project = PivotalAPI::Project.retrieve(1158374)
    #   activity = project.activity
    #   activity.each do |a|
    #     puts "------------------"
    #     puts "Activity: #{a}"
    #     puts "------------------"
    #   end
    #
    #   assert_not_nil(activity)
    # end

    # should "should get project activity" do
    #   project = PivotalAPI::Project.retrieve(1158374)
    #   story = project.story(128105441)
    #
    #   assert_not_nil(story)
    # end

  end

end
