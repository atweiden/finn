use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 2;

# sub infix:<cmp> {{{

=begin pod
=head C<sub infix:<cmp>>

The output of C<got> and C<expected> are I<identical> with
C<is-deeply>. Tests are failing for reasons I don't understand. That is
the reason for introducing custom C<sub infix:<cmp>>.
=end pod

multi sub infix:<cmp>(File['Absolute'] $a, File['Absolute'] $b) returns Order:D
{
    my Order:D $order-path = $a.path cmp $b.path;
}

multi sub infix:<cmp>(
    File['Absolute', 'Protocol'] $a,
    File['Absolute', 'Protocol'] $b
) returns Order:D
{
    my Order:D $order-path = $a.path cmp $b.path;
    my Order:D $order-protocol = $a.protocol cmp $b.protocol;
    my Order:D $sameness = $order-path eqv Same && $order-protocol eqv Same
        ?? Same
        !! Less;
}

multi sub infix:<cmp>(File['Relative'] $a, File['Relative'] $b) returns Order:D
{
    my Order:D $order-path = $a.path cmp $b.path;
}

multi sub infix:<cmp>(
    File['Relative', 'Protocol'] $a,
    File['Relative', 'Protocol'] $b
) returns Order:D
{
    my Order:D $order-path = $a.path cmp $b.path;
    my Order:D $order-protocol = $a.protocol cmp $b.protocol;
    my Order:D $sameness = $order-path eqv Same && $order-protocol eqv Same
        ?? Same
        !! Less;
}

multi sub infix:<cmp>(
    File $a,
    File $b
) returns Order:D
{
    Less;
}

# end sub infix:<cmp> }}}

subtest 'absolute',
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D @file = qw<
        /
        /a
        /a/b/c/d/e/f
        ~
        ~/a
        ~/a/b/c/d/e/f
        file:///
        file:///a
        file:///a/b/c/d/e/f
        file://~
        file://~/a
        file://~/a/b/c/d/e/f
    >;
    my Str:D $protocol = 'file://';
    my File:D @file-made =
        File['Absolute'].new(:path(IO::Path.new('/'))),
        File['Absolute'].new(:path(IO::Path.new('/a'))),
        File['Absolute'].new(:path(IO::Path.new('/a/b/c/d/e/f'))),
        File['Absolute'].new(:path(IO::Path.new('~'))),
        File['Absolute'].new(:path(IO::Path.new('~/a'))),
        File['Absolute'].new(:path(IO::Path.new('~/a/b/c/d/e/f'))),
        File['Absolute', 'Protocol'].new(:path(IO::Path.new('/')), :$protocol),
        File['Absolute', 'Protocol'].new(:path(IO::Path.new('/a')), :$protocol),
        File['Absolute', 'Protocol'].new(:path(IO::Path.new('/a/b/c/d/e/f')), :$protocol),
        File['Absolute', 'Protocol'].new(:path(IO::Path.new('~')), :$protocol),
        File['Absolute', 'Protocol'].new(:path(IO::Path.new('~/a')), :$protocol),
        File['Absolute', 'Protocol'].new(:path(IO::Path.new('~/a/b/c/d/e/f')), :$protocol);
    loop (my UInt:D $i = 0; $i < @file.elems; $i++)
    {
        is-deeply
            Finn::Parser::Grammar.parse(@file[$i], :rule<file>, :$actions).made cmp @file-made[$i],
            Same,
            'File OK';
    }
}

subtest 'relative',
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D @file = qw<
        a
        a/b/c/d/e/f
        file://a
        file://a/b/c/d/e/f
    >;
    my Str:D $protocol = 'file://';
    # leading C<./> necessary because Actions prepends C<$.file> to path
    my File:D @file-made =
        File['Relative'].new(:path(IO::Path.new('./a'))),
        File['Relative'].new(:path(IO::Path.new('./a/b/c/d/e/f'))),
        File['Relative', 'Protocol'].new(:path(IO::Path.new('./a')), :$protocol),
        File['Relative', 'Protocol'].new(:path(IO::Path.new('./a/b/c/d/e/f')), :$protocol);
    loop (my UInt:D $i = 0; $i < @file.elems; $i++)
    {
        is-deeply
            Finn::Parser::Grammar.parse(@file[$i], :rule<file>, :$actions).made cmp @file-made[$i],
            Same,
            'File OK';
    }
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
