#
# Cookbook Name:: app_james
# Recipe:: enable_spool monitoring
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

unless node[:app_james][:spool][:service_key].empty?

  python_pip 'pagerduty' do
    action :install
  end

  template "#{node[:app_james][:destination]}/chkspool.py" do
    source 'chkspool.py.erb'
    variables({
    :trigger => node[:app_james][:spool][:trigger],
    :resolve => node[:app_james][:spool][:resolve],
    :service_key => node[:app_james][:spool][:service_key]
  })
  end
  cron 'chkspool' do
    command "python #{node[:app_james][:destination]}/chkspool.py"
    minute [rand(29), rand(29)+30] * ","
  end

end
rightscale_marker :end