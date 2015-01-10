require "active_record"
require_relative 'call'

if development?
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(:development)
else
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end
