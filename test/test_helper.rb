ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'sidekiq/testing'

class ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include AuthHelper
  include FactoryBot::Syntax::Methods
end

Sidekiq::Testing.inline!
