class Bigstock::Client::Page

  attr_reader :items, :items_per_page, :total_items, :page, :total_pages

  def initialize(items:, items_per_page:, total_items:, page:, total_pages:)
    @items = items
    @items_per_page = items_per_page
    @total_items = total_items
    @page = page
    @total_pages = total_pages
  end

  def to_json(options = {})
    {items: @items, items_per_page: @items_per_page, total_items: @total_items, page: @page, total_pages: @total_pages}.to_json(options)
  end

  def from_hash(data)
    self.new items: data['items'],
             items_per_page: data['items_per_page'],
             total_items: data['total_items'],
             total_pages: data['total_pages'],
             page: data['page']
  end

end