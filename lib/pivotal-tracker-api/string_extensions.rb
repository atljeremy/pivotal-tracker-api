require 'cgi'
require 'addressable/uri'

module PivotalAPI
  module Extensions
    module String
      module QueryParams

        def append_pivotal_params(params, replace=true)
          return self if params.nil?
          
          resulting_url = if replace then self else "" end
          
          if self.rindex("?").nil?
            resulting_url += "?"
            replace(resulting_url)
          end
          
          case params
          when Array
            resulting_url += params_from_array(params)
          when Hash
            resulting_url += params_from_hash(params)
          else
            resulting_url += "#{params}"
          end

	  # convert to ascii 
	  url = Addressable::URI.parse(resulting_url).normalize.to_str
          
          if replace then replace(url) else url end
        end
        
        protected
        
        def params_from_hash(hash)
          q_params = ""
          hash.each do |k,v|
            case v
            when Array
              q_params += if q_params.length == 0 then "#{k}=" else "&#{k}=" end
              q_params += params_from_array(v)
            when Hash
              q_params += if q_params.length == 0 then "#{k}=" else "&#{k}=" end
              v.each { |kk,vv|
                q_params += if v.keys.first == kk then "#{kk}%3A" else "%20#{kk}%3A" end
                q_params += append_pivotal_params(vv, false)
              }
            else
              q_params += if q_params.length == 0 then "#{k}=#{v}" else "&#{k}=#{v}" end
            end
          end
          q_params
        end
        
        def params_from_array(array)
          q_params = ""
          array.each { |vv| q_params += if array.index(vv) == 0 then "#{vv}" else ",#{vv}" end }
          q_params
        end
        
      end
    end
  end
end
