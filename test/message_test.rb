require 'simplecov'
SimpleCov.start

gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/message"
require 'pry'
class MessageTest < Minitest::Test

end
