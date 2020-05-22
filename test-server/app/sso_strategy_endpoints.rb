get '/sso_strategies' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/sso_strategies/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

