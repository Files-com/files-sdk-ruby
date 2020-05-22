get '/groups' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/groups/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/groups' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/groups/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/groups/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

