module FreeboxApi
end

require 'freebox_api/config'
require 'freebox_api/connection'
require 'freebox_api/freebox'
require 'freebox_api/session'
require 'freebox_api/version'
resource_files = Dir[File.expand_path("#{File.dirname(__FILE__)}/freebox_api/resources/*.rb", __FILE__)]
resource_files.each { |f| require f }
