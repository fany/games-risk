use 5.010;
use strict;
use warnings;

package Games::Risk::ExtraMaps;
# ABSTRACT: base class for exta maps

use File::ShareDir::PathClass;
use Moose;
use Path::Class;

extends 'Games::Risk::Map';

 
# -- public method

sub sharedir {
    my $self  = shift;
    my $extra   = $self->extra_category;
    my $distini = file("dist.ini");

    if ( -e $distini ) { 
        my ($line) = $distini->slurp;
        return dir( qw{ share maps }, $self->name )
            if $line =~ /$extra/;
    }

    return File::ShareDir::PathClass->dist_dir("Games-Risk-Maps-$extra");
}



1;
__END__

=head1 DESCRIPTION

Due to the weight of extra maps (with images), those are deported in
some other CPAN distributions. But this means that their shared data is
now located in a place which is not L<Games::Risk>'s one.

This class is therefore a base class for extra maps to allow smooth
finding of the share directory, with an overloading of C<sharedir>
method.