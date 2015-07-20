#!/usr/bin/perl

use strict;
use warnings;

use utf8;
use Cyrus::IMAP::Admin;
use Cyrus::SIEVE::managesieve;
use Getopt::Std;
use Pod::Usage;

my %opt;
getopts('hm:', \%opt);

if($opt{h}){
  pod2usage(-verbose => 2, -output => '-');
  exit;
}

if(!$opt{m}){
  pod2usage(-verbose => 1, -output => '-');
  exit;
}

my $cyrus_srvr    = "localhost";
my $cyrus_pass    = "{{ pillar.cyruspass }}";
my $cyrus_mech    = "login";

my $quota_size    = 2048000;
my $spam_expire   = 30; 
my $sieve_script  = "phpscript";
my $sieve_file    = "/etc/cyrus/default-sieve.script";

# Vytvoreni schranky
my ($user,$domain) = split("@",$opt{m});
my $cyrus_user = "cyrus\@$domain";
my $imap = Cyrus::IMAP::Admin->new($cyrus_srvr);
$imap->authenticate($cyrus_mech,'imap','',$cyrus_user,'0','10000',$cyrus_pass);
die $imap->error if $imap->error;

$imap->createmailbox("user/$user") or die $imap->error;
$imap->createmailbox("user/$user/Spam") or die $imap->error;
$imap->createmailbox("user/$user/Trash") or die $imap->error;
$imap->createmailbox("user/$user/Sent") or die $imap->error;
$imap->createmailbox("user/$user/Drafts") or die $imap->error;
$imap->mboxconfig("user/$user/Spam","expire",$spam_expire) or die $imap->error;
$imap->setquota("user/$user","STORAGE",$quota_size) or die $imap->error;
$imap->setaclmailbox("user/$user",$cyrus_user,"all") or die $imap->error;

# Nastaveni filtru v sieve
my $sieve = sieve_get_handle($cyrus_srvr, "prompt", "prompt", "prompt","prompt");
sieve_put_file_withdest($sieve, $sieve_file, $sieve_script);
sieve_activate($sieve, $sieve_script);

# Vypis
my @lines;
our $vystup = "Creating mailbox $opt{m}:\n";
@lines   = $imap->listmailbox("user/$user") or die $imap->error;
my($ref) = @lines;
$vystup .= "\t".join(", ",@$ref)."\n";
$vystup .= "Quota:\n";
@lines   = $imap->listquota("user/$user") or die $imap->error;
(my $key,$ref) = @lines;
$vystup .= "\t$key: ".join(", ",@$ref)."\n";
$vystup .= "ACL:\n";
@lines = $imap->listaclmailbox("user/$user") or die $imap->error;
my %h = @lines;
foreach my $key (keys %h){
  $vystup .= "\t$key $h{$key}\n";
}

print $vystup;

sub filtr {
  my($name, $isactive) = @_ ;
  if ($isactive == 1) {
    $name .= " <- active script";
  }
  $vystup .= "\t$name\n";
}

sub prompt {
  my($type, $prompt) = @_ ;
  if ($type eq "username"){
    return $opt{m};
  } elsif ($type eq "authname"){
    return $cyrus_user;
  } elsif ($type eq "realm"){
    return $domain;
  } elsif ($type eq "password") {
    return $cyrus_pass;
  }
}
__END__
=encoding utf8

=head1 NAME

cb.pl - Založení mailové schránky.

=head1 SYNOPSIS

cb.pl -h | -m jmeno.prijmeni@{{ pillar.base_mail_domain }}

=head1 OPTIONS AND ARGUMENTS

   -h - Nápověda
   -m - Email uživatele

=head1 DESCRIPTION

Založení mailové schránky.

=cut
