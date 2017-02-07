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
    my Str:D $content = ~$/;
    my SectionalInlineBlock:D $sectional-inline-block =
        $<sectional-inline-block>.made;
    make Chunk['SectionalInlineBlock'].new(
        :$bounds,
        :$section,
        :$content,
        :$sectional-inline-block
    );
}

method chunk:sectional-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my SectionalBlock:D $sectional-block = $<sectional-block>.made;
    make Chunk['SectionalBlock'].new(
        :$bounds,
        :$section,
        :$content,
        :$sectional-block
    );
}

method chunk:code-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my CodeBlock:D $code-block = $<code-block>.made;
    make Chunk['CodeBlock'].new(:$bounds, :$section, :$content, :$code-block);
}

method chunk:reference-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my ReferenceBlock:D $reference-block = $<reference-block>.made;
    make Chunk['ReferenceBlock'].new(
        :$bounds,
        :$section,
        :$content,
        :$reference-block
    );
}

method chunk:header-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my HeaderBlock:D $header-block = $<header-block>.made;
    make Chunk['HeaderBlock'].new(
        :$bounds,
        :$section,
        :$content,
        :$header-block
    );
}

method chunk:list-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my ListBlock:D $list-block = $<list-block>.made;
    make Chunk['ListBlock'].new(:$bounds, :$section, :$content, :$list-block);
}

method chunk:paragraph ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my Paragraph:D $paragraph = $<paragraph>.made;
    make Chunk['Paragraph'].new(:$bounds, :$section, :$content, :$paragraph);
}

method chunk:horizontal-rule ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    make Chunk['HorizontalRule'].new(
        :$bounds,
        :$section,
        :$content,
        :$horizontal-rule
    );
}

method chunk:comment-block ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my CommentBlock:D $comment-block = $<comment-block>.made;
    make Chunk['CommentBlock'].new(
        :$bounds,
        :$section,
        :$content,
        :$comment-block
    );
}

method chunk:blank-line ($/)
{
    my Bounds:D $bounds = gen-bounds();
    my UInt:D $section = 0;
    my Str:D $content = ~$/;
    my BlankLine:D $blank-line = $<blank-line>.made;
    make Chunk['BlankLine'].new(:$bounds, :$section, :$content, :$blank-line);
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
=head Block Text
=end pod

# sectional-inline-block {{{

# --- sectional-inline {{{

method sectional-inline-text:name-and-file ($/)
{
    my Str:D $content = ~$/;
    my Str:D $name = $<sectional-inline-name>.made;
    my File:D $file = $<sectional-inline-file>.made;
    make SectionalInline['Name', 'File'].new(:$content, :$name, :$file);
}

method sectional-inline-text:name-and-reference ($/)
{
    my Str:D $content = ~$/;
    my Str:D $name = $<sectional-inline-name>.made;
    my ReferenceInline:D $reference-inline = $<sectional-inline-reference>.made;
    make SectionalInline['Name', 'Reference'].new(
        :$content,
        :$name,
        :$reference-inline
    );
}

method sectional-inline-text:file-only ($/)
{
    my Str:D $content = ~$/;
    my File:D $file = $<sectional-inline-file>.made;
    make SectionalInline['File'].new(:$content, :$file);
}

method sectional-inline-text:reference-only ($/)
{
    my Str:D $content = ~$/;
    my ReferenceInline:D $reference-inline = $<sectional-inline-reference>.made;
    make SectionalInline['Reference'].new(:$content, :$reference-inline);
}

method sectional-inline-text:name-only ($/)
{
    my Str:D $content = ~$/;
    my Str:D $name = $<sectional-inline-name>.made;
    make SectionalInline['Name'].new(:$content, :$name);
}

method sectional-inline($/)
{
    make $<sectional-inline-text>.made;
}

# --- end sectional-inline }}}

method sectional-inline-block:top ($/)
{
    my Str:D $content = ~$/;
    my SectionalInline:D @sectional-inline = @<sectional-inline>».made;
    make SectionalInlineBlock.new(:$content, :@sectional-inline);
}

method sectional-inline-block:dispersed ($/)
{
    my Str:D $content = ~$/;
    my SectionalInline:D @sectional-inline = @<sectional-inline>».made;
    make SectionalInlineBlock.new(:$content, :@sectional-inline);
}

# end sectional-inline-block }}}
# sectional-block {{{

# --- sectional-block-name {{{

# --- --- sectional-block-name-identifier {{{

method sectional-block-name-identifier-export($/)
{
    make SectionalBlockName::Identifier::Export.new;
}

method sectional-block-name-identifier:file ($/)
{
    my File:D $file = $<file-absolute>.made;
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

method sectional-block-content-backticks($/)
{
    make ~$/;
}

method sectional-block-content-dashes($/)
{
    make ~$/;
}

# --- end sectional-block-content }}}

method sectional-block:backticks ($/)
{
    my Str:D $content = ~$/;
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    my Str:D $text = $<sectional-block-content-backticks>.made;
    make SectionalBlock.new(:$content, :$delimiter, :$name, :$text);
}

method sectional-block:dashes ($/)
{
    my Str:D $content = ~$/;
    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;
    my SectionalBlockName:D $name = $<sectional-block-name>.made;
    my Str:D $text = $<sectional-block-content-dashes>.made;
    make SectionalBlock.new(:$content, :$delimiter, :$name, :$text);
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
    my Str:D $content = ~$/;
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $language = $<code-block-language>.made;
    my Str:D $text = $<code-block-content-backticks>.made;
    make CodeBlock.new(:$content, :$delimiter, :$language, :$text);
}

method code-block:dashes ($/)
{
    my Str:D $content = ~$/;
    my CodeBlockDelimiter['Dashes'] $delimiter .= new;
    my Str:D $language = $<code-block-language>.made;
    my Str:D $text = $<code-block-content-dashes>.made;
    make CodeBlock.new(:$content, :$delimiter, :$language, :$text);
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
    my Str:D $content = ~$/;
    my Str:D $header-text = $<header-text>.made;
    make Header[1].new(:$content, :$header-text);
}

method header2($/)
{
    my Str:D $content = ~$/;
    my Str:D $header-text = $<header-text>.made;
    make Header[2].new(:$content, :$header-text);
}

method header3($/)
{
    my Str:D $content = ~$/;
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

multi method header-block:top ($/)
{
    my Str:D $content = ~$/;
    my Header:D $header = $<header>.made;
    make HeaderBlock['Top'].new(:$content, :$header);
}

multi method header-block:after-blank-line ($/)
{
    my Str:D $content = ~$/;
    my BlankLine:D $blank-line = $<blank-line>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['BlankLine'].new(:$content, :$blank-line, :$header);
}

multi method header-block:after-comment-block ($/)
{
    my Str:D $content = ~$/;
    my CommentBlock:D $comment-block = $<comment-block>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['CommentBlock'].new(:$content, :$comment-block, :$header);
}

multi method header-block:after-horizontal-rule ($/)
{
    my Str:D $content = ~$/;
    my HorizontalRule:D $horizontal-rule = $<horizontal-rule>.made;
    my Header:D $header = $<header>.made;
    make HeaderBlock['HorizontalRule'].new(
        :$content,
        :$horizontal-rule,
        :$header
    );
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
    my Str:D $content = ~$/;
    my Str:D $list-item-text =
        ?$<list-ordered-item-text> ?? $<list-ordered-item-text>.made !! '';
    my ListItem::Number:D $number = $<list-ordered-item-number>.made;
    make ListItem['Ordered'].new(:$content, :$list-item-text, :$number);
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
    my Str:D $content = ~$/;
    my CheckboxCheckedChar:D $checkbox-checked-char =
        $<checkbox-checked-char>.made;
    make Checkbox['Checked'].new(:$content, :$checkbox-checked-char);
}

# --- --- --- end checkbox-checked }}}
# --- --- --- checkbox-etc {{{

method checkbox-etc-char:sym<+>($/) { make CheckboxEtcChar['+'].new }
method checkbox-etc-char:sym<=>($/) { make CheckboxEtcChar['='].new }
method checkbox-etc-char:sym<->($/) { make CheckboxEtcChar['-'].new }

method checkbox-etc($/)
{
    my Str:D $content = ~$/;
    my CheckboxEtcChar:D $checkbox-etc-char = $<checkbox-etc-char>.made;
    make Checkbox['Etc'].new(:$content, :$checkbox-etc-char);
}

# --- --- --- end checkbox-etc }}}
# --- --- --- checkbox-exception {{{

method checkbox-exception-char:sym<*>($/) { make CheckboxExceptionChar['*'].new }
method checkbox-exception-char:sym<!>($/) { make CheckboxExceptionChar['!'].new }

method checkbox-exception($/)
{
    my Str:D $content = ~$/;
    my CheckboxExceptionChar:D $checkbox-exception-char =
        $<checkbox-exception-char>.made;
    make Checkbox['Exception'].new(:$content, :$checkbox-exception-char);
}

# --- --- --- end checkbox-exception }}}
# --- --- --- checkbox-unchecked {{{

method checkbox-unchecked($/)
{
    my Str:D $content = ~$/;
    make Checkbox['Unchecked'].new(:$content);
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
    my Str:D $content = ~$/;
    my Str:D $list-item-text = $<list-todo-item-text>.made;
    my Checkbox:D $checkbox = $<checkbox>.made;
    make ListItem['Todo'].new(:$content, :$checkbox, :$list-item-text);
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
    my Str:D $content = ~$/;
    my Str:D $list-item-text =
        ?$<list-unordered-item-text> ?? $<list-unordered-item-text>.made !! '';
    my BulletPoint:D $bullet-point = $<bullet-point>.made;
    make ListItem['Unordered'].new(:$content, :$list-item-text, :$bullet-point);
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
    my Str:D $content = ~$/;
    my ListItem:D @list-item = @<list-item>».made;
    make ListBlock.new(:$content, :@list-item);
}

# end list-block }}}
# paragraph {{{

method paragraph-line($/)
{
    make ~$/;
}

method paragraph($/)
{
    my Str:D $content = ~$/;
    my Str:D $text = @<paragraph-line>».made.join("\n");
    make Paragraph.new(:$content, :$text);
}

# end paragraph }}}
# horizontal-rule {{{

method horizontal-rule-soft($/)
{
    my Str:D $content = ~$/;
    make HorizontalRule['Soft'].new(:$content);
}

method horizontal-rule-hard($/)
{
    my Str:D $content = ~$/;
    make HorizontalRule['Hard'].new(:$content);
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
    my Str:D $content = ~$/;
    my Str:D $comment-text = $<comment-text>.made;
    make Comment.new(:$content, :$comment-text);
}

method comment-block($/)
{
    my Str:D $content = ~$/;
    my Comment:D $comment = $<comment>.made;
    make CommentBlock.new(:$content, :$comment);
}

# end comment-block }}}
# blank-line {{{

method blank-line($/)
{
    my Str:D $content = ~$/;
    make BlankLine.new(:$content);
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
    my Str:D $content = ~$/;
    my IO::Path:D $path = IO::Path.new($<file-path-absolute>.made);
    my File::Protocol:D $protocol = $<file-protocol>.made;
    make File['Absolute', 'Protocol'].new(:$content, :$path, :$protocol);
}

multi method file-absolute($/)
{
    my Str:D $content = ~$/;
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
    my Str:D $content = ~$/;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $<file-path-relative>.made);
    my File::Protocol:D $protocol = $<file-protocol>.made;
    make File['Relative', 'Protocol'].new(:$content, :$path, :$protocol);
}

multi method file-relative($/)
{
    my Str:D $content = ~$/;
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
    my Str:D $content = ~$/;
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
