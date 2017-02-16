use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 2;

# sub cmp-ok-file {{{

multi sub cmp-ok-file(File['Absolute'] $a, File['Absolute'] $b) returns Bool:D
{
    my Bool:D $is-same = $a.path eqv $b.path;
}

multi sub cmp-ok-file(
    File['Absolute', 'Protocol'] $a,
    File['Absolute', 'Protocol'] $b
) returns Bool:D
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
    my Bool:D $is-same-protocol = $a.protocol eqv $b.protocol;
    my Bool:D $is-same = $is-same-path && $is-same-protocol;
}

multi sub cmp-ok-file(File['Relative'] $a, File['Relative'] $b) returns Bool:D
{
    my Bool:D $is-same = $a.path eqv $b.path;
}

multi sub cmp-ok-file(
    File['Relative', 'Protocol'] $a,
    File['Relative', 'Protocol'] $b
) returns Bool:D
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
    my Bool:D $is-same-protocol = $a.protocol eqv $b.protocol;
    my Bool:D $is-same = $is-same-path && $is-same-protocol;
}

multi sub cmp-ok-file(File $, File $) returns Bool:D
{
    False;
}

# end sub cmp-ok-file }}}

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
    my Str:D $rule = 'file';
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
        cmp-ok
            Finn::Parser::Grammar.parse(@file[$i], :$rule, :$actions).made,
            &cmp-ok-file,
            @file-made[$i],
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
    my Str:D $rule = 'file';
    my Str:D $protocol = 'file://';
    # leading C<./> necessary because Actions prepends C<$.file> to path
    my File:D @file-made =
        File['Relative'].new(:path(IO::Path.new('./a'))),
        File['Relative'].new(:path(IO::Path.new('./a/b/c/d/e/f'))),
        File['Relative', 'Protocol'].new(:path(IO::Path.new('./a')), :$protocol),
        File['Relative', 'Protocol'].new(:path(IO::Path.new('./a/b/c/d/e/f')), :$protocol);
    loop (my UInt:D $i = 0; $i < @file.elems; $i++)
    {
        cmp-ok
            Finn::Parser::Grammar.parse(@file[$i], :$rule, :$actions).made,
            &cmp-ok-file,
            @file-made[$i],
            'File OK';
    }
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
