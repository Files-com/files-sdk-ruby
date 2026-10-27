require "spec_helper"

RSpec.describe Files::Folder, :with_test_folder do
  describe "#list_for" do
    # The shared fixture already makes test_folder/nested, so the listing gets a folder of its own.
    let(:listed_folder) { test_folder.join("listed") }

    before do
      Files::Folder.mkdir(listed_folder.to_s, {}, options)

      Files::File.open(listed_folder.join("example.txt").to_s, 'w', options) do |f|
        f.write("my text")
      end

      Files::Folder.mkdir(listed_folder.join("other").to_s, {}, options)

      Files::File.open(listed_folder.join("other/example2.txt").to_s, 'w', options) do |f|
        f.write("my text 2")
      end
    end

    it "lists from the root" do
      results = described_class.list_for(listed_folder.to_s, {}, options)

      expect(results.map(&:path).to_a).to match_array([ listed_folder.join("example.txt").to_s, listed_folder.join("other").to_s ])
      expect(results.map(&:type).to_a).to match_array(%w[file directory])
    end
  end

  describe "#delete" do
    it "deletes a folder" do
      Files::Folder.mkdir(test_folder.join("my-new-folder").to_s, {}, options)
      Files::Folder.delete(test_folder.join("my-new-folder").to_s, {}, options)

      expect(Files::Folder.exist?(test_folder.join("my-new-folder").to_s, options)).to eq(false)
    end
  end

  describe "mkdir" do
    it "makes a new folder" do
      Files::Folder.mkdir(test_folder.join("my-new-folder").to_s, {}, options)
      expect(Files::Folder.exist?(test_folder.join("my-new-folder").to_s, options)).to eq(true)
    end
  end
end
