get '/group_users' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/group_users/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/group_users/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

