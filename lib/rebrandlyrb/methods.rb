require 'httparty'
require 'rebrandlyrb/exc'
# @!attribute api_key
# @!attribute domain_id
# @!attribute domain_name
# @!attribute team_id
class Rebrandly
  include HTTParty
  base_uri 'api.rebrandly.com/v1'

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
      response = self.class.get('/links/', options)
    end
  end
  # @param [String] id Link ID
  # @option options [Hash] nil A hash of options to filter by
  def get(id = nil, options = nil)
    if id.nil?
      if options.nil?
        response = self.class.get("/links/#{id}")
      else
        response = self.class.get("/links/#{id}", options)
      end
    end

  end
  def count(options = nil)
    if options.nil?
      response = self.class.get("/links/count")
    else
      response = self.class.get('/links/count', options)
    end
  end
  # @param [Symbol] method POST or GET method
  # @option options [Hash] nil A Hash of options to filter by
  def new(method = nil, options = nil)
    case method
      when :get
        if options.nil?
          response = self.class.get('/links/new')
        else
          response = self.class.get('/links/new', options)
        end
      when :post
        if options.nil?
          response = self.class.get('/links')
        else
          response = self.class.get('/links', options)
        end
    end
  end
end
