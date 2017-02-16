use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 4;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $blank-line = q:to/EOF/;
    EOF
    my Str:D $rule = 'blank-line';
    my Str:D $text = '';
    is-deeply
        Finn::Parser::Grammar.parse($blank-line, :$rule, :$actions).made,
        BlankLine.new(:$text),
        'BlankLine OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $blank-line = q:to/EOF/.trim-trailing;

    EOF
    my Str:D $rule = 'blank-line';
    my Str:D $text = '';
    is-deeply
        Finn::Parser::Grammar.parse($blank-line, :$rule, :$actions).made,
        BlankLine.new(:$text),
        'BlankLine OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $blank-line = '        ';
    my Str:D $rule = 'blank-line';
    my Str:D $text = '        ';
    is-deeply
        Finn::Parser::Grammar.parse($blank-line, :$rule, :$actions).made,
        BlankLine.new(:$text),
        'BlankLine OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $blank-line = '	       ';
    my Str:D $rule = 'blank-line';
    my Str:D $text = '	       ';
    is-deeply
        Finn::Parser::Grammar.parse($blank-line, :$rule, :$actions).made,
        BlankLine.new(:$text),
        'BlankLine OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
