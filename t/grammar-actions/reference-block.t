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

    # --- reference-line-a {{{

    my UInt:D $number-a = 1;
    my ReferenceInline $reference-inline-a .= new(:number($number-a));
    my Str:D $reference-text-a = 'https://google.com';
    my ReferenceLine $reference-line-a .= new(
        :reference-inline($reference-inline-a),
        :reference-text($reference-text-a)
    );

    # --- end reference-line-a }}}
    # --- reference-line-b {{{

    my UInt:D $number-b = 2;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my Str:D $reference-text-b = 'https://youtube.com';
    my ReferenceLine $reference-line-b .= new(
        :reference-inline($reference-inline-b),
        :reference-text($reference-text-b)
    );

    # --- end reference-line-b }}}
    # --- reference-line-c {{{

    my UInt:D $number-c = 3;
    my ReferenceInline $reference-inline-c .= new(:number($number-c));
    my Str:D $reference-text-c = 'https://facebook.com';
    my ReferenceLine $reference-line-c .= new(
        :reference-inline($reference-inline-c),
        :reference-text($reference-text-c)
    );

    # --- end reference-line-c }}}
    # --- reference-line-d {{{

    my UInt:D $number-d = 4;
    my ReferenceInline $reference-inline-d .= new(:number($number-d));
    my Str:D $reference-text-d = 'https://twitter.com';
    my ReferenceLine $reference-line-d .= new(
        :reference-inline($reference-inline-d),
        :reference-text($reference-text-d)
    );

    # --- end reference-line-d }}}

    my ReferenceLine:D @reference-line =
        $reference-line-a,
        $reference-line-b,
        $reference-line-c,
        $reference-line-d;

    is-deeply
        Finn::Parser::Grammar.parse($reference-block, :$rule, :$actions).made,
        ReferenceBlock.new(:$horizontal-rule, :@reference-line),
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

    # --- reference-line-a {{{

    my UInt:D $number-a = 0;
    my ReferenceInline $reference-inline-a .= new(:number($number-a));
    my Str:D $reference-text-a = 'http://stackoverflow.com/questions/40633059/why-write-1-000-000-000-as-100010001000-in-c';
    my ReferenceLine $reference-line-a .= new(
        :reference-inline($reference-inline-a),
        :reference-text($reference-text-a)
    );

    # --- end reference-line-a }}}
    # --- reference-line-b {{{

    my UInt:D $number-b = 10;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my Str:D $reference-text-b = 'https://twitter.com/hashtag/KanyeWest?src=hash';
    my ReferenceLine $reference-line-b .= new(
        :reference-inline($reference-inline-b),
        :reference-text($reference-text-b)
    );

    # --- end reference-line-b }}}
    # --- reference-line-c {{{

    my UInt:D $number-c = 200;
    my ReferenceInline $reference-inline-c .= new(:number($number-c));
    my Str:D $reference-text-c = 'https://www.facebook.com/202123499894789/photos/363845463722591/';
    my ReferenceLine $reference-line-c .= new(
        :reference-inline($reference-inline-c),
        :reference-text($reference-text-c)
    );

    # --- end reference-line-c }}}
    # --- reference-line-d {{{

    my UInt:D $number-d = 3000000000;
    my ReferenceInline $reference-inline-d .= new(:number($number-d));
    my Str:D $reference-text-d = 'https://abc.xyz/?q=%s';
    my ReferenceLine $reference-line-d .= new(
        :reference-inline($reference-inline-d),
        :reference-text($reference-text-d)
    );

    # --- end reference-line-d }}}

    my ReferenceLine:D @reference-line =
        $reference-line-a,
        $reference-line-b,
        $reference-line-c,
        $reference-line-d;

    is-deeply
        Finn::Parser::Grammar.parse($reference-block, :$rule, :$actions).made,
        ReferenceBlock.new(:$horizontal-rule, :@reference-line),
        'ReferenceBlock OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
