require 'rebrandlyrb/exc'
class RebrandlyResponse
  def RebrandlyResponse.get_code(response)
    case code
    when 400
      raise RebrandlyError::BadRequestError response.message
    when 401
      raise RebrandlyError::NotAuthorizedError response.message
    when 403
      raise RebrandlyError::InvalidFormatError response.message
    when 404
      raise RebrandlyError::NotFoundError response.message
    when 500
      raise RebrandlyError::InternalServerError response.message
    when 502
      raise RebrandlyError::BadGatewayError response.message
    when 503
      raise RebrandlyError::APIUnavailableError response.message
    when 504
      raise RebrandlyError::APITimeoutError response.message
    end
  end
end