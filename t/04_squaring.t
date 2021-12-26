# Copyright (c) 2013 Martin Becker.  All rights reserved.
# This package is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
# $Id$

# Check whether multiplication can handle identical operands

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl t/04_squaring.t'

use strict;
use warnings;
use Test::More tests => 1;
use Math::Polynomial::Multivariate;

my $one = Math::Polynomial::Multivariate->const(1);
my $p   = $one + $one->var('x');

my $ok = eval {
    local $SIG{'ALRM'} = sub { die "timeout" };
    alarm(2);
    my $q = $p * $p;
    alarm(0);
    1
};

ok($ok, 'computing p*p terminated');

__END__
