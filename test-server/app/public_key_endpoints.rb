get '/public_keys' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/public_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/public_keys' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/public_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/public_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

