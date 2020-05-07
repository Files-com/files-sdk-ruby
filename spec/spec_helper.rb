require "files.com"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  RSpec.shared_context "API Helpers" do
    let(:test_folder) { @test_folder }
    let(:api_key) { @api_key }
    let(:options) { { api_key: api_key } }
  end

  RSpec.configure do |config|
    config.include_context "API Helpers", :with_test_folder
  end

  config.around(:example, :with_test_folder) do |all|
    @api_key = ENV["TEST_API_KEY"] || File.read("../../config/test_api_key.txt")
    @test_folder = Pathname.new("files_regional_worker/#{SecureRandom.uuid}")
    Files::Folder.exist?("files_regional_worker", api_key: @api_key)
    Files::Folder.mkdir("files_regional_worker", {}, api_key: @api_key) unless Files::Folder.exist?("files_regional_worker", api_key: @api_key)
    Files::Folder.mkdir(@test_folder.to_s, {}, api_key: @api_key)
    all.run
    Files::Folder.delete(@test_folder.to_s, { recursive: true }, api_key: @api_key)
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end
