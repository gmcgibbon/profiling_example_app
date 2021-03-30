ENV['RAILS_ENV'] ||= 'test'

if ENV["TEST_PROFILE"]
  require "stackprof"
  StackProf.start(mode: ENV["TEST_PROFILE"].to_sym, raw: true)
  at_exit do
    StackProf.stop
    Rails.root.join("tmp/flamegraph").mkpath
    Rails.root.join("tmp/flamegraph/test.dump").write(JSON.generate(StackProf.results))
    system("yarn speedscope #{Rails.root.join("tmp/flamegraph/test.dump")}")
  end
end

require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
