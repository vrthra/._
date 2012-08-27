### Solaris pkg depot

see http://www.oracle.com/technetwork/articles/servers-storage-admin/o11-097-create-pkg-ips-524496.html

#### Start depotd

     /usr/lib/pkg.depotd -d /export/pkg -p 80 --set-property publisher.prefix=puppet


#### Pkg send

    - install pkg at /var/pkg/fakeroot

    - Use a new shell where the PKG_TRANS_ID is stored
    | sh
    | . <(pkgsend -s http://localhost open puppet@3.0.0)
    | pkgsend -s http://localhost import /var/pkg/fakeroot
    - pkgsend add set name={pkg.summary, pkg.description, description, packager} value="..."
    | pkgsend close

#### Install it

    # set-publisher -g http://localhost puppet
    # pkg publisher
    # pkg install puppet

#### Using svcs

    | svcs -l svc:/application/pkg/server
    | svccfg -v -s application/pkg/server listprop | grep inst_root
      /var/pkgrepo
    | mkdir -p /var/pkgrepo
    | pkgrepo create --version=3 /var/pkgrepo
    | edit /var/pkgrepo/cfg_cache set prefix=Puppet
    | svccfg -v -s application/pkg/server setprop pkg/inst_root=/var/pkgrepo
    | svccfg -s application/pkg/server setprop pkg/readonly=true
    | svccfg -s application/pkg/server setprop pkg/port=80
    | svccfg -s pkg/server editprop
    | svcadm enable /application/pkg/server
    | svcs /application/pkg/server 
    - should be online (see cat /var/svc/log/application-pkg-server:default.log )

#### Regenerate indexes (get the search box)

    | pkgrepo refresh -s /var/pkgrepo

