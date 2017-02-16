Vagrant.configure(2) do |config|

  # Set base box and provisioning
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, path: "bootstrap.sh"

  # Provider resources
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 4
  end

  # Networking
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Shared folders
  config.vm.synced_folder '.', '/vagrant',
    owner: "www-data", group: "www-data"

end
