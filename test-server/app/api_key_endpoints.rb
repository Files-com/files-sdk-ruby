get '/api_keys' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/api_key' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/api_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/api_keys' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/api_key' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/api_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/api_key' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/api_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

