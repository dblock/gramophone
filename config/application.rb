$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'gramophone'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

require 'active_model'

Dir[File.expand_path('../initializers', __FILE__) + '/**/*.rb'].each do |file|
  require file
end

Mongoid.load! File.expand_path('../mongoid.yml', __FILE__), ENV['RACK_ENV']

require 'models'
require 'api'
require 'app'
