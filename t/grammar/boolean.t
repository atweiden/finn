use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 2;

subtest
{
    my Str:D $boolean = 'true';

    ok
        Finn::Parser::Grammar.parse($boolean, :rule<boolean>),
        'Boolean parses';
}

subtest
{
    my Str:D $boolean = 'false';

    ok
        Finn::Parser::Grammar.parse($boolean, :rule<boolean>),
        'Boolean parses';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
