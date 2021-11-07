apt_update
package 'git'


directory "Ensure Project Directory" do
    owner 'root'
    path '/var/www/app/'
    recursive true
    mode '0755'
    action :create
end

git "Sync Git Repo" do
    repository "git://github.com/codingforentrepreneurs/iac-python.git"
    destination "/var/www/app"
    checkout_branch "main"
    action :sync
end


# build container via Docker


execute "Build App via Docker" do
    command "docker build -t pyapp -f Dockerfile ."
    cwd "/var/www/app/"
    live_stream true
end


# remove other containers
bash "Docker Stop & Remove" do
    code <<-EOH
        if [ "$(docker ps -aq)" ]; then
            docker stop $(docker ps -aq)
            docker rm $(docker ps -aq)
        fi
    EOH
end


# run app in the background
execute 'Run App in Bg' do
    command "docker run --restart always -p 80:8001 -e PORT=8001 -d pyapp"
end

# knife ssh "name:*" "sudo chef-client"