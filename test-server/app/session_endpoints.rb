post '/sessions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/sessions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

