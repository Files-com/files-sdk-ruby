require "spec_helper"

RSpec.describe Files::File, :with_test_folder do
  describe "#read" do
    before do
      Files::File.open(test_folder.join("read.txt").to_s, 'w', options) do |f|
        f.write("contents")
      end
    end

    it "returns the body of the file" do
      file = Files::File.find(test_folder.join("read.txt").to_s, {}, options)
      expect(file.read).to eq("contents")
    end
  end

  describe "#write" do
    it "can take string" do
      Files::File.open(test_folder.join("write-as-string.txt").to_s, 'w', options) do |f|
        f.write("I am a string")
      end

      file = Files::File.find(test_folder.join("write-as-string.txt").to_s, {}, options)
      expect(file.read).to eq("I am a string")
    end

    it "can take IO object" do
      Files::File.open(test_folder.join("write-as-io.txt").to_s, 'w', options) do |f|
        f.write(StringIO.new("I am a string via IO"))
      end

      file = Files::File.find(test_folder.join("write-as-io.txt").to_s, {}, options)
      expect(file.read).to eq("I am a string via IO")
    end
  end
end
