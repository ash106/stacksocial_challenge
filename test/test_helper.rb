ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  ActiveRecord::Migration.check_pending!
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def assert_valid(record, message = nil)
    message ||= "Expected #{record.inspect} to be valid"
    assert record.valid?, message
  end
  
  def assert_invalid(record, options = {})
    assert record.invalid?, "Expected #{record.inspect} to be invalid"
    options.each do |attribute, message|
      assert_includes record.errors[attribute], message
    end
  end

end
