# create a simple hostname and ip host entry
host { 'vagrant.bigtop1':
    ip => $::ipaddress_eth1,
}
