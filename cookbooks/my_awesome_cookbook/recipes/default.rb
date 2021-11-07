#
# Cookbook:: my_awesome_cookbook
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
execute "my_cmd_name" do 
    command "echo 'hello world'"
end

execute "my_cmd_name2" do 
    command "echo 'hello world again'"
end
