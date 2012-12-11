maintainer       "Abine, Inc."
maintainer_email "cloud@abine.com"
license          "All rights reserved"
description      "Installs/Configures JAMES"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "rightscale"
depends "svn_ssh"
depends "app"


recipe "app_james::default", "Set up the JAMES server"

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
