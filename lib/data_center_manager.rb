# require 'init'
require "securerandom"
require "net/telnet"
require "ipaddr"

class DataCenterManager

    STATUS_RUNNING = "running".freeze
    SETUP_SHELL = "/root/setup.sh".freeze
    STARTUP_SHELL = "/root/start.sh".freeze

    def initialize
        
    end

    def getInstances
        ::Instance.all
    end

    def launch
        instance = nil
        begin 
            machine = ::Machine.first
            vm_name = "vm_syake_#{SecureRandom.uuid}"
            memory_size = 1024
            machine_ip = machine.ip
            vm_ip = machine.assign_ip_addr
            params = {
                machine: machine,
                name: vm_name,
                disk_size: 1024000000,
                memory: memory_size,
                ip: vm_ip,
                # mac: macaddr,
                status: STATUS_RUNNING
            }
            instance = ::Instance.create!(params)
            macaddr = instance.gen_macaddr
            instance.update_attributes(mac: macaddr)
            ssh(machine_ip, "#{SETUP_SHELL} #{vm_name} #{vm_ip} #{macaddr}; #{STARTUP_SHELL} #{memory_size} #{macaddr} #{vm_name}", true)
            instance
        rescue => e
            puts e.message
            instance.destroy if instance
        ensure
        end
    end

    def terminate(instanceId)
        begin
            instance = ::Instance.find(instanceId)
            machine = instance.machine
            connect_monitor(machine.ip, 4444) do | telnet |
                telnet.cmd("quit")
            end
            instance.destroy!
            nil
        rescue ActiveRecord::RecordNotFound => e
            e.message
        rescue Errno::ECONNRESET => e
            # Telnetのコネクションが切切れるので正常終了
        rescue => e
            ssh(machine.ip, "kill -9 $(car /var/run/#{instance.name}.pid)", true)
            instance.destroy!
            nil
        end
    end

    private
        def ssh(private_ip, command, dump=false)
            dev_null = dump ? '' : '>& /dev/null'
            one_liner =
            "ssh -o 'StrictHostKeyChecking no' " +
            "root@#{private_ip} '#{command}'" + dev_null
            print "Execute: #{one_liner}\n" if dump
            pid = `#{one_liner}`
        end

        def connect_monitor(ip, port, &blk)
            begin
                telnet = ::Net::Telnet.new(
                    "Host" => ip.to_s   ,
                    "Port" => port.to_s,
                    "Prompt" => /\n\(qemu\)/,
                    "Timeout" => 60,
                    "Waittime" => 0.2)
                blk.call(telnet)
            rescue => e
                p e
                puts e.message
            ensure
                telnet.close
            end
        end
end