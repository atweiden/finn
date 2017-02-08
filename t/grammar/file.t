use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 2;

subtest 'absolute',
{
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

    @file.map({
        ok Finn::Parser::Grammar.parse($_, :rule<file>), 'Parses absolute file'
    });
}

subtest 'relative',
{
    my Str:D @file = qw<
        a
        a/b/c/d/e/f
        file://a
        file://a/b/c/d/e/f
    >;

    @file.map({
        ok Finn::Parser::Grammar.parse($_, :rule<file>), 'Parses relative file'
    });
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
