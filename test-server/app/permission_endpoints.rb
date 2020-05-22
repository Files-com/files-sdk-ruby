get '/permissions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/permissions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/permissions/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

