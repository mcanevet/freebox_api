module FreeboxApi

  module Resources

    class LanHost

      def initialize(session)
        @session = session
      end

      def index
        Interface.new(@session).index.collect { |interface|
          @session.http_call('get', "/lan/browser/#{interface['name']}")
	}.flatten
      end

      def show(id, interface = 'pub')
        @session.http_call('get', "/lan/browser/#{interface}/#{id}/")
      end

      def update(params = {}, interface = 'pub')
        @session.http_call('put', "/lan/browser/#{interface}/#{params['id']}", params)
      end
      
    end

  end

end
