# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "mozodev/anyenv"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/55177834/mozodev-trusty-anyenv.box"
  
  config.vm.box_check_update = false
  config.vbguest.auto_update = false
  
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "trusty-anyenv"
    vb.memory = "1024"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y nginx
    anyenv install nodenv && source ~/.profile
    nodenv install 6.2.0 && nodenv global 6.2.0
    git clone https://github.com/nodenv/nodenv-package-rehash.git "$(nodenv root)"/plugins/nodenv-package-rehash
    npm -g i forever
  SHELL
end
