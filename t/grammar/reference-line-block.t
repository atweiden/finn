use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(5);

subtest('reference-line-block:top', {
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    [0]: 0
    EOF
    my Str:D $rule = 'reference-line-block';
    ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule),
        'Parses reference-line-block'
    );
});

subtest('reference-line-block:after-blank-lines', {
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;




    [11]: a.b.c
    [22]: d.e.f
    [33]: g.h.i
    EOF
    my Str:D $rule = 'reference-line-block';
    ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule),
        'Parses reference-line-block'
    );
});

subtest('reference-line-block:after-comment-block', {
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    /*
     * a comment block
     */
    [0]: 0
    EOF
    my Str:D $rule = 'reference-line-block';
    ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule),
        'Parses reference-line-block'
    );
});

subtest('reference-line-block:after-horizontal-rule', {
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    ******************************************************************************
    [0]: 0
    EOF
    my Str:D $rule = 'reference-line-block';
    ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule),
        'Parses reference-line-block'
    );
});

subtest('reference-line continuations', {
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    [0]: 0                     |||||||||||||||||||||||
      1                     |||||||||||||||||||||||
    2                     |||||||||||||||||||||||
      3                     |||||||||||||||||||||||
    4                     |||||||||||||||||||||||
      qwerty                     |||||||||||||||||||||||
        asdf                     |||||||||||||||||||||||
          zxcv                     |||||||||||||||||||||||
            [1]: poiu                     |||||||||||||||||||||||
                 curl                     |||||||||||||||||||||||
                 wget                     |||||||||||||||||||||||
          [2]: lkjh                     |||||||||||||||||||||||
        [3]: mnbv                     |||||||||||||||||||||||
      [4]: <SPACE>                     |||||||||||||||||||||||
    <CAPS>                     |||||||||||||||||||||||
    EOF
    my Str:D $rule = 'reference-line-block';
    ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule),
        'Parses reference-line-block'
    );
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
