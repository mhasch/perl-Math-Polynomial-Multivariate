# Copyright (c) 2013 Martin Becker.  All rights reserved.
# This package is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
# $Id: 10_synopsis.t 4 2013-06-01 20:56:56Z demetri $

# Checking synopsis examples

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl t/10_synopsis.t'

#########################

use strict;
use warnings;
use Test::More;
use lib 't/lib';
use Test::MyUtils;
BEGIN {
    use_or_bail('Math::BigRat');
    plan tests => 11;
}
use Math::Polynomial::Multivariate;

#########################

my $two = Math::Polynomial::Multivariate->const(2);
my $x   = Math::Polynomial::Multivariate->var('x');
my $xy  = Math::Polynomial::Multivariate->
                monomial(1, {'x' => 1, 'y' => 1});
my $pol = $x**2 + $xy - $two;
is("$pol", '-2 + x^2 + x*y');           # 1

my $rat = Math::BigRat->new('-1/3');
my $c   = Math::Polynomial::Multivariate->const($rat);
my $y   = $c->var('y');
my $lin = $y - $c;
is("$lin" , '1/3 + y');                 # 2

my $zero = $c - $c;           # zero polynomial on rationals
my $null = $c->null;          # dito

my $p = $c->monomial($rat, { 'a' => 2, 'b' => 1 });
is("$p", '-1/3*a^2*b');                 # 3
my $f = $p->coefficient({'a' => 2, 'b' => 1});
is("$f", '-1/3');                       # 4
my $q = $p->subst('a', $c);
is("$q", '-1/27*b');                    # 5
my $v = $p->evaluate({'a' => 6, 'b' => -1});
is("$v", '12');                         # 6

my @vars = $pol->variables;
is("@vars", 'x y');                     # 7
my @exp = $pol->exponents_of('x');
is("@exp", '0 1 2');                    # 8
my $r   = $pol->factor_of('x', 1);
is("$r", 'y');                          # 9
my $d = $pol->degree;
my $z = $zero->degree;
is("$d $z", '2 -inf');                  # 10

my $dx = $pol->partial_derivative('x');
is("$dx", '2*x + y');                   # 11

__END__
