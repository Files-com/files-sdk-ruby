get '/messages' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/messages/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/messages' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/messages/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/messages/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

