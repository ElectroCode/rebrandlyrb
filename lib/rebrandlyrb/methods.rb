require 'httparty'
require 'rebrandlyrb/exc'
require 'rebrandlyrb/rebrandly_response'
# @!attribute api_key
# @!attribute domain_id
# @!attribute domain_name
# @!attribute team_id
module Rebrandly
  class Links
    include HTTParty
    base_uri 'api.rebrandly.com/v1/links'

    attr :api_key, :domain_id, :domain_name, :team_id
    if @team_id
      team = {'team' => @team_id}
    end

    headers('Content-Type' => 'application/json')
    unless team.nil
      headers << team
    end
    def initialize
      @domain = {
        fullName: @domain_name,
        id: @domain_id
      }

      if @team_id
        @team_header = {'team': @team_id}
      else
      end
    end
    # @option option [Hash] nil A hash of options to list links
    # @overload list(options = nil)
    #   @note There are certain options allowed for sorting filtering
    #     
    #     orderBy => {createdAt, updatedAt, title, slashtag} -- Sort by
    #
    #     orderDir=> {desc, asc} -- Order Direction
    #
    #     offset => N -- Skip N links
    #
    #     limit => N -- Limit to N links
    #
    #     favourite => true/false -- optional, shows or hides favourites if given 
    #
    #     status => active -- Sort by status, {active, trashed}
    #
    #     @note Due to markup restrictions, I have to explain this next one
    #       @overload
    #         To use the sort by domain ID, use domain^id^, replacing ^
    #         with left and right square brackets respectively. 
    def list(options = nil)
      if options.nil?
        rebrandly_response = self.class.get('/', options)
        http_response = rebrandly_response
        #RebrandlyResponse.raise_exception(http_response, rebrandly_response)
      end
    end
    # @param [String] id Link ID
    # @option options [Hash] nil A hash of options to filter by
    def get(id = nil, options = nil)
      if id.nil?
        if options.nil?
          response = self.class.get("/#{id}")
        else
          response = self.class.get("/#{id}", options)
        end
      end

    end
    def count(options = nil)
      if options.nil?
        response = self.class.get("/count")
      else
        response = self.class.get('/count', options)
      end
    end
    # @param [Symbol] method POST or GET method
    # @option options [Hash] nil A Hash of options to filter by
    def new(method = nil, options = nil)
      case method
        when :get
          if options.nil?
            response = self.class.get('/new')
          else
            response = self.class.get('/new', options)
          end
        when :post
          if options.nil?
            response = self.class.get('/')
          else
            response = self.class.get('/', options)
          end
      end
    end
    # @param [String] id link id to update
    # @option options [Hash] nil A Hash of the fields to update, all required
    # but not necessarily different than their values
    def update(id = nil, options = nil)
      if options.nil?
        raise RebrandlyAPIError "Rebrandly#update must be used with options."
      else
        response = self.class.post("/#{id}", options)
      end
    end
    # @param [String] id link id to delete
    # @option options [Hash] nil An optional Hash containing the key 'trash'
    # that declares whether to trash the link or to delete it permanently.
    def delete(id = nil, options = nil)
      if id.nil?
        raise RebrandlyAPIError "No ID to delete"
      else
        if options.nil?
          response = self.class.delete("/#{id}")
        else
          if options.keys == ['trash']
            if options['trash'] ~= /(true|false)/
              response = self.class.delete("/#{id}", options)
            else
              raise RebrandlyAPIError "Rebrandly#delete supports one key only, 'trash', which is a boolean"
            end
          else
            raise RebrandlyAPIError "Rebrandly#delete supports one key only, 'trash', which is a boolean"
          end
        end
      end
    end
  end
  class Domain
    include HTTParty
    base_uri 'api.rebrandly.com/v1/domains'
    # @option options [Hash] nil An optional Hash to filter by
    # @overload list(options = nil)
    #   @note There are certain options allowed for sorting filtering
    #   
    #   active: optional boolean -- true/false
    #
    #   type: optional string -- user/service
    #   
    #   orderBy: optional string -- criteria to filter by/ createdAt, updatedAt, fullName
    #
    #   orderDir: optional string -- Order Direction, asc/desc
    #
    #   offset: optional integer -- skip N domains 
    #
    #   limit: optional integer -- limit to N domains
    def list(options = nil)
      if options.nil?
        response = self.class.get('/')
      else
        response = self.class.get('/', options)
      end
    end
    # @param [String] id domain id
    # @option options [Hash] nil An optional Hash containing filter
    def get(id = nil)
        response = self.class.get("/#{id}")
    end
    # @option options [Hash] nil 
    # @overload count(options = nil)
    #  Options:
    #
    #    active: true/false
    #    
    #    type: user/service
    def count(options = nil)
      if options.nil?
        response = self.class.get("/count")
      else
        response = self.class.get("/count", options)
      end
    end
  end
  class Account
    include HTTParty
    base_uri 'api.rebrandly.com/v1/account'
    # @option options [Hash]
    def get(options = nil)
      begin
          response = self.class.get('/')
          case response.code
          when 
      rescue HTTParty::Error => e
        raise HTTParty "HTTParty encountered an error. Details: #{e}"
      end
    end
    def teams(options = nil)
      if options.nil?
        response = self.class.get("/teams/")
      else
        response = self.class.get("/teams/", options)
      end
    end
  end
end