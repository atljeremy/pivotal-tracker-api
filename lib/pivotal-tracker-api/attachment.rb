module Scorer
  class Attachment < Scorer::Base

    attr_accessor :filename, :id, :created_at, :uploaded_by, :big_url,
                  :width, :height, :download_url, :thumbnail_url, :size, :content_type

    def self.parse_attachments(attachments)
      parsed_attachments = []
      attachments.each do |file|
        parsed_attachments << new({
          id: file[:id].to_i,
          filename: file[:filename],
          created_at: file[:created_at],
          uploaded_by: file[:uploaded_by],
          big_url: file[:big_url],
          width: file[:width],
          height: file[:height],
          download_url: file[:download_url],
          thumbnail_url: file[:thumbnail_url],
          size: file[:size],
          content_type: file[:content_type]
        })
      end if attachments
      parsed_attachments
    end

  end
end
