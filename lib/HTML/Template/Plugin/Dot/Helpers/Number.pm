package HTML::Template::Plugin::Dot::Helpers::Number;

use strict;
use warnings;
use base qw/Number::Format/;

sub equals
{
    return $_[1] == $_[2];
}

sub le
{
    return $_[1] <= $_[2];
}

sub lt
{
    return $_[1] < $_[2];
}

sub ge
{
    return $_[1] >= $_[2];
}

sub gt
{
    return $_[1] > $_[2];
}

1;

__END__

=head1 NAME

HTML::Template::Plugin::Dot::Helpers::Number - Number formatting and comparison functions

=head1 METHODS

See L<Number::Format> for formatting functions

=over 4

=item equals

=item le, lt, ge, gt

=back

=head1 SEE ALSO

L<HTML::Template::Plugin::Dot::Helpers> for detailed help, license, and contact information.

=cut

