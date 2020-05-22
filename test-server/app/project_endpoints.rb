get '/projects' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/projects/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/projects' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/projects/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/projects/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

