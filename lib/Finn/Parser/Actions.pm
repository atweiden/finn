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
=head Block Elements
=end pod

# sectional-inline-block {{{

# --- sectional-inline {{{

method sectional-inline-text:name-and-file ($/)
{
    my Str:D $name = $<sectional-inline-name>.made;
    my File:D $file = $<sectional-inline-file>.made;
    make SectionalInline['Name', 'File'].new(:$name, :$file);
}

method sectional-inline-text:name-and-reference ($/)
{
    my Str:D $name = $<sectional-inline-name>.made;
    my ReferenceInline:D $reference-inline = $<sectional-inline-reference>.made;
    make SectionalInline['Name', 'Reference'].new(:$name, :$reference-inline);
}

method sectional-inline-text:file-only ($/)
{
    my File:D $file = $<sectional-inline-file>.made;
    make SectionalInline['File'].new(:$file);
}

method sectional-inline-text:reference-only ($/)
{
    my ReferenceInline:D $reference-inline = $<sectional-inline-reference>.made;
    make SectionalInline['Reference'].new(:$reference-inline);
}

method sectional-inline-text:name-only ($/)
{
    my Str:D $name = $<sectional-inline-name>.made;
    make SectionalInline['Name'].new(:$name);
}

method sectional-inline($/)
{
    make $<sectional-inline-text>.made;
}

# --- end sectional-inline }}}

method sectional-inline-block:top ($/)
{
    my SectionalInline:D @sectional-inline = @<sectional-inline>».made;
    make SectionalInlineBlock['Top'].new(:@sectional-inline);
}

multi method sectional-inline-block:after-blank-line ($/)
{
    my BlankLine:D $blank-line = $<blank-line>.made;
    my SectionalInline:D @sectional-inline = @<sectional-inline>».made;
    make SectionalInlineBlock['BlankLine'].new(
        :$blank-line,
        :@sectional-inline
    );
}

multi method sectional-inline-block:after-comment-block ($/)
{
    my CommentBlock:D $comment-block = $<comment-block>.made;
    my SectionalInline:D @sectional-inline = @<sectional-inline>».made;
    make SectionalInlineBlock['CommentBlock'].new(
        :$comment-block,
        :@sectional-inline
    );
}

multi method sectional-inline-block:after-horizontal-rule ($/)
{
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    my SectionalInline:D @sectional-inline = @<sectional-inline>».made;
    make SectionalInlineBlock['HorizontalRule'].new(
        :$horizontal-rule,
        :@sectional-inline
    );
}

# end sectional-inline-block }}}
# sectional-block {{{

# --- sectional-block-name {{{

# --- --- sectional-block-name-identifier {{{

method sectional-block-name-identifier-export($/)
{
    make SectionalBlockName::Identifier::Export.new;
}

method sectional-block-name-identifier-file:absolute ($/)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    make File['Absolute'].new(:$path);
}

method sectional-block-name-identifier-file:absolute-protocol ($/)
{
    my Str:D $file-absolute = $<file-absolute-protocol>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    my Str:D $protocol = $<file-absolute-protocol>.made<file-protocol>;
    make File['Absolute', 'Protocol'].new(:$path, :$protocol);
}

method sectional-block-name-identifier-file:relative-protocol ($/)
{
    my Str:D $file-relative = $<file-relative-protocol>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    my Str:D $protocol = $<file-relative-protocol>.made<file-protocol>;
    make File['Relative', 'Protocol'].new(:$path, :$protocol);
}

method sectional-block-name-identifier:file ($/)
{
    my File:D $file = $<sectional-block-name-identifier-file>.made;
    make SectionalBlockName::Identifier['File'].new(:$file);
}

method sectional-block-name-identifier:word ($/)
{
    my Str:D $word = ~$/;
    make SectionalBlockName::Identifier['Word'].new(:$word);
}

# --- --- end sectional-block-name-identifier }}}
# --- --- sectional-block-name-operator {{{

method sectional-block-name-operator:additive ($/)
{
    make SectionalBlockName::Operator::Additive.new;
}

method sectional-block-name-operator:redefine ($/)
{
    make SectionalBlockName::Operator::Redefine.new;
}

# --- --- end sectional-block-name-operator }}}

method sectional-block-name($/)
{
    my SectionalBlockName::Identifier:D $identifier =
        $<sectional-block-name-identifier>.made;
    my SectionalBlockName::Identifier::Export:D $export =
        $<sectional-block-name-identifier-export>.made
            if ?$<sectional-block-name-identifier-export>;
    my SectionalBlockName::Operator:D $operator =
        $<sectional-block-name-operator>.made
            if ?$<sectional-block-name-operator>;

    my %h;
    %h<export> = $export if $export;
    %h<operator> = $operator if $operator;

    make SectionalBlockName.new(:$identifier, |%h);
}

# --- end sectional-block-name }}}
# --- sectional-block-content {{{

# --- --- sectional-block-content-line {{{

method sectional-block-content-line-backticks:sectional-inline ($/)
{
    my SectionalInline:D $sectional-inline = $<sectional-inline>.made;
    make SectionalBlockContent['SectionalInline'].new(:$sectional-inline);
}

method sectional-block-content-line-backticks:text ($/)
{
    my Str:D $text = ~$/;
    make SectionalBlockContent['Text'].new(:$text);
}

method sectional-block-content-line-dashes:sectional-inline ($/)
{
    my SectionalInline:D $sectional-inline = $<sectional-inline>.made;
    make SectionalBlockContent['SectionalInline'].new(:$sectional-inline);
}

method sectional-block-content-line-dashes:text ($/)
{
    my Str:D $text = ~$/;
    make SectionalBlockContent['Text'].new(:$text);
}

# --- --- end sectional-block-content-line }}}

method sectional-block-content-backticks($/)
{
    my SectionalBlockContent:D @content =
        @<sectional-block-content-line-backticks>».made;
    make @content;
}

method sectional-block-content-dashes($/)
{
    my SectionalBlockContent:D @content =
        @<sectional-block-content-line-dashes>».made;
    make @content;
}

# --- end sectional-block-content }}}

method sectional-block:backticks ($/)
{
    my SectionalBlockContent:D @content =
        $<sectional-block-content-backticks>.made;
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    make SectionalBlock.new(:@content, :$delimiter, :$name);
}

method sectional-block:dashes ($/)
{
    my SectionalBlockContent:D @content =
        $<sectional-block-content-dashes>.made;
    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    make SectionalBlock.new(:@content, :$delimiter, :$name);
}

# end sectional-block }}}
# code-block {{{

# --- code-block-language {{{

method code-block-language($/)
{
    make ~$/;
}

# --- end code-block-language }}}
# --- code-block-content {{{

method code-block-content-backticks($/)
{
    make ~$/;
}

method code-block-content-dashes($/)
{
    make ~$/;
}

# --- end code-block-content }}}

method code-block:backticks ($/)
{
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $language =
        ?$<code-block-language> ?? $<code-block-language>.made !! '';
    my Str:D $text = $<code-block-content-backticks>.made;
    make CodeBlock.new(:$delimiter, :$language, :$text);
}

method code-block:dashes ($/)
{
    my CodeBlockDelimiter['Dashes'] $delimiter .= new;
    my Str:D $language =
        ?$<code-block-language> ?? $<code-block-language>.made !! '';
    my Str:D $text = $<code-block-content-dashes>.made;
    make CodeBlock.new(:$delimiter, :$language, :$text);
}

# end code-block }}}
# reference-block {{{

method reference-block-reference-line-text($/)
{
    make ~$/;
}

method reference-block-reference-line($/)
{
    my ReferenceInline:D $reference-inline = $<reference-inline>.made;
    my Str:D $reference-text = $<reference-block-reference-line-text>.made;
    make ReferenceLine.new(:$reference-inline, :$reference-text);
}

method reference-block($/)
{
    my HorizontalRule['Hard'] $horizontal-rule = $<horizontal-rule-hard>.made;
    my ReferenceLine:D @reference-line = @<reference-block-reference-line>».made;
    make ReferenceBlock.new(:$horizontal-rule, :@reference-line);
}

# end reference-block }}}
# header-block {{{

method header-text($/)
{
    make ~$/;
}

method header1($/)
{
    my Str:D $text = $<header-text>.made;
    make Header[1].new(:$text);
}

method header2($/)
{
    my Str:D $text = $<header-text>.made;
    make Header[2].new(:$text);
}

method header3($/)
{
    my Str:D $text = $<header-text>.made;
    make Header[3].new(:$text);
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

multi method header-block:top ($/)
{
    my Header:D $header = $<header>.made;
    make HeaderBlock['Top'].new(:$header);
}

multi method header-block:after-blank-line ($/)
{
    my BlankLine:D $blank-line = $<blank-line>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['BlankLine'].new(:$blank-line, :$header);
}

multi method header-block:after-comment-block ($/)
{
    my CommentBlock:D $comment-block = $<comment-block>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['CommentBlock'].new(:$comment-block, :$header);
}

multi method header-block:after-horizontal-rule ($/)
{
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['HorizontalRule'].new(:$horizontal-rule, :$header);
}

# end header-block }}}
# list-block {{{

# --- list-ordered-item {{{

# --- --- list-ordered-item-number {{{

method list-ordered-item-number-value($/)
{
    make +$/;
}

method list-ordered-item-number-terminator:sym<.>($/)
{
    make ListItem::Number::Terminator['.'].new;
}

method list-ordered-item-number-terminator:sym<:>($/)
{
    make ListItem::Number::Terminator[':'].new;
}

method list-ordered-item-number-terminator:sym<)>($/)
{
    make ListItem::Number::Terminator[')'].new;
}

method list-ordered-item-number($/)
{
    my ListItem::Number::Terminator:D $terminator =
        $<list-ordered-item-number-terminator>.made;
    my UInt:D $value = $<list-ordered-item-number-value>.made;
    make ListItem::Number.new(:$terminator, :$value);
}

# --- --- end list-ordered-item-number }}}
# --- --- list-ordered-item-text {{{

method list-ordered-item-text-first-line($/)
{
    make ~$/;
}

method list-ordered-item-text-continuation($/)
{
    make ~$/;
}

multi method list-ordered-item-text(
    $/ where @<list-ordered-item-text-continuation>.so
)
{
    make (
        $<list-ordered-item-text-first-line>.made,
        @<list-ordered-item-text-continuation>».made.join("\n")
    ).join("\n");
}

multi method list-ordered-item-text($/)
{
    make $<list-ordered-item-text-first-line>.made;
}

# --- --- end list-ordered-item-text }}}

method list-ordered-item($/)
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

method checkbox-checked-char:sym<x>($/) { make CheckboxCheckedChar['x'].new }
method checkbox-checked-char:sym<o>($/) { make CheckboxCheckedChar['o'].new }
method checkbox-checked-char:sym<v>($/) { make CheckboxCheckedChar['v'].new }

method checkbox-checked($/)
{
    my CheckboxCheckedChar:D $char = $<checkbox-checked-char>.made;
    make Checkbox['Checked'].new(:$char);
}

# --- --- --- end checkbox-checked }}}
# --- --- --- checkbox-etc {{{

method checkbox-etc-char:sym<+>($/) { make CheckboxEtcChar['+'].new }
method checkbox-etc-char:sym<=>($/) { make CheckboxEtcChar['='].new }
method checkbox-etc-char:sym<->($/) { make CheckboxEtcChar['-'].new }

method checkbox-etc($/)
{
    my CheckboxEtcChar:D $char = $<checkbox-etc-char>.made;
    make Checkbox['Etc'].new(:$char);
}

# --- --- --- end checkbox-etc }}}
# --- --- --- checkbox-exception {{{

method checkbox-exception-char:sym<*>($/) { make CheckboxExceptionChar['*'].new }
method checkbox-exception-char:sym<!>($/) { make CheckboxExceptionChar['!'].new }

method checkbox-exception($/)
{
    my CheckboxExceptionChar:D $char = $<checkbox-exception-char>.made;
    make Checkbox['Exception'].new(:$char);
}

# --- --- --- end checkbox-exception }}}
# --- --- --- checkbox-unchecked {{{

method checkbox-unchecked($/)
{
    make Checkbox['Unchecked'].new;
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
    my Checkbox:D $checkbox = $<checkbox>.made;
    my Str:D $text = $<list-todo-item-text>.made;
    make ListItem['Todo'].new(:$checkbox, :$text);
}

# --- end list-todo-item }}}
# --- list-unordered-item {{{

# --- --- bullet-point {{{

method bullet-point:sym<->($/)  { make BulletPoint['-'].new }
method bullet-point:sym<@>($/)  { make BulletPoint['@'].new }
method bullet-point:sym<#>($/)  { make BulletPoint['#'].new }
method bullet-point:sym<$>($/)  { make BulletPoint['$'].new }
method bullet-point:sym<*>($/)  { make BulletPoint['*'].new }
method bullet-point:sym<:>($/)  { make BulletPoint[':'].new }
method bullet-point:sym<x>($/)  { make BulletPoint['x'].new }
method bullet-point:sym<o>($/)  { make BulletPoint['o'].new }
method bullet-point:sym<+>($/)  { make BulletPoint['+'].new }
method bullet-point:sym<=>($/)  { make BulletPoint['='].new }
method bullet-point:sym<!>($/)  { make BulletPoint['!'].new }
method bullet-point:sym<~>($/)  { make BulletPoint['~'].new }
method bullet-point:sym«>»($/)  { make BulletPoint['>'].new }
method bullet-point:sym«<-»($/) { make BulletPoint['<-'].new }
method bullet-point:sym«<=»($/) { make BulletPoint['<='].new }
method bullet-point:sym«->»($/) { make BulletPoint['->'].new }
method bullet-point:sym«=>»($/) { make BulletPoint['=>'].new }

# --- --- end bullet-point }}}
# --- --- list-unordered-item-text {{{

method list-unordered-item-text-first-line($/)
{
    make ~$/;
}

method list-unordered-item-text-continuation($/)
{
    make ~$/;
}

multi method list-unordered-item-text(
    $/ where @<list-unordered-item-text-continuation>.so
)
{
    make (
        $<list-unordered-item-text-first-line>.made,
        @<list-unordered-item-text-continuation>».made.join("\n")
    ).join("\n");
}

multi method list-unordered-item-text($/)
{
    make $<list-unordered-item-text-first-line>.made;
}

# --- --- end list-unordered-item-text }}}

method list-unordered-item($/)
{
    my BulletPoint:D $bullet-point = $<bullet-point>.made;
    my Str:D $text =
        ?$<list-unordered-item-text> ?? $<list-unordered-item-text>.made !! '';
    make ListItem['Unordered'].new(:$bullet-point, :$text);
}

# --- end list-unordered-item }}}

method list-item:ordered ($/)
{
    make $<list-ordered-item>.made;
}

method list-item:todo ($/)
{
    make $<list-todo-item>.made;
}

method list-item:unordered ($/)
{
    make $<list-unordered-item>.made;
}

method list-block($/)
{
    my ListItem:D @list-item = @<list-item>».made;
    make ListBlock.new(:@list-item);
}

# end list-block }}}
# paragraph {{{

method paragraph-line($/)
{
    make ~$/;
}

method paragraph($/)
{
    my Str:D $text = @<paragraph-line>».made.join("\n");
    make Paragraph.new(:$text);
}

# end paragraph }}}
# horizontal-rule {{{

method horizontal-rule-soft($/)
{
    make HorizontalRule['Soft'].new;
}

method horizontal-rule-hard($/)
{
    make HorizontalRule['Hard'].new;
}

method horizontal-rule:soft ($/)
{
    make $<horizontal-rule-soft>.made;
}

method horizontal-rule:hard ($/)
{
    make $<horizontal-rule-hard>.made;
}

# end horizontal-rule }}}
# comment-block {{{

method comment-text($/)
{
    make ~$/;
}

method comment($/)
{
    my Str:D $text = $<comment-text>.made;
    make Comment.new(:$text);
}

method comment-block($/)
{
    my Comment:D $comment = $<comment>.made;
    make CommentBlock.new(:$comment);
}

# end comment-block }}}
# blank-line {{{

method blank-line($/)
{
    my Str:D $text = ~$/;
    make BlankLine.new(:$text);
}

# end blank-line }}}

=begin pod
=head Inline Elements
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

method file-path-escape:sym<*>($/)
{
    make ~$/;
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
    make ~$/;
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

multi method file-absolute($/)
{
    my Str:D $file-absolute = $<file-path-absolute>.made;
    make %(:$file-absolute);
}

# --- end file-absolute }}}
# --- file-absolute-protocol {{{

method file-absolute-protocol($/)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my Str:D $file-protocol = $<file-protocol>.made;
    make %(:$file-absolute, :$file-protocol);
}

# --- end file-absolute-protocol }}}
# --- file-relative {{{

multi method file-path-relative($/ where @<file-path-absolute>.so)
{
    make @<file-path-char>».made.join ~ @<file-path-absolute>».made.join;
}

multi method file-path-relative($/)
{
    make @<file-path-char>».made.join;
}

multi method file-relative($/)
{
    my Str:D $file-relative = $<file-path-relative>.made;
    make %(:$file-relative);
}

# --- end file-relative }}}
# --- file-relative-protocol {{{

method file-relative-protocol($/)
{
    my Str:D $file-relative = $<file-relative>.made<file-relative>;
    my Str:D $file-protocol = $<file-protocol>.made;
    make %(:$file-relative, :$file-protocol);
}

# --- end file-relative-protocol }}}

method file:absolute ($/)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    make File['Absolute'].new(:$path);
}

method file:absolute-protocol ($/)
{
    my Str:D $file-absolute = $<file-absolute-protocol>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    my Str:D $protocol = $<file-absolute-protocol>.made<file-protocol>;
    make File['Absolute', 'Protocol'].new(:$path, :$protocol);
}

method file:relative ($/)
{
    my Str:D $file-relative = $<file-relative>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    make File['Relative'].new(:$path);
}

method file:relative-protocol ($/)
{
    my Str:D $file-relative = $<file-relative-protocol>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    my Str:D $protocol = $<file-relative-protocol>.made<file-protocol>;
    make File['Relative', 'Protocol'].new(:$path, :$protocol);
}

# end file }}}
# reference-inline {{{

method reference-inline-number($/)
{
    make +$/;
}

method reference-inline($/)
{
    my UInt:D $number = $<reference-inline-number>.made;
    make ReferenceInline.new(:$number);
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
