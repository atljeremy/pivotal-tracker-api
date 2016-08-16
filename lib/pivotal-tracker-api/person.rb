module PivotalAPI
  class Person < Base

    attr_accessor :name, :id, :initials, :email, :username, :kind

    def self.fields
      ['name', 'id', 'initials', 'email', 'username', 'kind']
    end

    def self.unknown
      new({
        id: '0',
        name: 'Unkown',
        initials: 'Unkown',
        username: 'Unkown',
        email: 'Unkown',
        kind: 'person'
      })
    end

  end
  
  class People < Person
  end
end