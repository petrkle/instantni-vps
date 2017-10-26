Vagrant.configure(2) do |config|
  config.vm.box = "pek/instantni-vps"
  config.vm.box_version = "0.0.8"
  config.vm.box_download_checksum = "293f6919d3467aeb78f9321f36b6fc8a8a71f0db4767a371320671013a6f0b30"
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
