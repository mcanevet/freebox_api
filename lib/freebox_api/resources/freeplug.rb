module FreeboxApi

  module Resources

    class Freeplug

      def initialize(session)
        @session = session
      end

      def index
        FreeplugNetwork.new(session).collect { |freeplug_network|
          freeplug_network['members']
	}.flatten
      end

      def show(id)
        @session.http_call('get', "/freeplug/#{id}/")
      end

      def reset(id)
        @session.http_call('post', "/freeplug/#{id}/reset/")
      end

    end

  end

end
