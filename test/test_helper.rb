ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'sidekiq/testing'

Dir[Rails.root.join('test', 'support', '**', '*.rb')].sort.each { |f| require f }

Minitest::Test.include(ActiveStorageCleanup)

class ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include AuthHelper
  include FactoryBot::Syntax::Methods
end

Sidekiq::Testing.inline!
