class Instance < ActiveRecord::Base
    belongs_to :machine

    def gen_macaddr
        "52:54:00:12:34:#{format("%02d",id)}"
    end
end