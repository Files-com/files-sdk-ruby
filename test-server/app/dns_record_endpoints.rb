get '/dns_records' do
  status 200
  { 'foo' => 'bar' }.to_json
end

