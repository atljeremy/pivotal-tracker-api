module Scorer
  class Person

    attr_accessor :name, :id, :initials, :email, :username

    def self.fields
      ['name', 'id', 'initials', 'email', 'username']
    end

    def initialize(attributes={})
      update_attributes(attributes)
    end

    def self.parse_json_person(json_person)
      new({
        id: json_person[:id].to_i,
        name: json_person[:name],
        initials: json_person[:initals],
        email: json_person[:email],
        username: json_person[:username]
      })
    end

    protected

    def update_attributes(attrs)
      attrs.each do |key, value|
        self.send("#{key}=", value)
      end
    end

  end
end