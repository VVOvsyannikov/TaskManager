if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start :rails do
    enable_coverage :branch

    if ENV["COV_IN_DEV_MODE"]
      formatter SimpleCov::Formatter::HTMLFormatter
    else
      require "simplecov-lcov"

      SimpleCov::Formatter::LcovFormatter.config do |config|
        config.report_with_single_file = true
        config.single_report_path = "coverage/lcov.info"
      end

      formatter SimpleCov::Formatter::LcovFormatter
    end
  end
end