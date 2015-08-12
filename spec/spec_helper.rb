require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'

require File.expand_path('../../config/environment', __FILE__)

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].each do |file|
  require file
end
