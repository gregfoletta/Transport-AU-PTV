package Transport::AU::PTV;

use strict;
use warnings;
use 5.010;


use Transport::AU::PTV::APIRequest;
use Transport::AU::PTV::Error;
use Transport::AU::PTV::Routes;

use Carp;
use LWP::UserAgent;
use URI;
use JSON;
use Digest::SHA qw(hmac_sha1_hex);

=head2 new

    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        aaa_aaa => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });


=cut

sub new {
    my $class = shift;
    my ($credential_r) = @_;
    my %ret;

    $ret{api} = Transport::AU::PTV::APIRequest->new($credential_r);

    return bless \%ret, $class;
}


=head2 routes

=cut

sub routes {
    my $self = shift;
    return Transport::AU::PTV::Routes->new( $self->{api} );
}

1;
