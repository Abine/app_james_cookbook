#
# Cookbook Name:: app_james
# Recipe:: default
#
# Copyright 2012, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

# Set up the LWRP resources
node[:app][:provider] = 'app_james'
deploy_to = node[:app_james][:destination]

# Install the packages
aptpkgs = ['unzip', 'libmysql-java', 'openjdk-7-jre-headless']

aptpkgs.each do |p|
  log "apt #{p}"
  package p do
    action :install
  end
end

# Download and unpack JAMES
log "Downloading and unpacking JAMES..."
directory deploy_to do
  recursive true
end

remote_file "#{deploy_to}/apache-james-2.3.2.tar.gz" do
  source "http://download.nextag.com/apache/james/server/apache-james-2.3.2.tar.gz"
  checksum '3bdcbf3151529fd013ed9388db7c78d357824f66ba749912e392d3eefd062544'
end

execute "tar xfz #{deploy_to}/apache-james-2.3.2.tar.gz" do
  cwd deploy_to
end

execute "unzip #{deploy_to}/james-2.3.2/apps/james.sar -d #{deploy_to}/james-2.3.2/apps/james"
execute "cp /usr/share/java/mysql.jar #{deploy_to}/james-2.3.2/lib"

# Download and unpack JAMES-DKIM
log "Downloading and unpacking JAMES-DKIM..."
remote_file "#{deploy_to}/apache-jdkim-0.2-bin.tar.gz" do
  source "http://download.nextag.com/apache/james/jdkim/apache-jdkim-0.2-bin.tar.gz"
  checksum 'ed12decb26f1b94e6eea1d5180d8e3d42c8c8fc05ea7d4a4d31f43d970544d57'
end

execute "tar xfz #{deploy_to}/apache-jdkim-0.2-bin.tar.gz" do
  cwd deploy_to
end
execute "cp #{deploy_to}/apache-jdkim-0.2/lib/*.jar #{deploy_to}/james-2.3.2/apps/james/SAR-INF/lib"

# Setting up logs
log "Setting up logs"
directory '/mnt/ephemeral/james/logs' do
  recursive true
end
directory '/mnt/ephemeral/james/data' do
  recursive true
end

link "#{deploy_to}/james-2.3.2/apps/james/logs" do
  to '/mnt/ephemeral/james/logs'
end
link "#{deploy_to}/james-2.3.2/apps/james/var" do
  to '/mnt/ephemeral/james/data'
end

# Allow executing the start script
execute "chmod +x #{deploy_to}/james-2.3.2/bin/phoenix.sh"

node[:app][:destination] = node[:app_james][:destination]

rightscale_marker :end
