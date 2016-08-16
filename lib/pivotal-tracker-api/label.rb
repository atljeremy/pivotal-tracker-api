# PROPERTIES
# id int
#  —  Database id of the label. This field is read only. This field is always returned.
#
# project_id int
#  —  id of the project. This field is read only.
#
# name string[255]
# Required  —  The label's name.
#
# created_at datetime
#  —  Creation time. This field is read only.
#
# updated_at datetime
#  —  Time of last update. This field is read only.
#
# counts story_counts
#  —  Summary of numbers of stories and points contained. This field is read only. This field is excluded by default.
#
# kind string
#  —  The type of this object: label. This field is read only.

module PivotalAPI
  class Label < Base

    attr_accessor :id, :project_id, :name, :created_at, :updated_at, :counts, :kind

  end
  
  class Labels < Label
  end
end