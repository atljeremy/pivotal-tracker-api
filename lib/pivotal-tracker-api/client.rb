module Scorer
  class Client

    class NoToken < StandardError; end

    class << self

      attr_writer :token, :ssl_enabled
      attr_reader :api_host, :api_projects_path

      def get(path)
        begin
          set_response_headers(connection["#{api_version}#{path}"].get)
        rescue
          puts "Encountered Error in get: #{$!}"
          clear_connections
          set_response_headers(connection["#{api_version}#{path}"].get)
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

      def clear_connections
        @connections = nil
      end

      def ssl_enabled
        @ssl_enabled || true
      end

      def token(username, password)
        response = RestClient.get("#{api_ssl_host(username, password)}#{api_version}/me")
        json = JSON.parse(response, {:symbolize_names => true})
        @token = json[:api_token]
      end

      def api_ssl_host(user=nil, password=nil)
        user_password = (user && password) ? "#{user}:#{CGI.escape(password)}@" : ''
        "https://#{user_password}www.pivotaltracker.com"
      end

      def api_host
        @api_host ||= 'http://www.pivotaltracker.com'
      end

      def api_projects_path
        @api_projects_path ||= "#{ssl_enabled ? api_ssl_host : api_host}#{api_version}/projects"
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
          @connections[@token] = RestClient::Resource.new("#{ssl_enabled ? api_ssl_host : api_host}", :headers => {'X-TrackerToken' => @token, 'Content-Type' => 'application/json'})
        end

    end

  end
end