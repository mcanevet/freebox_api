module FreeboxApi

  module Configuration

    module Ftp

      def self.getConfig(session)
        session.http_call('get', '/ftp/config/')
      end

      def self.updateConfig(session, value)
        session.http_call('put', '/ftp/config/', value)
      end

    end

  end

end
