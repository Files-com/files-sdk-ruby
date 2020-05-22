get '/invoices' do
  status 200
  { 'foo' => 'bar' }.to_json
end

get '/invoices/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

