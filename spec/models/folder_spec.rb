require "spec_helper"

RSpec.describe Files::Folder, :with_test_folder do
  xdescribe "#list_for" do
    before do
      Files::File.open(test_folder.join("example.txt").to_s, 'w', options) do |f|
        f.write("my text")
      end

      Files::Folder.mkdir(test_folder.join("other").to_s, {}, options)

      Files::File.open(test_folder.join("other/example2.txt").to_s, 'w', options) do |f|
        f.write("my text 2")
      end
    end

    it "lists from the root" do
      results = described_class.list_for(test_folder.to_s, {}, options)

      expect(results.map(&:path).to_a).to match_array([ test_folder.join("example.txt").to_s, test_folder.join("other").to_s ])
      expect(results.map(&:type).to_a).to match_array(%w[file directory])
    end
  end

  xdescribe "#delete" do
    it "deletes a folder" do
      Files::Folder.mkdir(test_folder.join("my-new-folder").to_s, {}, options)
      Files::Folder.delete(test_folder.join("my-new-folder").to_s, {}, options)

      expect(Files::Folder.exist?(test_folder.join("my-new-folder").to_s, options)).to eq(false)
    end
  end

  xdescribe "mkdir" do
    it "makes a new folder" do
      Files::Folder.mkdir(test_folder.join("my-new-folder").to_s, {}, options)
      expect(Files::Folder.exist?(test_folder.join("my-new-folder").to_s, options)).to eq(true)
    end
  end
end
