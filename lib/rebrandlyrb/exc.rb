class RebrandlyError > StandardError
  def initialize(msg = 'My default message')
    super
  end
end
class NotEnoughArgumentsError > RebrandlyError
end
class RebrandlyAPIError > RebrandlyError
end
