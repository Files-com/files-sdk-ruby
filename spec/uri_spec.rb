require "spec_helper"

RSpec.describe Files::URI do
  describe "normalized_path" do
    it { expect(described_class.normalized_path("path/[[strange stuff]]#yes.text")).to eq("path/%5B%5Bstrange%20stuff%5D%5D%23yes.text") }
    it { expect(Addressable::URI.unencode_component(described_class.normalized_path("[[strange stuff]]#yes.text"))).to eq("[[strange stuff]]#yes.text") }

    it { expect(described_class.normalized_path("folder/AdÇe")).to eq("folder/AdC%CC%A7e") }
    it { expect(Addressable::URI.unencode_component(described_class.normalized_path("AdÇe"))).to eq("AdÇe") }

    it { expect(described_class.normalized_path("lorem%20ipsum.txt")).to eq("lorem%2520ipsum.txt") }
    it { expect(described_class.normalized_path("lorem%ipsum.txt")).to eq("lorem%25ipsum.txt") }
    it { expect(described_class.normalized_path("lorem ipsum.txt")).to eq("lorem%20ipsum.txt") }
  end
end
