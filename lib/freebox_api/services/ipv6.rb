module FreeboxApi

  module Services

    class IPv6

      def initialize(session)
        @session = session
      end

      def config
        @session.http_call('get', '/connection/ipv6/config/')
      end

      def config=(value)
        @session.http_call('put', '/connection/ipv6/config/', value)
      end

    end

  end

end
