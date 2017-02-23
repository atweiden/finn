use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 35;

subtest
{
    my Str:D $sectional-inline = '§ "A"';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Abc"';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Abc Foo Bar"';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ /';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ ~';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ /finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ ~/finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file:///';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file://~';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file:///finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline'; ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file://~/finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ [0]';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ [1]';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ [1010101010101]';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' /";
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' ~";
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' /a/b/c/d";
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' ~/a/b/c/d";
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' file:///";
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" file://~';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" file:///a/b/c/d';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" file://~/a/b/c/d';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" [0]';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" [1]';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" [1010101010101]';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" relative-path';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" relative/path';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ relative-path';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ relative/path';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ a/b\/c\ d';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = Q{§ "z\\" a/b\/c\ d};
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file://a';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ file://a/b\/c\ d';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '§ "a" file://a';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

subtest
{
    my Str:D $sectional-inline = '¶ "a" file://a';
    my Str:D $rule = 'sectional-inline';
    ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule),
        'Parses sectional-inline';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
