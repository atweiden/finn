use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(4);

subtest({
    my Str:D $sectional-link = '|Cities in Washington|';
    my Str:D $rule = 'sectional-link';
    ok(
        Finn::Parser::Grammar.parse($sectional-link, :$rule),
        'Parses sectional-link'
    );
});

subtest({
    my Str:D $sectional-link = '|a|';
    my Str:D $rule = 'sectional-link';
    ok(
        Finn::Parser::Grammar.parse($sectional-link, :$rule),
        'Parses sectional-link'
    );
});

subtest({
    my Str:D $sectional-link = '|\ \ \ a|';
    my Str:D $rule = 'sectional-link';
    ok(
        Finn::Parser::Grammar.parse($sectional-link, :$rule),
        'Parses sectional-link'
    );
});

subtest({
    my Str:D $sectional-link = '|Chinese /finn/hello|';
    my Str:D $rule = 'sectional-link';
    ok(
        Finn::Parser::Grammar.parse($sectional-link, :$rule),
        'Parses sectional-link'
    );
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
