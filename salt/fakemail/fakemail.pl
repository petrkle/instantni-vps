#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp;
use Email::MIME;
use File::Glob ':glob';

my $message = read_file(\*STDIN) ;

my $email = Email::MIME->new($message);

my @pairs = $email->header_str_pairs;

my $path = '/home/fakemail';

if( ! -d $path ){
	mkdir($path);
}

my $recipient = {@pairs}->{'To'};

my @files = glob("$path/$recipient.*.eml");

my $num = @files;

$num++;

write_file("$path/$recipient.$num.eml", $message);
