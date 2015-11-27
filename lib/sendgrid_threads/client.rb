require 'faraday'

module SendgridThreads
  class Client
    ENDPOINT = 'https://input.threads.io/v1/'.freeze
    HEADERS = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}.freeze

    attr_reader :key, :secret, :endpoint, :user_agent
    attr_writer :adapter, :conn, :raise_exceptions

    def initialize( params = {} )
      self.key      = params.fetch(:key,      SendgridThreads.config.key)
      self.secret   = params.fetch(:secret,   SendgridThreads.config.secret)
      self.endpoint = params.fetch(:endpoint, SendgridThreads.config.endpoint || ENDPOINT)
      self.raise_exceptions = params.fetch(:raise_exceptions,
                                          SendgridThreads.config.raise_exceptions || true)
      self.adapter    = params.fetch(:adapter, adapter)
      self.conn       = params.fetch(:conn, conn)
      self.user_agent = params.fetch(:user_agent, "sendgrid-threads/#{SendGrid::VERSION};ruby")
      yield self if block_given?
    end

    def post(url, body = nil)
      response = conn.post(url) do |req|
        req.headers = HEADERS
        req.request  :basic_authentication, @key, @secret
        req.body = body if body
      end
      fail SendgridThreads::Exception, response.body if raise_exceptions? && response.status != 200

      response.body
    end

    def conn
      @conn ||= Faraday.new(url: @endpoint) do |conn|
        conn.request :url_encoded
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
