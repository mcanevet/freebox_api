module FreeboxApi

  module Services

    class DHCP

      def initialize(session)
        @session = session
      end

      def config
        @session.http_call('get', '/dhcp/config/')
      end

      def config=(value)
        @session.http_call('put', '/dhcp/config/', value)
      end

    end

  end

end
