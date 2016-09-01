#!/usr/bin/env perl
# LWP::UserAgent tests

use strict;
use warnings;
use 5.010;

use LWP::UserAgent;

sub get_url {
  my ($url) = @_;
  my $results;

  my ($worker, $request, $response);

  $worker = LWP::UserAgent->new;
  $request = HTTP::Request->new(GET => $url);

  $response = $worker->request($request);

  unless ($response->is_success) {
    print "ERROR: ", $response->status_line, "\n";
    exit 1;
  }

  return $response;
}

my $meta_url = 'http://1863BFAF.pwnz.org:4567/meta';
my $meta = get_url($meta_url);

my @urls = split(',', $meta->content);

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
