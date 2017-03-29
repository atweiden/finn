use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 3;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    - abcdefghijklmnopqrstuvwxyz /* inner comment */
      ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 /* eol comment */
      - /* inner comment */ abcdefghijklmnopqrstuvwxyz /* eol comment */
        ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 /* eol comment */
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF
    my Str:D $rule = 'list-block';

    # --- list-item-a {{{

    my BulletPoint['-'] $bullet-point-a .= new;
    my Str:D $text-a =
        ~ 'abcdefghijklmnopqrstuvwxyz /* inner comment */'
        ~ "\n"
        ~ '  ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 /* eol comment */';
    my ListItem['Unordered'] $list-item-a .= new(
        :bullet-point($bullet-point-a),
        :text($text-a)
    );

    # --- end list-item-a }}}
    # --- list-item-b {{{

    my BulletPoint['-'] $bullet-point-b .= new;
    my Str:D $text-b =
        ~ '/* inner comment */ abcdefghijklmnopqrstuvwxyz /* eol comment */'
        ~ "\n"
        ~ '    ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 /* eol comment */';
    my ListItem['Unordered'] $list-item-b .= new(
        :bullet-point($bullet-point-b),
        :text($text-b)
    );

    # --- end list-item-b }}}
    # --- list-item-c {{{

    my BulletPoint['-'] $bullet-point-c .= new;
    my Str:D $text-c =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Unordered'] $list-item-c .= new(
        :bullet-point($bullet-point-c),
        :text($text-c)
    );

    # --- end list-item-c }}}
    # --- list-item-d {{{

    my BulletPoint['-'] $bullet-point-d .= new;
    my Str:D $text-d = $text-c;
    my ListItem['Unordered'] $list-item-d .= new(
        :bullet-point($bullet-point-d),
        :text($text-d)
    );

    # --- end list-item-d }}}
    # --- list-item-e {{{

    my BulletPoint['-'] $bullet-point-e .= new;
    my Str:D $text-e = $text-c;
    my ListItem['Unordered'] $list-item-e .= new(
        :bullet-point($bullet-point-e),
        :text($text-e)
    );

    # --- end list-item-e }}}

    my ListItem:D @list-item =
        $list-item-a,
        $list-item-b,
        $list-item-c,
        $list-item-d,
        $list-item-e;

    cmp-ok
        Finn::Parser::Grammar.parse($list-block, :$rule, :$actions).made,
        &cmp-ok-list-block,
        ListBlock.new(:@list-item),
        'ListBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
            1234567890 abcdefghijklmnopqrstuvwxyz
            ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
              1234567890
    EOF
    my Str:D $rule = 'list-block';

    # --- list-item-a {{{

    my BulletPoint['-'] $bullet-point-a .= new;
    my Str:D $text-a =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Unordered'] $list-item-a .= new(
        :bullet-point($bullet-point-a),
        :text($text-a)
    );

    # --- end list-item-a }}}
    # --- list-item-b {{{

    my BulletPoint['-'] $bullet-point-b .= new;
    my Str:D $text-b =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Unordered'] $list-item-b .= new(
        :bullet-point($bullet-point-b),
        :text($text-b)
    );

    # --- end list-item-b }}}
    # --- list-item-c {{{

    my BulletPoint['-'] $bullet-point-c .= new;
    my Str:D $text-c =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Unordered'] $list-item-c .= new(
        :bullet-point($bullet-point-c),
        :text($text-c)
    );

    # --- end list-item-c }}}
    # --- list-item-d {{{

    my BulletPoint['-'] $bullet-point-d .= new;
    my Str:D $text-d =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        ~ "\n"
        ~ '        1234567890 abcdefghijklmnopqrstuvwxyz'
        ~ "\n"
        ~ '        ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890'
        ~ "\n"
        ~ '        1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    my ListItem['Unordered'] $list-item-d .= new(
        :bullet-point($bullet-point-d),
        :text($text-d)
    );

    # --- end list-item-d }}}
    # --- list-item-e {{{

    my BulletPoint['-'] $bullet-point-e .= new;
    my Str:D $text-e =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        ~ "\n"
        ~ '          1234567890';
    my ListItem['Unordered'] $list-item-e .= new(
        :bullet-point($bullet-point-e),
        :text($text-e)
    );

    # --- end list-item-e }}}

    my ListItem:D @list-item =
        $list-item-a,
        $list-item-b,
        $list-item-c,
        $list-item-d,
        $list-item-e;

    cmp-ok
        Finn::Parser::Grammar.parse($list-block, :$rule, :$actions).made,
        &cmp-ok-list-block,
        ListBlock.new(:@list-item),
        'ListBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    1. abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
       - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
         [*] abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
           - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
             1234567890 abcdefghijklmnopqrstuvwxyz
    2. ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
       3. 1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ
     x asdfasdf
       o asdfasdf
         + abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
           1234567890
           <- abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
              1234567890
    EOF
    my Str:D $rule = 'list-block';

    # --- list-item-a {{{

    my UInt:D $value-a = 1;
    my ListItem::Number::Terminator['.'] $terminator-a .= new;
    my ListItem::Number $number-a .= new(
        :value($value-a),
        :terminator($terminator-a)
    );
    my Str:D $text-a =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Ordered'] $list-item-a .= new(
        :number($number-a),
        :text($text-a)
    );

    # --- end list-item-a }}}
    # --- list-item-b {{{

    my BulletPoint['-'] $bullet-point-b .= new;
    my Str:D $text-b =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Unordered'] $list-item-b .= new(
        :bullet-point($bullet-point-b),
        :text($text-b)
    );

    # --- end list-item-b }}}
    # --- list-item-c {{{

    my CheckboxExceptionChar['*'] $char-c .= new;
    my Checkbox['Exception'] $checkbox-c .= new(:char($char-c));
    my Str:D $text-c =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Todo'] $list-item-c .= new(
        :checkbox($checkbox-c),
        :text($text-c)
    );

    # --- end list-item-c }}}
    # --- list-item-d {{{

    my BulletPoint['-'] $bullet-point-d .= new;
    my Str:D $text-d =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        ~ "\n"
        ~ '         1234567890 abcdefghijklmnopqrstuvwxyz';
    my ListItem['Unordered'] $list-item-d .= new(
        :bullet-point($bullet-point-d),
        :text($text-d)
    );

    # --- end list-item-d }}}
    # --- list-item-e {{{

    my UInt:D $value-e = 2;
    my ListItem::Number::Terminator['.'] $terminator-e .= new;
    my ListItem::Number $number-e .= new(
        :value($value-e),
        :terminator($terminator-e)
    );
    my Str:D $text-e =
        ~ 'ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890';
    my ListItem['Ordered'] $list-item-e .= new(
        :number($number-e),
        :text($text-e)
    );

    # --- end list-item-e }}}
    # --- list-item-f {{{

    my UInt:D $value-f = 3;
    my ListItem::Number::Terminator['.'] $terminator-f .= new;
    my ListItem::Number $number-f .= new(
        :value($value-f),
        :terminator($terminator-f)
    );
    my Str:D $text-f =
        ~ '1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    my ListItem['Ordered'] $list-item-f .= new(
        :number($number-f),
        :text($text-f)
    );

    # --- end list-item-f }}}
    # --- list-item-g {{{

    my BulletPoint['x'] $bullet-point-g .= new;
    my Str:D $text-g = 'asdfasdf';
    my ListItem['Unordered'] $list-item-g .= new(
        :bullet-point($bullet-point-g),
        :text($text-g)
    );

    # --- end list-item-g }}}
    # --- list-item-h {{{

    my BulletPoint['o'] $bullet-point-h .= new;
    my Str:D $text-h = 'asdfasdf';
    my ListItem['Unordered'] $list-item-h .= new(
        :bullet-point($bullet-point-h),
        :text($text-h)
    );

    # --- end list-item-h }}}
    # --- list-item-i {{{

    my BulletPoint['+'] $bullet-point-i .= new;
    my Str:D $text-i =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        ~ "\n"
        ~ '       1234567890';
    my ListItem['Unordered'] $list-item-i .= new(
        :bullet-point($bullet-point-i),
        :text($text-i)
    );

    # --- end list-item-i }}}
    # --- list-item-j {{{

    my BulletPoint['<-'] $bullet-point-j .= new;
    my Str:D $text-j =
        ~ 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        ~ "\n"
        ~ '          1234567890';
    my ListItem['Unordered'] $list-item-j .= new(
        :bullet-point($bullet-point-j),
        :text($text-j)
    );

    # --- end list-item-j }}}

    my ListItem:D @list-item =
        $list-item-a,
        $list-item-b,
        $list-item-c,
        $list-item-d,
        $list-item-e,
        $list-item-f,
        $list-item-g,
        $list-item-h,
        $list-item-i,
        $list-item-j;

    cmp-ok
        Finn::Parser::Grammar.parse($list-block, :$rule, :$actions).made,
        &cmp-ok-list-block,
        ListBlock.new(:@list-item),
        'ListBlock OK';
}

sub cmp-ok-list-block(ListBlock:D $a, ListBlock:D $b --> Bool:D)
{
    $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
