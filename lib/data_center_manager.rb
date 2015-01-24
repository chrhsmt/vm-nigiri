# require 'init'

class DataCenterManager

    STATUS_RUNNING = "running".freeze

    def initialize
        
    end

    def getInstances
        ::Instance.all
    end

    def launch
        ip = "192.168.6.1"
        ssh(ip, "ifconfig", true)
        params = {
            name: "syake-test-vm",
            disk_size: 1024000000,
            memory: 1024,
            ip: ip,
            mac: "98:fe:94:4f:15:7c",
            status: STATUS_RUNNING
        }
        ::Instance.create!(params)
    end

    def terminate(instanceId)
        
    end

    private
        def ssh(private_ip, command, dump=false)
            dev_null = dump ? '' : '>& /dev/null'
            one_liner =
            "ssh -o 'StrictHostKeyChecking no' " +
            "root@#{private_ip} '#{command}'" + dev_null
            print "Execute: #{one_liner}\n" if dump
            system one_liner           
        end
    end
end