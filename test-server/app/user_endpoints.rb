get '/users' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/users/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/users' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/users/:id/unlock' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/users/:id/resend_welcome_email' do
  status 200
  { 'foo' => 'bar' }.to_json
end

post '/users/:id/2fa/reset' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/users/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/users/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

