use strict;
use warnings;
use utf8;
use Test::Base tests => 2;
use Board::Controller;

my $c = Board::Controller->new;
isa_ok( $c, "Board::Controller" );
my @method = qw/index error/;
@method = map { "dispatch_$_"; } @method;
can_ok( $c, @method );
