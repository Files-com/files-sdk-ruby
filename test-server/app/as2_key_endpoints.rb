get '/as2_keys' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/as2_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/as2_keys' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/as2_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/as2_keys/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

