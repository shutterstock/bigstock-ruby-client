class Bigstock::Client::Response

  attr_reader :response_code, :message, :data

  def initialize(response_code:, message:, data:)
    @response_code = response_code
    @message = message
    @data = data
  end

  def to_json(options = {})
    {response_code: @response_code, message: @message, data: @data}.to_json(options)
  end

end