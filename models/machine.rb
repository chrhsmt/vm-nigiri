class Machine < ActiveRecord::Base
    has_many :instances

    def assign_ip_addr
        IPAddr.new(ip_range).to_range.each do | ip |
            return ip.to_s unless instances.where(ip: ip.to_s).first
        end
        nil
    end
end