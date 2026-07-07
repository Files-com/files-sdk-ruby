require "spec_helper"

RSpec.describe Files::File do
  it "copies to a remote server underscore destination" do
    expect(described_class).to receive(:copy).with(
      "source.txt",
      { overwrite: true, destination: "_/RemoteServers/42/remote/path/to/file.txt" },
      {}
    )

    described_class.copy_to_remote_server("source.txt", 42, "/../../remote\\path//./to/file.txt", { overwrite: true })
  end

  it "uploads to a remote server underscore destination using the local basename" do
    expect(described_class).to receive(:upload_file).with(
      "local/path/to/file.txt",
      "_/RemoteServers/42/file.txt",
      {},
      params: {}
    )

    described_class.upload_to_remote_server("local/path/to/file.txt", 42)
  end
end
