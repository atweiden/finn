use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 1;

subtest
{
    my Str:D @string =
        Q{"a"},
        Q{"\\"},
        Q{"		tabs come before and after this		"},
        Q{"/path/to/document"},
        Q{'a'},
        Q{'\\'},
        Q{'		tabs come before and after this		'},
        Q{'/path/to/document'};
    my Str:D $rule = 'string';
    @string.map({
        ok Finn::Parser::Grammar.parse($_, :$rule), 'Parses string'
    });
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
