require "spec_helper"
require "tempfile"

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

  describe "#read_io" do
    before do
      Files::File.open(test_folder.join("read.txt").to_s, 'w', options) do |f|
        f.write("contents")
      end
    end

    it "returns an IO Object" do
      file = Files::File.find(test_folder.join("read.txt").to_s, {}, options)
      expect(file.read_io).to be_a_kind_of(IO)
      expect(file.read_io.read).to eq("contents")
      expect(file.read_io.size).to eq("contents".length)
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

    it "can take an IO without #size" do
      temp_file = Tempfile.new("testing_io.txt")

      temp_file.write("I am a string via IO")
      temp_file.rewind
      fd = IO.sysopen(temp_file.path)
      io = IO.new(fd)

      file = Files::File.open(test_folder.join("write-as-io.txt").to_s, 'w', options) do |f|
        f.write(io)
      end

      expect(file.read).to eq("I am a string via IO")
      temp_file.close
    end
  end
end
