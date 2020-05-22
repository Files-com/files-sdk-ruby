get '/styles/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/styles/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/styles/?*path' do
  status 200
  { 'foo' => 'bar' }.to_json
end

