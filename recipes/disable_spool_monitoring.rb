#
# Cookbook Name:: app_james
# Recipe:: disable_spool_monitoring
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

cron 'chkspool' do
  action :delete
end

rightscale_marker :end