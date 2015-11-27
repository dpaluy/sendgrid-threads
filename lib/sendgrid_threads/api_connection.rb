module SendgridThreads
  class ApiConnection
    attr_reader :connection

    def initialize( params = {} )
      @connection = SendgridThreads::Client.new(params)
    end

    def identify(user_id, traits = {}, timestamp = Time.now )
      body = {userId: user_id, traits: traits, timestamp: timestamp.utc.iso8601}
      @connection.post("identify", body)
    end

    def track(user_id, event, properties = {}, timestamp = Time.now)
      body = {userId: user_id, event: event, timestamp: timestamp.utc.iso8601, properties: properties}
      @connection.post("track", body)
    end

    def page_view(user_id, name, properties = {}, timestamp = Time.now)
      body = {userId: user_id, name: name, timestamp: timestamp.utc.iso8601, properties: properties}
      @connection.post("page", body)
    end

    def remove(user_id, timestamp = Time.now)
      body = {userId: user_id, timestamp: timestamp.utc.iso8601}
      @connection.post("remove", body)
    end
  end
end
