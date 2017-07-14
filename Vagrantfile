MEMORY = ENV['BUILDROOT_VAGRANT_MEMORY'] || "4096"
CORES = ENV['BUILDROOT_VAGRANT_CORES'] || "2"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.disksize.size = "20GB"

  config.vm.provider "virtualbox" do |v|
    v.name = "knot-gateway-buildroot-vm"
    v.cpus = CORES.to_i
    v.memory = MEMORY.to_i
  end

  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/home/ubuntu/buildroot", type: "nfs", mount_options: ["rw", "vers=3", "tcp", "fsc", "actimeo=2"]

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y \
      bzr cvs git mercurial subversion \
      build-essential automake libtool pkg-config g++ flex gawk bc \
      cpio locales \
      libssl-dev libncurses5-dev \
      zlib1g libncurses5 \
      wget unzip \
      cachefilesd
    echo "RUN=yes" | sudo tee /etc/default/cachefilesd
    sudo -u ubuntu mkdir -p /home/ubuntu/output
  SHELL
end
