# require 'init'
require "securerandom"
require "net/telnet"
require "ipaddr"

class DataCenterManager

    STATUS_RUNNING = "running".freeze
    SETUP_SHELL = "/root/setup.sh".freeze
    STARTUP_SHELL = "/root/(vm_name)/start.sh"
    TEARDOWN_SHELL = "/root/teardown.sh".freeze

    def initialize
        
    end

    def getInstances
        ::Instance.all.includes(:machine)
    end

    def launch
        instance = nil
        ::Instance.transaction do 
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

                telnet_port = instance.gen_telnet_port
                instance.update_attributes(telnet_port: telnet_port)

                start_shell = STARTUP_SHELL.gsub("(vm_name)", vm_name)
                ssh(machine_ip, "#{SETUP_SHELL} #{vm_name} #{vm_ip} #{macaddr}; #{start_shell} #{memory_size} #{macaddr} #{vm_name} #{telnet_port}", true)
                instance
            rescue => e
                puts e.message
                raise ActiveRecord::Rollback, "Call tech support!"
            ensure
            end
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
            ssh(machine.ip, "kill -9 $(cat /var/run/#{instance.name}.pid)", true)
            instance.destroy!
            nil
        ensure
            ssh(machine.ip, "#{TEARDOWN_SHELL} #{instance.name}", true)
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