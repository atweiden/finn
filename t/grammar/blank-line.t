use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(4);

subtest({
    my Str:D $blank-line = q:to/EOF/;
    EOF
    my Str:D $rule = 'blank-line';
    ok(Finn::Parser::Grammar.parse($blank-line, :$rule), 'Blank line parses');
});

subtest({
    my Str:D $blank-line = q:to/EOF/.trim-trailing;

    EOF
    my Str:D $rule = 'blank-line';
    ok(Finn::Parser::Grammar.parse($blank-line, :$rule), 'Blank line parses');
});

subtest({
    my Str:D $blank-line = q:to/EOF/.trim-trailing;
            
    EOF
    my Str:D $rule = 'blank-line';
    ok(Finn::Parser::Grammar.parse($blank-line, :$rule), 'Blank line parses');
});

subtest({
    my Str:D $blank-line = q:to/EOF/.trim-trailing;
    	       
    EOF
    my Str:D $rule = 'blank-line';
    ok(Finn::Parser::Grammar.parse($blank-line, :$rule), 'Blank line parses');
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
