module SendgridThreads
  class Api
    attr_reader :connection

    def initialize( params = {} )
      @connection = SendgridThreads::Client.new(params)
    end

    def identify(user_id, traits = {}, timestamp = Time.now )
      body = {userId: user_id, traits: traits, timestamp: utc_iso8601(timestamp)}
      @connection.post("identify", body)
    end

    def track(user_id, event, properties = {}, timestamp = Time.now)
      body = {userId: user_id, event: event, timestamp: utc_iso8601(timestamp), properties: properties}
      @connection.post("track", body)
    end

    def page_view(user_id, name, properties = {}, timestamp = Time.now)
      body = {userId: user_id, name: name, timestamp: utc_iso8601(timestamp), properties: properties}
      @connection.post("page", body)
    end

    def remove(user_id, timestamp = Time.now)
      body = {userId: user_id, timestamp: utc_iso8601(timestamp)}
      @connection.post("remove", body)
    end

    private

    def utc_iso8601(timestamp)
      timestamp.utc.iso8601.gsub(/Z$/, '.000Z')
    end
  end
end
