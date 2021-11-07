#
# Cookbook:: docker_init
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# sudo apt-get update
# sudo apt-get install curl
# curl https://get.docker.com -o docker-bootstrap.sh
# sudo sh docker-bootstrap.sh
apt_update 'Run apt-get update' do
    frequency 86400
end

package "apt-transport-https"

package "Install Curl" do
    package_name            "curl"
    action                  :install
end


remote_file "Get Docker Script" do
    source 'https://get.docker.com'
    action :create
    path "/tmp/get-docker.sh"
end


bash "Run Docker Bootstrap Script" do
    code <<-EOH
        if [ ~"$(command -v docker)" ]; then
            echo "docker is not installed"
            sudo sh /tmp/get-docker.sh
        fi
    EOH
end

# knife ssh "name:node*" "sudo sh /tmp/get-docker.sh"


service 'docker' do 
    action [:start, :enable]
end
