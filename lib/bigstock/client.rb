require 'bigstock/client/version'
require 'httparty'
require 'json'
require 'digest/sha1'

module Bigstock
  module Client
    class Client
      include HTTParty
      format :json

      API_VERSION = 2

      def initialize(account_id, secret, use_ssl = false, use_test_api = false)
        @account_id = account_id
        @secret = secret
        protocol = use_ssl ? 'https' : 'http'
        subdomain = use_test_api ? 'testapi' : 'api'
        self.class.base_uri "#{protocol}://#{subdomain}.bigstockphoto.com/#{API_VERSION}/#{@account_id}"
      end

      def search(query, options = {})
        args = {query: {q: query}}
        args[:query] = args[:query].merge(options) unless options.empty?
        self.class.get('/search', args).parsed_response
      end

      def asset(asset_id, asset_type)
        self.class.get("/#{asset_type}/#{asset_id}").parsed_response
      end

      def image(image_id)
        asset(image_id, 'image')
      end

      def video(video_id)
        asset(video_id, 'video')
      end

      def collections
        self.class.get('/lightbox', query: { auth_key: get_auth }).parsed_response
      end

      def collection(collection_id)
        self.class.get("/lightbox/#{collection_id}", query: { auth_key: get_auth(collection_id) }).parsed_response
      end

      alias_method :lightboxes, :collections

      alias_method :lightbox, :collection

      def purchase(asset_id, size_code)
        self.class.get('/purchase', query: { image_id: asset_id, size_code: size_code, auth_key: get_auth(asset_id) }).parsed_response
      end

      def get_download_url(download_id)
        [
          self.class.base_uri,
          '/download?',
          "download_id=#{download_id}",
          "&auth_key=#{get_auth(download_id)}"
        ].join
      end

      private

      def get_auth(additional_params = [])
        elements = [@secret, @account_id].concat(Array(additional_params))
        Digest::SHA1.hexdigest(elements.join)
      end

    end

  end

end
