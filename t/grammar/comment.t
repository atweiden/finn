use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(3);

subtest({
    my Str:D $comment = '/* this is a comment */';
    my Str:D $rule = 'comment';
    ok(Finn::Parser::Grammar.parse($comment, :$rule), 'Parses comment');
});

subtest({
    my Str:D $comment = q:to/EOF/.trim;
    /*
     *
     * this is a block comment - line 1
     * this is a block comment - line 2
     * this is a block comment - line 3
     *
     */
    EOF
    my Str:D $rule = 'comment';
    ok(Finn::Parser::Grammar.parse($comment, :$rule), 'Parses comment');
});

subtest({
    my Str:D $comment = q:to/EOF/.trim;
    /*
     <!--                             -->
       this is a block comment - line 1
       this is a block comment - line 2
       this is a block comment - line 3
     <!--                             --> */
    EOF
    my Str:D $rule = 'comment';
    ok(Finn::Parser::Grammar.parse($comment, :$rule), 'Parses comment');
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
