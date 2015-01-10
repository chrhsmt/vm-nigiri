require "active_record"
require_relative 'instance'

ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
if development?
    ActiveRecord::Base.establish_connection(:development)
else
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(:production)
end
