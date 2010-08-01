package Board::Config;
use strict;
use warnings;
use base qw(Board::Base Class::Accessor::Fast);

use Path::Class qw(file dir);

my @path = qw/Users haoyayoi Sites sakura_cw p5-board/;
my $file = "config.pl";

sub config {
    my $self = shift;
    my $conf = $self->config_file;
    if ( -f $conf ) {
        my $code = do $conf;
        return $code or die;
    } else {
        die;
    }
}

sub config_file {
    my $self = shift;
    $self->path . "config.pl";
}

sub path { "/" . dir(@path) }

1;
