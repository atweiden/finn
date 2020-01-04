use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(4);

subtest({
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1. One
    EOF
    my Str:D $rule = 'list-ordered-item';
    ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule),
        'Parses list-ordered-item'
    );
});

subtest({
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1: One
    EOF
    my Str:D $rule = 'list-ordered-item';
    ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule),
        'Parses list-ordered-item'
    );
});

subtest({
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1) One
    EOF
    my Str:D $rule = 'list-ordered-item';
    ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule),
        'Parses list-ordered-item'
    );
});

subtest({
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1) One one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
    EOF
    my Str:D $rule = 'list-ordered-item';
    ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule),
        'Parses list-ordered-item'
    );
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
