class Key < ActiveRecord::Base

    after_destroy do 
        directory = "#{App.settings.root}/keys"
        `rm -rf #{directory}/#{name} #{directory}/#{name}.pub `
    end
end