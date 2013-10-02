require 'rest_client'
require 'json'
require 'logger'

module FreeboxApi

  class Freebox < Hash

    attr_reader :logger

    def initialize(hash = {}, logger = nil)
      self[:freebox_ip] = hash[:freebox_ip] ? hash[:freebox_ip] : 'mafreebox.free.fr'
      self[:freebox_port] = hash[:freebox_port] ? hash[:freebox_port] : '80'
      @client = RestClient::Resource.new("http://#{self[:freebox_ip]}:#{self[:freebox_port]}")
      self[:uid] = discover['uid']
      self[:device_name] = discover['device_name']
      self[:api_version] = discover['api_version']
      self[:api_base_url] = discover['api_base_url']
      self[:device_type] = discover['device_type']
      self.logger = logger
    end

    def logger=(logger)
      if logger.nil?
        logger = Logger.new(STDOUT)
        logger.level = Logger::WARN
      end
        @logger = logger
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

    def http_call(http_method, path, params = nil, session = nil)
      headers = {}

      args = [http_method]
      if %w[post put].include?(http_method.to_s)
        args << params.to_json
      else
        headers[:params] = params if params
      end
      headers[:'X_Fbx_App_Auth'] = session.session_token if session

      logger.info "#{http_method.upcase} #{path}"
      logger.debug "Params: #{params.inspect}"
      logger.debug "Headers: #{headers.inspect}"
      args << headers if headers
      process_data(@client[build_url(path)].send(*args))['result']
    end

    def process_data(response)
      data = begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
      logger.debug "Returned data: #{data.inspect}"
      return data
    end

  end

end
