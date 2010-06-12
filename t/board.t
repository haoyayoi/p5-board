use strict;
use warnings;
use utf8;
use Test::More tests => 5;
use Board;

my $board = Board->new('test');
isa_ok ( $board , "Board" );
can_ok ( $board , qw/new handle controller error query dbi invalied_check/);
isa_ok ( $board->query , "CGI" );
isa_ok ( $board->dbi , "Board::Model" );
isa_ok ( $board->controller, "Board::Controller" );
