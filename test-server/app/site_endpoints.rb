get '/site' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/site/usage' do
  status 200
  { 'foo' => 'bar' }.to_json
end

patch '/site' do
  status 200
  { 'foo' => 'bar' }.to_json
end

