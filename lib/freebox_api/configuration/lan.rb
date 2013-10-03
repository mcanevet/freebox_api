module FreeboxApi

  module Configuration

    module Lan

      def self.getConfig(session)
        session.http_call('get', '/lan/config/')
      end

      def self.updateConfig(session, value)
        session.http_call('put', '/lan/config/', value)
      end

      module Browser

        def self.interfaces(session)
          session.http_call('get', '/lan/browser/interfaces/')
        end

        class Interface

          def initialize(session, name)
            @session = session
            @name = name
          end

          def self.getLanHosts(session, name)
            session.http_call('get', "/lan/browser/#{name}/")
          end

          def lan_hosts
            self.class.getLanHosts(@session, @name)
          end

          def self.wol(session, name, params = {})
            session.http_call('post', "/lan/wol/#{name}/", params)
          end

          def wol(params = {})
            self.class.wol(@session, @name, params)
          end

        end

        class LanHost

          def initialize(session, interface, hostid)
            @session = session
            @interface = interface
            @hostid = hostid
          end

          def self.show(session, interface, hostid)
            session.http_call('get', "/lan/browser/#{interface}/#{hostid}/")
          end

          def show
            self.class.show(@session, @interface, @hostid)
          end

          def self.update(session, interface, hostid, value)
            session.http_call('put', "/lan/browser/#{interface}/#{hostid}/", value)
          end

          def update(value)
            self.class.update(@session, @interface, @hostid, value)
          end

          def wol(password = '')
            Interface.wol(@session, interface, {
              :mac      => show['l2ident']['id'],
              :password => password,
	    })
          end

        end

      end

    end

  end

end
