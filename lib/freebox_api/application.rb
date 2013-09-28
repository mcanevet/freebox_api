require 'rest_client'
require 'json'

module FreeboxApi

  class Application < Hash

    def initialize(hash = {})
      self[:app_id] = hash[:app_id]
      self[:app_token] = hash[:app_token]
    end

  end

end
