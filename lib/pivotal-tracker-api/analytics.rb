# PROPERTIES
# stories_accepted int
#  —  Number of stories accepted during this iteration. This field is read only.
#
# bugs_created int
#  —  Number of new bugs created. This field is read only.
#
# cycle_time int
#  —  Median cycle time in milliseconds for contained stories. This field is read only.
#
# rejection_rate float
#  —  Percentage of accepted bugs and features in the iteration that have ever been rejected. This field is read only.
#
# kind string
#  —  The type of this object: analytics. This field is read only.

module PivotalAPI
  class Analytics < Base

    attr_accessor :stories_accepted, :bugs_created, :cycle_time, :rejection_rate, :kind 

  end
end