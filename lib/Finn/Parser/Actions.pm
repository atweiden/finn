use v6;
use Finn::Parser::ParseTree;
unit class Finn::Parser::Actions;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions

=head SYNOPSIS

=begin code
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;

my Finn::Parser::Actions $actions .= new;
my Finn::Parser::ParseTree $parse-tree =
    Finn::Parser::Grammar.parse('text', :$actions).made;
=end code

=head DESCRIPTION

Works in tandem with C<Finn::Parser::Grammar> and
C<Finn::Parser::ParseTree> to build a parse tree from Finn source files.

Follows C<sectional-inline>s and C<sectional-link>s which link to external
files that are assumed to be Finn source files. Parses external source
files in turn. Initial concept code doesn't do any optimization, and
may parse the same external source file many times.

Since C<sectional-inline>s may contain C<reference-inline>s
linking to external files in place of file paths, and since the
C<reference-block>(s) containing external file mappings for these
C<reference-inline>s encountered may appear anywhere in a Finn source
document, C<sectional-inline>s can't be blindly followed when first
seen. The entire Finn source document has to finish parsing before
C<sectional-inline>s can be followed.
=end pod

# end p6doc }}}

=begin pod
=head Attributes
=end pod

# public attributes {{{

# the file currently being parsed
has Str:D $.file = '.';

# increments on each section (0+)
has UInt:D $.section = 0;

# end public attributes }}}

=begin pod
=head Document
=end pod

# document {{{

# --- chunk {{{

method chunk:sectional-inline-block ($/)
{
    make $<sectional-inline-block>.made;
}

method chunk:sectional-block ($/)
{
    make $<sectional-block>.made;
}

method chunk:code-block ($/)
{
    make $<code-block>.made;
}

method chunk:reference-block ($/)
{
    make $<reference-block>.made;
}

method chunk:header-block ($/)
{
    make $<header-block>.made;
}

method chunk:list-block ($/)
{
    make $<list-block>.made;
}

method chunk:paragraph-block ($/)
{
    make $<paragraph>.made;
}

method chunk:horizontal-rule ($/)
{
    make $<horizontal-rule>.made;
}

method chunk:comment-block ($/)
{
    make $<comment-block>.made;
}

method chunk:blank-line ($/)
{
    make $<blank-line>.made;
}

# --- end chunk }}}

method document($/)
{
    make @<chunk>».made;
}

# end document }}}
# TOP {{{

multi method TOP($/ where $<document>.so)
{
    make $<document>.made;
}

multi method TOP($/)
{
    make Nil;
}

# end TOP }}}

=begin pod
=head Block Text
=end pod

# sectional-inline-block {{{

# --- sectional-inline {{{

method sectional-inline-text:name-and-file ($/)
{
    make SectionalInline['Name', 'File'].new(
        :content($/.orig),
        :name($<sectional-inline-name>.made),
        :file($<sectional-inline-file>.made)
    );
}

method sectional-inline-text:name-and-reference ($/)
{
    make SectionalInline['Name', 'Reference'].new(
        :content($/.orig),
        :name($<sectional-inline-name>.made),
        :number($<sectional-inline-reference>.made)
    );
}

method sectional-inline-text:file-only ($/)
{
    make SectionalInline['File'].new(
        :content($/.orig),
        :file($<sectional-inline-file>.made)
    );
}

method sectional-inline-text:reference-only ($/)
{
    make SectionalInline['Reference'].new(
        :content($/.orig),
        :number($<sectional-inline-reference>.made)
    );
}

method sectional-inline-text:name-only ($/)
{
    make SectionalInline['Name'].new(
        :content($/.orig),
        :name($<sectional-inline-name>.made)
    );
}

multi method sectional-inline($/)
{
    make $<sectional-inline-text>.made;
}

# --- end sectional-inline }}}

method sectional-inline-block:top ($/)
{
    make Chunk::SectionalInlineBlock.new(
        :sectional-inline(@<sectional-inline>».made)
    );
}

method sectional-inline-block:dispersed ($/)
{
    make Chunk::SectionalInlineBlock.new(
        :sectional-inline(@<sectional-inline>».made)
    );
}

# end sectional-inline-block }}}
# sectional-block {{{

# end sectional-block }}}
# code-block {{{

# end code-block }}}
# reference-block {{{

# end reference-block }}}
# header-block {{{

method header-text($/)
{
    make ~$/;
}

method header1($/)
{
    my Str:D $content = $/.orig;
    my Str:D $header-text = $<header-text>.made;
    make Header[1].new(:$content, :$header-text);
}

method header2($/)
{
    my Str:D $content = $/.orig;
    my Str:D $header-text = $<header-text>.made;
    make Header[2].new(:$content, :$header-text);
}

method header3($/)
{
    my Str:D $content = $/.orig;
    my Str:D $header-text = $<header-text>.made;
    make Header[3].new(:$content, :$header-text);
}

method header:h1 ($/)
{
    make $<header1>.made;
}

method header:h2 ($/)
{
    make $<header2>.made;
}

method header:h3 ($/)
{
    make $<header3>.made;
}

multi method header-block:top ($/ where { $<header>.made ~~ Header[1] })
{
    my Bounds:D $bounds = gen-bounds();
    my Str:D $content = $/.orig;
    my Header[1] $header1 = $<header>.made;
    my UInt:D $section = 0;
    make Chunk::HeaderBlock[1].new(:$bounds, :$content, :$section, :$header1);
}

multi method header-block:top ($/ where { $<header>.made ~~ Header[2] })
{
    my Bounds:D $bounds = gen-bounds();
    my Str:D $content = $/.orig;
    my Header[2] $header2 = $<header>.made;
    my UInt:D $section = 0;
    make Chunk::HeaderBlock[2].new(:$bounds, :$content, :$section, :$header2);
}

multi method header-block:top ($/ where { $<header>.made ~~ Header[3] })
{
    my Bounds:D $bounds = gen-bounds();
    my Str:D $content = $/.orig;
    my Header[3] $header3 = $<header>.made;
    my UInt:D $section = 0;
    make Chunk::HeaderBlock[3].new(:$bounds, :$content, :$section, :$header3);
}

multi method header-block:dispersed ($/ where { $<header>.made ~~ Header[1] })
{
    my Bounds:D $bounds = gen-bounds();
    my Str:D $content = $/.orig;
    my Header[1] $header1 = $<header>.made;
    my UInt:D $section = 0;
    make Chunk::HeaderBlock[1].new(:$bounds, :$content, :$section, :$header1);
}

multi method header-block:dispersed ($/ where { $<header>.made ~~ Header[2] })
{
    my Bounds:D $bounds = gen-bounds();
    my Str:D $content = $/.orig;
    my Header[2] $header2 = $<header>.made;
    my UInt:D $section = 0;
    make Chunk::HeaderBlock[2].new(:$bounds, :$content, :$section, :$header2);
}

multi method header-block:dispersed ($/ where { $<header>.made ~~ Header[3] })
{
    my Bounds:D $bounds = gen-bounds();
    my Str:D $content = $/.orig;
    my Header[3] $header3 = $<header>.made;
    my UInt:D $section = 0;
    make Chunk::HeaderBlock[3].new(:$bounds, :$content, :$section, :$header3);
}

# end header-block }}}
# XXX redo list-block in spirit of header-block
# list-block {{{

# --- list-todo-item {{{

# --- --- checkbox {{{

# --- --- --- checkbox-checked {{{

method checkbox-checked-char:sym<x> ($/)
{
    make ~$/;
}

method checkbox-checked-char:sym<o> ($/)
{
    make ~$/;
}

method checkbox-checked-char:sym<v> ($/)
{
    make ~$/;
}

method checkbox-checked($/)
{
    make $<checkbox-checked-char>.made;
}

# --- --- --- end checkbox-checked }}}
# --- --- --- checkbox-etc {{{

method checkbox-etc-char:sym<+> ($/)
{
    make ~$/;
}

method checkbox-etc-char:sym<=> ($/)
{
    make ~$/;
}

method checkbox-etc-char:sym<-> ($/)
{
    make ~$/;
}

method checkbox-etc($/)
{
    make $<checkbox-etc-char>.made;
}

# --- --- --- end checkbox-etc }}}
# --- --- --- checkbox-exception {{{

method checkbox-exception-char:sym<*> ($/)
{
    make ~$/;
}

method checkbox-exception-char:sym<!> ($/)
{
    make ~$/;
}

method checkbox-exception($/)
{
    make $<checkbox-exception-char>.made;
}

# --- --- --- end checkbox-exception }}}
# --- --- --- checkbox-unchecked {{{

method checkbox-unchecked($/)
{
    make ' ';
}

# --- --- --- end checkbox-unchecked }}}

method checkbox:checked ($/)
{
    make $<checkbox-checked>.made;
}

method checkbox:etc ($/)
{
    make $<checkbox-etc>.made;
}

method checkbox:exception ($/)
{
    make $<checkbox-exception>.made;
}

method checkbox:unchecked ($/)
{
    make $<checkbox-unchecked>.made;
}

# --- --- end checkbox }}}

method list-todo-item-text($/)
{
    make ~$/;
}

method list-todo-item($/)
{
    make $<checkbox>.made ~ $<list-todo-item-text>.made;
}

# --- end list-todo-item }}}
# --- list-unordered-item {{{

# --- --- bullet-point {{{

method bullet-point:sym<-> ($/)
{
    make ~$/;
}

method bullet-point:sym<@> ($/)
{
    make ~$/;
}

method bullet-point:sym<#> ($/)
{
    make ~$/;
}

method bullet-point:sym<$> ($/)
{
    make ~$/;
}

method bullet-point:sym<*> ($/)
{
    make ~$/;
}

method bullet-point:sym<:> ($/)
{
    make ~$/;
}

method bullet-point:sym<x> ($/)
{
    make ~$/;
}

method bullet-point:sym<o> ($/)
{
    make ~$/;
}

method bullet-point:sym<+> ($/)
{
    make ~$/;
}

method bullet-point:sym<=> ($/)
{
    make ~$/;
}

method bullet-point:sym<!> ($/)
{
    make ~$/;
}

method bullet-point:sym<~> ($/)
{
    make ~$/;
}

method bullet-point:sym«>» ($/)
{
    make ~$/;
}

method bullet-point:sym«<-» ($/)
{
    make ~$/;
}

method bullet-point:sym«<=» ($/)
{
    make ~$/;
}

method bullet-point:sym«->» ($/)
{
    make ~$/;
}

method bullet-point:sym«=>» ($/)
{
    make ~$/;
}

# --- --- end bullet-point }}}

method list-unordered-item-text-continuation($/)
{
    make ~$/;
}

multi method list-unordered-item-text(
    $/ where @<list-unordered-item-text-continuation>.so
)
{
    # XXX may need to add grammar token for first line of text
    make ~$/ ~ @<list-unordered-item-text-continuation>».made.join("\n");
}

multi method list-unordered-item-text($/)
{
    make ~$/;
}

multi method list-unordered-item($/ where $<list-unordered-item-text>.so)
{
    make $<bullet-point>.made ~ $<list-unordered-item-text>.made;
}

multi method list-unordered-item($/)
{
    make $<bullet-point>.made;
}

# --- end list-unordered-item }}}
# --- list-ordered-item {{{

# --- --- list-ordered-item-number {{{

method list-ordered-item-number-value($/)
{
    make ~$/;
}

method list-ordered-item-number-terminator:sym<.> ($/)
{
    make ~$/;
}

method list-ordered-item-number-terminator:sym<:> ($/)
{
    make ~$/;
}

method list-ordered-item-number-terminator:sym<)> ($/)
{
    make ~$/;
}

method list-ordered-item-number($/)
{
    make
        $<list-ordered-item-number-value>.made
        ~ $<list-ordered-item-number-terminator>.made;
}

# --- --- end list-ordered-item-number }}}

method list-ordered-item-text-continuation($/)
{
    make ~$/;
}

multi method list-ordered-item-text(
    $/ where @<list-ordered-item-text-continuation>.so
)
{
    # XXX may need to add grammar token for first line of text
    make ~$/ ~ @<list-ordered-item-text-continuation>».made.join;
}

multi method list-ordered-item-text($/)
{
    make ~$/;
}

multi method list-ordered-item($/ where $<list-ordered-item-text>.so)
{
    make $<list-ordered-item-number>.made ~ $<list-ordered-item-text>.made;
}

multi method list-ordered-item($/)
{
    make $<list-ordered-item-number>.made;
}

# --- end list-ordered-item }}}

method list-item:unordered ($/)
{
    make $<list-unordered-item>.made;
}

method list-item:todo ($/)
{
    make $<list-todo-item>.made;
}

method list-item:ordered ($/)
{
    make $<list-ordered-item>.made;
}

method list-block($/)
{
    my Bounds:D $bounds = gen-bounds();
    make Chunk::ListBlock.new(
        :$bounds,
        :content(@<list-item>».made.join("\n")),
        :section(0)
    );
}

# end list-block }}}
# paragraph-block {{{

# end paragraph-block }}}
# horizontal-rule {{{

# end horizontal-rule }}}
# XXX redo comment-block in spirit of header-block
# comment-block {{{

method comment-delimiter-opening($/)
{
    make ~$/;
}

method comment-delimiter-closing($/)
{
    make ~$/;
}

method comment-text($/)
{
    make ~$/;
}

method comment($/)
{
    make
        $<comment-delimiter-opening>.made
        ~ $<comment-text>.made
        ~ $<comment-delimiter-closing>.made;
}

method comment-block($/)
{
    my Bounds:D $bounds = gen-bounds();
    make Chunk::CommentBlock.new(
        :$bounds,
        :content($<comment>.made),
        :section(0)
    );
}

# end comment-block }}}
# XXX redo blank-link in spirit of header-block
# blank-line {{{

method blank-line($/)
{
    my Bounds:D $bounds = gen-bounds();
    make Chunk::BlankLine.new(:$bounds, :content($/.orig), :section(0));
}

# end blank-line }}}

=begin pod
=head Inline Text
=end pod

# string {{{

# --- string-basic {{{

# --- --- string-basic-char {{{

method string-basic-char:common ($/)
{
    make ~$/;
}

method string-basic-char:tab ($/)
{
    make ~$/;
}

method string-basic-char:escape-sequence ($/)
{
    make $<escape>.made;
}

# --- --- end string-basic-char }}}
# --- --- escape {{{

method escape:sym<b>($/)
{
    make "\b";
}

method escape:sym<t>($/)
{
    make "\t";
}

method escape:sym<n>($/)
{
    make "\n";
}

method escape:sym<f>($/)
{
    make "\f";
}

method escape:sym<r>($/)
{
    make "\r";
}

method escape:sym<quote>($/)
{
    make "\"";
}

method escape:sym<backslash>($/)
{
    make '\\';
}

method escape:sym<u>($/)
{
    make chr(:16(@<hex>.join));
}

method escape:sym<U>($/)
{
    make chr(:16(@<hex>.join));
}

# --- --- end escape }}}

method string-basic-text($/)
{
    make @<string-basic-char>».made.join;
}

method string-basic($/)
{
    make $<string-basic-text>.made;
}

# --- end string-basic }}}
# --- string-literal {{{

# --- --- string-literal-char {{{

method string-literal-char:common ($/)
{
    make ~$/;
}

method string-literal-char:backslash ($/)
{
    make '\\';
}

# --- --- end string-literal-char }}}

method string-literal-text($/)
{
    make @<string-literal-char>».made.join;
}

method string-literal($/)
{
    make $<string-literal-text>.made;
}

# --- end string-literal }}}

method string:basic ($/)
{
    make $<string-basic>.made;
}

method string:literal ($/)
{
    make $<string-literal>.made;
}

# end string }}}
# file {{{

# --- file-path-char {{{

method file-path-char:common ($/)
{
    make ~$/;
}

method file-path-char:escape-sequence ($/)
{
    make $<file-path-escape>.made;
}

# --- end file-path-char }}}
# --- file-path-escape {{{

method file-path-escape:sym<whitespace>($/)
{
    make ~$/;
}

method file-path-escape:sym<b>($/)
{
    make "\b";
}

method file-path-escape:sym<t>($/)
{
    make "\t";
}

method file-path-escape:sym<n>($/)
{
    make "\n";
}

method file-path-escape:sym<f>($/)
{
    make "\f";
}

method file-path-escape:sym<r>($/)
{
    make "\r";
}

method file-path-escape:sym<single-quote>($/)
{
    make "'";
}

method file-path-escape:sym<double-quote>($/)
{
    make "\"";
}

method file-path-escape:sym<fwdslash>($/)
{
    make '/';
}

method file-path-escape:sym<backslash>($/)
{
    make '\\';
}

method file-path-escape:sym<[>($/)
{
    make ~$/;
}

method file-path-escape:sym<]>($/)
{
    make ~$/;
}

method file-path-escape:sym<{>($/)
{
    make ~$/;
}

method file-path-escape:sym<}>($/)
{
    make ~$/;
}

method file-path-escape:sym<u>($/)
{
    make chr(:16(@<hex>.join));
}

method file-path-escape:sym<U>($/)
{
    make chr(:16(@<hex>.join));
}

# --- end file-path-escape }}}
# --- file-protocol {{{

method file-protocol($/)
{
    make File::Protocol.new(:protocol(~$/));
}

# --- end file-protocol }}}
# --- file-absolute {{{

multi method file-path-absolute($/ where @<file-path-absolute>.so)
{
    make '/' ~ @<file-path-char>».made.join ~ @<file-path-absolute>».made.join;
}

multi method file-path-absolute($/)
{
    make '/' ~ @<file-path-char>».made.join;
}

multi method file-absolute($/ where $<file-protocol>.so)
{
    my Str:D $content = $/.orig;
    my IO::Path:D $path = IO::Path.new($<file-path-absolute>.made);
    my File::Protocol:D $protocol = $<file-protocol>.made;
    make File['Absolute', 'Protocol'].new(:$content, :$path, :$protocol);
}

multi method file-absolute($/)
{
    my Str:D $content = $/.orig;
    my IO::Path:D $path = IO::Path.new($<file-path-absolute>.made);
    make File['Absolute'].new(:$content, :$path);
}

# --- end file-absolute }}}
# --- file-relative {{{

multi method file-path-relative($/ where @<file-path-absolute>.so)
{
    make @<file-path-char>».made.join ~ @<file-path-absolute>».made.join;
}

multi method file-path-relative($/)
{
    make @<file-path-char>».made.join;
}

multi method file-relative($/ where $<file-protocol>.so)
{
    my Str:D $content = $/.orig;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $<file-path-relative>.made);
    my File::Protocol:D $protocol = $<file-protocol>.made;
    make File['Relative', 'Protocol'].new(:$content, :$path, :$protocol);
}

multi method file-relative($/)
{
    my Str:D $content = $/.orig;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $<file-path-relative>.made);
    make File['Relative'].new(:$content, :$path);
}

# --- end file-relative }}}

method file:absolute ($/)
{
    make $<file-absolute>.made;
}

method file:relative ($/)
{
    make $<file-relative>.made;
}

# end file }}}
# reference-inline {{{

method reference-inline-number($/)
{
    make +$/;
}

method reference-inline($/)
{
    my Str:D $content = $/.orig;
    my UInt:D $number = $<reference-inline-number>.made;
    make ReferenceInline.new(:$content, :$number);
}

# end reference-inline }}}

=begin pod
=head Helper Functions
=end pod

# sub gen-bounds {{{

sub gen-bounds() returns Bounds:D
{
    # XXX fix dummy data
    my Bounds::Begins:D $begins = Bounds::Begins.new(:line(0), :column(0));
    my Bounds::Ends:D $ends = Bounds::Ends.new(:line(0), :column(0));
    my Bounds:D $bounds = Bounds.new(:$begins, :$ends);
}

# end sub gen-bounds }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0: