get '/folders/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/folders/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

