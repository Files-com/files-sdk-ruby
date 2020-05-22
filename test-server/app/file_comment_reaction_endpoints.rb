post '/file_comment_reactions' do
  status 200
  { 'foo' => 'bar' }.to_json
end

delete '/file_comment_reactions/:id' do
  status 200
  { 'foo' => 'bar' }.to_json
end

