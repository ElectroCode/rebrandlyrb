module RebrandlyError
  class Error > StandardError
    def initialize(msg = 'An unknown Error occured')
      super
    end
  class APIError > Error
  end
  # Invalid JSON Request
  # Code: 400
  class BadRequestError > APIError
  end
  # Authorization credentials invalid
  # oAuth Token expired etc.
  # Code: 401
  class NotAuthorizedError > APIError
  end
  # Invalid input format
  # Missing body
  # Limits threshold reached
  # Code: 403
  class InvalidFormatError > APIError
  end
  # Resource/Endpoint not found
  # Code: 404
  class NotFoundError > APIError
  end
  # API Endpoint Server Error
  # Code: 500
  class InternalServerError > APIError
  end
  # Failure in Rebrandly's upstream providers
  # Code: 502
  class BadGatewayError > APIError
  end
  # API endpoint under maintenance
  # Code: 503
  class APIUnavailable > APIError