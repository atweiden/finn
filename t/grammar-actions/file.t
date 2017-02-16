use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 2;

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

sub cmp-ok-file(File:D $a, File:D $b) returns Bool:D
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
