get '/files/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/files/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/files/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/files/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

