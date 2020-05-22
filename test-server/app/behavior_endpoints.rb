get '/behaviors' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/behaviors/folders/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/behaviors/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/behaviors' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/behaviors/webhook/test' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/behaviors/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/behaviors/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

