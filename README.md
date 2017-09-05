# bigstock-client-ruby

A Ruby client for Bigstock's API

## Installation

Bigstock-Client-Ruby is available as a RubyGem:

```bash
$ gem install bigstock-client
```

## Usage

Create an instance of the Bigstock API Client by passing in your API ID
and API Secret as parameters. The client will then handle any authentication
when required.

```ruby
require 'bigstock/client'
client = Bigstock::Client::Client.new('API_ID', 'API_SECRET')
```

Then use the client to contact the Bigstock-API

### Search
```ruby
response = client.search('dog')
if response['message'] == 'success'
  pages = response['data']['pages']
  images = response['data']['images']
end
```

Additional options might be passed to the `search`. For a list of
options see [Bigstock's API
documentatation](http://help.bigstockphoto.com/hc/en-us/articles/200303245-API-Documentation#search)

For example, to get only the first five images for 'dog' but
with all image details:
```ruby
response = client.search('dog', response_detail: 'all', limit: 5)
```

### Image Detail

The image ID returned in a search response can be used to query for more
information about a specific image.
```ruby
response = client.image('IMAGE_ID')
if response['message'] == 'success'
  image = response['data']['image']
end
```

### Purchase

Once you have funded your API account you will be able to download full
resolution un-watermarked images.
```ruby
response = client.purchase('IMAGE_ID', 'SIZE_CODE')
if response['message'] == 'success'
  download_url = client.get_download_url(response['data']['download_id'])
end
```

### Lightboxes & Saved Images

To get the list of private lightbox content saved under your account:

```ruby
response = client.lightboxes
if response['message'] == 'success'
  total_items = response['data']['total_items']
  lightboxes = response['data']['lightboxes']
end
```

To get the content of a lightbox

```ruby
response = client.lightbox('LIGHTBOX_ID')
if response['message'] == 'success'
  pages = response['data']['pages']
  lightbox = response['data']['lightbox']
  images = response['data']['images']
end
```

## License

[MIT](LICENSE) © 2014-2017 moiesk
