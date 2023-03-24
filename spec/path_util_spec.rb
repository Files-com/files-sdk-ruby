require "spec_helper"
require 'json'

RSpec.describe Files::PathUtil do
  json_str = File.read("shared/normalization_for_comparison_test_data.json")
  test_cases = JSON.parse json_str

  test_cases.each do |test_case_info|
    src_chars, dst_chars = test_case_info
    example "normalizes #{src_chars} to #{dst_chars}" do
      expect(Files::PathUtil.same?(src_chars, dst_chars)).to eq(true)
    end
  end
end
