get '/automations' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/automations/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/automations' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/automations/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/automations/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

