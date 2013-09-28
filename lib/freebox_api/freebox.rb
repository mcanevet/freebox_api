require 'rest_client'
require 'json'

module FreeboxApi

  class Freebox < Hash

    def initialize(hash = {})
      self[:freebox_ip] = hash[:freebox_ip] ? hash[:freebox_ip] : 'mafreebox.free.fr'
      self[:freebox_port] = hash[:freebox_port] ? hash[:freebox_port] : '80'
      @client = RestClient::Resource.new("http://#{self[:freebox_ip]}:#{self[:freebox_port]}")
      self[:uid] = discover['uid']
      self[:device_name] = discover['device_name']
      self[:api_version] = discover['api_version']
      self[:api_base_url] = discover['api_base_url']
      self[:device_type] = discover['device_type']
    end

    def discover
      args = ['get']
      @discover ||= JSON.parse(@client['/api_version'].send(*args))
    end

    def build_url(api_url)
      "#{self[:api_base_url]}v#{self[:api_version].split('.')[0]}#{api_url}"
    end

    def authorize(token_request)
      http_call('post', '/login/authorize/', token_request)
    end

    def track_auth(track_id)
      http_call('get', "/login/authorize/#{track_id}")
    end

    def challenge
      http_call('get', '/login/')['challenge']
    end

    def http_call(http_method, path, params = {}, session = nil)
      headers = {}

      args = [http_method]
      if %w[post put].include?(http_method.to_s)
        args << params.to_json
      else
        headers[:params] = params if params
      end
      headers[:'X_Fbx_App_Auth'] = session.session_token if session
      args << headers if headers
      JSON.parse(@client[build_url(path)].send(*args))['result']
    end

  end

end
