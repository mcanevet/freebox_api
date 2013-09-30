module FreeboxApi

  module Resources

    class StaticLease

      def initialize(session)
        @session = session
      end

      def index
        @session.http_call('get', '/dhcp/static_lease/') || []
      end

      def show(id)
        @session.http_call('get', "/dhcp/static_lease/#{id}")
      end

      def update(params = {})
        @session.http_call('put', "/dhcp/static_lease/#{params['id']}", params)
      end

      def destroy(id)
        @session.http_call('delete', "/dhcp/static_lease/#{id}")
      end

      def create(params = {})
        @session.http_call('post', '/dhcp/static_lease/', params)
      end

    end

  end

end
