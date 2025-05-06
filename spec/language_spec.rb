require "spec_helper"

RSpec.describe 'Language setting', :with_test_folder do
  it 'sets the language' do
    # Set language and verify
    Files.language = 'es'
    expect(Files.language).to eq('es')
    begin
      Files::File.find(test_folder.join("read.txt").to_s, {}, options)
    rescue StandardError => e
      expect(e.message).to include('No se ha encontrado')
    end
  end
end
