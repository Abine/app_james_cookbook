#
# Cookbook Name:: app_james
# Recipe:: setup_db_connection
#
# Copyright 2012, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin
app 'default' do
  action :setup_db_connection
end
rightscale_marker :end