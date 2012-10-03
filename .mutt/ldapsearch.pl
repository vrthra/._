#!/usr/bin/perl
use Net::LDAP;

$ldap = Net::LDAP->new("directory.oregonstate.edu") or die "$@";

sub LDAPsearch {
  my ($ldap,$searchString,$attrs,$base) = @_;
  # if they don't pass a base... set it for them
  if (!$base ) { $base = "o=orst.edu"; }
  # if they don't pass an array of attributes...
  # set up something for them
  if (!$attrs ) {$attrs = [ 'cn','mail' ]; }
  my $msg = $ldap->search ( base    => "$base",
#     scope   => "sub",
     filter  => $searchString,
     attrs   =>  $attrs
     );
     $msg->code && die $msg->error;
     return $msg;
}

my @Attrs = ();
print $ARGV[1];
#my $result= LDAPsearch($ldap, "uid=gopinatr", \@Attrs);
#my $result= LDAPsearch($ldap, "cn=*Gopinat*", \@Attrs);
my $result= LDAPsearch($ldap, "cn=".$ARGV[0]."*");#, \@Attrs);

#foreach my $k (keys %$result) {
#  print $k." = ".$result->{$k}."\n";
#}

my @entries = $result->{'entries'};
foreach $entry ($result->entries) {
 #$entry->dump;
 my $mail = $entry->get('mail');
 my $cn = $entry->get('cn');
 if ($mail and $cn) {
 print "\n";
 print $mail->[0]."\t".$cn->[0]."\t";
 }
}
$ldap->unbind;
