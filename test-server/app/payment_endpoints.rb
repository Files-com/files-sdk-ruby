get '/payments' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/payments/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

