use v6;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::ParseTree

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

Finn::Parser::ParseTree contains punned roles, many of which are
parameterized, for building a parse tree from Finn source files.
=end pod

# end p6doc }}}

=begin pod
=head Bounds
=end pod

# class Bounds {{{

# --- role Boundary {{{

role Boundary
{
    has UInt:D $.line is required;
    has UInt:D $.column is required;
}

# --- end role Boundary }}}

class Bounds::Begins does Boundary {*}
class Bounds::Ends does Boundary {*}
class Bounds
{
    has Bounds::Begins:D $.begins is required;
    has Bounds::Ends:D $.ends is required;
}

# end class Bounds }}}

=begin pod
=head Content
=end pod

# role Content {{{

role Content
{
    # original text ($/.orig)
    has Str:D $.content is required;
}

# end role Content }}}

=begin pod
=head Elements
=end pod

# role BlankLine {{{

role BlankLine does Content {*}

# end role BlankLine }}}
# role Comment {{{

role Comment does Content
{
    has Str:D $.comment-delimiter-opening is required;
    has Str:D $.comment-delimiter-closing is required;
    has Str:D $.comment-text is required;
}

# end role Comment }}}
# role CommentBlock {{{

role CommentBlock does Content
{
    has Comment:D $.comment is required;
}

# end role CommentBlock }}}
# role File {{{

# C<File::Path> contains a file path given in Finn source document
role File::Path
{
    has IO::Path:D $.path is required;
}

# C<File::Protocol> is instantiated when C<File::Path> comes with
# a protocol (e.g. file://) prepended to it
role File::Protocol
{
    has Str:D $.protocol is required;
}

role File['Absolute']             does Content does File::Path {*}
role File['Absolute', 'Protocol'] does Content does File::Path does File::Protocol {*}
role File['Relative']             does Content does File::Path {*}
role File['Relative', 'Protocol'] does Content does File::Path does File::Protocol {*}

# end role File }}}
# role Header {{{

role Header::Text { has Str:D $.header-text is required }
role Header[1] does Content does Header::Text {*}
role Header[2] does Content does Header::Text {*}
role Header[3] does Content does Header::Text {*}

# end role Header }}}
# role HeaderBlock {{{

# Header comes after BlankLine
role HeaderBlock['BlankLine'] does Content
{
    has BlankLine:D $.blank-line is required;
    has Header:D $.header is required;
}

# Header comes after CommentBlock
role HeaderBlock['CommentBlock'] does Content
{
    has CommentBlock:D $.comment-block is required;
    has Header:D $.header is required;
}

# Header comes after HorizontalRule
role HeaderBlock['HorizontalRule'] does Content
{
    has HorizontalRule $.horizontal-rule is required;
    has Header:D $.header is required;
}

# Header comes at top of Finn document
role HeaderBlock['Top'] does Content
{
    has Header:D $.header is required;
}

# end role HeaderBlock }}}
# role HorizontalRule {{{

role HorizontalRule['Hard'] does Content {*}
role HorizontalRule['Soft'] does Content {*}

# end role HorizontalRule }}}
# role ListBlock {{{

role ListItem {...}

role ListBlock does Content
{
    has ListItem:D @.list-item is required;
}

# end role ListBlock }}}
# role ListItem {{{

role ListItem::Text
{
    has Str:D $.list-item-text is required;
}

# --- role ListItem['Ordered'] {{{

role ListItem::Number::Terminator['.'] {*}
role ListItem::Number::Terminator[':'] {*}
role ListItem::Number::Terminator[')'] {*}

role ListItem::Number
{
    has ListItem::Number::Terminator:D $.terminator is required;
    has UInt:D $.value is required;
}

role ListItem['Ordered'] does Content does ListItem::Text
{
    has ListItem::Number:D $.number is required;
}

# --- end role ListItem['Ordered'] }}}
# --- role ListItem['Todo'] {{{

# --- --- role Checkbox['Checked'] {{{

role CheckboxCheckedChar['x'] {*}
role CheckboxCheckedChar['o'] {*}
role CheckboxCheckedChar['v'] {*}

role Checkbox['Checked'] does Content
{
    has CheckboxCheckedChar:D $.checkbox-checked-char is required;
}

# --- --- end role Checkbox['Checked'] }}}
# --- --- role Checkbox['Etc'] {{{

role CheckboxEtcChar['+'] {*}
role CheckboxEtcChar['='] {*}
role CheckboxEtcChar['-'] {*}

role Checkbox['Etc'] does Content
{
    has CheckboxEtcChar:D $.checkbox-etc-char is required;
}

# --- --- end role Checkbox['Etc'] }}}
# --- --- role Checkbox['Exception'] {{{

role CheckboxExceptionChar['*'] {*}
role CheckboxExceptionChar['!'] {*}

role Checkbox['Exception'] does Content
{
    has CheckboxExceptionChar:D $.checkbox-exception-char is required;
}

# --- --- end role Checkbox['Exception'] }}}
# --- --- role Checkbox['Unchecked'] {{{

role Checkbox['Unchecked'] does Content {*}

# --- --- end role Checkbox['Unchecked'] }}}

role ListItem['Todo'] does Content does ListItem::Text
{
    has Checkbox:D $.checkbox is required;
}

# --- end role ListItem['Todo'] }}}
# --- role ListItem['Unordered'] {{{

# --- --- role BulletPoint {{{

role BulletPoint['-']  {*}
role BulletPoint['@']  {*}
role BulletPoint['#']  {*}
role BulletPoint['$']  {*}
role BulletPoint['*']  {*}
role BulletPoint[':']  {*}
role BulletPoint['x']  {*}
role BulletPoint['o']  {*}
role BulletPoint['+']  {*}
role BulletPoint['=']  {*}
role BulletPoint['!']  {*}
role BulletPoint['~']  {*}
role BulletPoint['>']  {*}
role BulletPoint['<-'] {*}
role BulletPoint['<='] {*}
role BulletPoint['->'] {*}
role BulletPoint['=>'] {*}

# --- --- end role BulletPoint }}}

role ListItem['Unordered'] does Content does ListItem::Text
{
    has BulletPoint:D $.bullet-point is required;
}

# --- end role ListItem['Unordered'] }}}

# end role ListItem }}}
# role ReferenceBlock {{{

role ReferenceInline {...}

# --- role ReferenceLine {{{

role ReferenceLine
{
    # the Reference Block Reference Line Reference Inline
    has ReferenceInline:D $.reference-inline is required;

    # the Reference Block Reference Line Text
    has Str:D $.reference-text is required;
}

# --- end role ReferenceLine }}}

role ReferenceBlock does Content
{
    has ReferenceLine:D @.reference-line is required;
}

# end role ReferenceBlock }}}
# role ReferenceInline {{{

role ReferenceInline does Content
{
    # the Reference Inline Number
    has UInt:D $.number is required;
}

# end role ReferenceInline }}}
# role SectionalBlock {{{

role SectionalInline {...}

# --- role SectionalBlockDelimiter {{{

role SectionalBlockDelimiter['Backticks'] {*}
role SectionalBlockDelimiter['Dashes'] {*}

# --- end role SectionalBlockDelimiter }}}
# --- role SectionalBlockName {{{

role SectionalBlockName::Identifier::Export {*}

# the Sectional Block Name is a file
role SectionalBlockName::Identifier['File']
{
    has File:D $.file is required;
}

# the Sectional Block Name is an unquoted string
role SectionalBlockName::Identifier['Word']
{
    has Str:D $.word is required;
}

# Sectional Block Name Operator can be either additive (+=) or
# redefine (:=)
role SectionalBlockName::Operator['Additive'] {*}
role SectionalBlockName::Operator['Redefine'] {*}

# Sectional Block Name has an identifier, which may be exported,
# and an optional Operator
role SectionalBlockName
{
    has SectionalBlockName::Identifier:D $.identifier is required;
    has SectionalBlockName::Identifier::Export $.export;
    has SectionalBlockName::Operator $.operator;
}

# --- end role SectionalBlockName }}}
# --- role SectionalBlockText {{{

# Sectional Block Content can feature Sectional Inlines
role SectionalBlockText::Chunk['SectionalInline']
{
    has SectionalInline:D $.sectional-inline is required;
}

# Sectional Block Content is considered source code by default
role SectionalBlockText::Chunk['SourceCode']
{
    has Str:D $.source-code is required;
}

# each Sectional Block contains chunks of C<SectionalBlockText>
role SectionalBlockText
{
    has SectionalBlockText::Chunk:D @.chunk is required;
}

# --- end role SectionalBlockText }}}

# each Sectional Block has delimiters (dashes or backticks), a name
# and associated text
role SectionalBlock does Content
{
    has SectionalBlockDelimiter:D $.delimiter is required;
    has SectionalBlockName:D $.name is required;
    has SectionalBlockText:D $.text is required;
}

# end role SectionalBlock }}}
# role SectionalInline {{{

role SectionalInline::Name      {...}
role SectionalInline::File      {...}
role SectionalInline::Reference {...}

# C<role SectionalInline['Name']> is a Haml-style include directive
# telling us to process C<self.name> as Sectional Block and embed
# in-place
# XXX: it can only appear inside of a Sectional Block
role SectionalInline['Name']
    does Content
    does SectionalInline::Name
{*}

# C<role SectionalInline['File']> is a Haml-style include directive
# telling us to process the entirety of the linked Finn source file
# and embed in-place
role SectionalInline['File']
    does Content
    does SectionalInline::File
{*}

# C<role SectionalInline['Reference']> is a Haml-style include
# directive telling us to process the entirety of the linked Finn
# source file given by Reference Inline and embed in-place
role SectionalInline['Reference']
    does Content
    does SectionalInline::Reference
{*}

# C<role SectionalInline['Name', 'File']> is a Haml-style include
# directive with added specificity from C<sectional-block-name>
# qualifier, which gets stored in C<self.name>
#
# tells us to process C<self.name> from C<self.file> as Sectional Block
# and embed in-place
role SectionalInline['Name', 'File']
    does Content
    does SectionalInline::Name
    does SectionalInline::File
{*}

# C<role SectionalInline['Name', 'Reference']> is the same as
# C<role SectionalInline['Name', 'File']> except the C<self.name>
# Sectional Block Name is searched for in the File resolved from
# Reference Inline
role SectionalInline['Name', 'Reference']
    does Content
    does SectionalInline::Name
    does SectionalInline::Reference
{*}

role SectionalInline::Name
{
    # the linked Sectional Block Name
    has Str:D $.name is required;
}

role SectionalInline::File
{
    # the linked Finn source file
    has File:D $.file is required;
}

role SectionalInline::Reference
{
    # the linked Reference Inline
    has ReferenceInline:D $.reference-inline is required;
}

# end role SectionalInline }}}

=begin pod
=head Chunks
=end pod

# role Chunk {{{

role Chunk::Meta {...}

# --- role Chunk['SectionalInlineBlock'] {{{

role Chunk['SectionalInlineBlock'] does Chunk::Meta does Content
{
    has SectionalInline:D @.sectional-inline is required;
}

# --- end role Chunk['SectionalInlineBlock'] }}}
# --- role Chunk['SectionalBlock'] {{{

role Chunk['SectionalBlock'] does Chunk::Meta does Content
{
    has SectionalBlock:D $.sectional-block is required;
}

# --- end role Chunk['SectionalBlock'] }}}
# --- role Chunk['CodeBlock'] {{{

role Chunk['CodeBlock'] does Chunk::Meta does Content {*}

# --- end role Chunk['CodeBlock'] }}}
# --- role Chunk['ReferenceBlock'] {{{

role Chunk['ReferenceBlock'] does Chunk::Meta does Content
{
    has ReferenceBlock:D $.reference-block is required;
}

# --- end role Chunk['ReferenceBlock'] }}}
# --- role Chunk['HeaderBlock'] {{{

role Chunk['HeaderBlock'] does Chunk::Meta does Content
{
    has HeaderBlock:D $.header-block is required;
}

# --- end role Chunk['HeaderBlock'] }}}
# --- role Chunk['ListBlock'] {{{

role Chunk['ListBlock'] does Chunk::Meta does Content
{
    has ListBlock:D $.list-block is required;
}

# --- end role Chunk['ListBlock'] }}}
# --- role Chunk['ParagraphBlock'] {{{

role Chunk['ParagraphBlock'] does Chunk::Meta does Content {*}

# --- end role Chunk['ParagraphBlock'] }}}
# --- role Chunk['HorizontalRule'] {{{

role Chunk['HorizontalRule'] does Chunk::Meta does Content
{
    has HorizontalRule:D $.horizontal-rule is required;
}

# --- end role Chunk['HorizontalRule'] }}}
# --- role Chunk['CommentBlock'] {{{

role Chunk['CommentBlock'] does Chunk::Meta does Content
{
    has CommentBlock:D $.comment-block is required;
}

# --- end role Chunk['CommentBlock'] }}}
# --- role Chunk['BlankLine'] {{{

role Chunk['BlankLine'] does Chunk::Meta does Content
{
    has BlankLine:D $.blank-line is required;
}

# --- end role Chunk['BlankLine'] }}}

role Chunk::Meta
{
    # file:line:column
    has Bounds:D $.bounds is required;

    # is a part of this section number
    has UInt:D $.section is required;
}

# end role Chunk }}}

=begin pod
=head Document
=end pod

# class Document {{{

class Document
{
    has Chunk:D @.chunk is required;
}

# end class Document }}}

=begin pod
=head Parse Tree
=end pod

# class Finn::Parser::ParseTree {{{

class Finn::Parser::ParseTree
{
    has Document:D $.document is required;
}

# end class Finn::Parser::ParseTree }}}

=begin pod
=head Content
=end pod

# role Content::CodeBlock {{{

=begin pod
Reprocess content for:

=over
=item syntax highlighting
=back
=end pod

# end role Content::CodeBlock }}}
# role Content::Prose {{{

=begin pod
Reprocess content for:

=over
=item bold
=item italic
=item underline
=item strikethrough
=item boolean
=item date
=item time
=item callout
=item log-level
=item string
=item url
=item file
=item reference-inline
=item code-inline
=item sectional-link
=back

When C<bold>, C<italic>, C<underline>, C<strikethrough>, C<boolean>,
C<date>, C<time>, C<callout>, C<log-level>, C<string>, C<url> or
C<file> or is encountered, Finn stores this context for high-level
client syntax highlighting.

When C<reference-inline> is encountered, Finn stores the reference's
content.

When C<code-inline> is encountered, Finn processes it with
C<Content::Code> and default syntax.

When C<sectional-link> is encountered, Finn stores the linked
Sectional Block Name and the linked file path if given.
=end pod

# end role Content::Prose }}}
# role Content::SectionalBlock {{{

=begin pod
Reprocess content for:

=over
=item sectional-inline
=back

When a C<sectional-inline> is encountered, Finn follows the link,
parses potentially deeply nested include directives and returns the
result.
=end pod

# end role Content::SectionalBlock }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
