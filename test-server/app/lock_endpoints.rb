get '/locks/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/locks/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/locks/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

