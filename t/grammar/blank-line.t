use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

subtest
{
    my Str:D $blank-line = q:to/EOF/;
    EOF

    ok
        Finn::Parser::Grammar.parse($blank-line, :rule<blank-line>),
        'Blank line parses';
}

subtest
{
    my Str:D $blank-line = q:to/EOF/.trim-trailing;

    EOF

    ok
        Finn::Parser::Grammar.parse($blank-line, :rule<blank-line>),
        'Blank line parses';
}

subtest
{
    my Str:D $blank-line = q:to/EOF/.trim-trailing;
            
    EOF

    ok
        Finn::Parser::Grammar.parse($blank-line, :rule<blank-line>),
        'Blank line parses';
}

subtest
{
    my Str:D $blank-line = q:to/EOF/.trim-trailing;
    	       
    EOF

    ok
        Finn::Parser::Grammar.parse($blank-line, :rule<blank-line>),
        'Blank line parses';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
