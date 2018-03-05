use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan(4);

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;

    § 'Name Of Section To Embed' [1]
    § /
    § 'Name Of Section To Embed' ~/a/b/c/d
    § "Name Of Section To Embed" /a/b/c/d
    § "Name Of Section To Embed" file:///
    EOF
    my Str:D $rule = 'include-line-block';

    my BlankLine $blank-line .= new(:text(''));

    # --- include-line-a {{{

    my Str:D $name-a = 'Name Of Section To Embed';
    my ReferenceInline $reference-inline-a .= new(:number(1));
    my IncludeLine::Request['Name', 'Reference'] $request-a .= new(
        :name($name-a),
        :reference-inline($reference-inline-a)
    );
    my &resolve-a;
    my IncludeLine::Resolver['Name', 'Reference'] $resolver-a .= new(
        :resolve(&resolve-a)
    );
    my IncludeLine['Finn'] $include-line-a .= new(
        :request($request-a),
        :resolver($resolver-a)
    );

    # --- end include-line-a }}}
    # --- include-line-b {{{

    my IO::Path $path-b .= new('/');
    my File['Absolute'] $file-b .= new(:path($path-b));
    my IncludeLine::Request['File'] $request-b .= new(:file($file-b));
    my &resolve-b;
    my IncludeLine::Resolver['File'] $resolver-b .= new(:resolve(&resolve-b));
    my IncludeLine['Finn'] $include-line-b .= new(
        :request($request-b),
        :resolver($resolver-b)
    );

    # --- end include-line-b }}}
    # --- include-line-c {{{

    my Str:D $name-c = 'Name Of Section To Embed';
    my IO::Path $path-c .= new('~/a/b/c/d');
    my File['Absolute'] $file-c .= new(:path($path-c));
    my IncludeLine::Request['Name', 'File'] $request-c .= new(
        :name($name-c),
        :file($file-c)
    );
    my &resolve-c;
    my IncludeLine::Resolver['Name', 'File'] $resolver-c .= new(
        :resolve(&resolve-c)
    );
    my IncludeLine['Finn'] $include-line-c .= new(
        :request($request-c),
        :resolver($resolver-c)
    );

    # --- end include-line-c }}}
    # --- include-line-d {{{

    my Str:D $name-d = 'Name Of Section To Embed';
    my IO::Path $path-d .= new('/a/b/c/d');
    my File['Absolute'] $file-d .= new(:path($path-d));
    my IncludeLine::Request['Name', 'File'] $request-d .= new(
        :name($name-d),
        :file($file-d)
    );
    my &resolve-d;
    my IncludeLine::Resolver['Name', 'File'] $resolver-d .= new(
        :resolve(&resolve-d)
    );
    my IncludeLine['Finn'] $include-line-d .= new(
        :request($request-d),
        :resolver($resolver-d)
    );

    # --- end include-line-d }}}
    # --- include-line-e {{{

    my Str:D $name-e = 'Name Of Section To Embed';
    my IO::Path $path-e .= new('/');
    my Str:D $protocol-e = 'file://';
    my File['Absolute', 'Protocol'] $file-e .= new(
        :path($path-e),
        :protocol($protocol-e)
    );
    my IncludeLine::Request['Name', 'File'] $request-e .= new(
        :name($name-e),
        :file($file-e)
    );
    my &resolve-e;
    my IncludeLine::Resolver['Name', 'File'] $resolver-e .= new(
        :resolve(&resolve-e)
    );
    my IncludeLine['Finn'] $include-line-e .= new(
        :request($request-e),
        :resolver($resolver-e)
    );

    # --- end include-line-e }}}

    my IncludeLine:D @include-line =
        $include-line-a,
        $include-line-b,
        $include-line-c,
        $include-line-d,
        $include-line-e;

    cmp-ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule, :$actions).made,
        &cmp-ok-include-line-block,
        IncludeLineBlock['BlankLine'].new(:$blank-line, :@include-line),
        'IncludeLineBlock OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;
    /*
     *
     * comment
     * comment
     * comment
     *
     */
    § "Name Of Section To Embed" file:///a/b/c/d
    EOF
    my Str:D $rule = 'include-line-block';

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

    # --- include-line-a {{{

    my Str:D $name-a = 'Name Of Section To Embed';
    my IO::Path $path .= new('/a/b/c/d');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file-a .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request-a .= new(
        :name($name-a),
        :file($file-a)
    );
    my &resolve-a;
    my IncludeLine::Resolver['Name', 'File'] $resolver-a .= new(
        :resolve(&resolve-a)
    );
    my IncludeLine['Finn'] $include-line-a .= new(
        :request($request-a),
        :resolver($resolver-a)
    );

    # --- end include-line-a }}}

    my IncludeLine:D @include-line = $include-line-a;

    cmp-ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule, :$actions).made,
        &cmp-ok-include-line-block,
        IncludeLineBlock['CommentBlock'].new(:$comment-block, :@include-line),
        'IncludeLineBlock OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;
    /* a comment block */
    § 'Name Of Section To Embed' file://~/a/b/c/d
    § "Name Of Section To Embed" [0]
    § 'Name Of Section To Embed' [1010101010101]
    EOF
    my Str:D $rule = 'include-line-block';

    my Str:D $text = ' a comment block ';
    my Comment $comment .= new(:$text);
    my CommentBlock $comment-block .= new(:$comment);

    # --- include-line-a {{{

    my Str:D $name-a = 'Name Of Section To Embed';
    my IO::Path $path-a .= new('~/a/b/c/d');
    my Str:D $protocol-a = 'file://';
    my File['Absolute', 'Protocol'] $file-a .= new(
        :path($path-a),
        :protocol($protocol-a)
    );
    my IncludeLine::Request['Name', 'File'] $request-a .= new(
        :name($name-a),
        :file($file-a)
    );
    my &resolve-a;
    my IncludeLine::Resolver['Name', 'File'] $resolver-a .= new(
        :resolve(&resolve-a)
    );
    my IncludeLine['Finn'] $include-line-a .= new(
        :request($request-a),
        :resolver($resolver-a)
    );

    # --- end include-line-a }}}
    # --- include-line-b {{{

    my Str:D $name-b = 'Name Of Section To Embed';
    my UInt:D $number-b = 0;
    my ReferenceInline $reference-inline-b .= new(:number($number-b));
    my IncludeLine::Request['Name', 'Reference'] $request-b .= new(
        :name($name-b),
        :reference-inline($reference-inline-b)
    );
    my &resolve-b;
    my IncludeLine::Resolver['Name', 'Reference'] $resolver-b .= new(
        :resolve(&resolve-b)
    );
    my IncludeLine['Finn'] $include-line-b .= new(
        :request($request-b),
        :resolver($resolver-b)
    );

    # --- end include-line-b }}}
    # --- include-line-c {{{

    my Str:D $name-c = 'Name Of Section To Embed';
    my UInt:D $number-c = 1010101010101;
    my ReferenceInline $reference-inline-c .= new(:number($number-c));
    my IncludeLine::Request['Name', 'Reference'] $request-c .= new(
        :name($name-c),
        :reference-inline($reference-inline-c)
    );
    my &resolve-c;
    my IncludeLine::Resolver['Name', 'Reference'] $resolver-c .= new(
        :resolve(&resolve-c)
    );
    my IncludeLine['Finn'] $include-line-c .= new(
        :request($request-c),
        :resolver($resolver-c)
    );

    # --- end include-line-c }}}

    my IncludeLine:D @include-line =
        $include-line-a,
        $include-line-b,
        $include-line-c;

    cmp-ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule, :$actions).made,
        &cmp-ok-include-line-block,
        IncludeLineBlock['CommentBlock'].new(:$comment-block, :@include-line),
        'IncludeLineBlock OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line-block = q:to/EOF/.trim-trailing;
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
    my Str:D $rule = 'include-line-block';

    my HorizontalRule['Soft'] $horizontal-rule .= new;

    # --- include-line-a {{{

    my IO::Path $path-a .= new('~/finn/share/vimfmt');
    my File['Absolute'] $file-a .= new(:path($path-a));
    my IncludeLine::Request['File'] $request-a .= new(:file($file-a));
    my &resolve-a;
    my IncludeLine::Resolver['File'] $resolver-a .= new(:resolve(&resolve-a));
    my IncludeLine['Finn'] $include-line-a .= new(
        :request($request-a),
        :resolver($resolver-a)
    );

    # --- end include-line-a }}}
    # --- include-line-b {{{

    my Str:D $name-b = 'Name Of Section To Embed';
    my IO::Path $path-b .= new('~');
    my File['Absolute'] $file-b .= new(:path($path-b));
    my IncludeLine::Request['Name', 'File'] $request-b .= new(
        :name($name-b),
        :file($file-b)
    );
    my &resolve-b;
    my IncludeLine::Resolver['Name', 'File'] $resolver-b .= new(
        :resolve(&resolve-b)
    );
    my IncludeLine['Finn'] $include-line-b .= new(
        :request($request-b),
        :resolver($resolver-b)
    );

    # --- end include-line-b }}}
    # --- include-line-c {{{

    my Str:D $name-c = 'Name Of Section To Embed';
    my IO::Path $path-c .= new('/');
    my File['Absolute'] $file-c .= new(:path($path-c));
    my IncludeLine::Request['Name', 'File'] $request-c .= new(
        :name($name-c),
        :file($file-c)
    );
    my &resolve-c;
    my IncludeLine::Resolver['Name', 'File'] $resolver-c .= new(
        :resolve(&resolve-c)
    );
    my IncludeLine['Finn'] $include-line-c .= new(
        :request($request-c),
        :resolver($resolver-c)
    );

    # --- end include-line-c }}}
    # --- include-line-d {{{

    my UInt:D $number-d = 1010101010101;
    my ReferenceInline $reference-inline-d .= new(:number($number-d));
    my IncludeLine::Request['Reference'] $request-d .= new(
        :reference-inline($reference-inline-d)
    );
    my &resolve-d;
    my IncludeLine::Resolver['Reference'] $resolver-d .= new(
        :resolve(&resolve-d)
    );
    my IncludeLine['Finn'] $include-line-d .= new(
        :request($request-d),
        :resolver($resolver-d)
    );

    # --- end include-line-d }}}
    # --- include-line-e {{{

    my IO::Path $path-e .= new('/');
    my Str:D $protocol-e = 'file://';
    my File['Absolute', 'Protocol'] $file-e .= new(
        :path($path-e),
        :protocol($protocol-e)
    );
    my IncludeLine::Request['File'] $request-e .= new(:file($file-e));
    my &resolve-e;
    my IncludeLine::Resolver['File'] $resolver-e .= new(:resolve(&resolve-e));
    my IncludeLine['Finn'] $include-line-e .= new(
        :request($request-e),
        :resolver($resolver-e)
    );

    # --- end include-line-e }}}
    # --- include-line-f {{{

    my IO::Path $path-f .= new('~');
    my Str:D $protocol-f = 'file://';
    my File['Absolute', 'Protocol'] $file-f .= new(
        :path($path-f),
        :protocol($protocol-f)
    );
    my IncludeLine::Request['File'] $request-f .= new(:file($file-f));
    my &resolve-f;
    my IncludeLine::Resolver['File'] $resolver-f .= new(:resolve(&resolve-f));
    my IncludeLine['Finn'] $include-line-f .= new(
        :request($request-f),
        :resolver($resolver-f)
    );

    # --- end include-line-f }}}
    # --- include-line-g {{{

    my IO::Path $path-g .= new('/finn/share/vimfmt');
    my Str:D $protocol-g = 'file://';
    my File['Absolute', 'Protocol'] $file-g .= new(
        :path($path-g),
        :protocol($protocol-g)
    );
    my IncludeLine::Request['File'] $request-g .= new(:file($file-g));
    my &resolve-g;
    my IncludeLine::Resolver['File'] $resolver-g .= new(:resolve(&resolve-g));
    my IncludeLine['Finn'] $include-line-g .= new(
        :request($request-g),
        :resolver($resolver-g)
    );

    # --- end include-line-g }}}
    # --- include-line-h {{{

    my IO::Path $path-h .= new('~/finn/share/vimfmt');
    my Str:D $protocol-h = 'file://';
    my File['Absolute', 'Protocol'] $file-h .= new(
        :path($path-h),
        :protocol($protocol-h)
    );
    my IncludeLine::Request['File'] $request-h .= new(:file($file-h));
    my &resolve-h;
    my IncludeLine::Resolver['File'] $resolver-h .= new(:resolve(&resolve-h));
    my IncludeLine['Finn'] $include-line-h .= new(
        :request($request-h),
        :resolver($resolver-h)
    );

    # --- end include-line-h }}}
    # --- include-line-i {{{

    my UInt:D $number-i = 0;
    my ReferenceInline $reference-inline-i .= new(:number($number-i));
    my IncludeLine::Request['Reference'] $request-i .= new(
        :reference-inline($reference-inline-i)
    );
    my &resolve-i;
    my IncludeLine::Resolver['Reference'] $resolver-i .= new(
        :resolve(&resolve-i)
    );
    my IncludeLine['Finn'] $include-line-i .= new(
        :request($request-i),
        :resolver($resolver-i)
    );

    # --- end include-line-i }}}
    # --- include-line-j {{{

    my UInt:D $number-j = 1;
    my ReferenceInline $reference-inline-j .= new(:number($number-j));
    my IncludeLine::Request['Reference'] $request-j .= new(
        :reference-inline($reference-inline-j)
    );
    my &resolve-j;
    my IncludeLine::Resolver['Reference'] $resolver-j .= new(
        :resolve(&resolve-j)
    );
    my IncludeLine['Finn'] $include-line-j .= new(
        :request($request-j),
        :resolver($resolver-j)
    );

    # --- end include-line-j }}}
    # --- include-line-k {{{

    my UInt:D $number-k = 2;
    my ReferenceInline $reference-inline-k .= new(:number($number-k));
    my IncludeLine::Request['Reference'] $request-k .= new(
        :reference-inline($reference-inline-k)
    );
    my &resolve-k;
    my IncludeLine::Resolver['Reference'] $resolver-k .= new(
        :resolve(&resolve-k)
    );
    my IncludeLine['Text'] $include-line-k .= new(
        :request($request-k),
        :resolver($resolver-k)
    );

    # --- end include-line-k }}}

    my IncludeLine:D @include-line =
        $include-line-a,
        $include-line-b,
        $include-line-c,
        $include-line-d,
        $include-line-e,
        $include-line-f,
        $include-line-g,
        $include-line-h,
        $include-line-i,
        $include-line-j,
        $include-line-k;

    cmp-ok(
        Finn::Parser::Grammar.parse($include-line-block, :$rule, :$actions).made,
        &cmp-ok-include-line-block,
        IncludeLineBlock['HorizontalRule'].new(:$horizontal-rule, :@include-line),
        'IncludeLineBlock OK'
    );
});

sub cmp-ok-include-line-block(
    IncludeLineBlock:D $a,
    IncludeLineBlock:D $b
    --> Bool:D
)
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
