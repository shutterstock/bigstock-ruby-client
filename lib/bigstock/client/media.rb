class Bigstock::Client::Media

  attr_reader :id, :title, :small_thumb, :title, :categories, :contributor, :formats, :keywords, :preview

  def initialize(id:, title:, small_thumb: nil, categories: [], contributor: nil, formats: [], keywords: nil, preview: nil)
    @id = id
    @title = title
    @small_thumb = small_thumb
    @title = title,
    @categories = categories
    @contributor = contributor
    @formats = formats
    @keywords = keywords
    @preview = preview
  end

  def to_json(options = {})
    hash = {id: @id, title: @title}
    hash[:small_thumb] = @small_thumb unless @small_thumb.nil?
    hash[:title] = @title unless @title.nil?
    hash[:categories] = @categories unless @categories.empty?
    hash[:contributor] = @contributor unless @contributor.nil?
    hash[:formats] = @formats unless @formats.empty?
    hash[:keywords] = @keywords unless @keywords.nil?
    hash[:preview] = @preview unless @preview.nil?
    hash.to_json(options)
  end

  def self.from_hash(data)
    hash = {id: data['id'], title: data['title']}
    hash[:small_thumb] = Bigstock::Client::Thumbnail::from_hash(data['small_thumb']) if data.has_key?('small_thumb')
    hash[:categories] = data['categories'].map {|c| Bigstock::Client::Category::from_hash(c)} if data.has_key?('categories')
    hash[:formats] = data['formats'].map {|c| Bigstock::Client::Format::from_hash(c)} if data.has_key?('formats')
    hash[:contributor] = data['contributor'] if data.has_key?('contributor')
    hash[:keywords] = data['keywords'] if data.has_key?('keywords')
    hash[:preview] = Bigstock::Client::Thumbnail::from_hash(data['preview']) if data.has_key?('preview')
    self.new(hash)
  end

end