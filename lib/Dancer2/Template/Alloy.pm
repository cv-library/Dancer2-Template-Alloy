package Dancer2::Template::Alloy;

# ABSTRACT: Template Alloy engine for Dancer2

=head1 SYNOPSIS

To use this engine you may configure Dacner2 via "config.yml":

    template: "alloy"

Most configuration possible when creating a new instance of a
Template::Alloy object can be passed via the configuration.

    template: "alloy"
    engines:
      template:
        AUTO_FILTER: html

The following variables are defaulted, they can be overriden.

=over

=item * ABSOLUTE

Defaulted to 1.

=item * ENCODING

Pulled from Dancer2 C<charset>.

=item * INCLUDE_PATH

Pointed to the Dancer2 C<views>.

=back

=cut

use strict;
use warnings;

use Carp 'croak';
use Moo;
use Template::Alloy;

with 'Dancer2::Core::Role::Template';

our $VERSION = '0.001';

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
