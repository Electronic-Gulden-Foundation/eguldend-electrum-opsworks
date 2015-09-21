# Example Vagrantfile with example usage for deploying a sample applications

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# Box configurations
config.vm.box = "ubuntu/trusty64"

# Network configurations
config.vm.network "forwarded_port", guest: 80, host: 8888
config.ssh.forward_agent = true

# Plugin settings
if Vagrant.has_plugin?("berkshelf")
config.berkshelf.enabled = true
else
puts "WARN: Berkshelf plugin not installed"
exit
end

if Vagrant.has_plugin?("vagrant-omnibus")
config.omnibus.chef_version = "11.10.4"
else
puts "WARN: Omnibus plugin not installed"
exit
end

# Chef provisioning
config.vm.provision "chef_solo" do |chef|
chef.json = {}

chef.run_list = [
	"recipe[setup-docker::default]",
	"recipe[deploy-servers::default]",
]
end

end

