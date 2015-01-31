$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../models")
require "machine"

::Machine.destroy_all
::Machine.create!({name: "syake2", disk_size: 300000, memory: 60000, ip: "192.168.0.30", ip_range: "192.168.0.96/28"})  unless ::Machine.where(name: "syake2").first
::Machine.create!({name: "syake3", disk_size: 300000, memory: 60000, ip: "192.168.0.40", ip_range: "192.168.0.112/28"}) unless ::Machine.where(name: "syake3").first
::Machine.create!({name: "syake4", disk_size: 300000, memory: 60000, ip: "192.168.0.50", ip_range: "192.168.0.128/28"}) unless ::Machine.where(name: "syake4").first
