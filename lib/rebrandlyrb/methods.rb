
# @!attribute api_key
# @!attribute domain_id
# @!attribute domain_name
# @!attribute team_id 
class Rebrandly
  include HTTParty
  base_uri 'api.rebrandly.com/v1'

  attr :api_key, :domain_id, :domain_name, :team_id

  def initialize()
    
  end

  def list()
    
  end
end
