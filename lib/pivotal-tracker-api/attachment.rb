module Scorer
  class Attachment

    attr_accessor :status, :url, :filename, :id, :description, :uploaded_at, :uploaded_by

    def initialize(attributes={})
      update_attributes(attributes)
    end

    protected

    def update_attributes(attrs)
      attrs.each do |key, value|
        self.send("#{key}=", value.is_a?(Array) ? value.join(',') : value )
      end
    end

  end
end
