# PROPERTIES
# total_cycle_time int
#  —  The total amount of time, in milliseconds, between when the story was first started to when it was last accepted. In the case where a story has not been accepted, it is the time between when the story was first started to the current time. If the story has not been started, this property is not returned. This field is read only.
#
# started_time int
#  —  The total amount of time, in milliseconds, that the story was in the started state. This field is read only.
#
# started_count int
#  —  The number of times that the story has been in the started state. This field is read only.
#
# finished_time int
#  —  The total amount of time, in milliseconds, that the story was in the finished state. This field is read only.
#
# finished_count int
#  —  The number of times that the story has been in the finished state. This field is read only.
#
# delivered_time int
#  —  The total amount of time, in milliseconds, that the story was in the delivered state. This field is read only.
#
# delivered_count int
#  —  The number of times that the story has been in the delivered state. This field is read only.
#
# rejected_time int
#  —  The total amount of time, in milliseconds, that the story was in the rejected state. This field is read only.
#
# rejected_count int
#  —  The number of times that the story has been in the rejected state. This field is read only.
#
# story_id int
#  —  The id of the associated story. This field is read only.
#
# kind string
#  —  The type of this object: cycle_time_details. This field is read only.

module PivotalAPI
  class CycleTimeDetails < Base

    attr_accessor :total_cycle_time, :started_time, :started_count, :finished_time, 
                  :finished_count, :delivered_time, :delivered_count, :rejected_time, 
                  :rejected_count, :story_id, :kind

  end
end
