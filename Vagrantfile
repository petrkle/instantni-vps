Vagrant.configure(2) do |config|
  config.vm.box = "pek/instantni-vps"
  config.vm.box_version = "0.0.4"
  config.vm.box_download_checksum = "4084559207718b7d9fee0f0bd552fcd6d1fd6bdd3317fcf72ced72c041185946"
  config.vm.box_download_checksum_type = "sha256"
	config.vm.network :private_network, ip: "10.20.30.40"
	config.hostsupdater.aliases = [
		"example.cz",
		"www.example.cz",
		"mx.example.cz",
		"rss.example.cz",
		"db.example.cz",
		"stat.example.cz",
		"roundcube.example.cz",
		"autoconfig.example.cz",
		"foo.cz",
		"www.foo.cz",
		"autoconfig.foo.cz",
	]
	config.vm.provision "shell", privileged: false, path: "provision.sh"
end

# -*- mode: ruby -*-
# vi: set ft=ruby :
