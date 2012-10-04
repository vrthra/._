#!/usr/bin/ruby

require 'net/ldap'

def search(name)
    ldap = Net::LDAP.new :host => 'directory.oregonstate.edu'
    # base = o=orst.edu
    # port 389
    # bind-dn = <none>
    # nick = OSU Online Directory
    # sur-or-given-or-name-or-email
    # begins with
    # sizelimit 200
    # timelimit 30
    # email->mail
    # name->cn
    # surname->sn
    # givenname->givenname
    cn = Net::LDAP::Filter.begins("cn", name)
    sur = Net::LDAP::Filter.begins("sn", name)
    email = Net::LDAP::Filter.begins("mail", name)
    gn = Net::LDAP::Filter.begins("givenname", name)
    search = {
        :base => "o=orst.edu",
        :filter => cn | sur | email | gn
    }
    ldap.search( search ) {|res|
        if res.respond_to? :mail
          puts "#{res.mail[0]} <#{res.cn[0]}>"
        else
          puts res.cn
        end
    }
end

search ARGV[0]

