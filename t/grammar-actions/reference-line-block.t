use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan(5);

subtest('reference-line-block:top', {
    my Finn::Parser::Actions $actions .= new;
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    [0]: 0
    EOF
    my Str:D $rule = 'reference-line-block';

    my UInt:D $number-a = 0;
    my ReferenceInline $reference-inline-a .= new(:number($number-a));
    my Str:D $reference-text-a = '0';
    my ReferenceLine:D $reference-line-a .= new(
        :reference-inline($reference-inline-a),
        :reference-text($reference-text-a)
    );

    my ReferenceLine:D @reference-line = $reference-line-a;

    cmp-ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule, :$actions).made,
        &cmp-ok-reference-line-block,
        ReferenceLineBlock['Top'].new(:@reference-line),
        'ReferenceLineBlock OK'
    );
});

subtest('reference-line-block:after-blank-lines', {
    my Finn::Parser::Actions $actions .= new;
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;




    [11]: a.b.c
    [22]: d.e.f
    [33]: g.h.i
    EOF
    my Str:D $rule = 'reference-line-block';

    my Str:D $blank-line-text-a = '';
    my BlankLine $blank-line-a .= new(:text($blank-line-text-a));
    my Str:D $blank-line-text-b = '';
    my BlankLine $blank-line-b .= new(:text($blank-line-text-b));
    my Str:D $blank-line-text-c = '';
    my BlankLine $blank-line-c .= new(:text($blank-line-text-c));
    my Str:D $blank-line-text-d = '';
    my BlankLine $blank-line-d .= new(:text($blank-line-text-d));

    my BlankLine:D @blank-line =
        $blank-line-a,
        $blank-line-b,
        $blank-line-c,
        $blank-line-d;

    my UInt:D $number-e = 11;
    my ReferenceInline $reference-inline-e .= new(:number($number-e));
    my Str:D $reference-text-e = 'a.b.c';
    my ReferenceLine:D $reference-line-e .= new(
        :reference-inline($reference-inline-e),
        :reference-text($reference-text-e)
    );

    my UInt:D $number-f = 22;
    my ReferenceInline $reference-inline-f .= new(:number($number-f));
    my Str:D $reference-text-f = 'd.e.f';
    my ReferenceLine:D $reference-line-f .= new(
        :reference-inline($reference-inline-f),
        :reference-text($reference-text-f)
    );

    my UInt:D $number-g = 33;
    my ReferenceInline $reference-inline-g .= new(:number($number-g));
    my Str:D $reference-text-g = 'g.h.i';
    my ReferenceLine:D $reference-line-g .= new(
        :reference-inline($reference-inline-g),
        :reference-text($reference-text-g)
    );

    my ReferenceLine:D @reference-line =
        $reference-line-e,
        $reference-line-f,
        $reference-line-g;

    cmp-ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule, :$actions).made,
        &cmp-ok-reference-line-block,
        ReferenceLineBlock['BlankLine'].new(:@blank-line, :@reference-line),
        'ReferenceLineBlock OK'
    );
});

subtest('reference-line-block:after-comment-block', {
    my Finn::Parser::Actions $actions .= new;
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    /*
     * a comment block
     */
    [0]: 0
    EOF
    my Str:D $rule = 'reference-line-block';

    my Str:D $comment-text-a = q:to/EOF/.trim-trailing;
    
     * a comment block
    EOF
    $comment-text-a ~= "\n ";
    my Comment:D $comment-a .= new(:text($comment-text-a));
    my CommentBlock:D $comment-block-a .= new(:comment($comment-a));

    my UInt:D $number-b = 0;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my Str:D $reference-text-b = '0';
    my ReferenceLine:D $reference-line-b .= new(
        :reference-inline($reference-inline-b),
        :reference-text($reference-text-b)
    );

    my ReferenceLine:D @reference-line = $reference-line-b;

    cmp-ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule, :$actions).made,
        &cmp-ok-reference-line-block,
        ReferenceLineBlock['CommentBlock'].new(
            :comment-block($comment-block-a),
            :@reference-line
        ),
        'ReferenceLineBlock OK'
    );
});

subtest('reference-line-block:after-horizontal-rule', {
    my Finn::Parser::Actions $actions .= new;
    my Str:D $reference-line-block = q:to/EOF/.trim-trailing;
    ******************************************************************************
    [0]: 0
    EOF
    my Str:D $rule = 'reference-line-block';

    my HorizontalRule['Hard'] $horizontal-rule-a .= new;

    my UInt:D $number-b = 0;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my Str:D $reference-text-b = '0';
    my ReferenceLine:D $reference-line-b .= new(
        :reference-inline($reference-inline-b),
        :reference-text($reference-text-b)
    );

    my ReferenceLine:D @reference-line = $reference-line-b;

    cmp-ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule, :$actions).made,
        &cmp-ok-reference-line-block,
        ReferenceLineBlock['HorizontalRule'].new(
            :horizontal-rule($horizontal-rule-a),
            :@reference-line
        ),
        'ReferenceLineBlock OK'
    );
});

subtest('reference-line continuations', {
    my Finn::Parser::Actions $actions .= new;
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

    # --- reference-line-a {{{

    my UInt:D $number-a = 0;
    my ReferenceInline $reference-inline-a .= new(:number($number-a));
    my Str:D $reference-text-a = q:to/EOF/.trim-trailing;
    0                     |||||||||||||||||||||||
      1                     |||||||||||||||||||||||
    2                     |||||||||||||||||||||||
      3                     |||||||||||||||||||||||
    4                     |||||||||||||||||||||||
      qwerty                     |||||||||||||||||||||||
        asdf                     |||||||||||||||||||||||
          zxcv                     |||||||||||||||||||||||
    EOF
    my ReferenceLine $reference-line-a .= new(
        :reference-inline($reference-inline-a),
        :reference-text($reference-text-a)
    );

    # --- end reference-line-a }}}
    # --- reference-line-b {{{

    my UInt:D $number-b = 1;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my Str:D $reference-text-b = q:to/EOF/.trim-trailing;
    poiu                     |||||||||||||||||||||||
                 curl                     |||||||||||||||||||||||
                 wget                     |||||||||||||||||||||||
    EOF
    my ReferenceLine $reference-line-b .= new(
        :reference-inline($reference-inline-b),
        :reference-text($reference-text-b)
    );

    # --- end reference-line-b }}}
    # --- reference-line-c {{{

    my UInt:D $number-c = 2;
    my ReferenceInline $reference-inline-c .= new(:number($number-c));
    my Str:D $reference-text-c = q:to/EOF/.trim-trailing;
    lkjh                     |||||||||||||||||||||||
    EOF
    my ReferenceLine $reference-line-c .= new(
        :reference-inline($reference-inline-c),
        :reference-text($reference-text-c)
    );

    # --- end reference-line-c }}}
    # --- reference-line-d {{{

    my UInt:D $number-d = 3;
    my ReferenceInline $reference-inline-d .= new(:number($number-d));
    my Str:D $reference-text-d = q:to/EOF/.trim-trailing;
    mnbv                     |||||||||||||||||||||||
    EOF
    my ReferenceLine $reference-line-d .= new(
        :reference-inline($reference-inline-d),
        :reference-text($reference-text-d)
    );

    # --- end reference-line-d }}}
    # --- reference-line-e {{{

    my UInt:D $number-e = 4;
    my ReferenceInline $reference-inline-e .= new(:number($number-e));
    my Str:D $reference-text-e = q:to/EOF/.trim-trailing;
    <SPACE>                     |||||||||||||||||||||||
    <CAPS>                     |||||||||||||||||||||||
    EOF
    my ReferenceLine $reference-line-e .= new(
        :reference-inline($reference-inline-e),
        :reference-text($reference-text-e)
    );

    # --- end reference-line-e }}}

    my ReferenceLine:D @reference-line =
        $reference-line-a,
        $reference-line-b,
        $reference-line-c,
        $reference-line-d,
        $reference-line-e;

    cmp-ok(
        Finn::Parser::Grammar.parse($reference-line-block, :$rule, :$actions).made,
        &cmp-ok-reference-line-block,
        ReferenceLineBlock['Top'].new(:@reference-line),
        'ReferenceLineBlock OK'
    );
});

sub cmp-ok-reference-line-block(
    ReferenceLineBlock:D $a,
    ReferenceLineBlock:D $b
    --> Bool:D
)
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
