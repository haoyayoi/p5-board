#!/usr/local/bin/perl
use strict;
use warnings;
use utf8;
use Config;
BEGIN {
    unshift @INC, '/Users/haoyayoi/Sites/sakura_cw/p5-board/lib',
    '/Users/haoyayoi/Sites/sakura_cw/p5-board/cgi-extlib-perl/extlib',
    "/Users/haoyayoi/perl5/lib/perl5/$Config{archname}";
}
use lib qw(./lib ./cgi-extlib-perl);
use Board;
use Path::Class qw(dir);

Board->new->handle;

