class Bigstock::Client::Thumbnail

  attr_reader :height, :width, :url

  def initialize(height:, width:, url:)
    @height = height
    @width = width
    @url = url
  end

  def to_json(options = {})
    {height: @height, width: @width, url: @url}.to_json(options)
  end

  def self.from_hash(data)
    self.new height: data['height'], width: data['width'], url: data['url']
  end

end