get '/file_comments/files/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/file_comments' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/file_comments/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/file_comments/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

