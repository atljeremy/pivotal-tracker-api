module Scorer
  class Attachment

    attr_accessor :filename, :id, :created_at, :uploaded_by, :big_url,
                  :width, :height, :download_url, :thumbnail_url, :size, :content_type

    def self.parse_attachments(attachments)
      parsed_attachments = Array.new
      if attachments
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
        end
      end
      parsed_attachments
    end

    def initialize(attributes={})
      update_attributes(attributes)
    end

    protected

    def update_attributes(attrs)
      attrs.each do |key, value|
        self.send("#{key}=", value)
      end
    end

  end
end
