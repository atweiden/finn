use v6;
use Finn::Parser::ParseTree;
unit module FinnTest;

# p6doc {{{

=begin pod
=head NAME

FinnTest

=head SYNOPSIS

=begin code
use FinnTest;
=end code

=head DESCRIPTION

Contains subroutines for testing Finn.
=end pod

# end p6doc }}}

# chunk {{{

multi sub infix:<eqv>(
    Chunk:D @a where .elems > 0,
    Chunk:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [&&] @is-same;
}

multi sub infix:<eqv>(
    Chunk:D @a,
    Chunk:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    Chunk @,
    Chunk @
    --> Bool:D
) is export
{
    False;
}

# --- Chunk['IncludeLineBlock'] {{{

multi sub infix:<eqv>(
    Chunk['IncludeLineBlock'] $a,
    Chunk['IncludeLineBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.include-line-block eqv $b.include-line-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['IncludeLineBlock'] }}}
# --- Chunk['SectionalBlock'] {{{

multi sub infix:<eqv>(
    Chunk['SectionalBlock'] $a,
    Chunk['SectionalBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.sectional-block eqv $b.sectional-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['SectionalBlock'] }}}
# --- Chunk['CodeBlock'] {{{

multi sub infix:<eqv>(
    Chunk['CodeBlock'] $a,
    Chunk['CodeBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.code-block eqv $b.code-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['CodeBlock'] }}}
# --- Chunk['ReferenceLineBlock'] {{{

multi sub infix:<eqv>(
    Chunk['ReferenceLineBlock'] $a,
    Chunk['ReferenceLineBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.reference-line-block eqv $b.reference-line-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['ReferenceLineBlock'] }}}
# --- Chunk['HeaderBlock'] {{{

multi sub infix:<eqv>(
    Chunk['HeaderBlock'] $a,
    Chunk['HeaderBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.header-block eqv $b.header-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['HeaderBlock'] }}}
# --- Chunk['ListBlock'] {{{

multi sub infix:<eqv>(
    Chunk['ListBlock'] $a,
    Chunk['ListBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.list-block eqv $b.list-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['ListBlock'] }}}
# --- Chunk['Paragraph'] {{{

multi sub infix:<eqv>(
    Chunk['Paragraph'] $a,
    Chunk['Paragraph'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.paragraph eqv $b.paragraph
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['Paragraph'] }}}
# --- Chunk['HorizontalRule'] {{{

multi sub infix:<eqv>(
    Chunk['HorizontalRule'] $a,
    Chunk['HorizontalRule'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['HorizontalRule'] }}}
# --- Chunk['CommentBlock'] {{{

multi sub infix:<eqv>(
    Chunk['CommentBlock'] $a,
    Chunk['CommentBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['CommentBlock'] }}}
# --- Chunk['BlankLine'] {{{

multi sub infix:<eqv>(
    Chunk['BlankLine'] $a,
    Chunk['BlankLine'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['BlankLine'] }}}

multi sub infix:<eqv>(Chunk $, Chunk $ --> Bool:D) is export
{
    False;
}

# end chunk }}}
# document {{{

multi sub infix:<eqv>(
    Document:D $a where .so,
    Document:D $b where .so
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.chunk eqv $b.chunk;
}

multi sub infix:<eqv>(
    Document:U $,
    Document:U $
    --> Bool:D
) is default is export
{
    True;
}

multi sub infix:<eqv>(
    Document $,
    Document $
    --> Bool:D
) is export
{
    False;
}

# end document }}}
# file {{{

multi sub infix:<eqv>(
    File['Absolute'] $a,
    File['Absolute'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
}

multi sub infix:<eqv>(
    File['Absolute', 'Protocol'] $a,
    File['Absolute', 'Protocol'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
    my Bool:D $is-same-protocol = $a.protocol eqv $b.protocol;
    my Bool:D $is-same = $is-same-path && $is-same-protocol;
}

multi sub infix:<eqv>(
    File['Relative'] $a,
    File['Relative'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
}

multi sub infix:<eqv>(
    File['Relative', 'Protocol'] $a,
    File['Relative', 'Protocol'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
    my Bool:D $is-same-protocol = $a.protocol eqv $b.protocol;
    my Bool:D $is-same = $is-same-path && $is-same-protocol;
}

multi sub infix:<eqv>(File $, File $ --> Bool:D) is export
{
    False;
}

# end file }}}
# header {{{

multi sub infix:<eqv>(Header[1] $a, Header[1] $b --> Bool:D) is export
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(Header[2] $a, Header[2] $b --> Bool:D) is export
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(Header[3] $a, Header[3] $b --> Bool:D) is export
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(Header $, Header $ --> Bool:D) is export
{
    False;
}

# end header }}}
# header-block {{{

multi sub infix:<eqv>(
    HeaderBlock['BlankLine'] $a,
    HeaderBlock['BlankLine'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock['CommentBlock'] $a,
    HeaderBlock['CommentBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock['HorizontalRule'] $a,
    HeaderBlock['HorizontalRule'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock['Top'] $a,
    HeaderBlock['Top'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock $,
    HeaderBlock $
    --> Bool:D
) is export
{
    False;
}

# end header-block }}}
# horizontal-rule {{{

multi sub infix:<eqv>(
    HorizontalRule['Hard'] $a,
    HorizontalRule['Hard'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ HorizontalRule['Hard']
            && $b ~~ HorizontalRule['Hard'];
}

multi sub infix:<eqv>(
    HorizontalRule['Soft'] $a,
    HorizontalRule['Soft'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ HorizontalRule['Soft']
            && $b ~~ HorizontalRule['Soft'];
}

multi sub infix:<eqv>(
    HorizontalRule $,
    HorizontalRule $
    --> Bool:D
) is export
{
    False;
}

# horizontal-rule }}}
# include-line {{{

multi sub infix:<eqv>(
    IncludeLine:D @a where .elems > 0,
    IncludeLine:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [&&] @is-same;
}

multi sub infix:<eqv>(
    IncludeLine:D @a,
    IncludeLine:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    IncludeLine @,
    IncludeLine @
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    IncludeLine['Finn'] $a,
    IncludeLine['Finn'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.request eqv $b.request
            && $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    IncludeLine['Text'] $a,
    IncludeLine['Text'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.request eqv $b.request
            && $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    IncludeLine $,
    IncludeLine $
    --> Bool:D
) is export
{
    False;
}

# --- IncludeLine::Request {{{

multi sub infix:<eqv>(
    IncludeLine::Request['Name'] $a,
    IncludeLine::Request['Name'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.name eqv $b.name;
}

multi sub infix:<eqv>(
    IncludeLine::Request['File'] $a,
    IncludeLine::Request['File'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.file eqv $b.file;
}

multi sub infix:<eqv>(
    IncludeLine::Request['Reference'] $a,
    IncludeLine::Request['Reference'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.reference-inline eqv $b.reference-inline;
}

multi sub infix:<eqv>(
    IncludeLine::Request['Name', 'File'] $a,
    IncludeLine::Request['Name', 'File'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.name eqv $b.name
            && $a.file eqv $b.file;
}

multi sub infix:<eqv>(
    IncludeLine::Request['Name', 'Reference'] $a,
    IncludeLine::Request['Name', 'Reference'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.name eqv $b.name
            && $a.reference-inline eqv $b.reference-inline;
}

multi sub infix:<eqv>(
    IncludeLine::Request $,
    IncludeLine::Request $
    --> Bool:D
) is export
{
    False;
}

# --- end IncludeLine::Request }}}

# end include-line }}}
# include-line-block {{{

multi sub infix:<eqv>(
    IncludeLineBlock['BlankLine'] $a,
    IncludeLineBlock['BlankLine'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock['CommentBlock'] $a,
    IncludeLineBlock['CommentBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock['HorizontalRule'] $a,
    IncludeLineBlock['HorizontalRule'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock['Top'] $a,
    IncludeLineBlock['Top'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock $,
    IncludeLineBlock $
    --> Bool:D
) is export
{
    False;
}

# end include-line-block }}}
# leading-ws {{{

multi sub infix:<eqv>(
    LeadingWS:D @a where .elems > 0,
    LeadingWS:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [&&] @is-same;
}

multi sub infix:<eqv>(
    LeadingWS:D @a where .elems == 0,
    LeadingWS:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS @,
    LeadingWS @
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    LeadingWS['Space'] $a,
    LeadingWS['Space'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ LeadingWS['Space']
            && $b ~~ LeadingWS['Space'];
}

multi sub infix:<eqv>(
    LeadingWS['Tab'] $a,
    LeadingWS['Tab'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ LeadingWS['Tab']
            && $b ~~ LeadingWS['Tab'];
}

multi sub infix:<eqv>(LeadingWS $, LeadingWS $ --> Bool:D) is export
{
    False;
}

# end leading-ws }}}
# list-block {{{

multi sub infix:<eqv>(
    ListBlock:D $a where .so,
    ListBlock:D $b where .so
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.list-item eqv $b.list-item;
}

multi sub infix:<eqv>(ListBlock $, ListBlock $ --> Bool:D) is export
{
    False;
}

# end list-block }}}
# list-item {{{

multi sub infix:<eqv>(
    ListItem:D @a where .elems > 0,
    ListItem:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [&&] @is-same;
}

multi sub infix:<eqv>(
    ListItem:D @a,
    ListItem:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    ListItem @,
    ListItem @
    --> Bool:D
) is export
{
    False;
}

# --- ListItem['Ordered'] {{{

# --- --- ListItem::Number {{{

# --- --- --- ListItem::Number::Terminator {{{

multi sub infix:<eqv>(
    ListItem::Number::Terminator['.'] $a,
    ListItem::Number::Terminator['.'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator['.']
            && $b ~~ ListItem::Number::Terminator['.'];
}

multi sub infix:<eqv>(
    ListItem::Number::Terminator[':'] $a,
    ListItem::Number::Terminator[':'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator[':']
            && $b ~~ ListItem::Number::Terminator[':'];
}

multi sub infix:<eqv>(
    ListItem::Number::Terminator[')'] $a,
    ListItem::Number::Terminator[')'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator[')']
            && $b ~~ ListItem::Number::Terminator[')'];
}

multi sub infix:<eqv>(
    ListItem::Number::Terminator $,
    ListItem::Number::Terminator $
    --> Bool:D
) is export
{
    False;
}

# --- --- --- end ListItem::Number::Terminator }}}

multi sub infix:<eqv>(
    ListItem::Number:D $a,
    ListItem::Number:D $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.terminator eqv $b.terminator
            && $a.value == $b.value;
}

# --- --- end ListItem::Number }}}

multi sub infix:<eqv>(
    ListItem['Ordered'] $a,
    ListItem['Ordered'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.number eqv $b.number
            && $a.text eqv $b.text;
}

# --- end ListItem['Ordered'] }}}
# --- ListItem['Todo'] {{{

# --- --- Checkbox['Checked'] {{{

# --- --- --- CheckboxCheckedChar {{{

multi sub infix:<eqv>(
    CheckboxCheckedChar['x'] $a,
    CheckboxCheckedChar['x'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['x']
            && $b ~~ CheckboxCheckedChar['x'];
}

multi sub infix:<eqv>(
    CheckboxCheckedChar['o'] $a,
    CheckboxCheckedChar['o'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['o']
            && $b ~~ CheckboxCheckedChar['o'];
}

multi sub infix:<eqv>(
    CheckboxCheckedChar['v'] $a,
    CheckboxCheckedChar['v'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['v']
            && $b ~~ CheckboxCheckedChar['v'];
}

multi sub infix:<eqv>(
    CheckboxCheckedChar $,
    CheckboxCheckedChar $
    --> Bool:D
) is export
{
    False;
}

# --- --- --- end CheckboxCheckedChar }}}

multi sub infix:<eqv>(
    Checkbox['Checked'] $a,
    Checkbox['Checked'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.char eqv $b.char;
}

# --- --- end Checkbox['Checked'] }}}
# --- --- Checkbox['Etc'] {{{

# --- --- --- CheckboxEtcChar {{{

multi sub infix:<eqv>(
    CheckboxEtcChar['+'] $a,
    CheckboxEtcChar['+'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['+']
            && $b ~~ CheckboxEtcChar['+'];
}

multi sub infix:<eqv>(
    CheckboxEtcChar['='] $a,
    CheckboxEtcChar['='] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['=']
            && $b ~~ CheckboxEtcChar['='];
}

multi sub infix:<eqv>(
    CheckboxEtcChar['-'] $a,
    CheckboxEtcChar['-'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['-']
            && $b ~~ CheckboxEtcChar['-'];
}

multi sub infix:<eqv>(
    CheckboxEtcChar $,
    CheckboxEtcChar $
    --> Bool:D
) is export
{
    False;
}

# --- --- --- end CheckboxEtcChar }}}

multi sub infix:<eqv>(
    Checkbox['Etc'] $a,
    Checkbox['Etc'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.char eqv $b.char;
}

# --- --- end Checkbox['Etc'] }}}
# --- --- Checkbox['Exception'] {{{

# --- --- --- CheckboxExceptionChar {{{

multi sub infix:<eqv>(
    CheckboxExceptionChar['*'] $a,
    CheckboxExceptionChar['*'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxExceptionChar['*']
            && $b ~~ CheckboxExceptionChar['*'];
}

multi sub infix:<eqv>(
    CheckboxExceptionChar['!'] $a,
    CheckboxExceptionChar['!'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ CheckboxExceptionChar['!']
            && $b ~~ CheckboxExceptionChar['!'];
}

multi sub infix:<eqv>(
    CheckboxExceptionChar $,
    CheckboxExceptionChar $
    --> Bool:D
) is export
{
    False;
}

# --- --- --- end CheckboxExceptionChar }}}

multi sub infix:<eqv>(
    Checkbox['Exception'] $a,
    Checkbox['Exception'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.char eqv $b.char;
}

# --- --- end Checkbox['Exception'] }}}
# --- --- Checkbox['Unchecked'] {{{

multi sub infix:<eqv>(
    Checkbox['Unchecked'] $a where .so,
    Checkbox['Unchecked'] $b where .so
    --> Bool:D
) is export
{
    True;
}

# --- --- end Checkbox['Unchecked'] }}}

multi sub infix:<eqv>(
    Checkbox $,
    Checkbox $
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    ListItem['Todo'] $a,
    ListItem['Todo'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.checkbox eqv $b.checkbox
            && $a.text eqv $b.text;
}

# --- end ListItem['Todo'] }}}
# --- ListItem['Unordered'] {{{

# --- --- BulletPoint {{{

multi sub infix:<eqv>(
    BulletPoint['-'] $a,
    BulletPoint['-'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['-']
            && $b ~~ BulletPoint['-'];
}

multi sub infix:<eqv>(
    BulletPoint['@'] $a,
    BulletPoint['@'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['@']
            && $b ~~ BulletPoint['@'];
}

multi sub infix:<eqv>(
    BulletPoint['#'] $a,
    BulletPoint['#'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['#']
            && $b ~~ BulletPoint['#'];
}

multi sub infix:<eqv>(
    BulletPoint['$'] $a,
    BulletPoint['$'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['$']
            && $b ~~ BulletPoint['$'];
}

multi sub infix:<eqv>(
    BulletPoint['*'] $a,
    BulletPoint['*'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['*']
            && $b ~~ BulletPoint['*'];
}

multi sub infix:<eqv>(
    BulletPoint[':'] $a,
    BulletPoint[':'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint[':']
            && $b ~~ BulletPoint[':'];
}

multi sub infix:<eqv>(
    BulletPoint['x'] $a,
    BulletPoint['x'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['x']
            && $b ~~ BulletPoint['x'];
}

multi sub infix:<eqv>(
    BulletPoint['o'] $a,
    BulletPoint['o'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['o']
            && $b ~~ BulletPoint['o'];
}

multi sub infix:<eqv>(
    BulletPoint['+'] $a,
    BulletPoint['+'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['+']
            && $b ~~ BulletPoint['+'];
}

multi sub infix:<eqv>(
    BulletPoint['='] $a,
    BulletPoint['='] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['=']
            && $b ~~ BulletPoint['='];
}

multi sub infix:<eqv>(
    BulletPoint['!'] $a,
    BulletPoint['!'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['!']
            && $b ~~ BulletPoint['!'];
}

multi sub infix:<eqv>(
    BulletPoint['~'] $a,
    BulletPoint['~'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['~']
            && $b ~~ BulletPoint['~'];
}

multi sub infix:<eqv>(
    BulletPoint['>'] $a,
    BulletPoint['>'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['>']
            && $b ~~ BulletPoint['>'];
}

multi sub infix:<eqv>(
    BulletPoint['<-'] $a,
    BulletPoint['<-'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['<-']
            && $b ~~ BulletPoint['<-'];
}

multi sub infix:<eqv>(
    BulletPoint['<='] $a,
    BulletPoint['<='] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['<=']
            && $b ~~ BulletPoint['<='];
}

multi sub infix:<eqv>(
    BulletPoint['->'] $a,
    BulletPoint['->'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['->']
            && $b ~~ BulletPoint['->'];
}

multi sub infix:<eqv>(
    BulletPoint['=>'] $a,
    BulletPoint['=>'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['=>']
            && $b ~~ BulletPoint['=>'];
}

multi sub infix:<eqv>(
    BulletPoint $,
    BulletPoint $
    --> Bool:D
) is export
{
    False;
}

# --- --- end BulletPoint }}}

multi sub infix:<eqv>(
    ListItem['Unordered'] $a,
    ListItem['Unordered'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.bullet-point eqv $b.bullet-point
            && $a.text eqv $b.text;
}

# --- end ListItem['Unordered'] }}}

multi sub infix:<eqv>(ListItem $, ListItem $ --> Bool:D) is export
{
    False;
}

# end list-item }}}
# parse-tree {{{

multi sub infix:<eqv>(
    Finn::Parser::ParseTree:D $a where .so,
    Finn::Parser::ParseTree:D $b where .so
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.document eqv $b.document;
}

multi sub infix:<eqv>(
    Finn::Parser::ParseTree:U $,
    Finn::Parser::ParseTree:U $
    --> Bool:D
) is default is export
{
    True;
}

multi sub infix:<eqv>(
    Finn::Parser::ParseTree $,
    Finn::Parser::ParseTree $
    --> Bool:D
) is export
{
    False;
}

# end parse-tree }}}
# reference-line-block {{{

multi sub infix:<eqv>(
    ReferenceLineBlock['BlankLine'] $a,
    ReferenceLineBlock['BlankLine'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock['CommentBlock'] $a,
    ReferenceLineBlock['CommentBlock'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock['HorizontalRule'] $a,
    ReferenceLineBlock['HorizontalRule'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock['Top'] $a,
    ReferenceLineBlock['Top'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock $,
    ReferenceLineBlock $
    --> Bool:D
) is export
{
    False;
}

# end reference-line-block }}}
# sectional-block {{{

multi sub infix:<eqv>(
    LeadingWS:D @a where .elems > 0,
    LeadingWS:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [&&] @is-same;
}

multi sub infix:<eqv>(
    LeadingWS:D @a,
    LeadingWS:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS @,
    LeadingWS @
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    LeadingWS['Space'] $ where .so,
    LeadingWS['Space'] $ where .so
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS['Tab'] $ where .so,
    LeadingWS['Tab'] $ where .so
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS $,
    LeadingWS $
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockDelimiter['Backticks'] $a,
    SectionalBlockDelimiter['Backticks'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    SectionalBlockDelimiter['Dashes'] $a,
    SectionalBlockDelimiter['Dashes'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier['File'] $a,
    SectionalBlockName::Identifier['File'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.file eqv $b.file;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier['Word'] $a,
    SectionalBlockName::Identifier['Word'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.word eqv $b.word;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier $,
    SectionalBlockName::Identifier $
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier::Export:D $ where .so,
    SectionalBlockName::Identifier::Export:D $ where .so
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier::Export:U $,
    SectionalBlockName::Identifier::Export:U $
    --> Bool:D
) is default is export
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier::Export $,
    SectionalBlockName::Identifier::Export $
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator['Additive'] $,
    SectionalBlockName::Operator['Additive'] $
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator['Redefine'] $,
    SectionalBlockName::Operator['Redefine'] $
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator:U $,
    SectionalBlockName::Operator:U $
    --> Bool:D
) is default is export
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator $,
    SectionalBlockName::Operator $
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockContent:D @a where .elems > 0,
    SectionalBlockContent:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [&&] @is-same;
}

multi sub infix:<eqv>(
    SectionalBlockContent:D @a,
    SectionalBlockContent:D @b where { .elems == @a.elems }
    --> Bool:D
) is export
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockContent @,
    SectionalBlockContent @
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockContent['IncludeLine'] $a,
    SectionalBlockContent['IncludeLine'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    SectionalBlockContent['Text'] $a,
    SectionalBlockContent['Text'] $b
    --> Bool:D
) is export
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(
    SectionalBlockContent $,
    SectionalBlockContent $
    --> Bool:D
) is export
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockName:D $a,
    SectionalBlockName:D $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.identifier eqv $b.identifier
            && $a.export eqv $b.export
                && $a.operator eqv $b.operator;
}

multi sub infix:<eqv>(
    SectionalBlock:D $a,
    SectionalBlock:D $b
    --> Bool:D
) is export
{
    my Bool:D $is-same =
        $a.delimiter eqv $b.delimiter
            && $a.name eqv $b.name
                && $a.content eqv $b.content;
}

# end sectional-block }}}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
