module FreeboxApi

  module Resources

    class UPnPRedir

      def initialize(session)
        @session = session
      end

      def index
        @session.http_call('get', '/upnpigd/redir/')
      end

      def destroy(id)
        @session.http_call('delete', "/upnpigd/redir/#{id}")
      end

    end
  
  end

end
