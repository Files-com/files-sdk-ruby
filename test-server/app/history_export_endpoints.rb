get '/history_exports' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/history_exports/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/history_exports' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/history_exports/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

