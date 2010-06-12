package Board::Base;
use strict;
use warnings;
use utf8;
use Config;
# 必要なパスをここで通す
BEGIN {
    unshift @INC, '/Users/haoyayoi/Sites/Prototype/p5-board/extlib';
    unshift @INC, '/Users/haoyayoi/Sites/Prototype/p5-board/app/cgi';
    unshift @INC, "/Users/haoyayoi/perl5/lib/perl5/$Config{archname}";
    unshift @INC, '/Users/haoyayoi/perl5/lib/perl5';
}

our $INVALIED_BOARD_ID = 1;
our $INVALIED_PARENT   = 2;
our $NOTHING_BOARD_ID  = 3;


1;

__END__

=head1 NAME

  Board::Base - Board's base class

=head1 SYNOPSIS

  use base qw(Board::Base);

=cut
