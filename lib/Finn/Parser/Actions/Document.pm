use v6;
use Finn::Parser::Actions;
use Finn::Parser::ParseTree;
unit class Finn::Parser::Actions::Document;
also is Finn::Parser::Actions;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::Document

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::Document;
use Finn::Parser::Grammar::Document;
use Finn::Parser::ParseTree;

my Finn::Parser::Actions::Document $actions .= new;
my Finn::Parser::ParseTree $parse-tree =
    Finn::Parser::Grammar::Document.parse('text', :$actions).made;
=end code

=head DESCRIPTION

Constructs a Finn Document parse tree.

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
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my SectionalInlineBlock:D $sectional-inline-block =
        $<sectional-inline-block>.made;
    make Chunk['SectionalInlineBlock'].new(
        :$bounds,
        :$section,
        :$sectional-inline-block
    );
}

method chunk:sectional-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my SectionalBlock:D $sectional-block = $<sectional-block>.made;
    make Chunk['SectionalBlock'].new(:$bounds, :$section, :$sectional-block);
}

method chunk:code-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my CodeBlock:D $code-block = $<code-block>.made;
    make Chunk['CodeBlock'].new(:$bounds, :$section, :$code-block);
}

method chunk:reference-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my ReferenceBlock:D $reference-block = $<reference-block>.made;
    make Chunk['ReferenceBlock'].new(:$bounds, :$section, :$reference-block);
}

method chunk:header-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my HeaderBlock:D $header-block = $<header-block>.made;
    make Chunk['HeaderBlock'].new(:$bounds, :$section, :$header-block);
}

method chunk:list-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my ListBlock:D $list-block = $<list-block>.made;
    make Chunk['ListBlock'].new(:$bounds, :$section, :$list-block);
}

method chunk:paragraph ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Paragraph:D $paragraph = $<paragraph>.made;
    make Chunk['Paragraph'].new(:$bounds, :$section, :$paragraph);
}

method chunk:horizontal-rule ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    make Chunk['HorizontalRule'].new(:$bounds, :$section, :$horizontal-rule);
}

method chunk:comment-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my CommentBlock:D $comment-block = $<comment-block>.made;
    make Chunk['CommentBlock'].new(:$bounds, :$section, :$comment-block);
}

method chunk:blank-line ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my BlankLine:D $blank-line = $<blank-line>.made;
    make Chunk['BlankLine'].new(:$bounds, :$section, :$blank-line);
}

# --- end chunk }}}

method document($/)
{
    my Chunk:D @chunk = @<chunk>».made;
    make Document.new(:@chunk);
}

# end document }}}
# TOP {{{

multi method TOP($/ where $<document>.so)
{
    my Document:D $document = $<document>.made;
    make Finn::Parser::ParseTree.new(:$document);
}

multi method TOP($/)
{
    make Nil;
}

# end TOP }}}

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
