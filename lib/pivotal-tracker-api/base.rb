module Scorer
  class Base

    def initialize(attributes={})
      update_attributes(attributes)
    end

    def to_json
      hash = {}
      self.instance_variables.each do |var|
        key = var.to_s.delete('@')
        variable = self.instance_variable_get var
        hash[key.to_sym] = variable
      end
      hash.to_json
    end

    protected

    def update_attributes(attrs)
      attrs.each do |key, value|
        # self.send("#{key}=", value.is_a?(Array) ? value.join(',') : value )
        self.send("#{key}=", value)
      end
    end

  end
end