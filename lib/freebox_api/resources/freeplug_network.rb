module FreeboxApi

  module Resources

    class FreeplugNetwork

      def initialize(session)
        @session = session
      end

      def index
        @session.http_call('get', '/freeplug/')
      end

    end

  end

end

