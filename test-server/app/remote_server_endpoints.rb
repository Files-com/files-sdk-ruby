get '/remote_servers' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/remote_servers/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/remote_servers' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/remote_servers/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/remote_servers/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

