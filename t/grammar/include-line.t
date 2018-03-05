use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(35);

subtest({
    my Str:D $include-line = '§ "A"';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Abc"';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Abc Foo Bar"';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ /';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ ~';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ /finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ ~/finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ file:///';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ file://~';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ file:///finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ file://~/finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ [0]';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ [1]';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ [1010101010101]';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = "§ 'Name Of Section To Embed' /";
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = "§ 'Name Of Section To Embed' ~";
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = "§ 'Name Of Section To Embed' /a/b/c/d";
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = "§ 'Name Of Section To Embed' ~/a/b/c/d";
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = "§ 'Name Of Section To Embed' file:///";
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" file://~';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" file:///a/b/c/d';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" file://~/a/b/c/d';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" [0]';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" [1]';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" [1010101010101]';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" relative-path';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "Name Of Section To Embed" relative/path';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ relative-path';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ relative/path';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ a/b\/c\ d';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = Q{§ "z\\" a/b\/c\ d};
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ file://a';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ file://a/b\/c\ d';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '§ "a" file://a';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

subtest({
    my Str:D $include-line = '¶ "a" file://a';
    my Str:D $rule = 'include-line';
    ok(
        Finn::Parser::Grammar.parse($include-line, :$rule),
        'Parses include-line'
    );
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
