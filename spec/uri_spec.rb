require "spec_helper"

RSpec.describe Files::URI do
  describe "normalized_path" do
    it { expect(described_class.normalized_path("[[strange stuff]]#yes.text")).to eq("%5B%5Bstrange%20stuff%5D%5D%23yes.text") }
    it { expect(Addressable::URI.unencode_component(described_class.normalized_path("[[strange stuff]]#yes.text"))).to eq("[[strange stuff]]#yes.text") }

    it { expect(described_class.normalized_path("folder/AdÇe")).to eq("folder/AdC%CC%A7e") }
    it { expect(Addressable::URI.unencode_component(described_class.normalized_path("AdÇe"))).to eq("AdÇe") }
  end
end
