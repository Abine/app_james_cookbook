#
# Cookbook Name:: app_james
#
# Copyright 2012, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#


# Attributes for James' platform
default[:app_james][:destination] = '/home/james'
default[:app_james][:jvm_heap] = '3072'

# Attributes for James' database connection
default[:app_james][:db][:db_user] = ''
default[:app_james][:db][:db_pwd] = ''
default[:app_james][:db][:db_name] = ''
default[:app_james][:db][:db_host] = ''

# Attributes for spool monitoring
default[:app_james][:spool][:service_key] = ''
default[:app_james][:spool][:trigger] = '100'
default[:app_james][:spool][:resolve] = '50'
