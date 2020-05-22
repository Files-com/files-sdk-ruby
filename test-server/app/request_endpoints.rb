get '/requests' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/requests/folders/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/requests' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/requests/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

