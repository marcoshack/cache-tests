$: << File.dirname(__FILE__)

require 'bundler/setup'
require 'rack/contrib'
require 'app'

use Rack::ETag

run RFC5861::App.new
