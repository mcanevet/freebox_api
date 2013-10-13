module FreeboxApi

  module Configuration

    module Nat

      module Dmz

        def self.getConfig(session)
          session.http_call('get', '/fw/dmz/')
        end

        def self.updateConfig(session, value)
          session.http_call('put', '/fw/dmz/', value)
        end

      end

      def self.port_forwardings(session)
        session.http_call('get', '/fw/redir/')
      end

      class PortForwarding

        def self.show(session, redir_id)
          session.http_call('get', "/fw/redir/#{redir_id}")
        end

        def self.update(session, redir_id, value = {})
          session.http_call('put', "/fw/redir/#{redir_id}", value)
        end

        def self.delete(session, id)
          session.http_call('delete', "/fw/redir/#{redir_id}")
        end

        def self.create(session, value)
          session.http_call('post', '/fw/redir/', value)
        end

      end

    end

  end

end
