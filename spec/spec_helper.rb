# frozen_string_literal: true

require_relative '../lib/chartmogul_test'
Bundler.require(:test)
require 'webmock/rspec'
require 'vcr'

WebMock.disable_net_connect!

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
end

module Helpers
  def file_fixture(name)
    File.open(
      File.join(File.dirname(__FILE__), 'fixtures', name)
    )
  end
end

RSpec.configure do |config|
  config.include Helpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
