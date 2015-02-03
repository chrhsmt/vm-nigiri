class Instance < ActiveRecord::Base
    belongs_to :machine

    DEFAULT_TELNET_PORT = 4444

    def gen_macaddr
        "52:54:00:12:34:#{format("%02d",id)}"
    end

    def gen_telnet_port
        port = DEFAULT_TELNET_PORT

        while !::Instance.where(machine_id: self.machine.id, telnet_port: port).empty? do 
            port += 1
        end
        port
    end
end