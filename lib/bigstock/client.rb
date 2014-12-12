require "bigstock/client/version"
require "httparty"
require "json"
require "digest/sha1"

require "bigstock/client/thumbnail"
require "bigstock/client/media"
require "bigstock/client/format"
require "bigstock/client/category"
require "bigstock/client/response"
require "bigstock/client/lightbox"

module Bigstock
  module Client
    class Client
      include HTTParty
      format :json

      API_VERSION = 2

      def initialize(account_id, secret, use_ssl: false, use_test_api: false)
        @account_id = account_id
        @secret = secret
        protocol = use_ssl ? 'https' : 'http'
        subdomain = use_test_api ? 'testapi' : 'api'
        self.class.base_uri "#{protocol}://#{subdomain}.bigstockphoto.com/#{API_VERSION}/#{@account_id}"
      end

      def search(query, options = {})
        args = {query: {q: query}}
        args[:query] = args[:query].merge(options) unless options.empty?
        response = self.class.get('/search', args)

        data = []
        if response['response_code'] == 200
          data = response['data']['images'].map { |image_string| Bigstock::Client::Media::from_hash(image_string) }
        end

        Bigstock::Client::Response.new(
            response_code: response['response_code'],
            message: response['message'],
            data: data
        )
      end

      def asset(asset_id, asset_type)
        response = self.class.get("/#{asset_type}/#{asset_id}")
        data = []
        if response['response_code'] == 200
          data = Bigstock::Client::Media.from_hash(response['data'][asset_type])
        end

        Bigstock::Client::Response.new(
            response_code: response['response_code'],
            message: response['message'],
            data: data
        )
      end

      def image(image_id)
        asset(image_id, 'image')
      end

      def video(video_id)
        asset(video_id, 'video')
      end

      def collections
        response = self.class.get('/lightbox', query: { auth_key: get_auth })
        data = []
        if response['response_code'] == 200
          data = response['data']['lightboxes'].map {|lightbox| Bigstock::Client::Lightbox.from_hash(lightbox)}
        end

        Bigstock::Client::Response.new(
            response_code: response['response_code'],
            message: response['message'],
            data: data
        )
      end

      def collection(collection_id)
        response = self.class.get("/lightbox/#{collection_id}", query: { auth_key: get_auth(collection_id) })
        data = []
        if response['response_code'] == 200
          response['data']['lightbox']['images'] = response['data']['images'] unless response['data']['images'].empty?
          data = Bigstock::Client::Lightbox::from_hash(response['data']['lightbox'])
        end

        Bigstock::Client::Response.new(
            response_code: response['response_code'],
            message: response['message'],
            data: data
        )
      end

      alias_method :lightboxes, :collections

      alias_method :lightbox, :collection

      def purchase
        # -> return purchase object
      end

      def get_download_url

      end

      private

      def get_auth(additional_params = [])
        elements = [@secret, @account_id].concat(Array(additional_params))
        Digest::SHA1.hexdigest(elements.join)
      end

    end
  end
end