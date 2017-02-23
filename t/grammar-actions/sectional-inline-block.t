use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 4;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline-block = q:to/EOF/.trim-trailing;

    § 'Name Of Section To Embed' [1]
    § /
    § 'Name Of Section To Embed' ~/a/b/c/d
    § "Name Of Section To Embed" /a/b/c/d
    § "Name Of Section To Embed" file:///
    EOF
    my Str:D $rule = 'sectional-inline-block';

    my BlankLine $blank-line .= new(:text(''));

    # --- sectional-inline-a {{{

    my Mode:D $mode-a = FINN;
    my Str:D $name-a = 'Name Of Section To Embed';
    my ReferenceInline $reference-inline-a .= new(:number(1));
    my SectionalInline['Name', 'Reference'] $sectional-inline-a .= new(
        :mode($mode-a),
        :name($name-a),
        :reference-inline($reference-inline-a)
    );

    # --- end sectional-inline-a }}}
    # --- sectional-inline-b {{{

    my Mode:D $mode-b = FINN;
    my IO::Path $path-b .= new('/');
    my File['Absolute'] $file-b .= new(:path($path-b));
    my SectionalInline['File'] $sectional-inline-b .= new(
        :mode($mode-b),
        :file($file-b)
    );

    # --- end sectional-inline-b }}}
    # --- sectional-inline-c {{{

    my Mode:D $mode-c = FINN;
    my Str:D $name-c = 'Name Of Section To Embed';
    my IO::Path $path-c .= new('~/a/b/c/d');
    my File['Absolute'] $file-c .= new(:path($path-c));
    my SectionalInline['Name', 'File'] $sectional-inline-c .= new(
        :mode($mode-c),
        :name($name-c),
        :file($file-c)
    );

    # --- end sectional-inline-c }}}
    # --- sectional-inline-d {{{

    my Mode:D $mode-d = FINN;
    my Str:D $name-d = 'Name Of Section To Embed';
    my IO::Path $path-d .= new('/a/b/c/d');
    my File['Absolute'] $file-d .= new(:path($path-d));
    my SectionalInline['Name', 'File'] $sectional-inline-d .= new(
        :mode($mode-d),
        :name($name-d),
        :file($file-d)
    );

    # --- end sectional-inline-d }}}
    # --- sectional-inline-e {{{

    my Mode:D $mode-e = FINN;
    my Str:D $name-e = 'Name Of Section To Embed';
    my IO::Path $path-e .= new('/');
    my Str:D $protocol-e = 'file://';
    my File['Absolute', 'Protocol'] $file-e .= new(
        :path($path-e),
        :protocol($protocol-e)
    );
    my SectionalInline['Name', 'File'] $sectional-inline-e .= new(
        :mode($mode-e),
        :name($name-e),
        :file($file-e)
    );

    # --- end sectional-inline-e }}}

    my SectionalInline:D @sectional-inline =
        $sectional-inline-a,
        $sectional-inline-b,
        $sectional-inline-c,
        $sectional-inline-d,
        $sectional-inline-e;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline-block, :$rule, :$actions).made,
        &cmp-ok-sectional-inline-block,
        SectionalInlineBlock['BlankLine'].new(:$blank-line, :@sectional-inline),
        'SectionalInlineBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline-block = q:to/EOF/.trim-trailing;
    /*
     *
     * comment
     * comment
     * comment
     *
     */
    § "Name Of Section To Embed" file:///a/b/c/d
    EOF
    my Str:D $rule = 'sectional-inline-block';

    my Str:D $text = q:to/EOF/;

     *
     * comment
     * comment
     * comment
     *
    EOF
    $text ~= ' ';
    my Comment $comment .= new(:$text);
    my CommentBlock $comment-block .= new(:$comment);

    # --- sectional-inline-a {{{

    my Mode:D $mode-a = FINN;
    my Str:D $name-a = 'Name Of Section To Embed';
    my IO::Path $path .= new('/a/b/c/d');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file-a .= new(:$path, :$protocol);
    my SectionalInline['Name', 'File'] $sectional-inline-a .= new(
        :mode($mode-a),
        :name($name-a),
        :file($file-a)
    );

    # --- end sectional-inline-a }}}

    my SectionalInline:D @sectional-inline = $sectional-inline-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline-block, :$rule, :$actions).made,
        &cmp-ok-sectional-inline-block,
        SectionalInlineBlock['CommentBlock'].new(:$comment-block, :@sectional-inline),
        'SectionalInlineBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline-block = q:to/EOF/.trim-trailing;
    /* a comment block */
    § 'Name Of Section To Embed' file://~/a/b/c/d
    § "Name Of Section To Embed" [0]
    § 'Name Of Section To Embed' [1010101010101]
    EOF
    my Str:D $rule = 'sectional-inline-block';

    my Str:D $text = ' a comment block ';
    my Comment $comment .= new(:$text);
    my CommentBlock $comment-block .= new(:$comment);

    # --- sectional-inline-a {{{

    my Mode:D $mode-a = FINN;
    my Str:D $name-a = 'Name Of Section To Embed';
    my IO::Path $path-a .= new('~/a/b/c/d');
    my Str:D $protocol-a = 'file://';
    my File['Absolute', 'Protocol'] $file-a .= new(
        :path($path-a),
        :protocol($protocol-a)
    );
    my SectionalInline['Name', 'File'] $sectional-inline-a .= new(
        :mode($mode-a),
        :name($name-a),
        :file($file-a)
    );

    # --- end sectional-inline-a }}}
    # --- sectional-inline-b {{{

    my Mode:D $mode-b = FINN;
    my Str:D $name-b = 'Name Of Section To Embed';
    my UInt:D $number-b = 0;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my SectionalInline['Name', 'Reference'] $sectional-inline-b .= new(
        :mode($mode-b),
        :name($name-b),
        :reference-inline($reference-inline-b)
    );

    # --- end sectional-inline-b }}}
    # --- sectional-inline-c {{{

    my Mode:D $mode-c = FINN;
    my Str:D $name-c = 'Name Of Section To Embed';
    my UInt:D $number-c = 1010101010101;
    my ReferenceInline $reference-inline-c .= new(:number($number-c));
    my SectionalInline['Name', 'Reference'] $sectional-inline-c .= new(
        :mode($mode-c),
        :name($name-c),
        :reference-inline($reference-inline-c)
    );

    # --- end sectional-inline-c }}}

    my SectionalInline:D @sectional-inline =
        $sectional-inline-a,
        $sectional-inline-b,
        $sectional-inline-c;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline-block, :$rule, :$actions).made,
        &cmp-ok-sectional-inline-block,
        SectionalInlineBlock['CommentBlock'].new(:$comment-block, :@sectional-inline),
        'SectionalInlineBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline-block = q:to/EOF/.trim-trailing;
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    § ~/finn/share/vimfmt
    § 'Name Of Section To Embed' ~
    § "Name Of Section To Embed" /
    § [1010101010101]
    § file:///
    § file://~
    § file:///finn/share/vimfmt
    § file://~/finn/share/vimfmt
    § [0]
    § [1]
    ¶ [2]
    EOF
    my Str:D $rule = 'sectional-inline-block';

    my HorizontalRule['Soft'] $horizontal-rule .= new;

    # --- sectional-inline-a {{{

    my Mode:D $mode-a = FINN;
    my IO::Path $path-a .= new('~/finn/share/vimfmt');
    my File['Absolute'] $file-a .= new(:path($path-a));
    my SectionalInline['File'] $sectional-inline-a .= new(
        :mode($mode-a),
        :file($file-a)
    );

    # --- end sectional-inline-a }}}
    # --- sectional-inline-b {{{

    my Mode:D $mode-b = FINN;
    my Str:D $name-b = 'Name Of Section To Embed';
    my IO::Path $path-b .= new('~');
    my File['Absolute'] $file-b .= new(:path($path-b));
    my SectionalInline['Name', 'File'] $sectional-inline-b .= new(
        :mode($mode-b),
        :name($name-b),
        :file($file-b)
    );

    # --- end sectional-inline-b }}}
    # --- sectional-inline-c {{{

    my Mode:D $mode-c = FINN;
    my Str:D $name-c = 'Name Of Section To Embed';
    my IO::Path $path-c .= new('/');
    my File['Absolute'] $file-c .= new(:path($path-c));
    my SectionalInline['Name', 'File'] $sectional-inline-c .= new(
        :mode($mode-c),
        :name($name-c),
        :file($file-c)
    );

    # --- end sectional-inline-c }}}
    # --- sectional-inline-d {{{

    my Mode:D $mode-d = FINN;
    my UInt:D $number-d = 1010101010101;
    my ReferenceInline $reference-inline-d .= new(:number($number-d));
    my SectionalInline['Reference'] $sectional-inline-d .= new(
        :mode($mode-d),
        :reference-inline($reference-inline-d)
    );

    # --- end sectional-inline-d }}}
    # --- sectional-inline-e {{{

    my Mode:D $mode-e = FINN;
    my IO::Path $path-e .= new('/');
    my Str:D $protocol-e = 'file://';
    my File['Absolute', 'Protocol'] $file-e .= new(
        :path($path-e),
        :protocol($protocol-e)
    );
    my SectionalInline['File'] $sectional-inline-e .= new(
        :mode($mode-e),
        :file($file-e)
    );

    # --- end sectional-inline-e }}}
    # --- sectional-inline-f {{{

    my Mode:D $mode-f = FINN;
    my IO::Path $path-f .= new('~');
    my Str:D $protocol-f = 'file://';
    my File['Absolute', 'Protocol'] $file-f .= new(
        :path($path-f),
        :protocol($protocol-f)
    );
    my SectionalInline['File'] $sectional-inline-f .= new(
        :mode($mode-f),
        :file($file-f)
    );

    # --- end sectional-inline-f }}}
    # --- sectional-inline-g {{{

    my Mode:D $mode-g = FINN;
    my IO::Path $path-g .= new('/finn/share/vimfmt');
    my Str:D $protocol-g = 'file://';
    my File['Absolute', 'Protocol'] $file-g .= new(
        :path($path-g),
        :protocol($protocol-g)
    );
    my SectionalInline['File'] $sectional-inline-g .= new(
        :mode($mode-g),
        :file($file-g)
    );

    # --- end sectional-inline-g }}}
    # --- sectional-inline-h {{{

    my Mode:D $mode-h = FINN;
    my IO::Path $path-h .= new('~/finn/share/vimfmt');
    my Str:D $protocol-h = 'file://';
    my File['Absolute', 'Protocol'] $file-h .= new(
        :path($path-h),
        :protocol($protocol-h)
    );
    my SectionalInline['File'] $sectional-inline-h .= new(
        :mode($mode-h),
        :file($file-h)
    );

    # --- end sectional-inline-h }}}
    # --- sectional-inline-i {{{

    my Mode:D $mode-i = FINN;
    my UInt:D $number-i = 0;
    my ReferenceInline $reference-inline-i .= new(:number($number-i));
    my SectionalInline['Reference'] $sectional-inline-i .= new(
        :mode($mode-i),
        :reference-inline($reference-inline-i)
    );

    # --- end sectional-inline-i }}}
    # --- sectional-inline-j {{{

    my Mode:D $mode-j = FINN;
    my UInt:D $number-j = 1;
    my ReferenceInline $reference-inline-j .= new(:number($number-j));
    my SectionalInline['Reference'] $sectional-inline-j .= new(
        :mode($mode-j),
        :reference-inline($reference-inline-j)
    );

    # --- end sectional-inline-j }}}
    # --- sectional-inline-k {{{

    my Mode:D $mode-k = TEXT;
    my UInt:D $number-k = 2;
    my ReferenceInline $reference-inline-k .= new(:number($number-k));
    my SectionalInline['Reference'] $sectional-inline-k .= new(
        :mode($mode-k),
        :reference-inline($reference-inline-k)
    );

    # --- end sectional-inline-k }}}

    my SectionalInline:D @sectional-inline =
        $sectional-inline-a,
        $sectional-inline-b,
        $sectional-inline-c,
        $sectional-inline-d,
        $sectional-inline-e,
        $sectional-inline-f,
        $sectional-inline-g,
        $sectional-inline-h,
        $sectional-inline-i,
        $sectional-inline-j,
        $sectional-inline-k;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline-block, :$rule, :$actions).made,
        &cmp-ok-sectional-inline-block,
        SectionalInlineBlock['HorizontalRule'].new(:$horizontal-rule, :@sectional-inline),
        'SectionalInlineBlock OK';
}

sub cmp-ok-sectional-inline-block(
    SectionalInlineBlock:D $a,
    SectionalInlineBlock:D $b
) returns Bool:D
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
