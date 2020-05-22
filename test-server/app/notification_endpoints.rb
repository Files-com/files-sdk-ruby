get '/notifications' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/notifications/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/notifications' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/notifications/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/notifications/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

