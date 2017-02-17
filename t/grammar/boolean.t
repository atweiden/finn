use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 2;

subtest
{
    my Str:D $boolean = 'true';
    my Str:D $rule = 'boolean';
    ok Finn::Parser::Grammar.parse($boolean, :$rule), 'Boolean parses';
}

subtest
{
    my Str:D $boolean = 'false';
    my Str:D $rule = 'boolean';
    ok Finn::Parser::Grammar.parse($boolean, :$rule), 'Boolean parses';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
