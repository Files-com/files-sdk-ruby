require '../lib/files.com'
require 'tempfile'

def assert(value)
  raise "failed assertion" unless value
end

Files.api_key = File.open(File.expand_path("../../../.test_credentials", __dir__)).read.strip
Files.base_url = "https://sdk.filesstaging.av"
Files.logger = Logger.new(STDOUT)
Files.log_level = 'debug'

def test_user_list_and_update
  user = Files::User.all.first
  user = Files::User.find(user.id)
  user.name = name = "Name #{Time.now.to_i}"
  user.save
  sleep 0.5
  user = Files::User.find(user.id)
  assert(name == user.name)
end

def test_user_create_and_delete
  name = "Test User #{Time.now.to_i}"
  user = Files::User.new(name: name, username: "test_user_#{Time.now.to_i}")
  user.save
  sleep 0.5
  user = Files::User.find(user.id)
  assert(name == user.name)
  user.destroy
end

def test_folder_operations
  name = "folder_#{Time.now.to_i}"
  Files::Folder.create(name)
  file = Files::File.find(name)
  file.copy("#{name}_copy")
  file.delete
  file = Files::File.find("#{name}_copy")
  file.move("#{name}_moved_copy")
  file = Files::File.find("#{name}_moved_copy")
  Files::Folder.create("#{file.path}/child")
  Files::FileUtils.rm_r(file.path)
end

def test_file_operations
  name = "file_#{Time.now.to_i}.txt"
  Files::File.upload_file(File.expand_path("../README.md", __dir__), name)
  file = Files::Folder.find(name) # also finds files
  file.delete
end

def test_file_ruby_emulation
  data_string = "File contents - #{Time.now}"
  name = "file_#{Time.now.to_i}.txt"
  Files::File.open(name, 'w') do |f|
    f.write(data_string)
  end
  file = Files::File.find(name)
  assert(file.read == data_string)
  file.delete
end

def test_sessions
  session = Files::Session.create(username: "sessionuser", password: "sessionuserpassword")
  Files::ApiKey.list({ user_id: 0 }, session: session)
  session.destroy
end

#test_user_list_and_update
#test_user_create_and_delete
#test_folder_operations
#test_file_operations
#test_file_ruby_emulation
test_sessions
