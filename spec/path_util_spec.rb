require "spec_helper"
require 'json'

RSpec.describe Files::PathUtil do
  json_str = File.read("shared/normalization_for_comparison_test_data.json")
  test_cases = JSON.parse json_str

  test_cases.each do |test_case_info|
    src_chars, dst_chars = test_case_info
    example "normalizes #{src_chars} to #{dst_chars}" do
      expect(Files::PathUtil.normalize_for_comparison(src_chars)).to eq(dst_chars)
      expect(Files::PathUtil.normalize_for_comparison(dst_chars)).to eq(dst_chars)
      expect(Files::PathUtil.same?(src_chars, dst_chars)).to eq(true)
    end
  end

  it "matches the server comparison examples without rewriting the result" do
    JSON.parse(File.read("shared/comparison_examples.json")).each do |input, expected|
      expect(Files::PathUtil.normalize_for_comparison(input)).to eq(expected)
    end
  end

  it "normalizes API paths without changing path identity" do
    expect(Files::PathUtil.normalize("/../../remote\\path//./to/file.txt")).to eq("remote/path/to/file.txt")
    expect(Files::PathUtil.normalize("remote/../path/to/file.txt")).to eq("remote/path/to/file.txt")
  end
end
