#!/usr/bin/env perl
# HTTP::Tiny tests

use strict;
use warnings;
use 5.010;

use HTTP::Tiny;

sub get_url {
  my ($url) = @_;
  my $results;

  my ($worker, $request, $response);

  $worker = HTTP::Tiny->new;
  $response = $worker->get($url);

  unless ($response->{success}) {
    print "ERROR: ", $response->{status}, "\n";
    exit 1;
  }

  return $response;
}

my $meta_url = 'http://localhost:4567/meta';
my $meta = get_url($meta_url);

my @urls = split(',', $meta->{content});

for my $url (@urls) {
  # ugh this sucks
  $url =~ s/\[//g;
  $url =~ s/\]//g;
  $url =~ s/"//g;
  print "-> $url\n";
  my $response = get_url($url);
}

# made it to here, all tests passed
exit 0;
