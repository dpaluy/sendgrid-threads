require 'faraday'

module SendgridThreads
  class Client
    VERSION = "v1".freeze
    URL     = 'https://input.threads.io'.freeze
    HEADERS = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}.freeze

    attr_reader :key, :secret, :url, :user_agent, :raise_exceptions
    attr_writer :adapter, :conn

    def initialize( params = {} )
      @key    = params.fetch(:key,    SendgridThreads.config.key)
      @secret = params.fetch(:secret, SendgridThreads.config.secret)
      @url    = params.fetch(:url,    SendgridThreads.config.url || URL)
      @raise_exceptions = params.fetch(:raise_exceptions,
                                SendgridThreads.config.raise_exceptions || true)
      @adapter    = params.fetch(:adapter, adapter)
      @conn       = params.fetch(:conn, conn)
      @user_agent = params.fetch(:user_agent, "sendgrid-threads/#{SendgridThreads::VERSION};ruby")
      yield self if block_given?
    end

    def post(endpoint, body = nil)
      endpoint_with_version = "/#{VERSION}/#{endpoint}"
      response = conn.post(endpoint_with_version) do |req|
        req.headers = HEADERS.merge('User-Agent' => @user_agent)
        req.body = JSON(body) if body
      end
      fail SendgridThreads::Exception, response.body if raise_exceptions? && response.status != 200

      response
    end

    def conn
      @conn ||= Faraday.new(url: @url) do |conn|
        conn.request :url_encoded
        conn.request :basic_auth, @key, @secret
        conn.adapter adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end

    def raise_exceptions?
      @raise_exceptions
    end
  end
end
