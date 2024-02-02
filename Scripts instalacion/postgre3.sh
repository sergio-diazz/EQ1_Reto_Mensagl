#!/bin/bash
sudo useradd -G sudo -m synapse -p 1234 -s /usr/bin/bash
cd /etc/postgresql/16/main
echo "local   all             postgres                                peer

local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            scram-sha-256
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
host    synapsedb       synapse         0.0.0.0/0               scram-sha-256" > pg_hba.conf
echo "data_directory = '/var/lib/postgresql/16/main'          # use data in another directory
                                        # (change requires restart)
hba_file = '/etc/postgresql/16/main/pg_hba.conf'        # host-based authentication file
                                        # (change requires restart)
ident_file = '/etc/postgresql/16/main/pg_ident.conf'    # ident configuration file
                                        # (change requires restart)
external_pid_file = '/var/run/postgresql/16-main.pid'                   # write an extra PID file
                                        # (change requires restart)
listen_addresses = '*'          # what IP address(es) to listen on;
                                        # comma-separated list of addresses;
port = 5432                             # (change requires restart)
max_connections = 100                   # (change requires restart)
unix_socket_directories = '/var/run/postgresql' # comma-separated list of directories
                                        # (change requires restart)
ssl = on
ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'

shared_buffers = 128MB                  # min 128kB
dynamic_shared_memory_type = posix      # the default is usually the first option

max_wal_size = 1GB
min_wal_size = 80MB

log_line_prefix = '%m [%p] %q%u@%d '            # special values:
log_timezone = 'Etc/UTC'

cluster_name = '16/main'                        # added to process titles if nonempty

datestyle = 'iso, mdy'
timezone = 'Etc/UTC'

lc_messages = 'C.UTF-8'                 # locale for system error message
lc_monetary = 'C.UTF-8'                 # locale for monetary formatting
lc_numeric = 'C.UTF-8'                  # locale for number formatting
lc_time = 'C.UTF-8'                     # locale for time formatting

default_text_search_config = 'pg_catalog.english'

include_dir = 'conf.d'                  # include files ending in '.conf' from" > postgresql.conf