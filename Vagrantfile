
machines = {
  "master" => {"memory" => 512, "cpu" => 1, "image" => "bento/ubuntu-22.04", "ip" => "10" },
  "node1"  => {"memory" => 512, "cpu" => 1, "image" => "bento/ubuntu-22.04", "ip" => "11" },
  "node2"  => {"memory" => 512, "cpu" => 1, "image" => "bento/ubuntu-22.04", "ip" => "12" },
  "node3"  => {"memory" => 512, "cpu" => 1, "image" => "bento/ubuntu-22.04", "ip" => "13" }
}

Vagrant.configure("2") do |config|
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = conf["image"]
      machine.vm.hostname = name
      machine.vm.network "private_network", ip: "192.168.56.#{conf["ip"]}"
      
      machine.vm.provider "virtualbox" do |vb|
        vb.name = name
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
      end
      machine.vm.provision "shell", path: "installdocker.sh"
    end
  end
end