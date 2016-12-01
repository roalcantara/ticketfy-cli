$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'byebug'

if ENV['coverage'] == 'on'
  require 'simplecov'
  SimpleCov.start do
    add_group 'lib', 'lib'
    minimum_coverage 100
  end
end

require 'ticketfy/cli'
