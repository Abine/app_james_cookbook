name             "app_james"
maintainer       "Abine, Inc."
maintainer_email "cloud@abine.com"
license          "All rights reserved"
description      "Installs/Configures James"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "rightscale"
depends "svn_ssh"
depends "app"

recipe "app_james::default", "Set up the James server"
recipe "app_james::setup_db_connection", "Provision a database snippet for James"

attribute 'app_james/destination',
  :display_name => "JAMES Installation Directory",
  :description => "Directory to deploy the JAMES files to. Please omit the trailing slash. Default: /home/james",
  :default => '/home/james',
  :required => 'optional',
  :recipes => ['app_james::default']

attribute 'app_james/jvm_heap',
  :display_name => "Max JVM Heap Size (MB)",
  :description => "Maximum size of the JVM heap. Enter in MB (e.g. 3072 MB)",
  :required => 'optional',
  :default => '3072',
  :recipes => ['app_james::default']

attribute 'app_james/db/db_user',
  :display_name => "Database Username",
  :description => "Username to connect to the database with",
  :required => "required",
  :recipes => ["app_james::setup_db_connection"]

attribute 'app_james/db/db_pwd',
  :display_name => "Database Password",
  :description => "Password to connect to the database with",
  :required => "required",
  :recipes => ["app_james::setup_db_connection"]

attribute 'app_james/db/db_name',
  :display_name => "Database name",
  :description => "Name of James database",
  :required => "required",
  :recipes => ["app_james::setup_db_connection"]

attribute 'app_james/db/db_host',
  :display_name => "Database FQDN",
  :description => "Fully qualified domain name for the database host",
  :required => "required",
  :recipes => ["app_james::setup_db_connection"]
