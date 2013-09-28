module FreeboxApi

  module Resources

    class Interface

      def initialize(session)
        @session = session
      end

      def index
        @session.http_call('get', '/lan/browser/interfaces')
      end

    end

  end

end
