$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'byebug'
require 'colorize'

if ENV['coverage'] == 'on'
  require 'simplecov'
  SimpleCov.start do
    add_group 'lib', 'lib'
    minimum_coverage 100
  end
  require 'coveralls'
  Coveralls.wear!
end

require 'ticketfy/cli'
