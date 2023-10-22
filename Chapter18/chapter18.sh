ping pg2

ping pg1

# Add settings for extensions here
listen_addresses = '*'
wal_level = logical
max_replication_slots = 10
max_wal_senders = 10

netstat -an | grep 5432

# Add settings for extensions here
listen_addresses = '*'
wal_level = logical
max_logical_replication_workers = 4
max_worker_processes = 10

netstat -an | grep 5432

# IPv4 local connections:
host all all 127.0.0.1/32 md5
host all replicarole 192.168.122.36/32 md5

systemctl reload postgresql
