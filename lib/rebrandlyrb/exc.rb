module RebrandlyError
  class Error < StandardError
    def initialize(msg = 'An unknown error occured')
      super
    end
  class APIError < Error
  end
  # Invalid JSON Request
  # Code: 400
  class BadRequestError < RebrandlyError.APIError
  end
  # Authorization credentials invalid
  # oAuth Token expired etc.
  # Code: 401
  class NotAuthorizedError < RebrandlyError.APIError
  end
  # Invalid input format
  # Missing body
  # Limits threshold reached
  # Code: 403
  class InvalidFormatError < RebrandlyError.APIError
  end
  # Resource/Endpoint not found
  # Code: 404
  class NotFoundError < RebrandlyError.APIError
  end
  # API Endpoint Server Error
  # Code: 500
  class InternalServerError < RebrandlyError.APIError
  end
  # Failure in Rebrandly's upstream providers
  # Code: 502
  class BadGatewayError < RebrandlyError.APIError
  end
  # API endpoint under maintenance
  # Code: 503
  class APIUnavailableError < RebrandlyError.APIError
  end
  # API Operation Timeout
  # Code: 504
  class APITimeoutError < RebrandlyError.APIError
  end
end