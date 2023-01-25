require "spec_helper"
require "tempfile"

RSpec.describe Files::File, :with_test_folder, skip: ENV.fetch("GITLAB", nil) do
  describe "#read" do
    before do
      Files::File.open(test_folder.join("[[strange stuff]]#yes.text").to_s, 'w', options) do |f|
        f.write("contents")
      end
    end

    it "returns the body of the file" do
      file = Files::File.find(test_folder.join("[[strange stuff]]#yes.text").to_s, {}, options)
      expect(file.read).to eq("contents")
    end

    context "stream failure" do
      let(:expired_download) { "https://s3.amazonaws.com/objects.brickftp.com/metadata/37868/52f55a21-1685-46aa-aaff-99ca8b172c00?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20210621%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210621T202802Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&response-cache-control=no-cache%2C%20no-store&response-content-disposition=attachment%3B%20filename%3D%22write-as-io.txt%22&response-content-type=text%2Fplain&X-Amz-Signature=83d5b5789cbd2282bfea6e560e4319385135204dc0df3217930f96905c9cb18f" }

      it "waits for io to be ready" do
        file = Files::File.new
        allow(file).to receive(:download_uri_with_load).and_return(expired_download)
        expect { file.read_io }.to raise_error('403 "Forbidden"')
      end
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

    it "works for file with zero bytes" do
      file = Files::File.open("zero-byte.txt", 'w', options)
      file.write("")
      file.close
      file = Files::File.find("zero-byte.txt", {}, options)
      expect(file.read_io.read).to eq("")
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

    it "will send with_rename" do
      path = test_folder.join("with_rename_test.txt").to_s
      io = StringIO.new("I am a string via IO")
      file = Files::File.new({ path: path, with_rename: true }, options)
      file.write(io)
      file.close

      io = StringIO.new("I am a string via IO")
      file = Files::File.new({ path: path, with_rename: true }, options)
      file.write(io)
      file.close

      file = Files::File.find(test_folder.join("with_rename_test.txt").to_s, {}, options)
      expect(file.read).to eq("I am a string via IO")

      file = Files::File.find(test_folder.join("with_rename_test_1.txt").to_s, {}, options)
      expect(file.read).to eq("I am a string via IO")
    end
  end

  describe "#download_content" do
    let(:file) {
      Files::File.open(test_folder.join("write-as-string.txt").to_s, 'w', options) do |f|
        f.write("I am a string")
      end
    }

    it "can take arbitrary IO" do
      file.download_content(io = StringIO.new)

      expect(io.tap(&:rewind).read).to eq("I am a string")
    end
  end

  describe ".from_path" do
    it "returns a file type" do
      Files::File.open(test_folder.join("read.txt").to_s, 'w', options) do |f|
        f.write("contents")
      end
      expect(Files::File.from_path(test_folder.join("read.txt").to_s).type).to eq("file")
    end

    it "returns a directory type" do
      Files::Folder.mkdir("testdir") unless Files::Folder.exist?("testdir")
      expect(Files::File.from_path("testdir").type).to eq("directory")
    end
  end
end
