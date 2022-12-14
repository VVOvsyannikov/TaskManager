ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)
  include FactoryBot::Syntax::Methods
  include AuthHelper

  fixtures :all
end
