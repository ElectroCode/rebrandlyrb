require 'rebrandlyrb/exc'
class RebrandlyResponse
  def RebrandlyResponse.raise_exception(http_response, rebrandly_response)
    code = http_response.code
    case code
    when 200
      # Everything went well, continue.
    when 400
      raise RebrandlyError::BadRequestError rebrandly_response.message
    when 401
      raise RebrandlyError::NotAuthorizedError rebrandly_response.message
    when 403
      if rebrandly_response.code == 'AlreadyExists'
        raise RebrandlyError::AlreadyExistsError rebrandly_response.message
      else
        raise RebrandlyError::InvalidFormatError rebrandly_response.message
    when 404
      raise RebrandlyError::NotFoundError rebrandly_response.message
    when 500
      raise RebrandlyError::InternalServerError rebrandly_response.message
    when 502
      raise RebrandlyError::BadGatewayError rebrandly_response.message
    when 503
      raise RebrandlyError::APIUnavailableError rebrandly_response.message
    when 504
      raise RebrandlyError::APITimeoutError rebrandly_response.message
    end
  end
end