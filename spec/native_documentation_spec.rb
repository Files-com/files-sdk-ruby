require "tmpdir"
require "yard"

RSpec.describe "Native API reference" do
  it "renders typed request contracts and remote IO helpers with YARD" do
    Dir.mktmpdir("files-ruby-yard-") do |directory|
      database = File.join(directory, ".yardoc")
      output = File.join(directory, "html")
      YARD::Registry.clear
      YARD::CLI::Yardoc.new.run("--db", database, "--output-dir", output, "--no-stats")
      YARD::Registry.clear
      YARD::Registry.load(database)

      create = YARD::Registry.at("Files::User.create")
      expect(create.tag(:return).types).to eq([ "Files::User" ])
      username = create.tags(:option).find { |tag| tag.pair.name == "username" }
      expect(username.name).to eq("params")
      expect(username.pair.types).to eq([ "String" ])
      expect(username.pair.text).to include("Required.")
      expect(YARD::Registry.at("Files::User#id").tag(:return).types).to eq([ "Integer", "nil" ])
      expect(YARD::Registry.at("Files::User#update").tag(:return).types).to eq([ "Array(Files::Response, Hash)" ])
      expect(YARD::Registry.at("Files::User#destroy").tag(:return).types).to eq([ "nil" ])
      expect(YARD::Registry.at("Files::List#next_page").tag(:return).types).to eq([ "Files::List" ])
      expect(YARD::Registry.at("Files::File#stat").tag(:return).types).to eq([ "Files::File" ])
      expect(YARD::Registry.at("Files::File#readlines").tag(:return).types).to eq([ "Array<String>" ])
      expect(YARD::Registry.at("Files::Folder#each").tag(:return).types).to eq([ "Array", "Enumerator" ])
      expect(YARD::Registry.at("Files::Folder#read").tag(:return).types).to eq([ "Files::File", "nil" ])
      expect(YARD::Registry.at("Files::Folder#seek").tag(:return).types).to eq([ "Integer" ])
      waiter = YARD::Registry.at("Files::FileAction#wait_for_completion")
      expect(waiter.tag(:return).types).to eq([ "Files::FileMigration", "nil" ])
      expect(waiter.tags(:param).map(&:name)).to eq([ "interval", "timeout" ])
      expect(YARD::Registry.at("Files::FileActionError#action").tag(:return).types).to eq([ "Files::FileAction" ])
      expect(YARD::Registry.at("Files::FileActionError#migration").tag(:return).types).to eq([ "Files::FileMigration", "nil" ])
      expect(YARD::Registry.at("Files::File.upload_file").tags(:param).find { |tag| tag.name == "progress" }.types).to eq([ "#call", "nil" ])
      etags = YARD::Registry.at("Files::File.create").tags(:option).find { |tag| tag.pair.name == "etags" }
      expect(etags.pair.types).to eq([ "Array<Hash>" ])
      expect(etags.pair.text).to include("etag", "part")

      user_reference = File.read(File.join(output, "Files", "User.html"))
      expect(user_reference).to include("Options Hash", "username", "Files::User")
      file_reference = File.read(File.join(output, "Files", "File.html"))
      expect(file_reference).to include("acknowledged_bytes", "part_number", "upload_file")
      folder_reference = File.read(File.join(output, "Files", "Folder.html"))
      expect(folder_reference).to include("auto_paging_each", "contents")
      action_reference = File.read(File.join(output, "Files", "FileAction.html"))
      expect(action_reference).to include("wait_for_completion", "timeout", "FileMigration")
      action_error_reference = File.read(File.join(output, "Files", "FileActionError.html"))
      expect(action_error_reference).to include("action", "migration")
    ensure
      YARD::Registry.clear
    end
  end
end
