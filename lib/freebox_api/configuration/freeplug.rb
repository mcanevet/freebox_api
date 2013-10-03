module FreeboxApi

  module Configuration

    class Freeplug

      def initialize(session, id)
        @session = session
	@id = id
      end

      def self.network(session)
        session.http_call('get', '/freeplug/')
      end

      def self.show(session, id)
        session.http_call('get', "/freeplug/#{id}/")
      end

      def show
        self.class.show(@session, @id)
      end

      def self.reset(session, id)
        session.http_call('post', "/freeplug/#{id}/reset/")
      end

      def reset
        self.class.reset(@session, @id)
      end

    end

  end

end
