get '/message_comments' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/message_comments/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/message_comments' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/message_comments/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/message_comments/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

