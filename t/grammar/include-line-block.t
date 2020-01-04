use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(4);

subtest({
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;

    § 'Name Of Section To Embed' [1]
    § /
    § 'Name Of Section To Embed' ~/a/b/c/d
    § "Name Of Section To Embed" /a/b/c/d
    § "Name Of Section To Embed" file:///
    EOF
    my Str:D $rule = 'include-line-block';
    ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule),
        'Parses include-line-block'
    );
});

subtest({
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;
    /*
     *
     * comment
     * comment
     * comment
     *
     */
    § "Name Of Section To Embed" file:///a/b/c/d
    EOF
    my Str:D $rule = 'include-line-block';
    ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule),
        'Parses include-line-block'
    );
});

subtest({
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;
    /* a comment block */
    § 'Name Of Section To Embed' file://~/a/b/c/d
    § "Name Of Section To Embed" [0]
    § 'Name Of Section To Embed' [1010101010101]
    EOF
    my Str:D $rule = 'include-line-block';
    ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule),
        'Parses include-line-block'
    );
});

subtest({
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    § ~/finn/share/vimfmt
    § 'Name Of Section To Embed' ~
    § "Name Of Section To Embed" /
    § [1010101010101]
    § file:///
    § file://~
    § file:///finn/share/vimfmt
    § file://~/finn/share/vimfmt
    § [0]
    § [1]
    ¶ [2]
    EOF
    my Str:D $rule = 'include-line-block';
    ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule),
        'Parses include-line-block'
    );
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
