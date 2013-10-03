module FreeboxApi

  module Configuration

    module Dhcp

      def self.getConfig(session)
        session.http_call('get', '/dhcp/config/')
      end

      def self.updateConfig(session, value)
        session.http_call('put', '/dhcp/config/')
      end

      def self.static_leases(session)
        session.http_call('get', '/dhcp/static_lease/')
      end

      def self.dynamic_leases(session)
        session.http_call('get', '/dhcp/dynamic_lease/')
      end

      class StaticLease

        def initialize(session, id)
          @session = session
          @id = id
	end

        def self.show(session, id)
          session.http_call('get', "/dhcp/static_lease/#{id}")
        end

        def show
          self.class.show(@session, @id)
  	end

        def self.update(session, id, value = {})
          session.http_call('put', "/dhcp/static_lease/#{id}", value)
        end

        def update(value = {})
          self.class.update(@session, @id, value)
        end

        def self.delete(session, id)
          session.http_call('delete', "/dhcp/static_lease/#{id}")
        end

        def delete
          self.class.delete(@session, @id)
        end

        def self.create(session, value)
          session.http_call('post', '/dhcp/static_lease/', value)
        end

        def create(value)
          self.class.create(@session, value)
        end

      end

    end

  end

end
