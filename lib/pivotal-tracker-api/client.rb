module PivotalAPI
  class Client

    class NoToken < StandardError; end

    class << self

      attr_writer :token, :username, :password

      def get(path)
        begin
          set_response_headers(connection["#{api_version}#{path}"].get)
        rescue
          puts "Encountered Error in get: #{$!}"
          clear_connections
          set_response_headers(connection["#{api_version}#{path}"].get)
        end
      end
      
      def ssl_get(path)
        raise ArgumentError.new("missing required fields :username and :password. " \
                                "Set these using PivotalAPI::Client.username = USERNAME " \
                                "and PivotalAPI::Client.password = PASSWORD.") unless @username && @password
        begin
          puts "ssl_connection: #{ssl_connection}"
          set_response_headers(ssl_connection["#{api_version}#{path}"].get)
        rescue
          puts "Encountered Error in ssl_get: #{$!}"
          clear_connections
          set_response_headers(ssl_connection["#{api_version}#{path}"].get)
        end
      end

      def get_with_caching(path)
        begin
          connection["#{api_version}#{path}"].get
        rescue
          puts "Encountered Error in get_with_caching: #{$!}"
          clear_connections
          connection["#{api_version}#{path}"].get
        end
      end

      def put(path, updates={})
        set_response_headers(connection["#{api_version}#{path}"].put(updates))
      end

      def connection
        raise NoToken if @token.to_s.empty?
        @connections ||= {}
        cached_connection? ? cached_connection : new_connection
      end
      
      def ssl_connection
        raise NoToken if @username.to_s.empty?
        @connections ||= {}
        cached_ssl_connection? ? cached_ssl_connection : new_ssl_connection
      end

      def clear_connections
        @connections = nil
      end

      def api_ssl_host
        "https://#{@username}:#{CGI.escape(@password)}@www.pivotaltracker.com"
      end

      def api_host
        @api_host ||= 'https://www.pivotaltracker.com'
      end
      
      def token=(val)
        @username = nil
        @password = nil
        @token = val
      end

      protected

        def set_response_headers(response)
          response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate' # HTTP 1.1.
          response.headers['Pragma']        = 'no-cache' # HTTP 1.0.
          response.headers['Expires']       = '0' # Proxies.
          response
        end

        def api_version
          '/services/v5'
        end

        def cached_connection?
          !@connections[@token].nil?
        end

        def cached_connection
          @connections[@token]
        end

        def new_connection
          @connections[@token] = RestClient::Resource.new(api_host, :headers => {'X-TrackerToken' => @token, 'Content-Type' => 'application/json'})
        end
        
        def cached_ssl_connection?
          !@connections[@username].nil?
        end

        def cached_ssl_connection
          @connections[@username]
        end
        
        def new_ssl_connection
          @connections[@username] = RestClient::Resource.new(api_ssl_host, :headers => {'Content-Type' => 'application/json'})
        end

    end

  end
end