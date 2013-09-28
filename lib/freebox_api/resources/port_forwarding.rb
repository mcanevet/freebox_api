module FreeboxApi

  module Resources

    class PortForwarding

      def initialize(session)
        @session = session
      end

      def index
        @session.http_call('get', '/fw/redir/')
      end

      def show(id)
        @session.http_call('get', "/fw/redir/#{id}")
      end

      def update(params = {})
        @session.http_call('put', "/fw/redir/#{params['id']}", params)
      end

      def destroy(id)
        @session.http_call('delete', "/fw/redir/#{id}")
      end

      def create(params = {})
        @session.http_call('post', '/fw/redir/', params)
      end

    end

  end

end
