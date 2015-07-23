module Scorer
  class Person < Scorer::Base

    attr_accessor :name, :id, :initials, :email, :username

    def self.fields
      ['name', 'id', 'initials', 'email', 'username']
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

  end
end