module FreeboxApi

  module Services

    class DDNS

      def initialize(session, provider)
        @session = session
	@provider = provider
      end

      def status
        @session.http_call('get', "/connection/ddns/#{@provider}/status/")
      end

      def config
        @session.http_call('get', "/connection/ddns/#{@provider}/")
      end

      def config=(value)
        @session.http_call('put', "/connection/ddns/#{@provider}/", value)
      end

    end

  end

end
