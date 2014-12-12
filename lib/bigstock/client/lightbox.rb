class Bigstock::Client::Lightbox

  attr_reader :id, :title, :items, :images

  def initialize(id:, title:, items:, images: [])
    @id = id
    @title = title
    @items = items
    @images = images
  end

  def to_json(options = {})
    data = {id: @id, title: @title, items: @items}
    data[:images] = @images
    data.to_json(options)
  end

  def self.from_hash(data)
    images = []
    if data.has_key?('images')
      images = data['images'].map { |image| Bigstock::Client::Media::from_hash(image) }
    end
    self.new(id: data['id'], title: data['title'], items: data['items'], images: images)
  end

end