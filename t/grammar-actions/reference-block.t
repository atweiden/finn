use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 2;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $reference-block = q:to/EOF/.trim;
    ******************************************************************************

    [1]: https://google.com
    [2]: https://youtube.com
    [3]: https://facebook.com
    [4]: https://twitter.com
    EOF
    my Str:D $rule = 'reference-block';

    my HorizontalRule['Hard'] $horizontal-rule .= new;

    my Str:D $blank-line-text-a = '';
    my BlankLine $blank-line-a .= new(:text($blank-line-text-a));
    my BlankLine:D @blank-line = $blank-line-a;

    # --- reference-line-b {{{

    my UInt:D $number-b = 1;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my Str:D $reference-text-b = 'https://google.com';
    my ReferenceLine $reference-line-b .= new(
        :reference-inline($reference-inline-b),
        :reference-text($reference-text-b)
    );

    # --- end reference-line-b }}}
    # --- reference-line-c {{{

    my UInt:D $number-c = 2;
    my ReferenceInline $reference-inline-c .= new(:number($number-c));
    my Str:D $reference-text-c = 'https://youtube.com';
    my ReferenceLine $reference-line-c .= new(
        :reference-inline($reference-inline-c),
        :reference-text($reference-text-c)
    );

    # --- end reference-line-c }}}
    # --- reference-line-d {{{

    my UInt:D $number-d = 3;
    my ReferenceInline $reference-inline-d .= new(:number($number-d));
    my Str:D $reference-text-d = 'https://facebook.com';
    my ReferenceLine $reference-line-d .= new(
        :reference-inline($reference-inline-d),
        :reference-text($reference-text-d)
    );

    # --- end reference-line-d }}}
    # --- reference-line-e {{{

    my UInt:D $number-e = 4;
    my ReferenceInline $reference-inline-e .= new(:number($number-e));
    my Str:D $reference-text-e = 'https://twitter.com';
    my ReferenceLine $reference-line-e .= new(
        :reference-inline($reference-inline-e),
        :reference-text($reference-text-e)
    );

    # --- end reference-line-e }}}

    my ReferenceLine:D @reference-line =
        $reference-line-b,
        $reference-line-c,
        $reference-line-d,
        $reference-line-e;

    my ReferenceLineBlock['BlankLine'] $reference-line-block .= new(
        :@blank-line,
        :@reference-line
    );

    my ReferenceLineBlock:D @reference-line-block = $reference-line-block;

    is-deeply
        Finn::Parser::Grammar.parse($reference-block, :$rule, :$actions).made,
        ReferenceBlock.new(:$horizontal-rule, :@reference-line-block),
        'ReferenceBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $reference-block = q:to/EOF/.trim;
    ******************************************************************************

    [0]: http://stackoverflow.com/questions/40633059/why-write-1-000-000-000-as-100010001000-in-c




    [10]: https://twitter.com/hashtag/KanyeWest?src=hash
    [200]: https://www.facebook.com/202123499894789/photos/363845463722591/



    [3000000000]: https://abc.xyz/?q=%s
    EOF
    my Str:D $rule = 'reference-block';

    my HorizontalRule['Hard'] $horizontal-rule .= new;

    # --- reference-line-block-a {{{

    # --- --- blank-line-a {{{

    my Str:D $blank-line-text-a01 = '';
    my BlankLine $blank-line-a01 .= new(:text($blank-line-text-a01));

    my BlankLine:D @blank-line-a = $blank-line-a01;

    # --- --- end blank-line-a }}}
    # --- --- reference-line-a {{{

    my UInt:D $number-a01 = 0;
    my ReferenceInline $reference-inline-a01 .= new(:number($number-a01));
    my Str:D $reference-text-a01 = 'http://stackoverflow.com/questions/40633059/why-write-1-000-000-000-as-100010001000-in-c';
    my ReferenceLine $reference-line-a01 .= new(
        :reference-inline($reference-inline-a01),
        :reference-text($reference-text-a01)
    );

    my ReferenceLine:D @reference-line-a = $reference-line-a01;

    # --- --- end reference-line-a }}}

    my ReferenceLineBlock['BlankLine'] $reference-line-block-a .= new(
        :blank-line(@blank-line-a),
        :reference-line(@reference-line-a)
    );

    # --- end reference-line-block-a }}}
    # --- reference-line-block-b {{{

    # --- --- blank-line-b {{{

    my Str:D $blank-line-text-b01 = '';
    my BlankLine $blank-line-b01 .= new(:text($blank-line-text-b01));

    my Str:D $blank-line-text-b02 = '';
    my BlankLine $blank-line-b02 .= new(:text($blank-line-text-b02));

    my Str:D $blank-line-text-b03 = '';
    my BlankLine $blank-line-b03 .= new(:text($blank-line-text-b03));

    my Str:D $blank-line-text-b04 = '';
    my BlankLine $blank-line-b04 .= new(:text($blank-line-text-b04));

    my BlankLine:D @blank-line-b =
        $blank-line-b01,
        $blank-line-b02,
        $blank-line-b03,
        $blank-line-b04;

    # --- --- end blank-line-b }}}
    # --- --- reference-line-b {{{

    my UInt:D $number-b01 = 10;
    my ReferenceInline $reference-inline-b01 .= new(:number($number-b01));
    my Str:D $reference-text-b01 = 'https://twitter.com/hashtag/KanyeWest?src=hash';
    my ReferenceLine $reference-line-b01 .= new(
        :reference-inline($reference-inline-b01),
        :reference-text($reference-text-b01)
    );

    my UInt:D $number-b02 = 200;
    my ReferenceInline $reference-inline-b02 .= new(:number($number-b02));
    my Str:D $reference-text-b02 = 'https://www.facebook.com/202123499894789/photos/363845463722591/';
    my ReferenceLine $reference-line-b02 .= new(
        :reference-inline($reference-inline-b02),
        :reference-text($reference-text-b02)
    );

    my ReferenceLine:D @reference-line-b =
        $reference-line-b01,
        $reference-line-b02;

    # --- --- end reference-line-b }}}

    my ReferenceLineBlock['BlankLine'] $reference-line-block-b .= new(
        :blank-line(@blank-line-b),
        :reference-line(@reference-line-b)
    );

    # --- end reference-line-block-b }}}
    # --- reference-line-block-c {{{

    # --- --- blank-line-c {{{

    my Str:D $blank-line-text-c01 = '';
    my BlankLine $blank-line-c01 .= new(:text($blank-line-text-c01));

    my Str:D $blank-line-text-c02 = '';
    my BlankLine $blank-line-c02 .= new(:text($blank-line-text-c02));

    my Str:D $blank-line-text-c03 = '';
    my BlankLine $blank-line-c03 .= new(:text($blank-line-text-c03));

    my BlankLine:D @blank-line-c =
        $blank-line-c01,
        $blank-line-c02,
        $blank-line-c03;

    # --- --- end blank-line-c }}}
    # --- --- reference-line-c {{{

    my UInt:D $number-c01 = 3000000000;
    my ReferenceInline $reference-inline-c01 .= new(:number($number-c01));
    my Str:D $reference-text-c01 = 'https://abc.xyz/?q=%s';
    my ReferenceLine $reference-line-c01 .= new(
        :reference-inline($reference-inline-c01),
        :reference-text($reference-text-c01)
    );

    my ReferenceLine:D @reference-line-c = $reference-line-c01;

    # --- --- end reference-line-c }}}

    my ReferenceLineBlock['BlankLine'] $reference-line-block-c .= new(
        :blank-line(@blank-line-c),
        :reference-line(@reference-line-c)
    );

    # --- reference-line-block-c }}}

    my ReferenceLineBlock:D @reference-line-block =
        $reference-line-block-a,
        $reference-line-block-b,
        $reference-line-block-c;

    is-deeply
        Finn::Parser::Grammar.parse($reference-block, :$rule, :$actions).made,
        ReferenceBlock.new(:$horizontal-rule, :@reference-line-block),
        'ReferenceBlock OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
