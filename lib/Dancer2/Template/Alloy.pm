package Dancer2::Template::Alloy;

use strict;
use warnings;

use Carp 'croak';
use Moo;
use Template::Alloy;

with 'Dancer2::Core::Role::Template';

sub _build_engine {
    my $self = shift;

    Template::Alloy->new(
        ABSOLUTE     => 1,
        ENCODING     => $self->charset,
        INCLUDE_PATH => $self->views,
        %{ $self->config },
    );
}

sub render {
    my ( $self, $tmpl, $vars ) = @_;

    $self->engine->process( $tmpl, $vars, \my $content )
        or croak $self->engine->error;

    $content;
}

1;
