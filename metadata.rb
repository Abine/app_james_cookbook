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
depends "python"

recipe "app_james::default", "Set up the James server"
recipe "app_james::setup_db_connection", "Provision a database snippet for James"
recipe "app_james::enable_spool_monitoring", "Enable spool size monitoring"
recipe "app_james::disable_spool_monitoring", "Disable spool size monitoring"
recipe "app_james::setup_redis_connection", "Provision a redis snippet for James"

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

attribute 'app_james/db/threads',
  :display_name => "Database Connection Pool Size",
  :description => "Number of database connections to keep in the pool. It is recommended that this number be at least as large as the number of spool threads",
  :required => "recommended",
  :default => "50",
  :recipes => ["app_james::setup_db_connection"]

attribute 'app_james/redis/host',
          :display_name => "Redis FQDN",
          :description => "Fully qualified domain name for the redis host",
          :required => "required",
          :recipes => ["app_james::setup_redis_connection"]

attribute 'app_james/redis/auth_key',
          :display_name => "Redis AUTH Key",
          :description => "Key required to AUTH with Redis server",
          :required => "required",
          :recipes => ["app_james::setup_redis_connection"]

attribute 'app_james/redis/expires_secs',
          :display_name => "Redis Mail Expiration",
          :description => "Seconds a mail lives on redis",
          :required => "required",
          :recipes => ["app_james::setup_redis_connection"]

attribute 'app_james/redis/expiration_buffer',
          :display_name => "Redis Expiration Buffer",
          :description => "Seconds email body lives after expiration",
          :required => "required",
          :recipes => ["app_james::setup_redis_connection"]

attribute 'app_james/redis/user_mails',
          :display_name => "Redis Mails Per User",
          :description => "Number of mails to store per target address",
          :required => "required",
          :recipes => ["app_james::setup_redis_connection"]

attribute 'app_james/spool/service_key',
  :display_name => "Spool monitoring service key",
  :description => "Pager Duty service key to use for triggering/resolving alerts about spool size reaching large levels",
  :required => "recommended",
  :recipes => ["app_james::enable_spool_monitoring"]

attribute 'app_james/spool/trigger',
  :display_name => "Spool monitoring trigger threshold",
  :description => "When the number of messages on the spool goes above this value, trigger a new incident",
  :required => "recommended",
  :recipes => ["app_james::enable_spool_monitoring"],
  :default => '100'

attribute 'app_james/spool/resolve',
  :display_name => "Spool monitoring resolution threshold",
  :description => "When the number of messages on the spool goes below this value, resolve any open incident. Be careful not to set this too close to trigger, otherwise you might thrash!",
  :required => "recommended",
  :recipes => ["app_james::enable_spool_monitoring"],
  :default => '50'
