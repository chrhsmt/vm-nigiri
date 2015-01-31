$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../models")
require "machine"

::Machine.create!({name: "syake2", disk_size: 300000, memory: 60000, ip: "192.168.0.30"})