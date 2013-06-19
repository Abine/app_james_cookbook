#
# Cookbook Name:: app_james
# Recipe:: setup_redis_connection
#
# Copyright 2012, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

template "#{node[:app_james][:destination]}/james-2.3.2/apps/james/SAR-INF/redis.xml" do
  source "redis.xml.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
        :redis_host => node[:app_james][:redis][:host],
        :redis_auth_key => node[:app_james][:redis][:auth_key],
        :redis_expires_secs => node[:app_james][:redis][:expires_secs],
        :redis_expiration_buffer => node[:app_james][:redis][:expiration_buffer],
        :redis_user_mails => node[:app_james][:redis][:user_mails]
    })
end

rightscale_marker :end
