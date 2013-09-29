module FreeboxApi

  module Services

    class Connection

      def initialize(session)
        @session = session
      end

      def status
        @session.http_call('get', '/connection/')
      end

      def config
        @session.http_call('get', '/connection/config/')
      end

      def config=(value)
        @session.http_call('put', '/connection/config/', value)
      end

    end

  end

end
