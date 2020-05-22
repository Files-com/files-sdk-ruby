get '/message_reactions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/message_reactions/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/message_reactions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/message_reactions/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

