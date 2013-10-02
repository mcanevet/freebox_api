module FreeboxApi

  module Configuration

    module Connection

      def self.getStatus(session)
        session.http_call('get', '/connection/')
      end

      def self.getConfig(session)
        session.http_call('get', '/connection/config/')
      end

      def self.updateConfig(session, value)
        session.http_call('put', '/connection/config/', value)
      end

      module IPv6

        def self.getConfig(session)
          session.http_call('get', '/connection/ipv6/config/')
	end

	def self.updateConfig(session, value)
          session.http_call('put', '/connection/ipv6/config/', value)
	end

      end

      class DDNS

        def initialize(session, provider)
          # TODO: validate that provider matches (ovh|dyndns|noip)
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

end

