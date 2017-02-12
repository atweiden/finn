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
=head Elements
=end pod

# role BlankLine {{{

role BlankLine
{
    has Str:D $.text is required;
}

# end role BlankLine }}}
# role CodeBlock {{{

# --- role CodeBlockDelimiter {{{

role CodeBlockDelimiter['Backticks'] {*}
role CodeBlockDelimiter['Dashes'] {*}

# --- end role CodeBlockDelimiter }}}

# each Code Block has delimiters (dashes or backticks), a language and
# associated text
role CodeBlock
{
    has CodeBlockDelimiter:D $.delimiter is required;
    has Str $.language;
    has Str $.text;
}

# end role CodeBlock }}}
# role Comment {{{

role Comment
{
    has Str $.text;
}

# end role Comment }}}
# role CommentBlock {{{

role CommentBlock
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

role File['Absolute']             does File::Path {*}
role File['Absolute', 'Protocol'] does File::Path does File::Protocol {*}
role File['Relative']             does File::Path {*}
role File['Relative', 'Protocol'] does File::Path does File::Protocol {*}

# end role File }}}
# role Header {{{

role Header::Text { has Str:D $.text is required }
role Header[1] does Header::Text {*}
role Header[2] does Header::Text {*}
role Header[3] does Header::Text {*}

# end role Header }}}
# role HeaderBlock {{{

role HorizontalRule {...}

# Header comes after BlankLine
role HeaderBlock['BlankLine']
{
    has BlankLine:D $.blank-line is required;
    has Header:D $.header is required;
}

# Header comes after CommentBlock
role HeaderBlock['CommentBlock']
{
    has CommentBlock:D $.comment-block is required;
    has Header:D $.header is required;
}

# Header comes after HorizontalRule
role HeaderBlock['HorizontalRule']
{
    has HorizontalRule:D $.horizontal-rule is required;
    has Header:D $.header is required;
}

# Header comes at top of Finn document
role HeaderBlock['Top']
{
    has Header:D $.header is required;
}

# end role HeaderBlock }}}
# role HorizontalRule {{{

role HorizontalRule['Hard'] {*}
role HorizontalRule['Soft'] {*}

# end role HorizontalRule }}}
# role ListBlock {{{

role ListItem {...}

role ListBlock
{
    has ListItem:D @.list-item is required;
}

# end role ListBlock }}}
# role ListItem {{{

role ListItem::Text
{
    has Str:D $.text is required;
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

role ListItem['Ordered'] does ListItem::Text
{
    has ListItem::Number:D $.number is required;
}

# --- end role ListItem['Ordered'] }}}
# --- role ListItem['Todo'] {{{

# --- --- role Checkbox['Checked'] {{{

role CheckboxCheckedChar['x'] {*}
role CheckboxCheckedChar['o'] {*}
role CheckboxCheckedChar['v'] {*}

role Checkbox['Checked']
{
    has CheckboxCheckedChar:D $.char is required;
}

# --- --- end role Checkbox['Checked'] }}}
# --- --- role Checkbox['Etc'] {{{

role CheckboxEtcChar['+'] {*}
role CheckboxEtcChar['='] {*}
role CheckboxEtcChar['-'] {*}

role Checkbox['Etc']
{
    has CheckboxEtcChar:D $.char is required;
}

# --- --- end role Checkbox['Etc'] }}}
# --- --- role Checkbox['Exception'] {{{

role CheckboxExceptionChar['*'] {*}
role CheckboxExceptionChar['!'] {*}

role Checkbox['Exception']
{
    has CheckboxExceptionChar:D $.char is required;
}

# --- --- end role Checkbox['Exception'] }}}
# --- --- role Checkbox['Unchecked'] {{{

role Checkbox['Unchecked'] {*}

# --- --- end role Checkbox['Unchecked'] }}}

role ListItem['Todo'] does ListItem::Text
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

role ListItem['Unordered'] does ListItem::Text
{
    has BulletPoint:D $.bullet-point is required;
}

# --- end role ListItem['Unordered'] }}}

# end role ListItem }}}
# role Paragraph {{{

role Paragraph
{
    has Str:D $.text is required;
}

# end role Paragraph }}}
# role ReferenceBlock {{{

role ReferenceInline {...}
role ReferenceLine   {...}

role ReferenceBlock
{
    has HorizontalRule:D $.horizontal-rule is required;
    has ReferenceLine:D @.reference-line is required;
}

role ReferenceLine
{
    # the Reference Block Reference Line Reference Inline
    has ReferenceInline:D $.reference-inline is required;

    # the Reference Block Reference Line Text
    has Str:D $.reference-text is required;
}

# end role ReferenceBlock }}}
# role ReferenceInline {{{

role ReferenceInline
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
# --- role SectionalBlockContent {{{

# Sectional Block Content can feature Sectional Inlines
role SectionalBlockContent['SectionalInline']
{
    has SectionalInline:D $.sectional-inline is required;
}

# otherwise Sectional Block Content is considered text (source code)
role SectionalBlockContent['Text']
{
    has Str:D $.text is required;
}

# --- end role SectionalBlockContent }}}

# each Sectional Block has delimiters (dashes or backticks), a name
# and associated text
role SectionalBlock
{
    has SectionalBlockDelimiter:D $.delimiter is required;
    has SectionalBlockName:D $.name is required;
    has SectionalBlockContent:D @.content;
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
role SectionalInline['Name'] does SectionalInline::Name {*}

# C<role SectionalInline['File']> is a Haml-style include directive
# telling us to process the entirety of the linked Finn source file
# and embed in-place
role SectionalInline['File'] does SectionalInline::File {*}

# C<role SectionalInline['Reference']> is a Haml-style include
# directive telling us to process the entirety of the linked Finn
# source file given by Reference Inline and embed in-place
role SectionalInline['Reference'] does SectionalInline::Reference {*}

# C<role SectionalInline['Name', 'File']> is a Haml-style include
# directive with added specificity from C<sectional-block-name>
# qualifier, which gets stored in C<self.name>
#
# tells us to process C<self.name> from C<self.file> as Sectional Block
# and embed in-place
role SectionalInline['Name', 'File']
    does SectionalInline::Name
    does SectionalInline::File
{*}

# C<role SectionalInline['Name', 'Reference']> is the same as
# C<role SectionalInline['Name', 'File']> except the C<self.name>
# Sectional Block Name is searched for in the File resolved from
# Reference Inline
role SectionalInline['Name', 'Reference']
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
# role SectionalInlineBlock {{{

# SectionalInline comes after BlankLine
role SectionalInlineBlock['BlankLine']
{
    has BlankLine:D $.blank-line is required;
    has SectionalInline:D @.sectional-inline is required;
}

# SectionalInline comes after CommentBlock
role SectionalInlineBlock['CommentBlock']
{
    has CommentBlock:D $.comment-block is required;
    has SectionalInline:D @.sectional-inline is required;
}

# SectionalInline comes after HorizontalRule
role SectionalInlineBlock['HorizontalRule']
{
    has HorizontalRule:D $.horizontal-rule is required;
    has SectionalInline:D @.sectional-inline is required;
}

# SectionalInline comes at top of Finn document
role SectionalInlineBlock['Top']
{
    has SectionalInline:D @.sectional-inline is required;
}

# end role SectionalInlineBlock }}}

=begin pod
=head Chunks
=end pod

# role Chunk {{{

role Chunk::Meta {...}

# --- role Chunk['SectionalInlineBlock'] {{{

role Chunk['SectionalInlineBlock'] does Chunk::Meta
{
    has SectionalInlineBlock:D $.sectional-inline-block is required;
}

# --- end role Chunk['SectionalInlineBlock'] }}}
# --- role Chunk['SectionalBlock'] {{{

role Chunk['SectionalBlock'] does Chunk::Meta
{
    has SectionalBlock:D $.sectional-block is required;
}

# --- end role Chunk['SectionalBlock'] }}}
# --- role Chunk['CodeBlock'] {{{

role Chunk['CodeBlock'] does Chunk::Meta
{
    has CodeBlock:D $.code-block is required;
}

# --- end role Chunk['CodeBlock'] }}}
# --- role Chunk['ReferenceBlock'] {{{

role Chunk['ReferenceBlock'] does Chunk::Meta
{
    has ReferenceBlock:D $.reference-block is required;
}

# --- end role Chunk['ReferenceBlock'] }}}
# --- role Chunk['HeaderBlock'] {{{

role Chunk['HeaderBlock'] does Chunk::Meta
{
    has HeaderBlock:D $.header-block is required;
}

# --- end role Chunk['HeaderBlock'] }}}
# --- role Chunk['ListBlock'] {{{

role Chunk['ListBlock'] does Chunk::Meta
{
    has ListBlock:D $.list-block is required;
}

# --- end role Chunk['ListBlock'] }}}
# --- role Chunk['Paragraph'] {{{

role Chunk['Paragraph'] does Chunk::Meta
{
    has Paragraph:D $.paragraph is required;
}

# --- end role Chunk['Paragraph'] }}}
# --- role Chunk['HorizontalRule'] {{{

role Chunk['HorizontalRule'] does Chunk::Meta
{
    has HorizontalRule:D $.horizontal-rule is required;
}

# --- end role Chunk['HorizontalRule'] }}}
# --- role Chunk['CommentBlock'] {{{

role Chunk['CommentBlock'] does Chunk::Meta
{
    has CommentBlock:D $.comment-block is required;
}

# --- end role Chunk['CommentBlock'] }}}
# --- role Chunk['BlankLine'] {{{

role Chunk['BlankLine'] does Chunk::Meta
{
    has BlankLine:D $.blank-line is required;
}

# --- end role Chunk['BlankLine'] }}}

class Chunk::Meta::Bounds {...}

role Chunk::Meta
{
    # file:line:column
    has Chunk::Meta::Bounds:D $.bounds is required;

    # is a part of this section number
    has UInt:D $.section is required;
}

# --- class Chunk::Meta::Bounds {{{

role Chunk::Meta::Bounds::Boundary
{
    has UInt:D $.line is required;
    has UInt:D $.column is required;
}

class Chunk::Meta::Bounds::Begins does Chunk::Meta::Bounds::Boundary {*}
class Chunk::Meta::Bounds::Ends does Chunk::Meta::Bounds::Boundary {*}
class Chunk::Meta::Bounds
{
    has Chunk::Meta::Bounds::Begins:D $.begins is required;
    has Chunk::Meta::Bounds::Ends:D $.ends is required;
}

# --- end class Chunk::Meta::Bounds }}}

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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
