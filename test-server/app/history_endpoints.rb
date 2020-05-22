get '/history/files(/*path)' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/history/folders(/*path)' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/history/users/:user_id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/history/login' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/history' do
  status 200
  { 'foo' => 'bar' }.to_json
end

