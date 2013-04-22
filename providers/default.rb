#
# Cookbook Name:: app_james
#
# Copyright 2012, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#

# nop and unsupported actions
action :reload do
  raise "Action not available: reload"
end
action :setup_monitoring do
  raise "Monitoring not supported"
end
action :setup_vhost do
  raise "VHOSTs not supported"
end
action :setup_db_connection do
  template "#{node[:app_james][:destination]}/james-2.3.2/apps/james/SAR-INF/db.xml" do
    source "db.xml.erb"
    mode "0644"
    owner "root"
    group "root"
    variables({
      :db_host => node[:app_james][:db][:db_host],
      :db_user => node[:app_james][:db][:db_user],
      :db_pwd => node[:app_james][:db][:db_pwd],
      :db_name => node[:app_james][:db][:db_name]
    })
  end
end

# Stop james
action :stop do
  execute "#{node[:app_james][:destination]}/james-2.3.2/bin/phoenix.sh stop" do
    environment({'JAVA_HOME' => '/usr/lib/jvm/java-7-openjdk-amd64'})
  end
end

# Start james
action :start do
  execute "#{node[:app_james][:destination]}/james-2.3.2/bin/phoenix.sh start" do
    environment({'JAVA_HOME' => '/usr/lib/jvm/java-7-openjdk-amd64',
      'PHOENIX_JVM_OPTS' => "-Xmx#{node[:app_james][:jvm_heap]}M"})
  end
end

# Restart
action :restart do
  log "  Running restart sequence"
  action_stop
  sleep 5
  action_start
end

# Installing required packages to system
action :install do
  log "Nothing to do here"
end

# Download/Update application repository
action :code_update do
  #stopping server
  action_stop

  #delete the old config and abine code
  file "#{node[:app_james][:destination]}/james-2.3.2/apps/james/SAR-INF/config.xml" do
    action :delete
  end
  file "#{node[:app_james][:destination]}/james-2.3.2/apps/james/SAR-INF/lib/abine.jar" do
    action :delete
  end
  directory "#{node[:app_james][:destination]}/abine" do
    action :delete
  end
  directory "#{node[:app_james][:destination]}/abine"

  #asking svn_ssh to grab the code
  svn_ssh 'pull code' do
    action :update
    destination "#{node[:app_james][:destination]}/abine"
    ssh_key node[:svn_ssh][:ssh_key]
    ssh_user node[:svn_ssh][:ssh_user]
    repo_location node[:svn_ssh][:repo_location]
  end

  #copy the config and abine files
  execute "cp #{node[:app_james][:destination]}/abine/config.xml #{node[:app_james][:destination]}/james-2.3.2/apps/james/SAR-INF/config.xml"
  execute "cp #{node[:app_james][:destination]}/abine/abine.jar #{node[:app_james][:destination]}/james-2.3.2/apps/james/SAR-INF/lib/abine.jar"

  action_start
end
