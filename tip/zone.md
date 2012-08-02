## zone

### list

    | zoneadm list -vi
    ID NAME             STATUS         PATH                          
    0 global           running        /
    1 jumpstart        running        /u01/zones/jumpstart

    | zonecfg -z zone1
    zonecfg:zone1> create
    zonecfg:zone1> set zonepath=/u01/zones/zone1
    zonecfg:zone1> set autoboot=true
    zonecfg:zone1> add fs
    zonecfg:zone1:fs> set dir=/opt
    zonecfg:zone1:fs> set special=/opt
    zonecfg:zone1:fs> set type=lofs
    zonecfg:zone1:fs> add options [ro,nodevices]
    zonecfg:zone1:fs> end
    zonecfg:zone1> verify
    zonecfg:zone1> add net
    zonecfg:zone1:net> set address=10.67.1.151/24
    zonecfg:zone1:net> set physical=eri0
    zonecfg:zone1:net> end
    zonecfg:zone1> verify
    zonecfg:zone1> commit
    zonecfg:zone1> exit

    | zoneadm -z zone1 install
    | zoneadm -z myzone boot

### to connect

    | zlogin -C -e @ testzone
    
### to exit from console

    On a newline do
    `@.` or `~~.`
