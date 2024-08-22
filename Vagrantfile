Vagrant.configure("2") do |config|

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  ### Configuration générale de la box ##
  config.vm.box = "eurolinux-vagrant/centos-stream-9"

  ### Serveur Jenkins ###
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.network "private_network", ip: "192.168.56.10"
    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
    jenkins.vm.provision :shell do |shell|
      shell.path = "install_jenkins.sh"
      shell.args = ["jenkins", "192.168.56.10"]
    end
  end

  ### Serveur Ansible ###
  config.vm.define "ansible" do |ansible|
    ansible.vm.hostname = "ansible"
    ansible.vm.network "private_network", ip: "192.168.56.11"
    ansible.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
    ansible.vm.provision :shell do |shell|
      shell.path = "install_ansible.sh"
      shell.args = ["ansible", "192.168.56.11"]
    end
  end

  ### Serveur Docker-Node ###
  config.vm.define "docker-node" do |docker_node|
    docker_node.vm.hostname = "docker-node"
    docker_node.vm.network "private_network", ip: "192.168.56.12"
    docker_node.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
    docker_node.vm.provision :shell do |shell|
      shell.path = "install_docker.sh"
      shell.args = ["ansible", "192.168.56.12"]
    end

  end

  ### Serveur Web-Node ###
  config.vm.define "web-node" do |web_node|
    web_node.vm.hostname = "web-node"
    web_node.vm.network "private_network", ip: "192.168.56.13"
    web_node.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur prometheus ###
  config.vm.define "prometheus" do |prometheus|
    prometheus.vm.hostname = "prometheus"
    prometheus.vm.network "private_network", ip: "192.168.56.14"
    prometheus.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur node_exporter ###
  config.vm.define "node_exporter" do |node_exporter|
    node_exporter.vm.hostname = "node-exporter"
    node_exporter.vm.network "private_network", ip: "192.168.56.15"
    node_exporter.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end


  ### Serveur grafana ###
  config.vm.define "grafana" do |grafana|
    grafana.vm.hostname = "grafana"
    grafana.vm.network "private_network", ip: "192.168.56.16"
    grafana.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur gitlab ###
  config.vm.define "gitlab" do |gitlab|
    gitlab.vm.hostname = "gitlab"
    gitlab.vm.network "private_network", ip: "192.168.56.17"
    gitlab.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur loki ###
  config.vm.define "loki" do |loki|
    loki.vm.hostname = "loki"
    loki.vm.network "private_network", ip: "192.168.56.18"
    loki.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur sonarqube ###
  config.vm.define "sonarqube" do |sonarqube|
    sonarqube.vm.hostname = "sonarqube"
    sonarqube.vm.network "private_network", ip: "192.168.56.19"
    sonarqube.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur kestra ###
  config.vm.define "kestra" do |kestra|
    kestra.vm.hostname = "kestra"
    kestra.vm.network "private_network", ip: "192.168.56.20"
    kestra.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

  ### Serveur artifactory ###
  config.vm.define "artifactory" do |artifactory|
    artifactory.vm.hostname = "artifactory"
    artifactory.vm.network "private_network", ip: "192.168.56.21"
    artifactory.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

   ### Serveur selenium ###
  config.vm.define "selenium" do |selenium|
    selenium.vm.hostname = "selenium"
    selenium.vm.network "private_network", ip: "192.168.56.22"
    selenium.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end

   ### Serveur haproxy ###
  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network "private_network", ip: "192.168.56.23"
    haproxy.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end


end
