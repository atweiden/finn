use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 25;

subtest
{
    my Str:D $sectional-inline = '§ A';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Abc';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Abc Foo Bar';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ /';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ ~';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ /finn/share/vimfmt';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ ~/finn/share/vimfmt';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file:///';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file://~';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file:///finn/share/vimfmt';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file://~/finn/share/vimfmt';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ [0]';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ [1]';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ [1010101010101]';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed /';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed ~';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed /a/b/c/d';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed ~/a/b/c/d';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed file:///';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed file://~';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed file:///a/b/c/d';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed file://~/a/b/c/d';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed [0]';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed [1]';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ Name Of Section To Embed [1010101010101]';

    ok
        Finn::Parser::Grammar.parse($sectional-inline, :rule<sectional-inline>),
        'Parses sectional-inline';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
