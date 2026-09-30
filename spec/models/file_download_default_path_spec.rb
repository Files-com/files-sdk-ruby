require "spec_helper"

RSpec.describe Files::File do
  describe ".download_file without a local path" do
    it "downloads to the remote file name" do
      allow(Gem).to receive(:win_platform?).and_return(false)
      file = described_class.new("folder/report:2026.txt")
      allow(described_class).to receive(:new).with("folder/report:2026.txt").and_return(file)
      expect(file).to receive(:download_file).with("report:2026.txt")

      described_class.download_file("folder/report:2026.txt")
    end

    it "refuses a drive or stream name on Windows" do
      allow(Gem).to receive(:win_platform?).and_return(true)

      [ "folder/C:victim.txt", "C:victim.txt", "folder/victim.txt::$DATA" ].each do |remote_path|
        expect { described_class.download_file(remote_path) }.to raise_error(Files::InvalidParameterError)
      end
    end
  end
end
