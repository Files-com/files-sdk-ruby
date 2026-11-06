require "spec_helper"
require "tempfile"

RSpec.describe Files::File, :with_test_folder do
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
      it "raises the download failure while preparing the reader" do
        path = test_folder.join("[[strange stuff]]#yes.text").to_s
        uri = URI("#{MockServerFixture.origin}/__files_mock/v1/faults")
        rule = { operation: "transfers.download", match: { path: path }, status: 403 }
        response = Net::HTTP.start(uri.hostname, uri.port, open_timeout: 5, read_timeout: 10) do |http|
          http.post(uri.request_uri, JSON.generate(rule), "Content-Type" => "application/json")
        end
        expect(response.code).to eq("201")
        fault_id = JSON.parse(response.body).fetch("id")

        file = Files::File.find(path, {}, options)
        expect { file.read_io }.to raise_error('403 "Forbidden"')
        downloads = MockServerFixture.journal(MockServerFixture.origin).select do |entry|
          entry["operation"] == "transfers.download" && entry["fault_id"] == fault_id
        end
        expect(downloads.size).to eq(1)
        expect(downloads.first).to include("status" => 403)
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
      file = Files::File.open(test_folder.join("zero-byte.txt").to_s, 'w', options)
      file.write("")
      file.close
      file = Files::File.find(test_folder.join("zero-byte.txt").to_s, {}, options)
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

    # The simulator answers with_rename with 501 (simulation/not-supported), so CI leaves this probe out.
    it "will send with_rename", skip: ENV.fetch("GITLAB", nil) do
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
      expect(Files::File.from_path(test_folder.join("read.txt").to_s, options).type).to eq("file")
    end

    it "returns a directory type" do
      Files::Folder.mkdir(test_folder.join("testdir").to_s, {}, options)
      expect(Files::File.from_path(test_folder.join("testdir").to_s, options).type).to eq("directory")
    end
  end
end
