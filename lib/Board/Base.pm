package Board::Base;
use strict;
use warnings;
use utf8;
use Config;
# 必要なパスをここで通す
BEGIN {
    unshift @INC, '/Users/haoyayoi/Sites/sakura_cw/p5-board/cgi-extlib-perl';
    unshift @INC, '/Users/haoyayoi/Sites/Prototype/p5-board/html';
    unshift @INC, "/Users/haoyayoi/perl5/lib/perl5/$Config{archname}";
    unshift @INC, '/Users/haoyayoi/perl5/lib/perl5';
}

use Board::Config;

sub config { Board::Config->new->config }

sub dbi {
    my $self = shift;
    my $conf = $self->config;
    DBI->connect(@{$conf->{Board}->{datasource}}, { AutoCommit => 1 });
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
