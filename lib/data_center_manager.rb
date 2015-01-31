# require 'init'
require "securerandom"

class DataCenterManager

    STATUS_RUNNING = "running".freeze
    STARTUP_SHELL = "/root/setup.sh".freeze

    def initialize
        
    end

    def getInstances
        ::Instance.all
    end

    def launch
        vm_name = "vm_syake_#{SecureRandom.uuid}"
        machine_ip = "192.168.0.30"
        vm_ip = "192.168.0.71"
        macaddr = "52:54:00:12:34:60"
        ssh(machine_ip, "#{STARTUP_SHELL} #{vm_name} #{vm_ip} #{macaddr}", true)
        params = {
            name: vm_name,
            disk_size: 1024000000,
            memory: 1024,
            ip: vm_ip,
            mac: macaddr,
            status: STATUS_RUNNING
        }
        ::Instance.create!(params)
    end

    def terminate(instanceId)
        ::Instance.find(instanceId).destroy!
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