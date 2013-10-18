Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "precise64"

  ## For masterless, mount your salt file root
  config.vm.synced_folder ".", "/srv/salt/"
  config.vm.synced_folder "vagrant/pillar", "/srv/pillar/"

  config.vm.define "ls01" do |box|
    box.vm.hostname = "ls01"
    box.vm.network "forwarded_port", guest: 5959, host: 5959
    box.vm.network :private_network, ip: "192.168.35.30"
  end

  ## Use all the defaults:
  config.vm.provision :salt do |salt|
    salt.verbose = true

    salt.minion_config = "vagrant/minion"

    # pillar data is in vagrant/pillar/top.sls|logstash.sls

    salt.run_highstate = true
  end
end
