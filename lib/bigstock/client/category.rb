class Bigstock::Client::Category

  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def to_json(options = {})
    {name: @name}.to_json(options)
  end

  def self.from_hash(data)
    self.new(name: data['name'])
  end

end