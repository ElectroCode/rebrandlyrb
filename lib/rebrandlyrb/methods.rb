
# @!attribute api_key
# @!attribute domain_id
# @!attribute domain_name
# @!attribute team_id 
class Rebrandly
  include HTTParty
  base_uri 'api.rebrandly.com/v1'

  attr :api_key, :domain_id, :domain_name, :team_id
  if @team_id
    team = {"team" => @team_id}
  end

  headers("Content-Type" => "application/json")
  headers(team) unless team.nil
  def initialize()
    @domain = {
      fullName: @domain_name,
      id: @domain_id
    }

    if @team_id
      @team_header = {"team": @team_id}
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
      response = self.class.get('/links/', options.nil? ? options : nil)
    end
  end


  def add()
  end
end
