module FreeboxApi
end

require 'freebox_api/freebox'
require 'freebox_api/session'
require 'freebox_api/version'
resource_files = Dir[File.expand_path("#{File.dirname(__FILE__)}/freebox_api/resources/*.rb", __FILE__)]
resource_files.each { |f| require f }
service_files = Dir[File.expand_path("#{File.dirname(__FILE__)}/freebox_api/services/*.rb", __FILE__)]
service_files.each { |f| require f }
