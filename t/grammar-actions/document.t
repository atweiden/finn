use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 2;

subtest 'finn-examples/app',
{
    my Str:D $document = 't/data/app/Story';
    my Finn::Parser::Actions $actions .= new(:file($document));
    my Finn::Parser::ParseTree:D $parse-tree =
        Finn::Parser::Grammar.parsefile($document, :$actions).made;

    # @chunk {{{

    # --- chunk-a {{{

    my Chunk::Meta::Bounds:D $bounds-a = gen-bounds();
    my UInt:D $section-a = 0;

    my Str:D $text-a =
        ' vim: set filetype=finn foldmethod=marker foldlevel=0: ';
    my Comment:D $comment-a .= new(:text($text-a));

    my CommentBlock:D $comment-block-a .= new(:comment($comment-a));

    my Chunk['CommentBlock'] $chunk-a .= new(
        :bounds($bounds-a),
        :section($section-a),
        :comment-block($comment-block-a)
    );

    # --- end chunk-a }}}
    # --- chunk-b {{{

    my Chunk::Meta::Bounds:D $bounds-b = gen-bounds();
    my UInt:D $section-b = 0;

    my Str:D $blank-line-text-b = '';
    my BlankLine:D $blank-line-b .= new(:text($blank-line-text-b));

    my Str:D $header-text-b = 'Your App or Library Name Goes Here';
    my Header[1] $header-b .= new(:text($header-text-b));

    my HeaderBlock['BlankLine'] $header-block-b .= new(
        :blank-line($blank-line-b),
        :header($header-b)
    );

    my Chunk['HeaderBlock'] $chunk-b .= new(
        :bounds($bounds-b),
        :section($section-b),
        :header-block($header-block-b)
    );

    # --- end chunk-b }}}
    # --- chunk-c {{{

    my Chunk::Meta::Bounds:D $bounds-c = gen-bounds();
    my UInt:D $section-c = 0;

    my Str:D $blank-line-text-c = '';
    my BlankLine:D $blank-line-c .= new(:text($blank-line-text-c));

    my Str:D $header-text-c = 'Introduction';
    my Header[2] $header-c .= new(:text($header-text-c));

    my HeaderBlock['BlankLine'] $header-block-c .= new(
        :blank-line($blank-line-c),
        :header($header-c)
    );

    my Chunk['HeaderBlock'] $chunk-c .= new(
        :bounds($bounds-c),
        :section($section-c),
        :header-block($header-block-c)
    );

    # --- end chunk-c }}}
    # --- chunk-d {{{

    my Chunk::Meta::Bounds:D $bounds-d = gen-bounds();
    my UInt:D $section-d = 0;

    my Str:D $blank-line-text-d = '';
    my BlankLine $blank-line-d .= new(:text($blank-line-text-d));

    my Chunk['BlankLine'] $chunk-d .= new(
        :bounds($bounds-d),
        :section($section-d),
        :blank-line($blank-line-d)
    );

    # --- end chunk-d }}}
    # --- chunk-e {{{

    my Chunk::Meta::Bounds:D $bounds-e = gen-bounds();
    my UInt:D $section-e = 0;

    my Str:D $paragraph-text-e = q:to/EOF/.trim-trailing;
    The `Story` file is the self-contained story of the software being
    assembled by Finn. All content must be assembled from this file.
    EOF
    my Paragraph $paragraph-e .= new(:text($paragraph-text-e));

    my Chunk['Paragraph'] $chunk-e .= new(
        :bounds($bounds-e),
        :section($section-e),
        :paragraph($paragraph-e)
    );

    # --- end chunk-e }}}
    # --- chunk-f {{{

    my Chunk::Meta::Bounds:D $bounds-f = gen-bounds();
    my UInt:D $section-f = 0;

    my Str:D $blank-line-text-f = '';
    my BlankLine $blank-line-f .= new(:text($blank-line-text-f));

    my Chunk['BlankLine'] $chunk-f .= new(
        :bounds($bounds-f),
        :section($section-f),
        :blank-line($blank-line-f)
    );

    # --- end chunk-f }}}
    # --- chunk-g {{{

    my Chunk::Meta::Bounds:D $bounds-g = gen-bounds();
    my UInt:D $section-g = 0;

    my Str:D $paragraph-text-g = q:to/EOF/.trim-trailing;
    We'll begin by constructing the project's readme and licensing files,
    then move on to constructing the app's library.
    EOF
    my Paragraph $paragraph-g .= new(:text($paragraph-text-g));

    my Chunk['Paragraph'] $chunk-g .= new(
        :bounds($bounds-g),
        :section($section-g),
        :paragraph($paragraph-g)
    );

    # --- end chunk-g }}}
    # --- chunk-h {{{

    my Chunk::Meta::Bounds:D $bounds-h = gen-bounds();
    my UInt:D $section-h = 0;

    my Str:D $blank-line-text-h = '';
    my BlankLine $blank-line-h .= new(:text($blank-line-text-h));

    my Chunk['BlankLine'] $chunk-h .= new(
        :bounds($bounds-h),
        :section($section-h),
        :blank-line($blank-line-h)
    );

    # --- end chunk-h }}}
    # --- chunk-i {{{

    my Chunk::Meta::Bounds:D $bounds-i = gen-bounds();
    my UInt:D $section-i = 0;

    my HorizontalRule['Soft'] $horizontal-rule-i .= new;

    my Chunk['HorizontalRule'] $chunk-i .= new(
        :bounds($bounds-i),
        :section($section-i),
        :horizontal-rule($horizontal-rule-i)
    );

    # --- end chunk-i }}}
    # --- chunk-j {{{

    my Chunk::Meta::Bounds:D $bounds-j = gen-bounds();
    my UInt:D $section-j = 0;

    my Str:D $blank-line-text-j = '';
    my BlankLine $blank-line-j .= new(:text($blank-line-text-j));

    my IO::Path $path-j .= new('/finn/README.md.finn');
    my File['Absolute'] $file-j .= new(:path($path-j));
    my SectionalInline['File'] $sectional-inline-j .= new(:file($file-j));

    my SectionalInline:D @sectional-inline-j = $sectional-inline-j;

    my SectionalInlineBlock['BlankLine'] $sectional-inline-block-j .= new(
        :blank-line($blank-line-j),
        :sectional-inline(@sectional-inline-j)
    );

    my Chunk['SectionalInlineBlock'] $chunk-j .= new(
        :bounds($bounds-j),
        :section($section-j),
        :sectional-inline-block($sectional-inline-block-j)
    );

    # --- end chunk-j }}}
    # --- chunk-k {{{

    my Chunk::Meta::Bounds:D $bounds-k = gen-bounds();
    my UInt:D $section-k = 0;

    my Str:D $blank-line-text-k = '';
    my BlankLine $blank-line-k .= new(:text($blank-line-text-k));

    my Chunk['BlankLine'] $chunk-k .= new(
        :bounds($bounds-k),
        :section($section-k),
        :blank-line($blank-line-k)
    );

    # --- end chunk-k }}}
    # --- chunk-l {{{

    my Chunk::Meta::Bounds:D $bounds-l = gen-bounds();
    my UInt:D $section-l = 0;

    my HorizontalRule['Soft'] $horizontal-rule-l .= new;

    my Chunk['HorizontalRule'] $chunk-l .= new(
        :bounds($bounds-l),
        :section($section-l),
        :horizontal-rule($horizontal-rule-l)
    );

    # --- end chunk-l }}}
    # --- chunk-m {{{

    my Chunk::Meta::Bounds:D $bounds-m = gen-bounds();
    my UInt:D $section-m = 0;

    my Str:D $blank-line-text-m = '';
    my BlankLine $blank-line-m .= new(:text($blank-line-text-m));

    my IO::Path $path-m .= new('/finn/UNLICENSE.finn');
    my File['Absolute'] $file-m .= new(:path($path-m));
    my SectionalInline['File'] $sectional-inline-m .= new(:file($file-m));

    my SectionalInline:D @sectional-inline-m = $sectional-inline-m;

    my SectionalInlineBlock['BlankLine'] $sectional-inline-block-m .= new(
        :blank-line($blank-line-m),
        :sectional-inline(@sectional-inline-m)
    );

    my Chunk['SectionalInlineBlock'] $chunk-m .= new(
        :bounds($bounds-m),
        :section($section-m),
        :sectional-inline-block($sectional-inline-block-m)
    );

    # --- end chunk-m }}}
    # --- chunk-n {{{

    my Chunk::Meta::Bounds:D $bounds-n = gen-bounds();
    my UInt:D $section-n = 0;

    my Str:D $blank-line-text-n = '';
    my BlankLine $blank-line-n .= new(:text($blank-line-text-n));

    my Chunk['BlankLine'] $chunk-n .= new(
        :bounds($bounds-n),
        :section($section-n),
        :blank-line($blank-line-n)
    );

    # --- end chunk-n }}}
    # --- chunk-o {{{

    my Chunk::Meta::Bounds:D $bounds-o = gen-bounds();
    my UInt:D $section-o = 0;

    my HorizontalRule['Soft'] $horizontal-rule-o .= new;

    my Chunk['HorizontalRule'] $chunk-o .= new(
        :bounds($bounds-o),
        :section($section-o),
        :horizontal-rule($horizontal-rule-o)
    );

    # --- end chunk-o }}}
    # --- chunk-p {{{

    my Chunk::Meta::Bounds:D $bounds-p = gen-bounds();
    my UInt:D $section-p = 0;

    my Str:D $blank-line-text-p = '';
    my BlankLine $blank-line-p .= new(:text($blank-line-text-p));

    my IO::Path $path-p .= new('/finn/lib/App.pm.finn');
    my File['Absolute'] $file-p .= new(:path($path-p));
    my SectionalInline['File'] $sectional-inline-p .= new(:file($file-p));

    my SectionalInline:D @sectional-inline-p = $sectional-inline-p;

    my SectionalInlineBlock['BlankLine'] $sectional-inline-block-p .= new(
        :blank-line($blank-line-p),
        :sectional-inline(@sectional-inline-p)
    );

    my Chunk['SectionalInlineBlock'] $chunk-p .= new(
        :bounds($bounds-p),
        :section($section-p),
        :sectional-inline-block($sectional-inline-block-p)
    );

    # --- end chunk-p }}}
    # --- chunk-q {{{

    my Chunk::Meta::Bounds:D $bounds-q = gen-bounds();
    my UInt:D $section-q = 0;

    my Str:D $blank-line-text-q = '';
    my BlankLine $blank-line-q .= new(:text($blank-line-text-q));

    my Chunk['BlankLine'] $chunk-q .= new(
        :bounds($bounds-q),
        :section($section-q),
        :blank-line($blank-line-q)
    );

    # --- end chunk-q }}}
    # --- chunk-r {{{

    my Chunk::Meta::Bounds:D $bounds-r = gen-bounds();
    my UInt:D $section-r = 0;

    my HorizontalRule['Soft'] $horizontal-rule-r .= new;

    my Chunk['HorizontalRule'] $chunk-r .= new(
        :bounds($bounds-r),
        :section($section-r),
        :horizontal-rule($horizontal-rule-r)
    );

    # --- end chunk-r }}}

    my Chunk:D @chunk =
        $chunk-a,
        $chunk-b,
        $chunk-c,
        $chunk-d,
        $chunk-e,
        $chunk-f,
        $chunk-g,
        $chunk-h,
        $chunk-i,
        $chunk-j,
        $chunk-k,
        $chunk-l,
        $chunk-m,
        $chunk-n,
        $chunk-o,
        $chunk-p,
        $chunk-q,
        $chunk-r;

    # end @chunk }}}
    # @chunk tests {{{

    cmp-ok $parse-tree.document.chunk[$_], &cmp-ok-chunk, @chunk[$_], 'Chunk OK'
        for (0..17);
    ok $parse-tree.document.chunk[18].not;

    # end @chunk tests }}}

    my Document $d .= new(:@chunk);
    is-deeply $parse-tree.document, $d, 'Document OK';

    my Finn::Parser::ParseTree $t .= new(:document($d));
    is-deeply $parse-tree, $t, 'ParseTree OK';
}

subtest 'finn-examples/hangman',
{
    my Str:D $document = 't/data/hangman/Story';
    my Finn::Parser::Actions $actions .= new(:file($document));
    my Finn::Parser::ParseTree:D $parse-tree =
        Finn::Parser::Grammar.parsefile($document, :$actions).made;

    # @chunk {{{

    # --- chunk-a {{{

    my Chunk::Meta::Bounds:D $bounds-a = gen-bounds();
    my UInt:D $section-a = 0;

    my Str:D $text-a =
        ' vim: set filetype=finn foldmethod=marker foldlevel=0: ';
    my Comment:D $comment-a .= new(:text($text-a));

    my CommentBlock:D $comment-block-a .= new(:comment($comment-a));

    my Chunk['CommentBlock'] $chunk-a .= new(
        :bounds($bounds-a),
        :section($section-a),
        :comment-block($comment-block-a)
    );

    # --- end chunk-a }}}
    # --- chunk-b {{{

    my Chunk::Meta::Bounds:D $bounds-b = gen-bounds();
    my UInt:D $section-b = 0;

    my Str:D $blank-line-text-b = '';
    my BlankLine:D $blank-line-b .= new(:text($blank-line-text-b));

    my Str:D $header-text-b = 'Hangman';
    my Header[1] $header-b .= new(:text($header-text-b));

    my HeaderBlock['BlankLine'] $header-block-b .= new(
        :blank-line($blank-line-b),
        :header($header-b)
    );

    my Chunk['HeaderBlock'] $chunk-b .= new(
        :bounds($bounds-b),
        :section($section-b),
        :header-block($header-block-b)
    );

    # --- end chunk-b }}}
    # --- chunk-c {{{

    my Chunk::Meta::Bounds:D $bounds-c = gen-bounds();
    my UInt:D $section-c = 0;

    my Str:D $blank-line-text-c = '';
    my BlankLine:D $blank-line-c .= new(:text($blank-line-text-c));

    my Str:D $header-text-c = 'Introduction';
    my Header[2] $header-c .= new(:text($header-text-c));

    my HeaderBlock['BlankLine'] $header-block-c .= new(
        :blank-line($blank-line-c),
        :header($header-c)
    );

    my Chunk['HeaderBlock'] $chunk-c .= new(
        :bounds($bounds-c),
        :section($section-c),
        :header-block($header-block-c)
    );

    # --- end chunk-c }}}
    # --- chunk-d {{{

    my Chunk::Meta::Bounds:D $bounds-d = gen-bounds();
    my UInt:D $section-d = 0;

    my Str:D $blank-line-text-d = '';
    my BlankLine $blank-line-d .= new(:text($blank-line-text-d));

    my Chunk['BlankLine'] $chunk-d .= new(
        :bounds($bounds-d),
        :section($section-d),
        :blank-line($blank-line-d)
    );

    # --- end chunk-d }}}
    # --- chunk-e {{{

    my Chunk::Meta::Bounds:D $bounds-e = gen-bounds();
    my UInt:D $section-e = 0;

    my Str:D $paragraph-text-e = q:to/EOF/.trim-trailing;
    This is a Hangman program written in Perl6 [1]. It lets you make guesses
    about which letters are in an unknown word. On the eighth incorrect
    guess you lose.
    EOF
    my Paragraph $paragraph-e .= new(:text($paragraph-text-e));

    my Chunk['Paragraph'] $chunk-e .= new(
        :bounds($bounds-e),
        :section($section-e),
        :paragraph($paragraph-e)
    );

    # --- end chunk-e }}}
    # --- chunk-f {{{

    my Chunk::Meta::Bounds:D $bounds-f = gen-bounds();
    my UInt:D $section-f = 0;

    my Str:D $blank-line-text-f = '';
    my BlankLine:D $blank-line-f .= new(:text($blank-line-text-f));

    my Str:D $header-text-f = q:to/EOF/.trim-trailing;
    The structure of the hangman program will look like this:
    EOF
    my Header[3] $header-f .= new(:text($header-text-f));

    my HeaderBlock['BlankLine'] $header-block-f .= new(
        :blank-line($blank-line-f),
        :header($header-f)
    );

    my Chunk['HeaderBlock'] $chunk-f .= new(
        :bounds($bounds-f),
        :section($section-f),
        :header-block($header-block-f)
    );

    # --- end chunk-f }}}
    # --- chunk-g {{{

    my Chunk::Meta::Bounds:D $bounds-g = gen-bounds();
    my UInt:D $section-g = 0;

    my Str:D $blank-line-text-g = '';
    my BlankLine $blank-line-g .= new(:text($blank-line-text-g));

    my Chunk['BlankLine'] $chunk-g .= new(
        :bounds($bounds-g),
        :section($section-g),
        :blank-line($blank-line-g)
    );

    # --- end chunk-g }}}
    # --- chunk-h {{{

    my Chunk::Meta::Bounds:D $bounds-h = gen-bounds();
    my UInt:D $section-h = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-h .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my IO::Path $path-h .= new('/hangman.pl6');
    my File['Absolute'] $file-h .= new(:path($path-h));
    my SectionalBlockName::Identifier['File'] $identifier-h .= new(
        :file($file-h)
    );
    my SectionalBlockName $name-h .= new(:identifier($identifier-h));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-h01 = q:to/EOF/.trim-trailing;
    'Welcome to hangman!'.say;
    EOF
    my SectionalBlockContent['Text'] $content-h01 .= new(:text($text-h01));

    # --- --- --- end 01 }}}
    # --- --- --- 02 {{{

    my Str:D $sectional-inline-name-h02 = 'Setup';
    my SectionalInline['Name'] $sectional-inline-h02 .= new(
        :name($sectional-inline-name-h02)
    );
    my SectionalBlockContent['SectionalInline'] $content-h02 .= new(
        :sectional-inline($sectional-inline-h02)
    );

    # --- --- --- end 02 }}}
    # --- --- --- 03 {{{

    my Str:D $text-h03 = q:to/EOF/.trim-trailing;
    my UInt:D $lives-left = 8;
    while $lives-left > 0
    {
    EOF
    my SectionalBlockContent['Text'] $content-h03 .= new(:text($text-h03));

    # --- --- --- end 03 }}}
    # --- --- --- 04 {{{

    my Str:D $sectional-inline-name-h04 = 'User input';
    my SectionalInline['Name'] $sectional-inline-h04 .= new(
        :name($sectional-inline-name-h04)
    );
    my SectionalBlockContent['SectionalInline'] $content-h04 .= new(
        :sectional-inline($sectional-inline-h04)
    );

    # --- --- --- end 04 }}}
    # --- --- --- 05 {{{

    my Str:D $sectional-inline-name-h05 = 'Check input';
    my SectionalInline['Name'] $sectional-inline-h05 .= new(
        :name($sectional-inline-name-h05)
    );
    my SectionalBlockContent['SectionalInline'] $content-h05 .= new(
        :sectional-inline($sectional-inline-h05)
    );

    # --- --- --- end 05 }}}
    # --- --- --- 06 {{{

    my Str:D $sectional-inline-name-h06 = 'Check win';
    my SectionalInline['Name'] $sectional-inline-h06 .= new(
        :name($sectional-inline-name-h06)
    );
    my SectionalBlockContent['SectionalInline'] $content-h06 .= new(
        :sectional-inline($sectional-inline-h06)
    );

    # --- --- --- end 06 }}}
    # --- --- --- 07 {{{

    my Str:D $text-h07 = "}\n";
    my SectionalBlockContent['Text'] $content-h07 .= new(:text($text-h07));

    # --- --- --- end 07 }}}
    # --- --- --- 08 {{{

    my Str:D $sectional-inline-name-h08 = 'End';
    my SectionalInline['Name'] $sectional-inline-h08 .= new(
        :name($sectional-inline-name-h08)
    );
    my SectionalBlockContent['SectionalInline'] $content-h08 .= new(
        :sectional-inline($sectional-inline-h08)
    );

    # --- --- --- end 08 }}}

    my SectionalBlockContent:D @content-h =
        $content-h01,
        $content-h02,
        $content-h03,
        $content-h04,
        $content-h05,
        $content-h06,
        $content-h07,
        $content-h08;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-h .= new(
        :delimiter($delimiter-h),
        :name($name-h),
        :content(@content-h)
    );

    my Chunk['SectionalBlock'] $chunk-h .= new(
        :bounds($bounds-h),
        :section($section-h),
        :sectional-block($sectional-block-h)
    );

    # --- end chunk-h }}}
    # --- chunk-i {{{

    my Chunk::Meta::Bounds:D $bounds-i = gen-bounds();
    my UInt:D $section-i = 0;

    my Str:D $blank-line-text-i = '';
    my BlankLine $blank-line-i .= new(:text($blank-line-text-i));

    my Chunk['BlankLine'] $chunk-i .= new(
        :bounds($bounds-i),
        :section($section-i),
        :blank-line($blank-line-i)
    );

    # --- end chunk-i }}}
    # --- chunk-j {{{

    my Chunk::Meta::Bounds:D $bounds-j = gen-bounds();
    my UInt:D $section-j = 0;

    my Str:D $blank-line-text-j = '';
    my BlankLine:D $blank-line-j .= new(:text($blank-line-text-j));

    my Str:D $header-text-j = 'The Setup';
    my Header[2] $header-j .= new(:text($header-text-j));

    my HeaderBlock['BlankLine'] $header-block-j .= new(
        :blank-line($blank-line-j),
        :header($header-j)
    );

    my Chunk['HeaderBlock'] $chunk-j .= new(
        :bounds($bounds-j),
        :section($section-j),
        :header-block($header-block-j)
    );

    # --- end chunk-j }}}
    # --- chunk-k {{{

    my Chunk::Meta::Bounds:D $bounds-k = gen-bounds();
    my UInt:D $section-k = 0;

    my Str:D $blank-line-text-k = '';
    my BlankLine $blank-line-k .= new(:text($blank-line-text-k));

    my Chunk['BlankLine'] $chunk-k .= new(
        :bounds($bounds-k),
        :section($section-k),
        :blank-line($blank-line-k)
    );

    # --- end chunk-k }}}
    # --- chunk-l {{{

    my Chunk::Meta::Bounds:D $bounds-l = gen-bounds();
    my UInt:D $section-l = 0;

    my Str:D $paragraph-text-l = q:to/EOF/.trim-trailing;
    First, we have the computer come up with a secret word which it chooses
    randomly from a list of words read from a text file.
    EOF
    my Paragraph $paragraph-l .= new(:text($paragraph-text-l));

    my Chunk['Paragraph'] $chunk-l .= new(
        :bounds($bounds-l),
        :section($section-l),
        :paragraph($paragraph-l)
    );

    # --- end chunk-l }}}
    # --- chunk-m {{{

    my Chunk::Meta::Bounds:D $bounds-m = gen-bounds();
    my UInt:D $section-m = 0;

    my Str:D $blank-line-text-m = '';
    my BlankLine $blank-line-m .= new(:text($blank-line-text-m));

    my Chunk['BlankLine'] $chunk-m .= new(
        :bounds($bounds-m),
        :section($section-m),
        :blank-line($blank-line-m)
    );

    # --- end chunk-m }}}
    # --- chunk-n {{{

    my Chunk::Meta::Bounds:D $bounds-n = gen-bounds();
    my UInt:D $section-n = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-n .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-n = 'Setup';
    my SectionalBlockName::Identifier['Word'] $identifier-n .= new(
        :word($word-n)
    );
    my SectionalBlockName $name-n .= new(:identifier($identifier-n));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-n01 = q:to/EOF/.trim-trailing;
    my Str:D @words = 'words.txt'.IO.lines.split(/\s+/);
    my Str:D $secret-word = @words.pick;
    EOF
    my SectionalBlockContent['Text'] $content-n01 .= new(:text($text-n01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-n = $content-n01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-n .= new(
        :delimiter($delimiter-n),
        :name($name-n),
        :content(@content-n)
    );

    my Chunk['SectionalBlock'] $chunk-n .= new(
        :bounds($bounds-n),
        :section($section-n),
        :sectional-block($sectional-block-n)
    );

    # --- end chunk-n }}}
    # --- chunk-o {{{

    my Chunk::Meta::Bounds:D $bounds-o = gen-bounds();
    my UInt:D $section-o = 0;

    my Str:D $blank-line-text-o = '';
    my BlankLine $blank-line-o .= new(:text($blank-line-text-o));

    my Chunk['BlankLine'] $chunk-o .= new(
        :bounds($bounds-o),
        :section($section-o),
        :blank-line($blank-line-o)
    );

    # --- end chunk-o }}}
    # --- chunk-p {{{

    my Chunk::Meta::Bounds:D $bounds-p = gen-bounds();
    my UInt:D $section-p = 0;

    my Str:D $paragraph-text-p = q:to/EOF/.trim-trailing;
    Next we initialize the variable to hold the dashes.
    EOF
    my Paragraph $paragraph-p .= new(:text($paragraph-text-p));

    my Chunk['Paragraph'] $chunk-p .= new(
        :bounds($bounds-p),
        :section($section-p),
        :paragraph($paragraph-p)
    );

    # --- end chunk-p }}}
    # --- chunk-q {{{

    my Chunk::Meta::Bounds:D $bounds-q = gen-bounds();
    my UInt:D $section-q = 0;

    my Str:D $blank-line-text-q = '';
    my BlankLine $blank-line-q .= new(:text($blank-line-text-q));

    my Chunk['BlankLine'] $chunk-q .= new(
        :bounds($bounds-q),
        :section($section-q),
        :blank-line($blank-line-q)
    );

    # --- end chunk-q }}}
    # --- chunk-r {{{

    my Chunk::Meta::Bounds:D $bounds-r = gen-bounds();
    my UInt:D $section-r = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-r .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-r = 'Setup';
    my SectionalBlockName::Identifier['Word'] $identifier-r .= new(
        :word($word-r)
    );
    my SectionalBlockName::Operator['Additive'] $operator-r .= new;
    my SectionalBlockName $name-r .= new(
        :identifier($identifier-r),
        :operator($operator-r)
    );

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-r01 = q:to/EOF/.trim-trailing;
    my Str:D @dashes = ('-' x $secret-word.chars).comb;
    EOF
    my SectionalBlockContent['Text'] $content-r01 .= new(:text($text-r01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-r = $content-r01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-r .= new(
        :delimiter($delimiter-r),
        :name($name-r),
        :content(@content-r)
    );

    my Chunk['SectionalBlock'] $chunk-r .= new(
        :bounds($bounds-r),
        :section($section-r),
        :sectional-block($sectional-block-r)
    );

    # --- end chunk-r }}}
    # --- chunk-s {{{

    my Chunk::Meta::Bounds:D $bounds-s = gen-bounds();
    my UInt:D $section-s = 0;

    my Str:D $blank-line-text-s = '';
    my BlankLine $blank-line-s .= new(:text($blank-line-text-s));

    my Chunk['BlankLine'] $chunk-s .= new(
        :bounds($bounds-s),
        :section($section-s),
        :blank-line($blank-line-s)
    );

    # --- end chunk-s }}}
    # --- chunk-t {{{

    my Chunk::Meta::Bounds:D $bounds-t = gen-bounds();
    my UInt:D $section-t = 0;

    my Str:D $blank-line-text-t = '';
    my BlankLine:D $blank-line-t .= new(:text($blank-line-text-t));

    my Str:D $header-text-t = 'Getting User Input';
    my Header[2] $header-t .= new(:text($header-text-t));

    my HeaderBlock['BlankLine'] $header-block-t .= new(
        :blank-line($blank-line-t),
        :header($header-t)
    );

    my Chunk['HeaderBlock'] $chunk-t .= new(
        :bounds($bounds-t),
        :section($section-t),
        :header-block($header-block-t)
    );

    # --- end chunk-t }}}
    # --- chunk-u {{{

    my Chunk::Meta::Bounds:D $bounds-u = gen-bounds();
    my UInt:D $section-u = 0;

    my Str:D $blank-line-text-u = '';
    my BlankLine $blank-line-u .= new(:text($blank-line-text-u));

    my Chunk['BlankLine'] $chunk-u .= new(
        :bounds($bounds-u),
        :section($section-u),
        :blank-line($blank-line-u)
    );

    # --- end chunk-u }}}
    # --- chunk-v {{{

    my Chunk::Meta::Bounds:D $bounds-v = gen-bounds();
    my UInt:D $section-v = 0;

    my Str:D $paragraph-text-v = q:to/EOF/.trim-trailing;
    Now we can start the game. We ask for the user's guess and store it in
    the `$guess` variable.
    EOF
    my Paragraph $paragraph-v .= new(:text($paragraph-text-v));

    my Chunk['Paragraph'] $chunk-v .= new(
        :bounds($bounds-v),
        :section($section-v),
        :paragraph($paragraph-v)
    );

    # --- end chunk-v }}}
    # --- chunk-w {{{

    my Chunk::Meta::Bounds:D $bounds-w = gen-bounds();
    my UInt:D $section-w = 0;

    my Str:D $blank-line-text-w = '';
    my BlankLine $blank-line-w .= new(:text($blank-line-text-w));

    my Chunk['BlankLine'] $chunk-w .= new(
        :bounds($bounds-w),
        :section($section-w),
        :blank-line($blank-line-w)
    );

    # --- end chunk-w }}}
    # --- chunk-x {{{

    my Chunk::Meta::Bounds:D $bounds-x = gen-bounds();
    my UInt:D $section-x = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-x .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-x = 'User input';
    my SectionalBlockName::Identifier['Word'] $identifier-x .= new(
        :word($word-x)
    );
    my SectionalBlockName $name-x .= new(:identifier($identifier-x));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $sectional-inline-name-x01 = 'print dashes array';
    my SectionalInline['Name'] $sectional-inline-x01 .= new(
        :name($sectional-inline-name-x01)
    );
    my SectionalBlockContent['SectionalInline'] $content-x01 .= new(
        :sectional-inline($sectional-inline-x01)
    );

    # --- --- --- end 01 }}}
    # --- --- --- 02 {{{

    my Str:D $text-x02 = q:to/EOF/.trim-trailing;
    "You have $lives-left lives left".say;
    "What's your guess? ".print;
    my Str:D $guess = $*IN.get;
    ''.say;
    EOF
    my SectionalBlockContent['Text'] $content-x02 .= new(:text($text-x02));

    # --- --- --- end 02 }}}

    my SectionalBlockContent:D @content-x = $content-x01, $content-x02;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-x .= new(
        :delimiter($delimiter-x),
        :name($name-x),
        :content(@content-x)
    );

    my Chunk['SectionalBlock'] $chunk-x .= new(
        :bounds($bounds-x),
        :section($section-x),
        :sectional-block($sectional-block-x)
    );

    # --- end chunk-x }}}
    # --- chunk-y {{{

    my Chunk::Meta::Bounds:D $bounds-y = gen-bounds();
    my UInt:D $section-y = 0;

    my Str:D $blank-line-text-y = '';
    my BlankLine $blank-line-y .= new(:text($blank-line-text-y));

    my Chunk['BlankLine'] $chunk-y .= new(
        :bounds($bounds-y),
        :section($section-y),
        :blank-line($blank-line-y)
    );

    # --- end chunk-y }}}
    # --- chunk-z {{{

    my Chunk::Meta::Bounds:D $bounds-z = gen-bounds();
    my UInt:D $section-z = 0;

    my Str:D $blank-line-text-z = '';
    my BlankLine:D $blank-line-z .= new(:text($blank-line-text-z));

    my Str:D $header-text-z = "Checking the User's Guess";
    my Header[2] $header-z .= new(:text($header-text-z));

    my HeaderBlock['BlankLine'] $header-block-z .= new(
        :blank-line($blank-line-z),
        :header($header-z)
    );

    my Chunk['HeaderBlock'] $chunk-z .= new(
        :bounds($bounds-z),
        :section($section-z),
        :header-block($header-block-z)
    );

    # --- end chunk-z }}}
    # --- chunk-ã {{{

    my Chunk::Meta::Bounds:D $bounds-ã = gen-bounds();
    my UInt:D $section-ã = 0;

    my Str:D $blank-line-text-ã = '';
    my BlankLine $blank-line-ã .= new(:text($blank-line-text-ã));

    my Chunk['BlankLine'] $chunk-ã .= new(
        :bounds($bounds-ã),
        :section($section-ã),
        :blank-line($blank-line-ã)
    );

    # --- end chunk-ã }}}
    # --- chunk-ḇ {{{

    my Chunk::Meta::Bounds:D $bounds-ḇ = gen-bounds();
    my UInt:D $section-ḇ = 0;

    my Str:D $paragraph-text-ḇ = q:to/EOF/.trim-trailing;
    We loop through the secret word, checking if any of its letters were
    guessed. If they were, reveal that letter in the dashes array. If
    none of the letters in secret word were equal to the guess, then
    `$got-one-correct` will be false, and one life will be deducted.
    EOF
    my Paragraph $paragraph-ḇ .= new(:text($paragraph-text-ḇ));

    my Chunk['Paragraph'] $chunk-ḇ .= new(
        :bounds($bounds-ḇ),
        :section($section-ḇ),
        :paragraph($paragraph-ḇ)
    );

    # --- end chunk-ḇ }}}
    # --- chunk-ç {{{

    my Chunk::Meta::Bounds:D $bounds-ç = gen-bounds();
    my UInt:D $section-ç = 0;

    my Str:D $blank-line-text-ç = '';
    my BlankLine $blank-line-ç .= new(:text($blank-line-text-ç));

    my Chunk['BlankLine'] $chunk-ç .= new(
        :bounds($bounds-ç),
        :section($section-ç),
        :blank-line($blank-line-ç)
    );

    # --- end chunk-ç }}}
    # --- chunk-ď {{{

    my Chunk::Meta::Bounds:D $bounds-ď = gen-bounds();
    my UInt:D $section-ď = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-ď .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-ď = 'Check input';
    my SectionalBlockName::Identifier['Word'] $identifier-ď .= new(
        :word($word-ď)
    );
    my SectionalBlockName $name-ď .= new(:identifier($identifier-ď));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-ď01 = q:to/EOF/.trim-trailing;
    my Bool:D $got-one-correct = False;
    loop (my UInt:D $i = 0; $i < $secret-word.chars; $i++)
    {
        if $secret-word.comb[$i] eq $guess
        {
            $got-one-correct = True;
            @dashes[$i] = $guess;
        }
    }

    $lives-left -= 1 unless $got-one-correct;
    EOF
    my SectionalBlockContent['Text'] $content-ď01 .= new(:text($text-ď01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-ď = $content-ď01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-ď .= new(
        :delimiter($delimiter-ď),
        :name($name-ď),
        :content(@content-ď)
    );

    my Chunk['SectionalBlock'] $chunk-ď .= new(
        :bounds($bounds-ď),
        :section($section-ď),
        :sectional-block($sectional-block-ď)
    );

    # --- end chunk-ď }}}
    # --- chunk-è {{{

    my Chunk::Meta::Bounds:D $bounds-è = gen-bounds();
    my UInt:D $section-è = 0;

    my Str:D $blank-line-text-è = '';
    my BlankLine $blank-line-è .= new(:text($blank-line-text-è));

    my Chunk['BlankLine'] $chunk-è .= new(
        :bounds($bounds-è),
        :section($section-è),
        :blank-line($blank-line-è)
    );

    # --- end chunk-è }}}
    # --- chunk-ḟ {{{

    my Chunk::Meta::Bounds:D $bounds-ḟ = gen-bounds();
    my UInt:D $section-ḟ = 0;

    my Str:D $blank-line-text-ḟ = '';
    my BlankLine:D $blank-line-ḟ .= new(:text($blank-line-text-ḟ));

    my Str:D $header-text-ḟ = 'Checking for Victory';
    my Header[2] $header-ḟ .= new(:text($header-text-ḟ));

    my HeaderBlock['BlankLine'] $header-block-ḟ .= new(
        :blank-line($blank-line-ḟ),
        :header($header-ḟ)
    );

    my Chunk['HeaderBlock'] $chunk-ḟ .= new(
        :bounds($bounds-ḟ),
        :section($section-ḟ),
        :header-block($header-block-ḟ)
    );

    # --- end chunk-ḟ }}}
    # --- chunk-ğ {{{

    my Chunk::Meta::Bounds:D $bounds-ğ = gen-bounds();
    my UInt:D $section-ğ = 0;

    my Str:D $blank-line-text-ğ = '';
    my BlankLine $blank-line-ğ .= new(:text($blank-line-text-ğ));

    my Chunk['BlankLine'] $chunk-ğ .= new(
        :bounds($bounds-ğ),
        :section($section-ğ),
        :blank-line($blank-line-ğ)
    );

    # --- end chunk-ğ }}}
    # --- chunk-ħ {{{

    my Chunk::Meta::Bounds:D $bounds-ħ = gen-bounds();
    my UInt:D $section-ħ = 0;

    my Str:D $paragraph-text-ħ = q:to/EOF/.trim-trailing;
    Now we should check if the user has guessed all the letters.
    EOF
    my Paragraph $paragraph-ħ .= new(:text($paragraph-text-ħ));

    my Chunk['Paragraph'] $chunk-ħ .= new(
        :bounds($bounds-ħ),
        :section($section-ħ),
        :paragraph($paragraph-ħ)
    );

    # --- end chunk-ħ }}}
    # --- chunk-ï {{{

    my Chunk::Meta::Bounds:D $bounds-ï = gen-bounds();
    my UInt:D $section-ï = 0;

    my Str:D $blank-line-text-ï = '';
    my BlankLine $blank-line-ï .= new(:text($blank-line-text-ï));

    my Chunk['BlankLine'] $chunk-ï .= new(
        :bounds($bounds-ï),
        :section($section-ï),
        :blank-line($blank-line-ï)
    );

    # --- end chunk-ï }}}
    # --- chunk-ĵ {{{

    my Chunk::Meta::Bounds:D $bounds-ĵ = gen-bounds();
    my UInt:D $section-ĵ = 0;

    my Str:D $paragraph-text-ĵ = q:to/EOF/.trim-trailing;
    Here we see if there are any dashes left in the array that holds the
    dashes. If there aren't, the user has won.
    EOF
    my Paragraph $paragraph-ĵ .= new(:text($paragraph-text-ĵ));

    my Chunk['Paragraph'] $chunk-ĵ .= new(
        :bounds($bounds-ĵ),
        :section($section-ĵ),
        :paragraph($paragraph-ĵ)
    );

    # --- end chunk-ĵ }}}
    # --- chunk-ķ {{{

    my Chunk::Meta::Bounds:D $bounds-ķ = gen-bounds();
    my UInt:D $section-ķ = 0;

    my Str:D $blank-line-text-ķ = '';
    my BlankLine $blank-line-ķ .= new(:text($blank-line-text-ķ));

    my Chunk['BlankLine'] $chunk-ķ .= new(
        :bounds($bounds-ķ),
        :section($section-ķ),
        :blank-line($blank-line-ķ)
    );

    # --- end chunk-ķ }}}
    # --- chunk-ł {{{

    my Chunk::Meta::Bounds:D $bounds-ł = gen-bounds();
    my UInt:D $section-ł = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-ł .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-ł = 'Check win';
    my SectionalBlockName::Identifier['Word'] $identifier-ł .= new(
        :word($word-ł)
    );
    my SectionalBlockName $name-ł .= new(:identifier($identifier-ł));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-ł01 = q:to/EOF/.trim-trailing;
    if @dashes.grep('-').not
    {
        "You win! The word was $secret-word".say;
        exit 0;
    }
    EOF
    my SectionalBlockContent['Text'] $content-ł01 .= new(:text($text-ł01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-ł = $content-ł01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-ł .= new(
        :delimiter($delimiter-ł),
        :name($name-ł),
        :content(@content-ł)
    );

    my Chunk['SectionalBlock'] $chunk-ł .= new(
        :bounds($bounds-ł),
        :section($section-ł),
        :sectional-block($sectional-block-ł)
    );

    # --- end chunk-ł }}}
    # --- chunk-ḿ {{{

    my Chunk::Meta::Bounds:D $bounds-ḿ = gen-bounds();
    my UInt:D $section-ḿ = 0;

    my Str:D $blank-line-text-ḿ = '';
    my BlankLine $blank-line-ḿ .= new(:text($blank-line-text-ḿ));

    my Chunk['BlankLine'] $chunk-ḿ .= new(
        :bounds($bounds-ḿ),
        :section($section-ḿ),
        :blank-line($blank-line-ḿ)
    );

    # --- end chunk-ḿ }}}
    # --- chunk-ñ {{{

    my Chunk::Meta::Bounds:D $bounds-ñ = gen-bounds();
    my UInt:D $section-ñ = 0;

    my Str:D $blank-line-text-ñ = '';
    my BlankLine:D $blank-line-ñ .= new(:text($blank-line-text-ñ));

    my Str:D $header-text-ñ = 'Pretty Printing the Dashes';
    my Header[2] $header-ñ .= new(:text($header-text-ñ));

    my HeaderBlock['BlankLine'] $header-block-ñ .= new(
        :blank-line($blank-line-ñ),
        :header($header-ñ)
    );

    my Chunk['HeaderBlock'] $chunk-ñ .= new(
        :bounds($bounds-ñ),
        :section($section-ñ),
        :header-block($header-block-ñ)
    );

    # --- end chunk-ñ }}}
    # --- chunk-ò {{{

    my Chunk::Meta::Bounds:D $bounds-ò = gen-bounds();
    my UInt:D $section-ò = 0;

    my Str:D $blank-line-text-ò = '';
    my BlankLine $blank-line-ò .= new(:text($blank-line-text-ò));

    my Chunk['BlankLine'] $chunk-ò .= new(
        :bounds($bounds-ò),
        :section($section-ò),
        :blank-line($blank-line-ò)
    );

    # --- end chunk-ò }}}
    # --- chunk-ṕ {{{

    my Chunk::Meta::Bounds:D $bounds-ṕ = gen-bounds();
    my UInt:D $section-ṕ = 0;

    my Str:D $paragraph-text-ṕ = q:to/EOF/.trim-trailing;
    We want the dashes to look pretty when they are printed, not look like
    an array of chars. Instead of `['-', '-', '-', '-']`, we want `----`.
    EOF
    my Paragraph $paragraph-ṕ .= new(:text($paragraph-text-ṕ));

    my Chunk['Paragraph'] $chunk-ṕ .= new(
        :bounds($bounds-ṕ),
        :section($section-ṕ),
        :paragraph($paragraph-ṕ)
    );

    # --- end chunk-ṕ }}}
    # --- chunk-ק {{{

    my Chunk::Meta::Bounds:D $bounds-ק = gen-bounds();
    my UInt:D $section-ק = 0;

    my Str:D $blank-line-text-ק = '';
    my BlankLine $blank-line-ק .= new(:text($blank-line-text-ק));

    my Chunk['BlankLine'] $chunk-ק .= new(
        :bounds($bounds-ק),
        :section($section-ק),
        :blank-line($blank-line-ק)
    );

    # --- end chunk-ק }}}
    # --- chunk-ŗ {{{

    my Chunk::Meta::Bounds:D $bounds-ŗ = gen-bounds();
    my UInt:D $section-ŗ = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-ŗ .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-ŗ = 'print dashes array';
    my SectionalBlockName::Identifier['Word'] $identifier-ŗ .= new(
        :word($word-ŗ)
    );
    my SectionalBlockName $name-ŗ .= new(:identifier($identifier-ŗ));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-ŗ01 = q:to/EOF/.trim-trailing;
    @dashes.join.say;
    EOF
    my SectionalBlockContent['Text'] $content-ŗ01 .= new(:text($text-ŗ01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-ŗ = $content-ŗ01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-ŗ .= new(
        :delimiter($delimiter-ŗ),
        :name($name-ŗ),
        :content(@content-ŗ)
    );

    my Chunk['SectionalBlock'] $chunk-ŗ .= new(
        :bounds($bounds-ŗ),
        :section($section-ŗ),
        :sectional-block($sectional-block-ŗ)
    );

    # --- end chunk-ŗ }}}
    # --- chunk-ś {{{

    my Chunk::Meta::Bounds:D $bounds-ś = gen-bounds();
    my UInt:D $section-ś = 0;

    my Str:D $blank-line-text-ś = '';
    my BlankLine $blank-line-ś .= new(:text($blank-line-text-ś));

    my Chunk['BlankLine'] $chunk-ś .= new(
        :bounds($bounds-ś),
        :section($section-ś),
        :blank-line($blank-line-ś)
    );

    # --- end chunk-ś }}}
    # --- chunk-ţ {{{

    my Chunk::Meta::Bounds:D $bounds-ţ = gen-bounds();
    my UInt:D $section-ţ = 0;

    my Str:D $blank-line-text-ţ = '';
    my BlankLine:D $blank-line-ţ .= new(:text($blank-line-text-ţ));

    my Str:D $header-text-ţ = 'The End';
    my Header[2] $header-ţ .= new(:text($header-text-ţ));

    my HeaderBlock['BlankLine'] $header-block-ţ .= new(
        :blank-line($blank-line-ţ),
        :header($header-ţ)
    );

    my Chunk['HeaderBlock'] $chunk-ţ .= new(
        :bounds($bounds-ţ),
        :section($section-ţ),
        :header-block($header-block-ţ)
    );

    # --- end chunk-ţ }}}
    # --- chunk-ú {{{

    my Chunk::Meta::Bounds:D $bounds-ú = gen-bounds();
    my UInt:D $section-ú = 0;

    my Str:D $blank-line-text-ú = '';
    my BlankLine $blank-line-ú .= new(:text($blank-line-text-ú));

    my Chunk['BlankLine'] $chunk-ú .= new(
        :bounds($bounds-ú),
        :section($section-ú),
        :blank-line($blank-line-ú)
    );

    # --- end chunk-ú }}}
    # --- chunk-ṽ {{{

    my Chunk::Meta::Bounds:D $bounds-ṽ = gen-bounds();
    my UInt:D $section-ṽ = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-ṽ .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my Str:D $word-ṽ = 'End';
    my SectionalBlockName::Identifier['Word'] $identifier-ṽ .= new(
        :word($word-ṽ)
    );
    my SectionalBlockName $name-ṽ .= new(:identifier($identifier-ṽ));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-ṽ01 = q:to/EOF/.trim-trailing;
    "You lose. The word was $secret-word".say;
    EOF
    my SectionalBlockContent['Text'] $content-ṽ01 .= new(:text($text-ṽ01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-ṽ = $content-ṽ01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-ṽ .= new(
        :delimiter($delimiter-ṽ),
        :name($name-ṽ),
        :content(@content-ṽ)
    );

    my Chunk['SectionalBlock'] $chunk-ṽ .= new(
        :bounds($bounds-ṽ),
        :section($section-ṽ),
        :sectional-block($sectional-block-ṽ)
    );

    # --- end chunk-ṽ }}}
    # --- chunk-ŵ {{{

    my Chunk::Meta::Bounds:D $bounds-ŵ = gen-bounds();
    my UInt:D $section-ŵ = 0;

    my Str:D $blank-line-text-ŵ = '';
    my BlankLine $blank-line-ŵ .= new(:text($blank-line-text-ŵ));

    my Chunk['BlankLine'] $chunk-ŵ .= new(
        :bounds($bounds-ŵ),
        :section($section-ŵ),
        :blank-line($blank-line-ŵ)
    );

    # --- end chunk-ŵ }}}
    # --- chunk-ẍ {{{

    my Chunk::Meta::Bounds:D $bounds-ẍ = gen-bounds();
    my UInt:D $section-ẍ = 0;

    my Str:D $blank-line-text-ẍ = '';
    my BlankLine:D $blank-line-ẍ .= new(:text($blank-line-text-ẍ));

    my Str:D $header-text-ẍ = 'Words';
    my Header[2] $header-ẍ .= new(:text($header-text-ẍ));

    my HeaderBlock['BlankLine'] $header-block-ẍ .= new(
        :blank-line($blank-line-ẍ),
        :header($header-ẍ)
    );

    my Chunk['HeaderBlock'] $chunk-ẍ .= new(
        :bounds($bounds-ẍ),
        :section($section-ẍ),
        :header-block($header-block-ẍ)
    );

    # --- end chunk-ẍ }}}
    # --- chunk-ý {{{

    my Chunk::Meta::Bounds:D $bounds-ý = gen-bounds();
    my UInt:D $section-ý = 0;

    my Str:D $blank-line-text-ý = '';
    my BlankLine $blank-line-ý .= new(:text($blank-line-text-ý));

    my Chunk['BlankLine'] $chunk-ý .= new(
        :bounds($bounds-ý),
        :section($section-ý),
        :blank-line($blank-line-ý)
    );

    # --- end chunk-ý }}}
    # --- chunk-ƶ {{{

    my Chunk::Meta::Bounds:D $bounds-ƶ = gen-bounds();
    my UInt:D $section-ƶ = 0;

    my Str:D $paragraph-text-ƶ = q:to/EOF/.trim-trailing;
    Here is the file containing all the words for the game. It's just a
    simple text file with words split by whitespace.
    EOF
    my Paragraph $paragraph-ƶ .= new(:text($paragraph-text-ƶ));

    my Chunk['Paragraph'] $chunk-ƶ .= new(
        :bounds($bounds-ƶ),
        :section($section-ƶ),
        :paragraph($paragraph-ƶ)
    );

    # --- end chunk-ƶ }}}
    # --- chunk-α {{{

    my Chunk::Meta::Bounds:D $bounds-α = gen-bounds();
    my UInt:D $section-α = 0;

    my Str:D $blank-line-text-α = '';
    my BlankLine $blank-line-α .= new(:text($blank-line-text-α));

    my Chunk['BlankLine'] $chunk-α .= new(
        :bounds($bounds-α),
        :section($section-α),
        :blank-line($blank-line-α)
    );

    # --- end chunk-α }}}
    # --- chunk-Ώ {{{

    my Chunk::Meta::Bounds:D $bounds-Ώ = gen-bounds();
    my UInt:D $section-Ώ = 0;

    # --- --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter-Ώ .= new;

    # --- --- end delimiter }}}
    # --- --- name {{{

    my IO::Path $path-Ώ .= new('/words.txt');
    my File['Absolute'] $file-Ώ .= new(:path($path-Ώ));
    my SectionalBlockName::Identifier['File'] $identifier-Ώ .= new(
        :file($file-Ώ)
    );
    my SectionalBlockName $name-Ώ .= new(:identifier($identifier-Ώ));

    # --- --- end name }}}
    # --- --- content {{{

    # --- --- --- 01 {{{

    my Str:D $text-Ώ01 = q:to/EOF/.trim-trailing;
    able about account acid across act addition adjustment
    advertisement after again against agreement almost among
    attempt attention attraction authority automatic awake
    baby back bad bag balance ball band base basin basket bath be
    beautiful because bed bee before behaviour belief bell
    bent berry between bird birth bit bite bitter black blade blood
    carriage cart cat cause certain chain chalk chance
    change cheap cheese chemical chest chief chin church circle clean clear
    clock cloth cloud coal coat cold collar colour comb
    come comfort committee common company comparison competition complete
    complex condition connection conscious control cook copper copy
    cord cork cotton cough country cover cow crack credit crime
    delicate dependent design desire destruction detail development
    different digestion direction dirty discovery discussion disease
    last late laugh law lead leaf learning leather left letter level
    library lift light like limit line linen lip liquid
    morning mother motion mountain mouth move much muscle music nail
    name narrow nation natural near necessary neck need needle
    private probable process produce profit property prose protest public
    pull pump punishment purpose push put quality question
    seem selection self send sense separate serious servant shade shake
    shame sharp sheep shelf ship shirt shock shoe short
    square stage stamp star start statement station steam steel stem step
    stick sticky stiff still stitch stocking stomach stone
    stop store story straight strange street stretch strong structure
    substance such sudden sugar suggestion summer sun support surprise
    very vessel view violent voice waiting walk wall war warm wash waste
    watch water wave wax way weather week weight well west
    wet wheel when where while whip whistle white who why wide will wind
    window wine wing winter wire wise with woman wood wool word
    work worm wound writing wrong year yellow yesterday young
    EOF
    my SectionalBlockContent['Text'] $content-Ώ01 .= new(:text($text-Ώ01));

    # --- --- --- end 01 }}}

    my SectionalBlockContent:D @content-Ώ = $content-Ώ01;

    # --- --- end content }}}

    my SectionalBlock $sectional-block-Ώ .= new(
        :delimiter($delimiter-Ώ),
        :name($name-Ώ),
        :content(@content-Ώ)
    );

    my Chunk['SectionalBlock'] $chunk-Ώ .= new(
        :bounds($bounds-Ώ),
        :section($section-Ώ),
        :sectional-block($sectional-block-Ώ)
    );

    # --- end chunk-Ώ }}}
    # --- chunk-Ψ {{{

    my Chunk::Meta::Bounds:D $bounds-Ψ = gen-bounds();
    my UInt:D $section-Ψ = 0;

    my Str:D $blank-line-text-Ψ = '';
    my BlankLine $blank-line-Ψ .= new(:text($blank-line-text-Ψ));

    my Chunk['BlankLine'] $chunk-Ψ .= new(
        :bounds($bounds-Ψ),
        :section($section-Ψ),
        :blank-line($blank-line-Ψ)
    );

    # --- end chunk-Ψ }}}
    # --- chunk-Θ {{{

    my Chunk::Meta::Bounds:D $bounds-Θ = gen-bounds();
    my UInt:D $section-Θ = 0;

    my Str:D $blank-line-text-Θ = '';
    my BlankLine $blank-line-Θ .= new(:text($blank-line-text-Θ));

    my Chunk['BlankLine'] $chunk-Θ .= new(
        :bounds($bounds-Θ),
        :section($section-Θ),
        :blank-line($blank-line-Θ)
    );

    # --- end chunk-Θ }}}
    # --- chunk-Δ {{{

    my Chunk::Meta::Bounds:D $bounds-Δ = gen-bounds();
    my UInt:D $section-Δ = 0;

    my HorizontalRule['Hard'] $horizontal-rule-Δ .= new;

    my Chunk['HorizontalRule'] $chunk-Δ .= new(
        :bounds($bounds-Δ),
        :section($section-Δ),
        :horizontal-rule($horizontal-rule-Δ)
    );

    # --- end chunk-Δ }}}
    # --- chunk-ж {{{

    my Chunk::Meta::Bounds:D $bounds-ж = gen-bounds();
    my UInt:D $section-ж = 0;

    my Str:D $blank-line-text-ж = '';
    my BlankLine $blank-line-ж .= new(:text($blank-line-text-ж));

    my UInt:D $number-ж = 1;
    my ReferenceInline $reference-inline-ж .= new(:number($number-ж));
    my Str:D $reference-text-ж =
        'https://github.com/zyedidia/Literate/blob/master/examples/hangman.lit';
    my ReferenceLine $reference-line-ж .= new(
        :reference-inline($reference-inline-ж),
        :reference-text($reference-text-ж)
    );

    my ReferenceLine:D @reference-line-ж = $reference-line-ж;

    my ReferenceLineBlock['BlankLine'] $reference-line-block-ж .= new(
        :blank-line($blank-line-ж),
        :reference-line(@reference-line-ж)
    );

    my Chunk['ReferenceLineBlock'] $chunk-ж .= new(
        :bounds($bounds-ж),
        :section($section-ж),
        :reference-line-block($reference-line-block-ж)
    );

    # --- end chunk-ж }}}

    my Chunk:D @chunk =
        $chunk-a,
        $chunk-b,
        $chunk-c,
        $chunk-d,
        $chunk-e,
        $chunk-f,
        $chunk-g,
        $chunk-h,
        $chunk-i,
        $chunk-j,
        $chunk-k,
        $chunk-l,
        $chunk-m,
        $chunk-n,
        $chunk-o,
        $chunk-p,
        $chunk-q,
        $chunk-r,
        $chunk-s,
        $chunk-t,
        $chunk-u,
        $chunk-v,
        $chunk-w,
        $chunk-x,
        $chunk-y,
        $chunk-z,
        $chunk-ã,
        $chunk-ḇ,
        $chunk-ç,
        $chunk-ď,
        $chunk-è,
        $chunk-ḟ,
        $chunk-ğ,
        $chunk-ħ,
        $chunk-ï,
        $chunk-ĵ,
        $chunk-ķ,
        $chunk-ł,
        $chunk-ḿ,
        $chunk-ñ,
        $chunk-ò,
        $chunk-ṕ,
        $chunk-ק,
        $chunk-ŗ,
        $chunk-ś,
        $chunk-ţ,
        $chunk-ú,
        $chunk-ṽ,
        $chunk-ŵ,
        $chunk-ẍ,
        $chunk-ý,
        $chunk-ƶ,
        $chunk-α,
        $chunk-Ώ,
        $chunk-Ψ,
        $chunk-Θ,
        $chunk-Δ,
        $chunk-ж;

    # end @chunk }}}
    # @chunk tests {{{

    cmp-ok $parse-tree.document.chunk[$_], &cmp-ok-chunk, @chunk[$_], 'Chunk OK'
        for (0..57);
    ok $parse-tree.document.chunk[58].not;

    # end @chunk tests }}}

    my Document $d .= new(:@chunk);
    is-deeply $parse-tree.document, $d, 'Document OK';

    my Finn::Parser::ParseTree $t .= new(:document($d));
    is-deeply $parse-tree, $t, 'ParseTree OK';
}

=begin pod
subtest 'finn-examples/hard',
{
    my Str:D $document = 't/data/hard/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Hard Example
        ============
        EOF
        q:to/EOF/.trim-trailing,
        this should be parsed as a `paragraph` since no `blank-line`,
        `comment-line` or `horizontal-rule` precedes it, and a line follows it
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be parsed as a `header3`
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should also be parsed as a `header3` /* eol comment */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be a paragraph since it ends in a comma (`,`),
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should also be a paragraph since it ends in a comma (`,`), /* eol comment */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be a paragraph since it ends in a period (`.`).
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should also be a paragraph since it ends in a period (`.`). /* eol comment */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this too should be a paragraph since it ends in a period (`.`). /*
        comment-text                                                     *
        comment-text                                                     *
        comment-text                                                     *
        comment-text                                                     *
        comment-text                                                     */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        /* lists
         * {{{
         */
        EOF
        '',
        '[9] (header3 with trailing whitespace)                 ',
        q:to/EOF/.trim-trailing,
        - nine
          ! nine
            o nine
              <- nine
                -> nine
                  = nine
                    => nine
                      <= nine
                        @ nine
                          $ nine
                            : nine
        EOF
        '',
        q:to/EOF/.trim-trailing,
        [0] (header2)
        --------------------
        EOF
        q:to/EOF/.trim-trailing,
        - zero
          # zero
            * zero
              x zero
                + zero
                  ! zero
                    ~ zero
                      > zero
                        - zero /* eol comment */
                          - z /* inner word comment */ ero
                            - /* leading comment */ zero
        EOF
        '',
        q:to/EOF/.trim-trailing,
        [909] (header1)
        ============================
        EOF
        q:to/EOF/.trim-trailing,
        - nine zero nine
        EOF
        q:to/EOF/.trim-trailing,
          /* comment */
        EOF
        q:to/EOF/.trim-trailing,
          - nine zero nine
        EOF
        q:to/EOF/.trim-trailing,
            /*
             * comment
             * comment
             * comment
             */
        EOF
        q:to/EOF/.trim-trailing,
            - nine zero nine /*
              comment         *
              comment         *
              comment         */
              - nine zero 「nine」
                - nine zero «nine»
                  - nine zero ⟅nine⟆
                    - nine zero ᚛nine᚜
                      - nine zero _nine_
                        - **nine** zero |nine|
                          - nine *zero* {nine}
                            - nine zero ~nine~
        EOF
        '',
        q:to/EOF/.trim-trailing,
        /*
         * }}}
         end lists */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        /**/ this should be parsed as a paragraph
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Header2
        -
        EOF
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Another Header2
        -
        EOF
        q:to/EOF/.trim-trailing,
        This is a paragraph since it is not preceded by a `blank-line`,
        `comment-block` or `horizontal-rule`. We just saw a `header2`.
        EOF
        '',
        '~' x 78,
        q:to/EOF/.trim-trailing,
        this should be parsed as a `header3` since a `horizontal-rule-soft` precedes it
        EOF
        '',
        q:to/EOF/.trim-trailing,
        **another header3 since a `blank-line` precedes it**
        EOF
        '',
        '*' x 78,
        q:to/EOF/.trim-trailing,
        this should be parsed as a `header3` since a `horizontal-rule-hard` precedes it
        EOF
        '*' x 78,
        q:to/EOF/.trim-trailing,
        this should not be a `header3` since one line of text comes after it
        {{{one line of text goes here}}}
        EOF
        '',
        '~' x 78,
        q:to/EOF/.trim-trailing,
        this should not be a `header3` since one line of text comes after it
        one line of text goes here
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be a `header3`
        EOF
        q:to/EOF/.trim-trailing,
        x because a `blank-line` comes before it
        [*] because a list comes after it
        1. the list continues \ / _$@$#%$^%Y&&^%%@$$#$T%Y^U&^' ' ~with~ *offset*
           **gibberish** underlined up to here_. file://~/tmp/ /a\/b.txt
           {} [] some symbols come on the next offset line
          2. indented list-item
        EOF
        q:to/EOF/.trim-trailing,
            ```perl6
            # indented perl6 code-block
            my Str:D $greeting = 'Hello';
            ```
        EOF
        q:to/EOF/.trim-trailing,
            /* ------------- *
             * comment-block *
             * comment-block *
             * comment-block *
             * ------------- */
        EOF
        q:to/EOF/.trim-trailing,
            -> here comes another code-block /* eol comment goes here */
        EOF
        q:to/EOF/.trim-trailing,
              --perl6
              # indented perl6 code-block
              my Str:D $greeting = 'Hello';
              --
        EOF
        q:to/EOF/.trim-trailing,
        --- The Simpsons Quotes
        'Doh!
        ---
        EOF
        q:to/EOF/.trim-trailing,
        ``` The Simpsons Quotes +=
        Dental Plan!
        ```
        EOF
        q:to/EOF/.trim-trailing,
        -- The Simpsons Quotes +=
        Lisa needs braces!
        -------------------------------
        EOF
        q:to/EOF/.trim-trailing,
        -- The Simpsons Quotes +=
        Bart! Why you little
        --
        EOF
        '',
        '~' x 2,
        q:to/EOF/.trim-trailing,
        this should be a `header3`
        EOF
        q:to/EOF/.trim-trailing,
        [o] because a `horizontal-rule` comes before it
        [o] because a list comes after it
        EOF
        '',
        '*' x 2,
        q:to/EOF/.trim-trailing,
        this should be a `header3`
        EOF
        q:to/EOF/.trim-trailing,
        [=] because a `horizontal-rule` comes before it
        [=] because a list comes after it
        EOF
        '',
        q:to/EOF/.trim-trailing,
              INFO Robot
        EOF
        '',
        q:to/EOF/.trim-trailing,
                           FIXME
        EOF
        q:to/EOF/.trim-trailing,
                            ```
                            \_/
                            |:|
                            -|-
                            / \
                            ```
        EOF
        '',
        q:to/EOF/.trim-trailing,
              DEBUG System
        EOF
        '',
        '',
        '',
        Q:to/EOF/.trim-trailing;
        ******************************************************************************

        [1]: https://[2[3[4]]].finn
        [9]: /\\/\/\/\/\/\/\/\/\/\/\/\/\\/
        [0]: 1234567890-=`1234567890`
        [909]: a
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<paragraph>, @chunk[3];
    is-deeply ~$match<document><chunk>[3]<header-block><blank-line>, @chunk[4];
    is-deeply ~$match<document><chunk>[3]<header-block><header>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<header-block><blank-line>, @chunk[6];
    is-deeply ~$match<document><chunk>[4]<header-block><header>, @chunk[7];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[8];
    is-deeply ~$match<document><chunk>[6]<paragraph>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<blank-line>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<paragraph>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<blank-line>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<paragraph>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<blank-line>, @chunk[14];
    is-deeply ~$match<document><chunk>[12]<paragraph>, @chunk[15];
    is-deeply ~$match<document><chunk>[13]<blank-line>, @chunk[16];
    is-deeply ~$match<document><chunk>[14]<paragraph>, @chunk[17];
    is-deeply ~$match<document><chunk>[15]<blank-line>, @chunk[18];
    is-deeply ~$match<document><chunk>[16]<comment-block>, @chunk[19];
    is-deeply ~$match<document><chunk>[17]<header-block><blank-line>, @chunk[20];
    is-deeply ~$match<document><chunk>[17]<header-block><header>, @chunk[21];
    is-deeply ~$match<document><chunk>[18]<list-block>, @chunk[22];
    is-deeply ~$match<document><chunk>[19]<header-block><blank-line>, @chunk[23];
    is-deeply ~$match<document><chunk>[19]<header-block><header>, @chunk[24];
    is-deeply ~$match<document><chunk>[20]<list-block>, @chunk[25];
    is-deeply ~$match<document><chunk>[21]<header-block><blank-line>, @chunk[26];
    is-deeply ~$match<document><chunk>[21]<header-block><header>, @chunk[27];
    is-deeply ~$match<document><chunk>[22]<list-block>, @chunk[28];
    is-deeply ~$match<document><chunk>[23]<comment-block>, @chunk[29];
    is-deeply ~$match<document><chunk>[24]<list-block>, @chunk[30];
    is-deeply ~$match<document><chunk>[25]<comment-block>, @chunk[31];
    is-deeply ~$match<document><chunk>[26]<list-block>, @chunk[32];
    is-deeply ~$match<document><chunk>[27]<blank-line>, @chunk[33];
    is-deeply ~$match<document><chunk>[28]<comment-block>, @chunk[34];
    is-deeply ~$match<document><chunk>[29]<blank-line>, @chunk[35];
    is-deeply ~$match<document><chunk>[30]<paragraph>, @chunk[36];
    is-deeply ~$match<document><chunk>[31]<header-block><blank-line>, @chunk[37];
    is-deeply ~$match<document><chunk>[31]<header-block><header>, @chunk[38];
    is-deeply ~$match<document><chunk>[32]<horizontal-rule>, @chunk[39];
    is-deeply ~$match<document><chunk>[33]<header-block><blank-line>, @chunk[40];
    is-deeply ~$match<document><chunk>[33]<header-block><header>, @chunk[41];
    is-deeply ~$match<document><chunk>[34]<paragraph>, @chunk[42];
    is-deeply ~$match<document><chunk>[35]<blank-line>, @chunk[43];
    is-deeply ~$match<document><chunk>[36]<header-block><horizontal-rule>, @chunk[44];
    is-deeply ~$match<document><chunk>[36]<header-block><header>, @chunk[45];
    is-deeply ~$match<document><chunk>[37]<header-block><blank-line>, @chunk[46];
    is-deeply ~$match<document><chunk>[37]<header-block><header>, @chunk[47];
    is-deeply ~$match<document><chunk>[38]<blank-line>, @chunk[48];
    is-deeply ~$match<document><chunk>[39]<header-block><horizontal-rule>, @chunk[49];
    is-deeply ~$match<document><chunk>[39]<header-block><header>, @chunk[50];
    is-deeply ~$match<document><chunk>[40]<horizontal-rule>, @chunk[51];
    is-deeply ~$match<document><chunk>[41]<paragraph>, @chunk[52];
    is-deeply ~$match<document><chunk>[42]<blank-line>, @chunk[53];
    is-deeply ~$match<document><chunk>[43]<horizontal-rule>, @chunk[54];
    is-deeply ~$match<document><chunk>[44]<paragraph>, @chunk[55];
    is-deeply ~$match<document><chunk>[45]<header-block><blank-line>, @chunk[56];
    is-deeply ~$match<document><chunk>[45]<header-block><header>, @chunk[57];
    is-deeply ~$match<document><chunk>[46]<list-block>, @chunk[58];
    is-deeply ~$match<document><chunk>[47]<code-block>, @chunk[59];
    is-deeply ~$match<document><chunk>[48]<comment-block>, @chunk[60];
    is-deeply ~$match<document><chunk>[49]<list-block>, @chunk[61];
    is-deeply ~$match<document><chunk>[50]<code-block>, @chunk[62];
    is-deeply ~$match<document><chunk>[51]<sectional-block>, @chunk[63];
    is-deeply ~$match<document><chunk>[52]<sectional-block>, @chunk[64];
    is-deeply ~$match<document><chunk>[53]<sectional-block>, @chunk[65];
    is-deeply ~$match<document><chunk>[54]<sectional-block>, @chunk[66];
    is-deeply ~$match<document><chunk>[55]<blank-line>, @chunk[67];
    is-deeply ~$match<document><chunk>[56]<header-block><horizontal-rule>, @chunk[68];
    is-deeply ~$match<document><chunk>[56]<header-block><header>, @chunk[69];
    is-deeply ~$match<document><chunk>[57]<list-block>, @chunk[70];
    is-deeply ~$match<document><chunk>[58]<blank-line>, @chunk[71];
    is-deeply ~$match<document><chunk>[59]<header-block><horizontal-rule>, @chunk[72];
    is-deeply ~$match<document><chunk>[59]<header-block><header>, @chunk[73];
    is-deeply ~$match<document><chunk>[60]<list-block>, @chunk[74];
    is-deeply ~$match<document><chunk>[61]<blank-line>, @chunk[75];
    is-deeply ~$match<document><chunk>[62]<paragraph>, @chunk[76];
    is-deeply ~$match<document><chunk>[63]<blank-line>, @chunk[77];
    is-deeply ~$match<document><chunk>[64]<paragraph>, @chunk[78];
    is-deeply ~$match<document><chunk>[65]<code-block>, @chunk[79];
    is-deeply ~$match<document><chunk>[66]<blank-line>, @chunk[80];
    is-deeply ~$match<document><chunk>[67]<paragraph>, @chunk[81];
    is-deeply ~$match<document><chunk>[68]<blank-line>, @chunk[82];
    is-deeply ~$match<document><chunk>[69]<blank-line>, @chunk[83];
    is-deeply ~$match<document><chunk>[70]<blank-line>, @chunk[84];
    is-deeply ~$match<document><chunk>[71]<reference-block>, @chunk[85];
    ok $match<document><chunk>[72].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/hello',
{
    my Str:D $document = 't/data/hello/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Hello World
        ===========
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Introduction
        ------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        A simple, single-file hello world program written in Perl6.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        The following will (over)write the contents of `bin/hello` with the
        `Import modules` and `Print a string` code blocks:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- /bin/hello
        § "Import modules"
        § "Print a string"
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        First, we import any modules needed:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Import modules
        use v6;
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Forgot the module. Code blocks can be extended by defining them again:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Import modules +=
        use Acme::Insult::Lala;
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Then we print a string:
        EOF
        '',
        q:to/EOF/.trim-trailing;
        --- Print a string
        say "hello, you " ~ Acme::Insult::Lala.new.generate-insult;
        ---
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<header-block><blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[2]<header-block><header>, @chunk[4];
    is-deeply ~$match<document><chunk>[3]<blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<paragraph>, @chunk[6];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<paragraph>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[8]<sectional-block>, @chunk[10];
    is-deeply ~$match<document><chunk>[9]<header-block><blank-line>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<header-block><header>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<blank-line>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<sectional-block>, @chunk[14];
    is-deeply ~$match<document><chunk>[12]<header-block><blank-line>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<header-block><header>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<blank-line>, @chunk[17];
    is-deeply ~$match<document><chunk>[14]<sectional-block>, @chunk[18];
    is-deeply ~$match<document><chunk>[15]<header-block><blank-line>, @chunk[19];
    is-deeply ~$match<document><chunk>[15]<header-block><header>, @chunk[20];
    is-deeply ~$match<document><chunk>[16]<blank-line>, @chunk[21];
    is-deeply ~$match<document><chunk>[17]<sectional-block>, @chunk[22];
    ok $match<document><chunk>[18].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/novel',
{
    my Str:D $document = 't/data/novel/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Novel
        =====
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § chapter-01/intro.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § chapter-02/intro.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § chapter-03/intro.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing;
        El Fin
        ------
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[3]<horizontal-rule>, @chunk[4];
    is-deeply ~$match<document><chunk>[4]<sectional-inline-block><blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<sectional-inline-block><sectional-inline>, @chunk[6];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<horizontal-rule>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<sectional-inline-block><blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<sectional-inline-block><sectional-inline>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<blank-line>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<horizontal-rule>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<sectional-inline-block><blank-line>, @chunk[13];
    is-deeply ~$match<document><chunk>[10]<sectional-inline-block><sectional-inline>, @chunk[14];
    is-deeply ~$match<document><chunk>[11]<blank-line>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<horizontal-rule>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<header-block><blank-line>, @chunk[17];
    is-deeply ~$match<document><chunk>[13]<header-block><header>, @chunk[18];
    ok $match<document><chunk>[14].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/sample',
{
    my Str:D $document = 't/data/sample/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn: */',
        '',
        q:to/EOF/.trim-trailing,
        vim-finn
        ========
        EOF
        '',
        q:to/EOF/.trim-trailing,
        *vim-finn*[1] is _a syntax plugin for Finn_, a superset of Junegunn Choi's
        *vim-journal*[2] specifically designed for literate programming.
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Bullet lists [3]
        ----------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Example:
        EOF
        q:to/EOF/.trim-trailing,
        - In typography, a bullet (•) is a typographical symbol or glyph used to
          introduce items in a list.
          = It is likely that the name originated from the resemblance of the
            traditional circular bullet symbol (•) to a projectile bullet, which were
            spherical until the second half of the 19th century
            * The bullet symbol may take any of a variety of shapes, such as
                1. circular,
                2. square,
                3. diamond,
                4. arrow, etc.
            * And typical word processor software offer a wide selection of shapes and
              colours.
                * When writing by hand, bullets may be drawn in any style
                  o Historically, the index symbol was popular for similar uses.
                    x Lists made with bullets are called bulleted lists.
                      > The HTML element name for a bulleted list is "unordered list"
                        ~ Because the list items are not arranged in numerical order.
                          : (as they would be in a numbered list)
                        ! Bullets are most often used in technical writing, reference
                          works, notes and presentations
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        To-do list [4]
        --------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        As its name implies, the To-do list on an article's talk page shows the
        list of improvements suggested for the article.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        [v] Task 1
          [ ] Task 1-1
            [v] Task 1-1-1
            [x] Task 1-1-2
              [*] Task 1-1-2-1
                [=] Task 1-1-2-1-1
                [=] Task 1-1-2-1-2
              [-] Task 1-1-2-2
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Software logs
        -------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        2015/04/01 12:00:00 DEBUG Info message
        2015/04/01 12:00:00 INFO Info message
        2015/04/01 12:00:00 WARN Warning message
        2015/04/01 12:00:00 ERROR Error message (FIXME)
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Code
        ----
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --clojure
        (defn is-directory? [path]
          (.isDirectory (io/file (path-for path))))
        --
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Blocks can be indented.
        EOF
        '',
        q:to/EOF/.trim-trailing,
          ```ruby
          class Foo
            def foobar
              puts :baz
            end
          end
          ```
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing;
        ******************************************************************************

        [1]: https://github.com/atweiden/vim-finn
        [2]: https://github.com/junegunn/vim-journal
        [3]: http://en.wikipedia.org/wiki/Bullet_%28typography%29
        [4]: http://en.wikipedia.org/wiki/Wikipedia:To-do_list
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[3]<paragraph>, @chunk[4];
    is-deeply ~$match<document><chunk>[4]<blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[5]<horizontal-rule>, @chunk[6];
    is-deeply ~$match<document><chunk>[6]<header-block><blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<header-block><header>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<header-block><blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<header-block><header>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<list-block>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<blank-line>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<horizontal-rule>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<header-block><blank-line>, @chunk[14];
    is-deeply ~$match<document><chunk>[11]<header-block><header>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<blank-line>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<paragraph>, @chunk[17];
    is-deeply ~$match<document><chunk>[14]<blank-line>, @chunk[18];
    is-deeply ~$match<document><chunk>[15]<list-block>, @chunk[19];
    is-deeply ~$match<document><chunk>[16]<blank-line>, @chunk[20];
    is-deeply ~$match<document><chunk>[17]<horizontal-rule>, @chunk[21];
    is-deeply ~$match<document><chunk>[18]<header-block><blank-line>, @chunk[22];
    is-deeply ~$match<document><chunk>[18]<header-block><header>, @chunk[23];
    is-deeply ~$match<document><chunk>[19]<blank-line>, @chunk[24];
    is-deeply ~$match<document><chunk>[20]<paragraph>, @chunk[25];
    is-deeply ~$match<document><chunk>[21]<blank-line>, @chunk[26];
    is-deeply ~$match<document><chunk>[22]<horizontal-rule>, @chunk[27];
    is-deeply ~$match<document><chunk>[23]<header-block><blank-line>, @chunk[28];
    is-deeply ~$match<document><chunk>[23]<header-block><header>, @chunk[29];
    is-deeply ~$match<document><chunk>[24]<blank-line>, @chunk[30];
    is-deeply ~$match<document><chunk>[25]<code-block>, @chunk[31];
    is-deeply ~$match<document><chunk>[26]<blank-line>, @chunk[32];
    is-deeply ~$match<document><chunk>[27]<paragraph>, @chunk[33];
    is-deeply ~$match<document><chunk>[28]<blank-line>, @chunk[34];
    is-deeply ~$match<document><chunk>[29]<code-block>, @chunk[35];
    is-deeply ~$match<document><chunk>[30]<blank-line>, @chunk[36];
    is-deeply ~$match<document><chunk>[31]<blank-line>, @chunk[37];
    is-deeply ~$match<document><chunk>[32]<reference-block>, @chunk[38];
    ok $match<document><chunk>[33].isa(Any);

    # end @chunk tests }}}
}
=end pod

# sub gen-bounds {{{

sub gen-bounds() returns Chunk::Meta::Bounds:D
{
    # XXX fix dummy data
    my Chunk::Meta::Bounds::Begins:D $begins =
        Chunk::Meta::Bounds::Begins.new(:line(0), :column(0));
    my Chunk::Meta::Bounds::Ends:D $ends =
        Chunk::Meta::Bounds::Ends.new(:line(0), :column(0));
    my Chunk::Meta::Bounds:D $bounds =
        Chunk::Meta::Bounds.new(:$begins, :$ends);
}

# end sub gen-bounds }}}

sub cmp-ok-chunk(Chunk:D $a, Chunk:D $b) returns Bool:D
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
