post '/file_actions/copy/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/file_actions/move/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/file_actions/begin_upload/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

