module FreeboxApi

  module Services

    class Lan

      def initialize(session)
        @session = session
      end

      def config
        @session.http_call('get', '/lan/config/')
      end

      def config=(value)
        @session.http_call('put', '/lan/config/', value)
      end

    end

  end

end
