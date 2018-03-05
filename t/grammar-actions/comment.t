use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan(3);

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $comment = '/* this is a comment */';
    my Str:D $rule = 'comment';
    my Str:D $text = ' this is a comment ';
    is-deeply(
        Finn::Parser::Grammar.parse($comment, :$rule, :$actions).made,
        Comment.new(:$text),
        'Comment OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
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
    my Str:D $text = q:to/EOF/;

     *
     * this is a block comment - line 1
     * this is a block comment - line 2
     * this is a block comment - line 3
     *
    EOF
    $text ~= ' ';
    is-deeply(
        Finn::Parser::Grammar.parse($comment, :$rule, :$actions).made,
        Comment.new(:$text),
        'Comment OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $comment = q:to/EOF/.trim;
    /*
     <!--                             -->
       this is a block comment - line 1
       this is a block comment - line 2
       this is a block comment - line 3
     <!--                             --> */
    EOF
    my Str:D $rule = 'comment';
    my Str:D $text = q:to/EOF/.trim-trailing;

     <!--                             -->
       this is a block comment - line 1
       this is a block comment - line 2
       this is a block comment - line 3
     <!--                             -->
    EOF
    $text ~= ' ';
    is-deeply(
        Finn::Parser::Grammar.parse($comment, :$rule, :$actions).made,
        Comment.new(:$text),
        'Comment OK'
    );
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
