#!/usr/local/bin/perl
package Board;
use strict;
use warnings;
use utf8;
use Config;
use base qw( Board::Base Class::Accessor::Fast );
use FindBin::libs;
use CGI;
use Text::MicroTemplate::File;
use Board::Model;
use Board::Config;
use Carp qw/croak/;
use HTTP::Message;
use HTTP::Headers;

our $VERSION = '0.01';

__PACKAGE__->mk_accessors(qw/path query tmt error/);

sub new {
    my $class = shift;
    my $path = Board::Config->new->path;
    my $self = bless {
        path  => $path || '',
        query => CGI->new,
        tmt   => Text::MicroTemplate::File->new(
            include_path => $path . "/html",
        ),
    }, $class;
    $self->tmt->{tag_start} = '<?tmt';
    return $self;
}

sub db { shift->dbi }

sub handle {
    my $self    = $_[0];
    my $command = $self->query->param('command') || 'index';
    
    my $path = $self->path;
    my $app = "${path}/html/${command}.pl";
    my $app_html = "${command}.html";
    my $content;

    if (-f $app ) {
        my $pkg = do $app;
        if ( my $e = $@ ) {
            ref $e ? warn $e && return : die;
        }
        if ( my $code = $pkg->run() ) {
            $content = $code->();
        } else {
            die "runメソッドが定義されていません";
        }
    } else {
        $content = $self->tmt->render_file($app_html, $self)->as_string;
    }

    my $h = HTTP::Headers->new( Content_Type => 'text/html');
    my $r = HTTP::Message->new( $h, $content );
    print $r->as_string;
}

sub invalied_check {
    my $self = $_[0];
    
    my $boardid = $self->query->param('boardid');
    my $parent  = $self->query->param('parent');
    
    return $Board::Base::NOTHING_BOARD_ID
        unless $boardid;
    return $Board::Base::INVALIED_BOARD_ID
        unless $self->dbi->is_exsit_table( $boardid );
    return $Board::Base::INVALIED_PARENT
        unless $self->dbi->can_reply_to( $parent );
}

1;
