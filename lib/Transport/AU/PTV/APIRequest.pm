package Transport::AU::PTV::APIRequest;

use strict;
use warnings;
use 5.010;

use Transport::AU::PTV::Error;

use LWP::UserAgent;
use Carp;
use URI;
use JSON;
use Digest::SHA qw(hmac_sha1_hex);

=head2 new

=cut

sub new {
    my $class = shift;
    my ($credential_r) = @_;
    my %attributes;

    %attributes = %{$credential_r};
    $attributes{user_agent} = LWP::UserAgent->new;

    return bless \%attributes, $class;
}

=head2 api_request

=cut

sub api_request {
    my $self = shift;
    my ($path) = @_;

    my $ret = $self->_send_request($path)->_check_response()->result();

}


=head2 _send_request

=cut
 
sub _send_request {
    my $self = shift;
    my ($path) = @_;

    $self->{api_response} = $self->{user_agent}->get(
            $self->_generate_signed_uri($path)
    );

    return $self;
}

sub _check_response {
    my $self = shift;

    return Transport::AU::PTV::Error->msg("HTTP Error") if $self->{api_response}->is_error;
    $self->{result} = decode_json($self->{api_response}->decoded_content());

    return $self;
}


sub result {
    my $self = shift;
    my $res = $self->{result};

    # Clean up
    delete $self->{result};
    delete $self->{api_response};

    return $res;
}

sub _generate_signed_uri {
    my $self = shift;
    my ($path) = @_;

    my $uri = URI->new('http://timetableapi.ptv.vic.gov.au');
    $uri->path($path);
    $uri->query_form(devid => $self->{dev_id});
    
    my $signature = hmac_sha1_hex($uri->path_query, $self->{api_key});

    $uri->query_form(devid => $self->{dev_id}, signature => $signature);

    return $uri;
} 

1;
