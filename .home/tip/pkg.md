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


