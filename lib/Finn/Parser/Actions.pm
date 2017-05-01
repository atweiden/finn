use v6;
use Finn::Parser::Actions::Cache;
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
C<Finn::Parser::ParseTree> to build a parse tree from Finn source
documents.

Follows C<include-line>s and C<sectional-link>s which link to external
files that are assumed to be Finn source documents. Parses external
source documents in turn.

Since C<include-line>s may contain C<reference-inline>s linking
to external documents in place of file paths, and since the
C<reference-line-block>(s) containing external document file path
mappings for these C<reference-inline>s encountered may appear anywhere
in a Finn source document, C<include-line>s can't be blindly followed
when first seen. The entire Finn source document has to finish parsing
before C<include-line>s can be followed.
=end pod

# end p6doc }}}

=begin pod
=head Attributes
=end pod

# public attributes {{{

# the file currently being parsed
has Str:D $.file = '.';

# the project root directory
has Str:D $.project-root = $!file.IO.resolve.dirname;

# increments on each section (0+)
has UInt:D $.section = 0;

# end public attributes }}}

=begin pod
=head Document
=end pod

# document {{{

# --- chunk {{{

method chunk:include-line-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my IncludeLineBlock:D $include-line-block = $<include-line-block>.made;
    make Chunk['IncludeLineBlock'].new(
        :$bounds,
        :$section,
        :$include-line-block
    );
}

method chunk:sectional-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my SectionalBlock:D $sectional-block = $<sectional-block>.made;
    make Chunk['SectionalBlock'].new(:$bounds, :$section, :$sectional-block);
}

method chunk:code-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my CodeBlock:D $code-block = $<code-block>.made;
    make Chunk['CodeBlock'].new(:$bounds, :$section, :$code-block);
}

method chunk:reference-line-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my ReferenceLineBlock:D $reference-line-block =
        $<reference-line-block>.made;
    make Chunk['ReferenceLineBlock'].new(
        :$bounds,
        :$section,
        :$reference-line-block
    );
}

method chunk:header-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my HeaderBlock:D $header-block = $<header-block>.made;
    make Chunk['HeaderBlock'].new(:$bounds, :$section, :$header-block);
}

method chunk:list-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my ListBlock:D $list-block = $<list-block>.made;
    make Chunk['ListBlock'].new(:$bounds, :$section, :$list-block);
}

method chunk:paragraph ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Paragraph:D $paragraph = $<paragraph>.made;
    make Chunk['Paragraph'].new(:$bounds, :$section, :$paragraph);
}

method chunk:horizontal-rule ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    make Chunk['HorizontalRule'].new(:$bounds, :$section, :$horizontal-rule);
}

method chunk:comment-block ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my CommentBlock:D $comment-block = $<comment-block>.made;
    make Chunk['CommentBlock'].new(:$bounds, :$section, :$comment-block);
}

method chunk:blank-line ($/ --> Nil)
{
    my Chunk::Meta::Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my BlankLine:D $blank-line = $<blank-line>.made;
    make Chunk['BlankLine'].new(:$bounds, :$section, :$blank-line);
}

# --- end chunk }}}

method document($/ --> Nil)
{
    my Chunk:D @chunk = @<chunk>».made;
    make Document.new(:@chunk);
}

# end document }}}
# TOP {{{

multi method TOP($/ where $<document>.so --> Nil)
{
    my Document:D $document = $<document>.made;
    make Finn::Parser::ParseTree.new(:$document);
}

multi method TOP($/ --> Nil)
{
    make Nil;
}

# end TOP }}}

=begin pod
=head Block Elements
=end pod

# include-line-block {{{

# --- include-line {{{

# --- --- include-line-request {{{

method include-line-request:name-and-file ($/ --> Nil)
{
    my Str:D $name = $<include-line-request-name>.made;
    my File:D $file = $<include-line-request-file>.made;
    make IncludeLine::Request['Name', 'File'].new(:$name, :$file);
}

method include-line-request:name-and-reference ($/ --> Nil)
{
    my Str:D $name = $<include-line-request-name>.made;
    my ReferenceInline:D $reference-inline =
        $<include-line-request-reference>.made;
    make IncludeLine::Request['Name', 'Reference'].new(
        :$name,
        :$reference-inline
    );
}

method include-line-request:file-only ($/ --> Nil)
{
    my File:D $file = $<include-line-request-file>.made;
    make IncludeLine::Request['File'].new(:$file);
}

method include-line-request:reference-only ($/ --> Nil)
{
    my ReferenceInline:D $reference-inline =
        $<include-line-request-reference>.made;
    make IncludeLine::Request['Reference'].new(:$reference-inline);
}

method include-line-request:name-only ($/ --> Nil)
{
    my Str:D $name = $<include-line-request-name>.made;
    make IncludeLine::Request['Name'].new(:$name);
}

# --- --- end include-line-request }}}

multi method include-line:finn ($/ where @<leading-ws>.so --> Nil)
{
    my LeadingWS:D @leading-ws = @<leading-ws>».made;
    my IncludeLine::Request:D $request = $<include-line-request>.made;
    my IncludeLine::Resolver:D $resolver =
        self.gen-include-line-resolver($request, :finn);
    make IncludeLine['Finn'].new(:@leading-ws, :$request, :$resolver);
}

multi method include-line:finn ($/ --> Nil)
{
    my IncludeLine::Request:D $request = $<include-line-request>.made;
    my IncludeLine::Resolver:D $resolver =
        self.gen-include-line-resolver($request, :finn);
    make IncludeLine['Finn'].new(:$request, :$resolver);
}

multi method include-line:text ($/ where @<leading-ws>.so --> Nil)
{
    my LeadingWS:D @leading-ws = @<leading-ws>».made;
    my IncludeLine::Request:D $request = $<include-line-request>.made;
    my IncludeLine::Resolver:D $resolver =
        self.gen-include-line-resolver($request, :text);
    make IncludeLine['Text'].new(:@leading-ws, :$request, :$resolver);
}

multi method include-line:text ($/ --> Nil)
{
    my IncludeLine::Request:D $request = $<include-line-request>.made;
    my IncludeLine::Resolver:D $resolver =
        self.gen-include-line-resolver($request, :text);
    make IncludeLine['Text'].new(:$request, :$resolver);
}

# --- end include-line }}}

method include-line-block:top ($/ --> Nil)
{
    my IncludeLine:D @include-line = @<include-line>».made;
    make IncludeLineBlock['Top'].new(:@include-line);
}

multi method include-line-block:after-blank-line ($/ --> Nil)
{
    my BlankLine:D $blank-line = $<blank-line>.made;
    my IncludeLine:D @include-line = @<include-line>».made;
    make IncludeLineBlock['BlankLine'].new(:$blank-line, :@include-line);
}

multi method include-line-block:after-comment-block ($/ --> Nil)
{
    my CommentBlock:D $comment-block = $<comment-block>.made;
    my IncludeLine:D @include-line = @<include-line>».made;
    make IncludeLineBlock['CommentBlock'].new(:$comment-block, :@include-line);
}

multi method include-line-block:after-horizontal-rule ($/ --> Nil)
{
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    my IncludeLine:D @include-line = @<include-line>».made;
    make IncludeLineBlock['HorizontalRule'].new(
        :$horizontal-rule,
        :@include-line
    );
}

# end include-line-block }}}
# sectional-block {{{

# --- sectional-block-name {{{

# --- --- sectional-block-name-identifier {{{

method sectional-block-name-identifier-export($/ --> Nil)
{
    make SectionalBlockName::Identifier::Export.new;
}

method sectional-block-name-identifier-file:absolute ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    make File['Absolute'].new(:$path);
}

method sectional-block-name-identifier-file:absolute-protocol ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-absolute-protocol>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    my Str:D $protocol = $<file-absolute-protocol>.made<file-protocol>;
    make File['Absolute', 'Protocol'].new(:$path, :$protocol);
}

method sectional-block-name-identifier-file:relative-protocol ($/ --> Nil)
{
    my Str:D $file-relative = $<file-relative-protocol>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    my Str:D $protocol = $<file-relative-protocol>.made<file-protocol>;
    make File['Relative', 'Protocol'].new(:$path, :$protocol);
}

method sectional-block-name-identifier:file ($/ --> Nil)
{
    my File:D $file = $<sectional-block-name-identifier-file>.made;
    make SectionalBlockName::Identifier['File'].new(:$file);
}

method sectional-block-name-identifier:word ($/ --> Nil)
{
    my Str:D $word = ~$/;
    make SectionalBlockName::Identifier['Word'].new(:$word);
}

# --- --- end sectional-block-name-identifier }}}
# --- --- sectional-block-name-operator {{{

method sectional-block-name-operator:additive ($/ --> Nil)
{
    make SectionalBlockName::Operator['Additive'].new;
}

method sectional-block-name-operator:redefine ($/ --> Nil)
{
    make SectionalBlockName::Operator['Redefine'].new;
}

# --- --- end sectional-block-name-operator }}}

multi method sectional-block-name(
    $/ where $<sectional-block-name-identifier-export>.so
        && $<sectional-block-name-operator>.so
    --> Nil
)
{
    my SectionalBlockName::Identifier:D $identifier =
        $<sectional-block-name-identifier>.made;
    my SectionalBlockName::Identifier::Export:D $export =
        $<sectional-block-name-identifier-export>.made;
    my SectionalBlockName::Operator:D $operator =
        $<sectional-block-name-operator>.made;
    make SectionalBlockName.new(:$identifier, :$export, :$operator);
}

multi method sectional-block-name(
    $/ where $<sectional-block-name-identifier-export>.so
    --> Nil
)
{
    my SectionalBlockName::Identifier:D $identifier =
        $<sectional-block-name-identifier>.made;
    my SectionalBlockName::Identifier::Export:D $export =
        $<sectional-block-name-identifier-export>.made;
    make SectionalBlockName.new(:$identifier, :$export);
}

multi method sectional-block-name(
    $/ where $<sectional-block-name-operator>.so
    --> Nil
)
{
    my SectionalBlockName::Identifier:D $identifier =
        $<sectional-block-name-identifier>.made;
    my SectionalBlockName::Operator:D $operator =
        $<sectional-block-name-operator>.made;
    make SectionalBlockName.new(:$identifier, :$operator);
}

multi method sectional-block-name($/ --> Nil)
{
    my SectionalBlockName::Identifier:D $identifier =
        $<sectional-block-name-identifier>.made;
    make SectionalBlockName.new(:$identifier);
}

# --- end sectional-block-name }}}
# --- sectional-block-content {{{

# --- --- sectional-block-content-text {{{

method sectional-block-content-text-backticks($/ --> Nil)
{
    make @<sectional-block-content-text-line-backticks>».made.join("\n");
}

method sectional-block-content-text-line-backticks($/ --> Nil)
{
    make ~$/;
}

method sectional-block-content-text-dashes($/ --> Nil)
{
    make @<sectional-block-content-text-line-dashes>».made.join("\n")
}

method sectional-block-content-text-line-dashes($/ --> Nil)
{
    make ~$/;
}

# --- --- end sectional-block-content-text }}}

method sectional-block-contents-backticks($/ --> Nil)
{
    make @<sectional-block-content-backticks>».made;
}

method sectional-block-content-backticks:include-line ($/ --> Nil)
{
    my IncludeLine:D $include-line = $<include-line>.made;
    make SectionalBlockContent['IncludeLine'].new(:$include-line);
}
method sectional-block-content-backticks:text ($/ --> Nil)
{
    my Str:D $text = $<sectional-block-content-text-backticks>.made;
    make SectionalBlockContent['Text'].new(:$text);
}

method sectional-block-contents-dashes($/ --> Nil)
{
    make @<sectional-block-content-dashes>».made;
}

method sectional-block-content-dashes:include-line ($/ --> Nil)
{
    my IncludeLine:D $include-line = $<include-line>.made;
    make SectionalBlockContent['IncludeLine'].new(:$include-line);
}
method sectional-block-content-dashes:text ($/ --> Nil)
{
    my Str:D $text = $<sectional-block-content-text-dashes>.made;
    make SectionalBlockContent['Text'].new(:$text);
}

# --- end sectional-block-content }}}
# --- sectional-block:backticks {{{

multi method sectional-block:backticks (
    $/ where $<sectional-block-contents-backticks>.so
        && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new(:@leading-ws);
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    my SectionalBlockContent:D @content-raw =
        $<sectional-block-contents-backticks>.made;
    my SectionalBlockContent:D @content = trim(@leading-ws, @content-raw);
    make SectionalBlock.new(:@content, :$delimiter, :$name);
}

multi method sectional-block:backticks (
    $/ where $<sectional-block-contents-backticks>.so
    --> Nil
)
{
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    my SectionalBlockContent:D @content =
        $<sectional-block-contents-backticks>.made;
    make SectionalBlock.new(:@content, :$delimiter, :$name);
}

multi method sectional-block:backticks (
    $/ where @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new(:@leading-ws);
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    make SectionalBlock.new(:$delimiter, :$name);
}

multi method sectional-block:backticks ($/ --> Nil)
{
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    make SectionalBlock.new(:$delimiter, :$name);
}

# --- end sectional-block:backticks }}}
# --- sectional-block:dashes {{{

multi method sectional-block:dashes (
    $/ where $<sectional-block-contents-dashes>.so
        && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my SectionalBlockDelimiter['Dashes'] $delimiter .= new(:@leading-ws);
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    my SectionalBlockContent:D @content-raw =
        $<sectional-block-contents-dashes>.made;
    my SectionalBlockContent:D @content = trim(@leading-ws, @content-raw);
    make SectionalBlock.new(:@content, :$delimiter, :$name);
}

multi method sectional-block:dashes (
    $/ where $<sectional-block-contents-dashes>.so
    --> Nil
)
{
    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    my SectionalBlockContent:D @content =
        $<sectional-block-contents-dashes>.made;
    make SectionalBlock.new(:@content, :$delimiter, :$name);
}

multi method sectional-block:dashes (
    $/ where @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my SectionalBlockDelimiter['Dashes'] $delimiter .= new(:@leading-ws);
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    make SectionalBlock.new(:$delimiter, :$name);
}

multi method sectional-block:dashes ($/ --> Nil)
{
    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    make SectionalBlock.new(:$delimiter, :$name);
}

# --- end sectional-block:dashes }}}

# end sectional-block }}}
# code-block {{{

# --- code-block-language {{{

method code-block-language($/ --> Nil)
{
    make ~$/;
}

# --- end code-block-language }}}
# --- code-block-content {{{

method code-block-content-backticks($/ --> Nil)
{
    make ~$/;
}

method code-block-content-dashes($/ --> Nil)
{
    make ~$/;
}

# --- end code-block-content }}}
# --- code-block:backticks {{{

multi method code-block:backticks (
    $/ where $<code-block-language>.so
        && $<code-block-content-backticks>.made.so
            && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Backticks'] $delimiter .= new(:@leading-ws);
    my Str:D $language = $<code-block-language>.made;
    my Str:D $text = trim(@leading-ws, $<code-block-content-backticks>.made);
    make CodeBlock.new(:$delimiter, :$language, :$text);
}

multi method code-block:backticks (
    $/ where $<code-block-language>.so
        && $<code-block-content-backticks>.made.so
    --> Nil
)
{
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $language = $<code-block-language>.made;
    my Str:D $text = $<code-block-content-backticks>.made.lines.join("\n");
    make CodeBlock.new(:$delimiter, :$language, :$text);
}

multi method code-block:backticks (
    $/ where $<code-block-language>.so
        && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Backticks'] $delimiter .= new(:@leading-ws);
    my Str:D $language = $<code-block-language>.made;
    make CodeBlock.new(:$delimiter, :$language);
}

multi method code-block:backticks (
    $/ where $<code-block-language>.so
    --> Nil
)
{
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $language = $<code-block-language>.made;
    make CodeBlock.new(:$delimiter, :$language);
}

multi method code-block:backticks (
    $/ where $<code-block-content-backticks>.made.so
        && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Backticks'] $delimiter .= new(:@leading-ws);
    my Str:D $text = trim(@leading-ws, $<code-block-content-backticks>.made);
    make CodeBlock.new(:$delimiter, :$text);
}

multi method code-block:backticks (
    $/ where $<code-block-content-backticks>.made.so
    --> Nil
)
{
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $text = $<code-block-content-backticks>.made.lines.join("\n");
    make CodeBlock.new(:$delimiter, :$text);
}

multi method code-block:backticks (
    $/ where @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Backticks'] $delimiter .= new(:@leading-ws);
    make CodeBlock.new(:$delimiter);
}

multi method code-block:backticks ($/ --> Nil)
{
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    make CodeBlock.new(:$delimiter);
}

# --- end code-block:backticks }}}
# --- code-block:dashes {{{

multi method code-block:dashes (
    $/ where $<code-block-language>.so
        && $<code-block-content-dashes>.made.so
            && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Dashes'] $delimiter .= new(:@leading-ws);
    my Str:D $language = $<code-block-language>.made;
    my Str:D $text = trim(@leading-ws, $<code-block-content-dashes>.made);
    make CodeBlock.new(:$delimiter, :$language, :$text);
}

multi method code-block:dashes (
    $/ where $<code-block-language>.so
        && $<code-block-content-dashes>.made.so
    --> Nil
)
{
    my CodeBlockDelimiter['Dashes'] $delimiter .= new;
    my Str:D $language = $<code-block-language>.made;
    my Str:D $text = $<code-block-content-dashes>.made.lines.join("\n");
    make CodeBlock.new(:$delimiter, :$language, :$text);
}

multi method code-block:dashes (
    $/ where $<code-block-language>.so
        && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Dashes'] $delimiter .= new(:@leading-ws);
    my Str:D $language = $<code-block-language>.made;
    make CodeBlock.new(:$delimiter, :$language);
}

multi method code-block:dashes (
    $/ where $<code-block-language>.so
    --> Nil
)
{
    my CodeBlockDelimiter['Dashes'] $delimiter .= new;
    my Str:D $language = $<code-block-language>.made;
    make CodeBlock.new(:$delimiter, :$language);
}

multi method code-block:dashes (
    $/ where $<code-block-content-dashes>.made.so
        && @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Dashes'] $delimiter .= new(:@leading-ws);
    my Str:D $text = trim(@leading-ws, $<code-block-content-dashes>.made);
    make CodeBlock.new(:$delimiter, :$text);
}

multi method code-block:dashes (
    $/ where $<code-block-content-dashes>.made.so
    --> Nil
)
{
    my CodeBlockDelimiter['Dashes'] $delimiter .= new;
    my Str:D $text = $<code-block-content-dashes>.made.lines.join("\n");
    make CodeBlock.new(:$delimiter, :$text);
}

multi method code-block:dashes (
    $/ where @<closing-ws>.so
    --> Nil
)
{
    my LeadingWS:D @leading-ws = @<closing-ws>».made;
    my CodeBlockDelimiter['Dashes'] $delimiter .= new(:@leading-ws);
    make CodeBlock.new(:$delimiter);
}

multi method code-block:dashes ($/ --> Nil)
{
    my CodeBlockDelimiter['Dashes'] $delimiter .= new;
    make CodeBlock.new(:$delimiter);
}

# --- end code-block:dashes }}}

# end code-block }}}
# reference-line-block {{{

# --- reference-line {{{

# --- --- reference-line-text {{{

method reference-line-text-first-line($/ --> Nil)
{
    make ~$/;
}

method reference-line-text-continuation($/ --> Nil)
{
    make ~$/;
}

multi method reference-line-text(
    $/ where @<reference-line-text-continuation>.so
    --> Nil
)
{
    make (
        $<reference-line-text-first-line>.made,
        @<reference-line-text-continuation>».made.join("\n")
    ).join("\n");
}

multi method reference-line-text($/ --> Nil)
{
    make $<reference-line-text-first-line>.made;
}

# --- --- end reference-line-text }}}

method reference-line($/ --> Nil)
{
    my ReferenceInline:D $reference-inline = $<reference-inline>.made;
    my Str:D $reference-text = $<reference-line-text>.made;
    make ReferenceLine.new(:$reference-inline, :$reference-text);
}

method reference-lines($/ --> Nil)
{
    make @<reference-line>».made;
}

# --- end reference-line }}}

method reference-line-block:top ($/ --> Nil)
{
    my ReferenceLine:D @reference-line = $<reference-lines>.made;
    make ReferenceLineBlock['Top'].new(:@reference-line);
}

method reference-line-block:after-blank-lines ($/ --> Nil)
{
    my BlankLine:D @blank-line = $<blank-lines>.made;
    my ReferenceLine:D @reference-line = $<reference-lines>.made;
    make ReferenceLineBlock['BlankLine'].new(:@blank-line, :@reference-line);
}

method reference-line-block:after-comment-block ($/ --> Nil)
{
    my CommentBlock:D $comment-block = $<comment-block>.made;
    my ReferenceLine:D @reference-line = $<reference-lines>.made;
    make ReferenceLineBlock['CommentBlock'].new(
        :$comment-block,
        :@reference-line
    );
}

method reference-line-block:after-horizontal-rule ($/ --> Nil)
{
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    my ReferenceLine:D @reference-line = $<reference-lines>.made;
    make ReferenceLineBlock['HorizontalRule'].new(
        :$horizontal-rule,
        :@reference-line
    );
}

method reference-line-blocks($/ --> Nil)
{
    make @<reference-line-block>».made;
}

# end reference-line-block }}}
# header-block {{{

method header-text($/ --> Nil)
{
    make ~$/;
}

method header1($/ --> Nil)
{
    my Str:D $text = $<header-text>.made;
    make Header[1].new(:$text);
}

method header2($/ --> Nil)
{
    my Str:D $text = $<header-text>.made;
    make Header[2].new(:$text);
}

method header3($/ --> Nil)
{
    my Str:D $text = $<header-text>.made;
    make Header[3].new(:$text);
}

method header:h1 ($/ --> Nil)
{
    make $<header1>.made;
}

method header:h2 ($/ --> Nil)
{
    make $<header2>.made;
}

method header:h3 ($/ --> Nil)
{
    make $<header3>.made;
}

multi method header-block:top ($/ --> Nil)
{
    my Header:D $header = $<header>.made;
    make HeaderBlock['Top'].new(:$header);
}

multi method header-block:after-blank-line ($/ --> Nil)
{
    my BlankLine:D $blank-line = $<blank-line>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['BlankLine'].new(:$blank-line, :$header);
}

multi method header-block:after-comment-block ($/ --> Nil)
{
    my CommentBlock:D $comment-block = $<comment-block>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['CommentBlock'].new(:$comment-block, :$header);
}

multi method header-block:after-horizontal-rule ($/ --> Nil)
{
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['HorizontalRule'].new(:$horizontal-rule, :$header);
}

# end header-block }}}
# list-block {{{

# --- list-ordered-item {{{

# --- --- list-ordered-item-number {{{

method list-ordered-item-number-value($/ --> Nil)
{
    make +$/;
}

method list-ordered-item-number-terminator:sym<.>($/ --> Nil)
{
    make ListItem::Number::Terminator['.'].new;
}

method list-ordered-item-number-terminator:sym<:>($/ --> Nil)
{
    make ListItem::Number::Terminator[':'].new;
}

method list-ordered-item-number-terminator:sym<)>($/ --> Nil)
{
    make ListItem::Number::Terminator[')'].new;
}

method list-ordered-item-number($/ --> Nil)
{
    my ListItem::Number::Terminator:D $terminator =
        $<list-ordered-item-number-terminator>.made;
    my UInt:D $value = $<list-ordered-item-number-value>.made;
    make ListItem::Number.new(:$terminator, :$value);
}

# --- --- end list-ordered-item-number }}}
# --- --- list-ordered-item-text {{{

method list-ordered-item-text-first-line($/ --> Nil)
{
    make ~$/;
}

method list-ordered-item-text-continuation($/ --> Nil)
{
    make ~$/;
}

multi method list-ordered-item-text(
    $/ where @<list-ordered-item-text-continuation>.so
    --> Nil
)
{
    make (
        $<list-ordered-item-text-first-line>.made,
        @<list-ordered-item-text-continuation>».made.join("\n")
    ).join("\n");
}

multi method list-ordered-item-text($/ --> Nil)
{
    make $<list-ordered-item-text-first-line>.made;
}

# --- --- end list-ordered-item-text }}}

method list-ordered-item($/ --> Nil)
{
    my ListItem::Number:D $number = $<list-ordered-item-number>.made;
    my Str:D $text =
        ?$<list-ordered-item-text> ?? $<list-ordered-item-text>.made !! '';
    make ListItem['Ordered'].new(:$number, :$text);
}

# --- end list-ordered-item }}}
# --- list-todo-item {{{

# --- --- checkbox {{{

# --- --- --- checkbox-checked {{{

method checkbox-checked-char:sym<x>($/ --> Nil)
{
    make CheckboxCheckedChar['x'].new;
}

method checkbox-checked-char:sym<o>($/ --> Nil)
{
    make CheckboxCheckedChar['o'].new;
}

method checkbox-checked-char:sym<v>($/ --> Nil)
{
    make CheckboxCheckedChar['v'].new;
}

method checkbox-checked($/ --> Nil)
{
    my CheckboxCheckedChar:D $char = $<checkbox-checked-char>.made;
    make Checkbox['Checked'].new(:$char);
}

# --- --- --- end checkbox-checked }}}
# --- --- --- checkbox-etc {{{

method checkbox-etc-char:sym<+>($/ --> Nil)
{
    make CheckboxEtcChar['+'].new;
}

method checkbox-etc-char:sym<=>($/ --> Nil)
{
    make CheckboxEtcChar['='].new;
}

method checkbox-etc-char:sym<->($/ --> Nil)
{
    make CheckboxEtcChar['-'].new;
}

method checkbox-etc($/ --> Nil)
{
    my CheckboxEtcChar:D $char = $<checkbox-etc-char>.made;
    make Checkbox['Etc'].new(:$char);
}

# --- --- --- end checkbox-etc }}}
# --- --- --- checkbox-exception {{{

method checkbox-exception-char:sym<*>($/ --> Nil)
{
    make CheckboxExceptionChar['*'].new;
}

method checkbox-exception-char:sym<!>($/ --> Nil)
{
    make CheckboxExceptionChar['!'].new;
}

method checkbox-exception($/ --> Nil)
{
    my CheckboxExceptionChar:D $char = $<checkbox-exception-char>.made;
    make Checkbox['Exception'].new(:$char);
}

# --- --- --- end checkbox-exception }}}
# --- --- --- checkbox-unchecked {{{

method checkbox-unchecked($/ --> Nil)
{
    make Checkbox['Unchecked'].new;
}

# --- --- --- end checkbox-unchecked }}}

method checkbox:checked ($/ --> Nil)
{
    make $<checkbox-checked>.made;
}

method checkbox:etc ($/ --> Nil)
{
    make $<checkbox-etc>.made;
}

method checkbox:exception ($/ --> Nil)
{
    make $<checkbox-exception>.made;
}

method checkbox:unchecked ($/ --> Nil)
{
    make $<checkbox-unchecked>.made;
}

# --- --- end checkbox }}}
# --- --- list-todo-item-text {{{

method list-todo-item-text($/ --> Nil)
{
    make ~$/;
}

# --- --- end list-todo-item-text }}}

method list-todo-item($/ --> Nil)
{
    my Checkbox:D $checkbox = $<checkbox>.made;
    my Str:D $text = $<list-todo-item-text>.made;
    make ListItem['Todo'].new(:$checkbox, :$text);
}

# --- end list-todo-item }}}
# --- list-unordered-item {{{

# --- --- bullet-point {{{

method bullet-point:sym<->($/ --> Nil)
{
    make BulletPoint['-'].new;
}

method bullet-point:sym<@>($/ --> Nil)
{
    make BulletPoint['@'].new;
}

method bullet-point:sym<#>($/ --> Nil)
{
    make BulletPoint['#'].new;
}

method bullet-point:sym<$>($/ --> Nil)
{
    make BulletPoint['$'].new;
}

method bullet-point:sym<*>($/ --> Nil)
{
    make BulletPoint['*'].new;
}

method bullet-point:sym<:>($/ --> Nil)
{
    make BulletPoint[':'].new;
}

method bullet-point:sym<x>($/ --> Nil)
{
    make BulletPoint['x'].new;
}

method bullet-point:sym<o>($/ --> Nil)
{
    make BulletPoint['o'].new;
}

method bullet-point:sym<+>($/ --> Nil)
{
    make BulletPoint['+'].new;
}

method bullet-point:sym<=>($/ --> Nil)
{
    make BulletPoint['='].new;
}

method bullet-point:sym<!>($/ --> Nil)
{
    make BulletPoint['!'].new;
}

method bullet-point:sym<~>($/ --> Nil)
{
    make BulletPoint['~'].new;
}

method bullet-point:sym«>»($/ --> Nil)
{
    make BulletPoint['>'].new;
}

method bullet-point:sym«<-»($/ --> Nil)
{
    make BulletPoint['<-'].new;
}

method bullet-point:sym«<=»($/ --> Nil)
{
    make BulletPoint['<='].new;
}

method bullet-point:sym«->»($/ --> Nil)
{
    make BulletPoint['->'].new;
}

method bullet-point:sym«=>»($/ --> Nil)
{
    make BulletPoint['=>'].new;
}

# --- --- end bullet-point }}}
# --- --- list-unordered-item-text {{{

method list-unordered-item-text-first-line($/ --> Nil)
{
    make ~$/;
}

method list-unordered-item-text-continuation($/ --> Nil)
{
    make ~$/;
}

multi method list-unordered-item-text(
    $/ where @<list-unordered-item-text-continuation>.so
    --> Nil
)
{
    make (
        $<list-unordered-item-text-first-line>.made,
        @<list-unordered-item-text-continuation>».made.join("\n")
    ).join("\n");
}

multi method list-unordered-item-text($/ --> Nil)
{
    make $<list-unordered-item-text-first-line>.made;
}

# --- --- end list-unordered-item-text }}}

method list-unordered-item($/ --> Nil)
{
    my BulletPoint:D $bullet-point = $<bullet-point>.made;
    my Str:D $text =
        ?$<list-unordered-item-text> ?? $<list-unordered-item-text>.made !! '';
    make ListItem['Unordered'].new(:$bullet-point, :$text);
}

# --- end list-unordered-item }}}

method list-item:ordered ($/ --> Nil)
{
    make $<list-ordered-item>.made;
}

method list-item:todo ($/ --> Nil)
{
    make $<list-todo-item>.made;
}

method list-item:unordered ($/ --> Nil)
{
    make $<list-unordered-item>.made;
}

method list-block($/ --> Nil)
{
    my ListItem:D @list-item = @<list-item>».made;
    make ListBlock.new(:@list-item);
}

# end list-block }}}
# paragraph {{{

method paragraph-line($/ --> Nil)
{
    make ~$/;
}

method paragraph($/ --> Nil)
{
    my Str:D $text = @<paragraph-line>».made.join("\n");
    make Paragraph.new(:$text);
}

# end paragraph }}}
# horizontal-rule {{{

method horizontal-rule-soft($/ --> Nil)
{
    make HorizontalRule['Soft'].new;
}

method horizontal-rule-hard($/ --> Nil)
{
    make HorizontalRule['Hard'].new;
}

method horizontal-rule:soft ($/ --> Nil)
{
    make $<horizontal-rule-soft>.made;
}

method horizontal-rule:hard ($/ --> Nil)
{
    make $<horizontal-rule-hard>.made;
}

# end horizontal-rule }}}
# comment-block {{{

method comment-text($/ --> Nil)
{
    make ~$/;
}

multi method comment($/ where $<comment-text>.made.so --> Nil)
{
    my Str:D $text = $<comment-text>.made;
    make Comment.new(:$text);
}

multi method comment($/ --> Nil)
{
    make Comment.new;
}

method comment-block($/ --> Nil)
{
    my Comment:D $comment = $<comment>.made;
    make CommentBlock.new(:$comment);
}

# end comment-block }}}
# blank-line {{{

method blank-line($/ --> Nil)
{
    my Str:D $text = ~$/;
    make BlankLine.new(:$text);
}

method blank-lines($/ --> Nil)
{
    make @<blank-line>».made;
}

# end blank-line }}}

=begin pod
=head Inline Elements
=end pod

# leading-ws {{{

method leading-ws:space ($/ --> Nil)
{
    make LeadingWS['Space'].new;
}

method leading-ws:tab ($/ --> Nil)
{
    make LeadingWS['Tab'].new;
}

# end leading-ws }}}
# string {{{

# --- string-basic {{{

# --- --- string-basic-char {{{

method string-basic-char:common ($/ --> Nil)
{
    make ~$/;
}

method string-basic-char:tab ($/ --> Nil)
{
    make ~$/;
}

method string-basic-char:escape-sequence ($/ --> Nil)
{
    make $<escape>.made;
}

# --- --- end string-basic-char }}}
# --- --- escape {{{

method escape:sym<b>($/ --> Nil)
{
    make "\b";
}

method escape:sym<t>($/ --> Nil)
{
    make "\t";
}

method escape:sym<n>($/ --> Nil)
{
    make "\n";
}

method escape:sym<f>($/ --> Nil)
{
    make "\f";
}

method escape:sym<r>($/ --> Nil)
{
    make "\r";
}

method escape:sym<quote>($/ --> Nil)
{
    make "\"";
}

method escape:sym<backslash>($/ --> Nil)
{
    make '\\';
}

method escape:sym<u>($/ --> Nil)
{
    make chr(:16(@<hex>.join));
}

method escape:sym<U>($/ --> Nil)
{
    make chr(:16(@<hex>.join));
}

# --- --- end escape }}}

method string-basic-text($/ --> Nil)
{
    make @<string-basic-char>».made.join;
}

method string-basic($/ --> Nil)
{
    make $<string-basic-text>.made;
}

# --- end string-basic }}}
# --- string-literal {{{

# --- --- string-literal-char {{{

method string-literal-char:common ($/ --> Nil)
{
    make ~$/;
}

method string-literal-char:backslash ($/ --> Nil)
{
    make '\\';
}

# --- --- end string-literal-char }}}

method string-literal-text($/ --> Nil)
{
    make @<string-literal-char>».made.join;
}

method string-literal($/ --> Nil)
{
    make $<string-literal-text>.made;
}

# --- end string-literal }}}

method string:basic ($/ --> Nil)
{
    make $<string-basic>.made;
}

method string:literal ($/ --> Nil)
{
    make $<string-literal>.made;
}

# end string }}}
# file {{{

# --- file-path-char {{{

method file-path-char:common ($/ --> Nil)
{
    make ~$/;
}

method file-path-char:escape-sequence ($/ --> Nil)
{
    make $<file-path-escape>.made;
}

# --- end file-path-char }}}
# --- file-path-escape {{{

method file-path-escape:sym<whitespace>($/ --> Nil)
{
    make ~$/;
}

method file-path-escape:sym<b>($/ --> Nil)
{
    make "\b";
}

method file-path-escape:sym<t>($/ --> Nil)
{
    make "\t";
}

method file-path-escape:sym<n>($/ --> Nil)
{
    make "\n";
}

method file-path-escape:sym<f>($/ --> Nil)
{
    make "\f";
}

method file-path-escape:sym<r>($/ --> Nil)
{
    make "\r";
}

method file-path-escape:sym<single-quote>($/ --> Nil)
{
    make "'";
}

method file-path-escape:sym<double-quote>($/ --> Nil)
{
    make "\"";
}

method file-path-escape:sym<fwdslash>($/ --> Nil)
{
    make '/';
}

method file-path-escape:sym<backslash>($/ --> Nil)
{
    make '\\';
}

method file-path-escape:sym<*>($/ --> Nil)
{
    make ~$/;
}

method file-path-escape:sym<[>($/ --> Nil)
{
    make ~$/;
}

method file-path-escape:sym<]>($/ --> Nil)
{
    make ~$/;
}

method file-path-escape:sym<{>($/ --> Nil)
{
    make ~$/;
}

method file-path-escape:sym<}>($/ --> Nil)
{
    make ~$/;
}

method file-path-escape:sym<u>($/ --> Nil)
{
    make chr(:16(@<hex>.join));
}

method file-path-escape:sym<U>($/ --> Nil)
{
    make chr(:16(@<hex>.join));
}

# --- end file-path-escape }}}
# --- file-protocol {{{

method file-protocol($/ --> Nil)
{
    make ~$/;
}

# --- end file-protocol }}}
# --- file-absolute {{{

# --- --- file-path-absolute {{{

method file-path-absolute-home($/ --> Nil)
{
    make ~$/;
}

method file-path-absolute-root($/ --> Nil)
{
    make ~$/;
}

multi method file-path-absolute($/ where @<file-path-absolute>.so --> Nil)
{
    make
        ~ $<file-path-absolute-root>.made
        ~ @<file-path-char>».made.join
        ~ @<file-path-absolute>».made.join;
}

multi method file-path-absolute($/ --> Nil)
{
    make $<file-path-absolute-root>.made ~ @<file-path-char>».made.join;
}

# --- --- end file-path-absolute }}}

multi method file-absolute:deep ($/ where $<file-path-absolute-home>.so --> Nil)
{
    my Str:D $file-absolute =
        $<file-path-absolute-home>.made ~ $<file-path-absolute>.made;
    make %(:$file-absolute);
}

multi method file-absolute:deep ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-path-absolute>.made;
    make %(:$file-absolute);
}

method file-absolute:home ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-path-absolute-home>.made;
    make %(:$file-absolute);
}

method file-absolute:root ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-path-absolute-root>.made;
    make %(:$file-absolute);
}

# --- end file-absolute }}}
# --- file-absolute-protocol {{{

method file-absolute-protocol($/ --> Nil)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my Str:D $file-protocol = $<file-protocol>.made;
    make %(:$file-absolute, :$file-protocol);
}

# --- end file-absolute-protocol }}}
# --- file-relative {{{

multi method file-path-relative($/ where @<file-path-absolute>.so --> Nil)
{
    make @<file-path-char>».made.join ~ @<file-path-absolute>».made.join;
}

multi method file-path-relative($/ --> Nil)
{
    make @<file-path-char>».made.join;
}

multi method file-relative($/ --> Nil)
{
    my Str:D $file-relative = $<file-path-relative>.made;
    make %(:$file-relative);
}

# --- end file-relative }}}
# --- file-relative-protocol {{{

method file-relative-protocol($/ --> Nil)
{
    my Str:D $file-relative = $<file-relative>.made<file-relative>;
    my Str:D $file-protocol = $<file-protocol>.made;
    make %(:$file-relative, :$file-protocol);
}

# --- end file-relative-protocol }}}

method file:absolute ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    make File['Absolute'].new(:$path);
}

method file:absolute-protocol ($/ --> Nil)
{
    my Str:D $file-absolute = $<file-absolute-protocol>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    my Str:D $protocol = $<file-absolute-protocol>.made<file-protocol>;
    make File['Absolute', 'Protocol'].new(:$path, :$protocol);
}

method file:relative ($/ --> Nil)
{
    my Str:D $file-relative = $<file-relative>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    make File['Relative'].new(:$path);
}

method file:relative-protocol ($/ --> Nil)
{
    my Str:D $file-relative = $<file-relative-protocol>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    my Str:D $protocol = $<file-relative-protocol>.made<file-protocol>;
    make File['Relative', 'Protocol'].new(:$path, :$protocol);
}

# end file }}}
# reference-inline {{{

method reference-inline-number($/ --> Nil)
{
    make +$/;
}

method reference-inline($/ --> Nil)
{
    my UInt:D $number = $<reference-inline-number>.made;
    make ReferenceInline.new(:$number);
}

# end reference-inline }}}

=begin pod
=head Helper Methods

=head2 Methods for Generating Closures

Generate closures in response to C<IncludeLine>s, which are found at
Finn document top level and within C<SectionalBlock>s.
=end pod

# method gen-include-line-resolver {{{

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Name'] $request,
    Bool:D :finn($)! where *.so
    --> IncludeLine::Resolver['Name']
)
{
    my IO::Path:D $absolute-path = $.file.IO.resolve;
    my Str:D $name = $request.name;
    my &document = self.gen-document-closure(
        IncludeLine::Request['Name'],
        $absolute-path,
        :await-self-document-parse,
        :finn
    );
    my &resolve = self.gen-sectional-block-closure(
        IncludeLine::Request['Name'],
        &document,
        :$name,
        :await-self-document-parse,
        :finn
    );
    my IncludeLine::Resolver['Name'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Name'] $request,
    Bool:D :text($)! where *.so
    --> IncludeLine::Resolver['Name']
)
{
    my IO::Path:D $absolute-path = $.file.IO.resolve;
    my Str:D $name = $request.name;
    my &document = self.gen-document-closure(
        IncludeLine::Request['Name'],
        $absolute-path,
        :await-self-document-parse,
        :text
    );
    my &resolve = self.gen-sectional-block-closure(
        IncludeLine::Request['Name'],
        &document,
        :$name,
        :await-self-document-parse,
        :text
    );
    my IncludeLine::Resolver['Name'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['File'] $request,
    Bool:D :finn($)! where *.so
    --> IncludeLine::Resolver['File']
)
{
    my File:D $file = $request.file;
    my IO::Path:D $absolute-path = self.resolve-path-from-file($file);
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['File'],
        $absolute-path,
        :defer-link-document-parse,
        :finn
    );
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['File'] $request,
    Bool:D :text($)! where *.so
    --> IncludeLine::Resolver['File']
)
{
    my File:D $file = $request.file;
    my IO::Path:D $absolute-path = self.resolve-path-from-file($file);
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['File'],
        $absolute-path,
        :defer-link-document-parse,
        :text
    );
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Reference'] $request,
    Bool:D :finn($)! where *.so
    --> IncludeLine::Resolver['Reference']
)
{
    my UInt:D $number = $request.reference-inline.number;
    my &reference = self.gen-reference-closure(
        IncludeLine::Request['Reference'],
        $number,
        :await-reference-table
    );
    my &absolute-path = self.gen-absolute-path-closure(
        IncludeLine::Request['Reference'],
        &reference,
        :await-reference-table
    );
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['Reference'],
        &absolute-path,
        :await-reference-table,
        :finn
    );
    my IncludeLine::Resolver['Reference'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Reference'] $request,
    Bool:D :text($)! where *.so
    --> IncludeLine::Resolver['Reference']
)
{
    my UInt:D $number = $request.reference-inline.number;
    my &reference = self.gen-reference-closure(
        IncludeLine::Request['Reference'],
        $number,
        :await-reference-table
    );
    my &absolute-path = self.gen-absolute-path-closure(
        IncludeLine::Request['Reference'],
        &reference,
        :await-reference-table
    );
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['Reference'],
        &absolute-path,
        :await-reference-table,
        :text
    );
    my IncludeLine::Resolver['Reference'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'File'] $request,
    Bool:D :finn($)! where *.so
    --> IncludeLine::Resolver['Name', 'File']
)
{
    my Str:D $name = $request.name;
    my File:D $file = $request.file;
    my IO::Path:D $absolute-path = self.resolve-path-from-file($file);
    my &document = self.gen-document-closure(
        IncludeLine::Request['Name', 'File'],
        $absolute-path,
        :defer-link-document-parse,
        :finn
    );
    my &resolve = self.gen-sectional-block-closure(
        IncludeLine::Request['Name', 'File'],
        &document,
        :$name,
        :defer-link-document-parse,
        :finn
    );
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'File'] $request,
    Bool:D :text($)! where *.so
    --> IncludeLine::Resolver['Name', 'File']
)
{
    my Str:D $name = $request.name;
    my File:D $file = $request.file;
    my IO::Path:D $absolute-path = self.resolve-path-from-file($file);
    my &document = self.gen-document-closure(
        IncludeLine::Request['Name', 'File'],
        $absolute-path,
        :defer-link-document-parse,
        :text
    );
    my &resolve = self.gen-sectional-block-closure(
        IncludeLine::Request['Name', 'File'],
        &document,
        :$name,
        :defer-link-document-parse,
        :text
    );
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'] $request,
    Bool:D :finn($)! where *.so
    --> IncludeLine::Resolver['Name', 'Reference']
)
{
    my Str:D $name = $request.name;
    my UInt:D $number = $request.reference-inline.number;
    my &reference = self.gen-reference-closure(
        IncludeLine::Request['Name', 'Reference'],
        $number,
        :await-reference-table
    );
    my &absolute-path = self.gen-absolute-path-closure(
        IncludeLine::Request['Name', 'Reference'],
        &reference,
        :await-reference-table
    );
    my &document = self.gen-document-closure(
        IncludeLine::Request['Name', 'Reference'],
        &absolute-path,
        :await-reference-table,
        :finn
    );
    my &resolve = self.gen-sectional-block-closure(
        IncludeLine::Request['Name', 'Reference'],
        &document,
        :$name,
        :await-reference-table,
        :finn
    );
    my IncludeLine::Resolver['Name', 'Reference'] $resolver .= new(:&resolve);
}

multi method gen-include-line-resolver(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'] $request,
    Bool:D :text($)! where *.so
    --> IncludeLine::Resolver['Name', 'Reference']
)
{
    my Str:D $name = $request.name;
    my UInt:D $number = $request.reference-inline.number;
    my &reference = self.gen-reference-closure(
        IncludeLine::Request['Name', 'Reference'],
        $number,
        :await-reference-table
    );
    my &absolute-path = self.gen-absolute-path-closure(
        IncludeLine::Request['Name', 'Reference'],
        &reference,
        :await-reference-table
    );
    my &document = self.gen-document-closure(
        IncludeLine::Request['Name', 'Reference'],
        &absolute-path,
        :await-reference-table,
        :text
    );
    my &resolve = self.gen-sectional-block-closure(
        IncludeLine::Request['Name', 'Reference'],
        &document,
        :$name,
        :await-reference-table,
        :text
    );
    my IncludeLine::Resolver['Name', 'Reference'] $resolver .= new(:&resolve);
}

# end method gen-include-line-resolver }}}

=begin pod
=head3 Ancillary Methods for Generating Closures

First parameter of type C<IncludeLine::Request> in methods is to prevent
paths from getting crossed.

Integrates a cache.
=end pod

# method gen-absolute-path-closure {{{

# resolve link text
multi method gen-absolute-path-closure(
    ::?CLASS:D:
    IncludeLine::Request['Reference'],
    Str:D &reference,
    Bool:D :await-reference-table($)! where *.so
    --> Sub:D
)
{
    my &resolve = self!gen-absolute-path-closure(&reference);
}

multi method gen-absolute-path-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'],
    Str:D &reference,
    Bool:D :await-reference-table($)! where *.so
    --> Sub:D
)
{
    my &resolve = self!gen-absolute-path-closure(&reference);
}

method !gen-absolute-path-closure(
    ::CLASS:D:
    Str:D &reference
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> IO::Path:D
    )
    {
        my Str:D $path-text = &reference(@reference-line-block);
        my File:D $file = self.get-or-parse-plus-cache-file($path-text);
        my IO::Path:D $absolute-path = self.resolve-path-from-file($file);
    }
}

# end method gen-absolute-path-closure }}}
# method gen-document-closure {{{

# get self Document from cache
multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name'],
    IO::Path:D $absolute-path,
    Bool:D :await-self-document-parse($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> Document:D)
    {
        my Document:D $document = self.get-document-from-cache($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name'],
    IO::Path:D $absolute-path,
    Bool:D :await-self-document-parse($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    # we need self Document parsed in Finn-mode for SectionalBlock by Name
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['Name'],
        $absolute-path,
        :await-self-document-parse,
        :finn
    );
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['File'],
    IO::Path:D $absolute-path,
    Bool:D :defer-link-document-parse($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> Document:D)
    {
        my Document:D $document =
            self.get-or-parse-plus-cache-document($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['File'],
    IO::Path:D $absolute-path,
    Bool:D :defer-link-document-parse($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> Str:D)
    {
        my Str:D $text = self.get-or-slurp-plus-cache-document($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Reference'],
    IO::Path:D &absolute-path,
    Bool:D :await-reference-table($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> Document:D
    )
    {
        my IO::Path:D $absolute-path = &absolute-path(@reference-line-block);
        my Document:D $document =
            self.get-or-parse-plus-cache-document($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Reference'],
    IO::Path:D &absolute-path,
    Bool:D :await-reference-table($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> Str:D
    )
    {
        my IO::Path:D $absolute-path = &absolute-path(@reference-line-block);
        my Str:D $text = self.get-or-slurp-plus-cache-document($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'File'],
    IO::Path:D $absolute-path,
    Bool:D :defer-link-document-parse($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> Document:D)
    {
        my Document:D $document =
            self.get-or-parse-plus-cache-document($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'File'],
    IO::Path:D $absolute-path,
    Bool:D :defer-link-document-parse($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    # we need link Document parsed in Finn-mode for SectionalBlock by Name
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['Name', 'File'],
        $absolute-path,
        :defer-link-document-parse,
        :finn
    );
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'],
    IO::Path:D &absolute-path,
    Bool:D :await-reference-table($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> Document:D
    )
    {
        my IO::Path:D $absolute-path = &absolute-path(@reference-line-block);
        my Document:D $document =
            self.get-or-parse-plus-cache-document($absolute-path);
    }
}

multi method gen-document-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'],
    IO::Path:D &absolute-path,
    Bool:D :await-reference-table($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    # we need link Document parsed in Finn-mode for SectionalBlock by Name
    my &resolve = self.gen-document-closure(
        IncludeLine::Request['Name', 'Reference'],
        &absolute-path,
        :await-reference-table,
        :finn
    );
}

# end method gen-document-closure }}}
# method gen-reference-closure {{{

# find link text referenced from request
multi method gen-reference-closure(
    ::?CLASS:D:
    IncludeLine::Request['Reference'],
    UInt:D $number,
    Bool:D :await-reference-table($)! where *.so
    --> Sub:D
)
{
    my &resolve = self!gen-reference-closure($number);
}

multi method gen-reference-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'],
    UInt:D $number,
    Bool:D :await-reference-table($)! where *.so
    --> Sub:D
)
{
    my &resolve = self!gen-reference-closure($number);
}

method !gen-reference-closure(
    ::?CLASS:D:
    UInt:D $number
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> Str:D
    )
    {
        my ReferenceLine:D $reference-line = @reference-line-block.flatmap({
            .reference-line.grep({ .reference-inline.number == $number })
        }).tail;
        my Str:D $reference-text = $reference-line.reference-text;
    }
}

# end method gen-reference-closure }}}
# method gen-sectional-block-closure {{{

multi method gen-sectional-block-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name'],
    &document,
    Str:D :$name! where *.so,
    Bool:D :await-self-document-parse($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> SectionalBlock:D)
    {
        my Document:D $document = &document();
        my SectionalBlock:D $sectional-block =
            self.resolve-sectional-block($document, :$name, :finn);
    }
}

multi method gen-sectional-block-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name'],
    &document,
    Str:D :$name! where *.so,
    Bool:D :await-self-document-parse($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> SectionalBlock:D)
    {
        my Document:D $document = &document();
        my Str:D $sectional-block =
            self.resolve-sectional-block($document, :$name, :text);
    }
}

multi method gen-sectional-block-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'File'],
    &document,
    Str:D :$name! where *.so,
    Bool:D :defer-link-document-parse($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> SectionalBlock:D)
    {
        my Document:D $document = &document();
        my SectionalBlock:D $sectional-block =
            self.resolve-sectional-block($document, :$name, :finn);
    }
}

multi method gen-sectional-block-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'File'],
    &document,
    Str:D :$name! where *.so,
    Bool:D :defer-link-document-parse($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (--> SectionalBlock:D)
    {
        my Document:D $document = &document();
        my Str:D $sectional-block =
            self.resolve-sectional-block($document, :$name, :text);
    }
}

multi method gen-sectional-block-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'],
    &document,
    Str:D :$name! where *.so,
    Bool:D :await-reference-table($)! where *.so,
    Bool:D :finn($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> SectionalBlock:D
    )
    {
        my Document:D $document = &document(@reference-line-block);
        my SectionalBlock:D $sectional-block =
            self.resolve-sectional-block($document, :$name, :finn);
    }
}

multi method gen-sectional-block-closure(
    ::?CLASS:D:
    IncludeLine::Request['Name', 'Reference'],
    &document,
    Str:D :$name! where *.so,
    Bool:D :await-reference-table($)! where *.so,
    Bool:D :text($)! where *.so
    --> Sub:D
)
{
    my &resolve = sub (
        ReferenceLineBlock:D @reference-line-block
        --> Str:D
    )
    {
        my Document:D $document = &document(@reference-line-block);
        my Str:D $sectional-block =
            self.resolve-sectional-block($document, :$name, :text);
    }
}

# end method gen-sectional-block-closure }}}

=begin pod
=head4 Ancillary Methods for Working With the Cache

=head5 Document (Finn-mode)
=end pod

# method get-document-from-cache {{{

multi method get-document-from-cache(
    ::?CLASS:D:
    IO::Path:D $absolute-path where {
        %Finn::Parser::Actions::Cache::document{~$_}:exists
    }
    --> Document:D
)
{
    my Document:D $document = %Finn::Parser::Actions::Cache::document{~$_};
}

multi method get-document-from-cache(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Nil
)
{
    Nil;
}

# end method get-document-from-cache }}}
# method get-or-parse-plus-cache-document {{{

# link Document exists in cache, so get it from cache
multi method get-or-parse-plus-cache-document(
    ::?CLASS:D:
    IO::Path:D $absolute-path where { self.get-document-from-cache($_).so }
    --> Document:D
)
{
    my Document:D $document = self.get-document-from-cache($absolute-path);
}

# link Document does not exist in cache, so parse it and add to cache
multi method get-or-parse-plus-cache-document(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Document:D
)
{
    my Document:D $document = self!parse-plus-cache-document($absolute-path);
}

# end method get-or-parse-plus-cache-document }}}
# method !cache-document {{{

method !cache-document(
    ::?CLASS:D:
    IO::Path:D $absolute-path,
    Document:D $document
    --> Nil
)
{
    my Str:D $file = ~$absolute-path;
    %Finn::Parser::Actions::Cache::document{$file} = $document;
}

# end method !cache-document }}}
# method !parse-document {{{

method !parse-document(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Document:D
)
{
    my Str:D $file = ~$absolute-path;
    my Finn::Parser::Actions $actions .=
        new(:$file, :$.project-root, :$.section);
    my Str:D $rule = 'document';
    my Document:D $document =
        Finn::Parser::Grammar.parsefile($file, :$actions, :$rule).made;
}

# end method !parse-document }}}
# method !parse-plus-cache-document {{{

method !parse-plus-cache-document(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Document:D
)
{
    my Document:D $document = self!parse-document($absolute-path);
    self!cache-document($absolute-path, $document);
    $document;
}

# end method !parse-plus-cache-document }}}

=begin pod
=head5 Document (Text-mode)
=end pod

# method get-docutext-from-cache {{{

multi method get-docutext-from-cache(
    ::?CLASS:D:
    IO::Path:D $absolute-path where {
        %Finn::Parser::Actions::Cache::docutext{~$_}:exists
    }
    --> Str:D
)
{
    my Str:D $text = %Finn::Parser::Actions::Cache::docutext{~$_};
}

multi method get-docutext-from-cache(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Nil
)
{
    Nil;
}

# end method get-docutext-from-cache }}}
# method get-or-slurp-plus-cache-docutext {{{

# link docutext exists in cache, so get it from cache
multi method get-or-slurp-plus-cache-docutext(
    ::?CLASS:D:
    IO::Path:D $absolute-path where { self.get-docutext-from-cache($_).so }
    --> Str:D
)
{
    my Str:D $text = self.get-docutext-from-cache($absolute-path);
}

# link docutext does not exist in cache, so slurp it and add to cache
multi method get-or-slurp-plus-cache-docutext(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Str:D
)
{
    my Str:D $text = self!slurp-plus-cache-docutext($absolute-path);
}

# end method get-or-slurp-plus-cache-docutext }}}
# method !cache-docutext {{{

method !cache-docutext(
    ::?CLASS:D:
    IO::Path:D $absolute-path,
    Str:D $text
    --> Nil
)
{
    my Str:D $file = ~$absolute-path;
    %Finn::Parser::Actions::Cache::docutext{$file} = $text;
}

# end method !cache-docutext }}}
# method !slurp-docutext {{{

method !slurp-docutext(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Str:D
)
{
    my Str:D $text = $absolute-path.slurp;
}

# end method !slurp-docutext }}}
# method !slurp-plus-cache-docutext {{{

method !slurp-plus-cache-docutext(
    ::?CLASS:D:
    IO::Path:D $absolute-path
    --> Str:D
)
{
    my Str:D $text = self!slurp-docutext($absolute-path);
    self!cache-docutext($absolute-path, $text);
    $text;
}

# end method !slurp-plus-cache-docutext }}}

=begin pod
=head5 File
=end pod

# method get-file-from-cache {{{

multi method get-file-from-cache(
    ::?CLASS:D:
    Str:D $path-text where { %Finn::Parser::Actions::Cache::file{$_}:exists }
    --> File:D
)
{
    my File:D $file = %Finn::Parser::Actions::Cache::file{$path-text};
}

multi method get-file-from-cache(
    ::?CLASS:D:
    Str:D $path-text
    --> Nil
)
{
    Nil;
}

# end method get-file-from-cache }}}
# method get-or-parse-plus-cache-file {{{

multi method get-or-parse-plus-cache-file(
    ::?CLASS:D:
    Str:D $path-text where { self.get-file-from-cache($_).so }
    --> File:D
)
{
    my File:D $file = self.get-file-from-cache($path-text);
}

multi method get-or-parse-plus-cache-file(
    ::?CLASS:D:
    Str:D $path-text
    --> File:D
)
{
    my File:D $file = self!parse-plus-cache-file($path-text);
}

# end method get-or-parse-plus-cache-file }}}
# method !cache-file {{{

method !cache-file(
    ::?CLASS:D:
    Str:D $path-text,
    File:D $file
    --> Nil
)
{
    %Finn::Parser::Actions::Cache::file{$path-text} = $file;
}

# end method !cache-file }}}
# method !parse-file {{{

method !parse-file(
    ::?CLASS:D:
    Str:D $path-text
    --> File:D
)
{
    my Finn::Parser::Actions $actions .=
        new(:$.file, :$.project-root, :$.section);
    my Str:D $rule = 'file';
    my File:D $file =
        Finn::Parser::Grammar.parse($path-text, :$actions, :$rule).made;
}

# end method !parse-file }}}
# method !parse-plus-cache-file {{{

method !parse-plus-cache-file(::?CLASS:D: Str:D $path-text --> File:D)
{
    my File:D $file = self!parse-file($path-text);
    self!cache-file($path-text, $file);
    $file;
}

# end method !parse-plus-cache-file }}}

=begin pod
=head2 Methods for Resolving File Paths and Named Sectional Blocks
=end pod

# method resolve-path-from-file {{{

# append relative to project root
multi method resolve-path-from-file(
    File['Absolute'] $file
    --> IO::Path:D
)
{
    my IO::Path:D $resolve = ($.project-root ~ $file.path.resolve).IO.resolve;
}

# absolute path
multi method resolve-path-from-file(
    File['Absolute', 'Protocol'] $file
    --> IO::Path:D
)
{
    my IO::Path:D $resolve = $file.path.resolve;
}

# relative path
multi method resolve-path-from-file(
    File['Relative'] $file
    --> IO::Path:D
)
{
    my IO::Path:D $resolve = $file.path.resolve;
}

# relative path
multi method resolve-path-from-file(
    File['Relative', 'Protocol'] $file
    --> IO::Path:D
)
{
    my IO::Path:D $resolve = $file.path.resolve;
}

# end method resolve-path-from-file }}}
# method resolve-sectional-block {{{

multi method resolve-sectional-block(
    ::?CLASS:D:
    Document:D $document,
    Str:D :$name! where *.so,
    Bool:D :finn($)! where *.so
    --> SectionalBlock:D
)
{
    my SectionalBlock:D @sectional-block = $document.sectional-block(:$name);
    my SectionalBlock:D $sectional-block =
        self.resolve-sectional-block(@sectional-block, :finn);
}

multi method resolve-sectional-block(
    ::?CLASS:D:
    Document:D $document,
    Str:D :$name! where *.so,
    Bool:D :text($)! where *.so
    --> Str:D
)
{
    my SectionalBlock:D @sectional-block = $document.sectional-block(:$name);
    my Str:D $sectional-block =
        self.resolve-sectional-block(@sectional-block, :text);
}

sub infix:<∑>(SectionalBlock:D, SectionalBlock:D --> SectionalBlock:D) {...}

multi method resolve-sectional-block(
    ::?CLASS:D:
    SectionalBlock:D @sectional-block,
    Bool:D :finn($)! where *.so
    --> SectionalBlock:D
)
{
    my SectionalBlock:D $sectional-block = [∑] @sectional-block;
}

multi method resolve-sectional-block(
    ::?CLASS:D:
    SectionalBlock:D @sectional-block,
    Bool:D :text($)! where *.so
    --> Str:D
)
{
    my SectionalBlock:D $sectional-block =
        self.resolve-sectional-block(@sectional-block, :finn);
    my Str:D $sectional-block-content = $sectional-block.Str;
}

# end method resolve-sectional-block }}}

=begin pod
=head Helper Subroutines
=end pod

# sub infix:<∑> {{{

# merge SectionalBlocks with matching name
sub infix:<∑>(
    SectionalBlock:D $a,
    SectionalBlock:D $b where {
        .name.identifier.word eq $a.name.identifier.word
    }
    --> SectionalBlock:D
)
{
    my SectionalBlock:D $sectional-block = merge($a, $b);
}

# end sub infix:<∑> }}}
# sub comb {{{

sub comb(
    LeadingWS:D @actual is copy,
    LeadingWS:D @padding
    --> Array:D
)
{
    die unless @actual.elems >= @padding.elems;
    @actual.splice(0, @padding.elems);
    @actual;
}

# end sub comb }}}
# sub gen-bounds {{{

sub gen-bounds(--> Chunk::Meta::Bounds:D)
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
# sub gen-include-line {{{

multi sub gen-include-line(
    IncludeLine['Finn'],
    LeadingWS:D :@leading-ws!,
    IncludeLine::Request:D :$request!,
    IncludeLine::Resolver:D :$resolver!
    --> IncludeLine['Finn']
)
{
    my IncludeLine['Finn'] $include .= new(:@leading-ws, :$request, :$resolver);
}

multi sub gen-include-line(
    IncludeLine['Text'],
    LeadingWS:D :@leading-ws!,
    IncludeLine::Request:D :$request!,
    IncludeLine::Resolver:D :$resolver!
    --> IncludeLine['Text']
)
{
    my IncludeLine['Text'] $include .= new(:@leading-ws, :$request, :$resolver);
}

# end sub gen-include-line }}}
# sub merge {{{

multi sub merge(
    SectionalBlock:D $a,
    SectionalBlock:D $b where {
        .operator ~~ SectionalBlockName::Operator['Additive']
    }
    --> SectionalBlock:D
)
{
    my SectionalBlockDelimiter:D $delimiter = $a.delimiter;

    my %name;
    my Str:D $word = $a.name.identifier.word;
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    %name<identifier> = $identifier;
    my SectionalBlockName::Identifier::Export $export .= new if $a.name.export;
    %name<export> = $export if $export;
    my SectionalBlockName $name .= new(|%name);

    my SectionalBlockContent:D @content = |$a.content, |$b.content;

    my SectionalBlock $sectional-block .= new(:$delimiter, :$name, :@content);
}

multi sub merge(
    SectionalBlock:D $a,
    SectionalBlock:D $b where {
        .operator ~~ SectionalBlockName::Operator['Redefine']
    }
    --> SectionalBlock:D
)
{
    my SectionalBlockDelimiter:D $delimiter = $a.delimiter;

    my %name;
    my Str:D $word = $a.name.identifier.word;
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    %name<identifier> = $identifier;
    my SectionalBlockName::Identifier::Export $export .= new if $a.name.export;
    %name<export> = $export if $export;
    my SectionalBlockName $name .= new(|%name);

    my SectionalBlockContent:D @content = |$b.content;

    my SectionalBlock $sectional-block .= new(:$delimiter, :$name, :@content);
}

multi sub merge(
    SectionalBlock $,
    SectionalBlock $
    --> SectionalBlock:D
)
{
    die;
}

# end sub merge }}}
# sub trim {{{

# XXX trim only handles tabs and spaces consistent with closing delimiter

# --- SectionalBlockContent {{{

multi sub trim(
    LeadingWS:D @leading-ws,
    SectionalBlockContent:D @content
    --> Array:D
)
{
    my SectionalBlockContent:D @c = (trim(@leading-ws, $_) for @content).Array;
}

multi sub trim(
    LeadingWS:D @leading-ws,
    SectionalBlockContent['IncludeLine'] $content
    --> SectionalBlockContent['IncludeLine']
)
{
    my LeadingWS:D @actual = $content.include-line.leading-ws;
    my LeadingWS:D @padding = @leading-ws;
    my LeadingWS:D @comb = comb(@actual, @padding);
    my IncludeLine::Request:D $request = $content.include-line.request;
    my IncludeLine::Resolver:D $resolver = $content.include-line.resolver;
    my IncludeLine:D $include-line = gen-include-line(
        $content.include-line.WHAT,
        :leading-ws(@comb),
        :$request,
        :$resolver
    );
    my SectionalBlockContent['IncludeLine'] $c .= new(:$include-line);
}

multi sub trim(
    LeadingWS:D @leading-ws,
    SectionalBlockContent['Text'] $content
    --> SectionalBlockContent['Text']
)
{
    my Str:D $text = trim(@leading-ws, $content.text);
    my SectionalBlockContent['Text'] $c .= new(:$text);
}

# --- end SectionalBlockContent }}}
# --- text {{{

multi sub trim(LeadingWS:D @leading-ws, Str:D $text --> Str:D)
{
    my Str:D $s = (trim-leading(@leading-ws, $_) for $text.lines).join("\n");
}

sub trim-leading(LeadingWS:D @leading-ws, Str:D $text --> Str:D)
{
    my Str:D $actual = $text.comb(/^\h*/).first;
    my Str:D $padding = @leading-ws».Str.join;
    die unless $actual.chars >= $padding.chars;
    my Str:D $s = $text.subst($padding, '');
}

# --- end text }}}

# end sub trim }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
