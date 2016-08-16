# PROPERTIES
# id int
#  —  Database id of the file_attachment. This field is read only. This field is always returned.
#
# filename string[255]
#  —  The file's name. This field is read only.
#
# created_at datetime
#  —  Creation time. This field is read only.
#
# uploader_id int
#  —  The id of the person who uploaded the file. This field is read only. In API responses, this attribute may be uploader_id or uploader.
#
# thumbnailable boolean
#  —  Flag indicating whether Tracker knows how to make a thumbnail image from the attachment. This field is read only.
#
# height int
#  —  If the attachment is thumbnailable the height of it in pixels. This field is read only.
#
# width int
#  —  If the attachment is thumbnailable the width of it in pixels. This field is read only.
#
# size int
#  —  The size of the attachment in bytes. This field is read only.
#
# download_url string
#  —  The URL for the original attachment on S3. This field is read only.
#
# content_type string[255]
#  —  The MIME type of the attachment. This field is read only.
#
# uploaded boolean
#  —  Flag indicating whether the attachment has been moved to S3. This field is read only.
#
# big_url string
#  —  URL to larger-size thumbnail version if attachment is an image. This field is read only.
#
# thumbnail_url string
#  —  URL to small-size thumbnail version if attachment is an image. This field is read only.
#
# kind string
#  —  The type of this object: file_attachment. This field is read only.

module PivotalAPI
  class FileAttachment < Base

    attr_accessor :filename, :id, :created_at, :uploaded_by, :big_url,
                  :width, :height, :download_url, :thumbnail_url, :size, 
                  :content_type, :kind, :uploader_id, :thumbnailable,
                  :uploaded
                  
  end
  
  class FileAttachments < FileAttachment
  end
end
