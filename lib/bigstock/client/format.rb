class Bigstock::Client::Format

  attr_reader :height, :width, :label, :size_code

  def initialize(height:, width:, label:, size_code:)
    @height = height
    @width = width
    @label = label
    @size_code = size_code
  end

  def to_json(options = {})
    {height: @height, width: @width, label: @label, size_code: @size_code}.to_json(options)
  end

  def self.from_hash(data)
    self.new(height: data['height'], width: data['width'], label: data['label'], size_code: data['size_code'])
  end

end