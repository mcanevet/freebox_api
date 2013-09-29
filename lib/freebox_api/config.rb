module FreeboxApi

  class Config

    def initialize(session)
    end

    def url(service)
      case service
      when 'ipv6'
        '/connection/ipv6/config/'
      when /^ddns\//
        "/connection/#{service}/"
      when 'dmz'
        '/fw/dmz/'
      when 'samba', 'afp'
        '/netshare/samba/'
      else
        "/#{service}/config/"
      end
    end

    def show(service)
      @session.http_call('get', url)
    end

    def update(service, params = {})
      @session.http_call('put', url, params)
    end

  end

end
