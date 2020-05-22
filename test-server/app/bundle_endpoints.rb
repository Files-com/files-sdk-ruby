get '/bundles' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/bundles/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/bundles' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/bundles/:id/share' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/bundles/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

