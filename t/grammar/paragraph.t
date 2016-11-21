use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 2;

subtest
{
    my Str:D $paragraph = q:to/EOF/.trim;
    Lorem ipsizzle dolor sit pot, fo shizzle mah nizzle fo rizzle, mah
    home g-dizzle adipiscing elizzle. Rizzle shizznit velizzle, owned
    volutpizzle, shit quizzle, pimpin' uhuh ... yih!, fizzle. Pellentesque
    eget tortizzle.
    EOF

    ok
        Finn::Parser::Grammar.parse($paragraph, :rule<paragraph>),
        'Parses paragraph';
}

subtest
{
    my Str:D $paragraph = q:to/EOF/.trim;
    --- -·· ·-·-·- --··-- - ··· -· ··-· ···- ····-
    ··- - --·- ···- ····· --··· ----· -·- ·· ·-- --
    --·- -·-- --·· --··· - ·-- - ·-- ··-· ···- -·-- ·-
    ···- ·-·-·- ··--·· --- -·-· ··-· -··- ·- --- --
    ··· --·- -·-- ··--- ···· ·-·· ···-- ·-· ·· -·
    --- ···-- ····-
    EOF

    ok
        Finn::Parser::Grammar.parse($paragraph, :rule<paragraph>),
        'Parses paragraph';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
