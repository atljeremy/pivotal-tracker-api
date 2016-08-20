module PivotalAPI
  class Me < Person
    
    attr_accessor :api_token, :updated_at, :created_at, :has_google_identity, 
                  :projects, :receives_in_app_notifications, :time_zone
                  
    def self.retrieve(username, password)
      Service.me(username, password)
    end
    
    def projects
      Projects.retrieve()
    end
    
  end
end