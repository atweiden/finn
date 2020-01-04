use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan(1);

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D @reference-inline = qw<
        [0]
        [1]
        [10]
        [99]
        [10990]
    >;
    my Str:D $rule = 'reference-inline';
    my ReferenceInline:D @reference-inline-made =
        ReferenceInline.new(:number(0)),
        ReferenceInline.new(:number(1)),
        ReferenceInline.new(:number(10)),
        ReferenceInline.new(:number(99)),
        ReferenceInline.new(:number(10990));
    loop (my UInt:D $i = 0; $i < @reference-inline.elems; $i++)
    {
        is-deeply(
            Finn::Parser::Grammar.parse(@reference-inline[$i], :$rule, :$actions).made,
            @reference-inline-made[$i],
            'ReferenceInline OK'
        );
    }
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
