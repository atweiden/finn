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
) is export returns Bool:D
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [[&is-true]] @is-same;
}

multi sub infix:<eqv>(
    Chunk:D @a,
    Chunk:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    Chunk @,
    Chunk @
) is export returns Bool:D
{
    False;
}

# --- Chunk['IncludeLineBlock'] {{{

multi sub infix:<eqv>(
    Chunk['IncludeLineBlock'] $a,
    Chunk['IncludeLineBlock'] $b
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
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
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.bounds eqv $b.bounds
                && $a.section == $b.section;
}

# --- end Chunk['BlankLine'] }}}

multi sub infix:<eqv>(Chunk $, Chunk $) is export returns Bool:D
{
    False;
}

# end chunk }}}
# document {{{

multi sub infix:<eqv>(
    Document:D $a where *.so,
    Document:D $b where *.so
) is export returns Bool:D
{
    my Bool:D $is-same = $a.chunk eqv $b.chunk;
}

multi sub infix:<eqv>(
    Document:U $,
    Document:U $
) is default is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    Document $,
    Document $
) is export returns Bool:D
{
    False;
}

# end document }}}
# file {{{

multi sub infix:<eqv>(
    File['Absolute'] $a,
    File['Absolute'] $b
) is export returns Bool:D
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
}

multi sub infix:<eqv>(
    File['Absolute', 'Protocol'] $a,
    File['Absolute', 'Protocol'] $b
) is export returns Bool:D
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
    my Bool:D $is-same-protocol = $a.protocol eqv $b.protocol;
    my Bool:D $is-same = $is-same-path && $is-same-protocol;
}

multi sub infix:<eqv>(
    File['Relative'] $a,
    File['Relative'] $b
) is export returns Bool:D
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
}

multi sub infix:<eqv>(
    File['Relative', 'Protocol'] $a,
    File['Relative', 'Protocol'] $b
) is export returns Bool:D
{
    my Bool:D $is-same-path = $a.path eqv $b.path;
    my Bool:D $is-same-protocol = $a.protocol eqv $b.protocol;
    my Bool:D $is-same = $is-same-path && $is-same-protocol;
}

multi sub infix:<eqv>(File $, File $) is export returns Bool:D
{
    False;
}

# end file }}}
# header {{{

multi sub infix:<eqv>(Header[1] $a, Header[1] $b) is export returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(Header[2] $a, Header[2] $b) is export returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(Header[3] $a, Header[3] $b) is export returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(Header $, Header $) is export returns Bool:D
{
    False;
}

# end header }}}
# header-block {{{

multi sub infix:<eqv>(
    HeaderBlock['BlankLine'] $a,
    HeaderBlock['BlankLine'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock['CommentBlock'] $a,
    HeaderBlock['CommentBlock'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock['HorizontalRule'] $a,
    HeaderBlock['HorizontalRule'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock['Top'] $a,
    HeaderBlock['Top'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.header eqv $b.header;
}

multi sub infix:<eqv>(
    HeaderBlock $,
    HeaderBlock $
) is export returns Bool:D
{
    False;
}

# end header-block }}}
# horizontal-rule {{{

multi sub infix:<eqv>(
    HorizontalRule['Hard'] $a,
    HorizontalRule['Hard'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ HorizontalRule['Hard']
            && $b ~~ HorizontalRule['Hard'];
}

multi sub infix:<eqv>(
    HorizontalRule['Soft'] $a,
    HorizontalRule['Soft'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ HorizontalRule['Soft']
            && $b ~~ HorizontalRule['Soft'];
}

multi sub infix:<eqv>(
    HorizontalRule $,
    HorizontalRule $
) is export returns Bool:D
{
    False;
}

# horizontal-rule }}}
# include-line {{{

multi sub infix:<eqv>(
    IncludeLine:D @a where .elems > 0,
    IncludeLine:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [[&is-true]] @is-same;
}

multi sub infix:<eqv>(
    IncludeLine:D @a,
    IncludeLine:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    IncludeLine @,
    IncludeLine @
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    IncludeLine['Finn'] $a,
    IncludeLine['Finn'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.request eqv $b.request
            && $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    IncludeLine['Text'] $a,
    IncludeLine['Text'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.request eqv $b.request
            && $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    IncludeLine $,
    IncludeLine $
) is export returns Bool:D
{
    False;
}

# --- IncludeLine::Request {{{

multi sub infix:<eqv>(
    IncludeLine::Request['Name'] $a,
    IncludeLine::Request['Name'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.name eqv $b.name;
}

multi sub infix:<eqv>(
    IncludeLine::Request['File'] $a,
    IncludeLine::Request['File'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.file eqv $b.file;
}

multi sub infix:<eqv>(
    IncludeLine::Request['Reference'] $a,
    IncludeLine::Request['Reference'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.reference-inline eqv $b.reference-inline;
}

multi sub infix:<eqv>(
    IncludeLine::Request['Name', 'File'] $a,
    IncludeLine::Request['Name', 'File'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.name eqv $b.name
            && $a.file eqv $b.file;
}

multi sub infix:<eqv>(
    IncludeLine::Request['Name', 'Reference'] $a,
    IncludeLine::Request['Name', 'Reference'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.name eqv $b.name
            && $a.reference-inline eqv $b.reference-inline;
}

multi sub infix:<eqv>(
    IncludeLine::Request $,
    IncludeLine::Request $
) is export returns Bool:D
{
    False;
}

# --- end IncludeLine::Request }}}

# end include-line }}}
# include-line-block {{{

multi sub infix:<eqv>(
    IncludeLineBlock['BlankLine'] $a,
    IncludeLineBlock['BlankLine'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock['CommentBlock'] $a,
    IncludeLineBlock['CommentBlock'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock['HorizontalRule'] $a,
    IncludeLineBlock['HorizontalRule'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock['Top'] $a,
    IncludeLineBlock['Top'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    IncludeLineBlock $,
    IncludeLineBlock $
) is export returns Bool:D
{
    False;
}

# end include-line-block }}}
# leading-ws {{{

multi sub infix:<eqv>(
    LeadingWS:D @a where .elems > 0,
    LeadingWS:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [[&is-true]] @is-same;
}

multi sub infix:<eqv>(
    LeadingWS:D @a where .elems == 0,
    LeadingWS:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS @,
    LeadingWS @
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    LeadingWS['Space'] $a,
    LeadingWS['Space'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ LeadingWS['Space']
            && $b ~~ LeadingWS['Space'];
}

multi sub infix:<eqv>(
    LeadingWS['Tab'] $a,
    LeadingWS['Tab'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ LeadingWS['Tab']
            && $b ~~ LeadingWS['Tab'];
}

multi sub infix:<eqv>(LeadingWS $, LeadingWS $) is export returns Bool:D
{
    False;
}

# end leading-ws }}}
# list-block {{{

multi sub infix:<eqv>(
    ListBlock:D $a where *.so,
    ListBlock:D $b where *.so
) is export returns Bool:D
{
    my Bool:D $is-same = $a.list-item eqv $b.list-item;
}

multi sub infix:<eqv>(ListBlock $, ListBlock $) is export returns Bool:D
{
    False;
}

# end list-block }}}
# list-item {{{

multi sub infix:<eqv>(
    ListItem:D @a where .elems > 0,
    ListItem:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [[&is-true]] @is-same;
}

multi sub infix:<eqv>(
    ListItem:D @a,
    ListItem:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    ListItem @,
    ListItem @
) is export returns Bool:D
{
    False;
}

# --- ListItem['Ordered'] {{{

# --- --- ListItem::Number {{{

# --- --- --- ListItem::Number::Terminator {{{

multi sub infix:<eqv>(
    ListItem::Number::Terminator['.'] $a,
    ListItem::Number::Terminator['.'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator['.']
            && $b ~~ ListItem::Number::Terminator['.'];
}

multi sub infix:<eqv>(
    ListItem::Number::Terminator[':'] $a,
    ListItem::Number::Terminator[':'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator[':']
            && $b ~~ ListItem::Number::Terminator[':'];
}

multi sub infix:<eqv>(
    ListItem::Number::Terminator[')'] $a,
    ListItem::Number::Terminator[')'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator[')']
            && $b ~~ ListItem::Number::Terminator[')'];
}

multi sub infix:<eqv>(
    ListItem::Number::Terminator $,
    ListItem::Number::Terminator $
) is export returns Bool:D
{
    False;
}

# --- --- --- end ListItem::Number::Terminator }}}

multi sub infix:<eqv>(
    ListItem::Number:D $a,
    ListItem::Number:D $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.terminator eqv $b.terminator
            && $a.value == $b.value;
}

# --- --- end ListItem::Number }}}

multi sub infix:<eqv>(
    ListItem['Ordered'] $a,
    ListItem['Ordered'] $b
) is export returns Bool:D
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
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['x']
            && $b ~~ CheckboxCheckedChar['x'];
}

multi sub infix:<eqv>(
    CheckboxCheckedChar['o'] $a,
    CheckboxCheckedChar['o'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['o']
            && $b ~~ CheckboxCheckedChar['o'];
}

multi sub infix:<eqv>(
    CheckboxCheckedChar['v'] $a,
    CheckboxCheckedChar['v'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['v']
            && $b ~~ CheckboxCheckedChar['v'];
}

multi sub infix:<eqv>(
    CheckboxCheckedChar $,
    CheckboxCheckedChar $
) is export returns Bool:D
{
    False;
}

# --- --- --- end CheckboxCheckedChar }}}

multi sub infix:<eqv>(
    Checkbox['Checked'] $a,
    Checkbox['Checked'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.char eqv $b.char;
}

# --- --- end Checkbox['Checked'] }}}
# --- --- Checkbox['Etc'] {{{

# --- --- --- CheckboxEtcChar {{{

multi sub infix:<eqv>(
    CheckboxEtcChar['+'] $a,
    CheckboxEtcChar['+'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['+']
            && $b ~~ CheckboxEtcChar['+'];
}

multi sub infix:<eqv>(
    CheckboxEtcChar['='] $a,
    CheckboxEtcChar['='] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['=']
            && $b ~~ CheckboxEtcChar['='];
}

multi sub infix:<eqv>(
    CheckboxEtcChar['-'] $a,
    CheckboxEtcChar['-'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['-']
            && $b ~~ CheckboxEtcChar['-'];
}

multi sub infix:<eqv>(
    CheckboxEtcChar $,
    CheckboxEtcChar $
) is export returns Bool:D
{
    False;
}

# --- --- --- end CheckboxEtcChar }}}

multi sub infix:<eqv>(
    Checkbox['Etc'] $a,
    Checkbox['Etc'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.char eqv $b.char;
}

# --- --- end Checkbox['Etc'] }}}
# --- --- Checkbox['Exception'] {{{

# --- --- --- CheckboxExceptionChar {{{

multi sub infix:<eqv>(
    CheckboxExceptionChar['*'] $a,
    CheckboxExceptionChar['*'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxExceptionChar['*']
            && $b ~~ CheckboxExceptionChar['*'];
}

multi sub infix:<eqv>(
    CheckboxExceptionChar['!'] $a,
    CheckboxExceptionChar['!'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxExceptionChar['!']
            && $b ~~ CheckboxExceptionChar['!'];
}

multi sub infix:<eqv>(
    CheckboxExceptionChar $,
    CheckboxExceptionChar $
) is export returns Bool:D
{
    False;
}

# --- --- --- end CheckboxExceptionChar }}}

multi sub infix:<eqv>(
    Checkbox['Exception'] $a,
    Checkbox['Exception'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.char eqv $b.char;
}

# --- --- end Checkbox['Exception'] }}}
# --- --- Checkbox['Unchecked'] {{{

multi sub infix:<eqv>(
    Checkbox['Unchecked'] $a where *.so,
    Checkbox['Unchecked'] $b where *.so
) is export returns Bool:D
{
    True;
}

# --- --- end Checkbox['Unchecked'] }}}

multi sub infix:<eqv>(Checkbox $, Checkbox $) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(ListItem['Todo'] $a, ListItem['Todo'] $b) is export returns Bool:D
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
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['-']
            && $b ~~ BulletPoint['-'];
}

multi sub infix:<eqv>(
    BulletPoint['@'] $a,
    BulletPoint['@'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['@']
            && $b ~~ BulletPoint['@'];
}

multi sub infix:<eqv>(
    BulletPoint['#'] $a,
    BulletPoint['#'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['#']
            && $b ~~ BulletPoint['#'];
}

multi sub infix:<eqv>(
    BulletPoint['$'] $a,
    BulletPoint['$'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['$']
            && $b ~~ BulletPoint['$'];
}

multi sub infix:<eqv>(
    BulletPoint['*'] $a,
    BulletPoint['*'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['*']
            && $b ~~ BulletPoint['*'];
}

multi sub infix:<eqv>(
    BulletPoint[':'] $a,
    BulletPoint[':'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint[':']
            && $b ~~ BulletPoint[':'];
}

multi sub infix:<eqv>(
    BulletPoint['x'] $a,
    BulletPoint['x'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['x']
            && $b ~~ BulletPoint['x'];
}

multi sub infix:<eqv>(
    BulletPoint['o'] $a,
    BulletPoint['o'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['o']
            && $b ~~ BulletPoint['o'];
}

multi sub infix:<eqv>(
    BulletPoint['+'] $a,
    BulletPoint['+'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['+']
            && $b ~~ BulletPoint['+'];
}

multi sub infix:<eqv>(
    BulletPoint['='] $a,
    BulletPoint['='] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['=']
            && $b ~~ BulletPoint['='];
}

multi sub infix:<eqv>(
    BulletPoint['!'] $a,
    BulletPoint['!'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['!']
            && $b ~~ BulletPoint['!'];
}

multi sub infix:<eqv>(
    BulletPoint['~'] $a,
    BulletPoint['~'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['~']
            && $b ~~ BulletPoint['~'];
}

multi sub infix:<eqv>(
    BulletPoint['>'] $a,
    BulletPoint['>'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['>']
            && $b ~~ BulletPoint['>'];
}

multi sub infix:<eqv>(
    BulletPoint['<-'] $a,
    BulletPoint['<-'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['<-']
            && $b ~~ BulletPoint['<-'];
}

multi sub infix:<eqv>(
    BulletPoint['<='] $a,
    BulletPoint['<='] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['<=']
            && $b ~~ BulletPoint['<='];
}

multi sub infix:<eqv>(
    BulletPoint['->'] $a,
    BulletPoint['->'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['->']
            && $b ~~ BulletPoint['->'];
}

multi sub infix:<eqv>(
    BulletPoint['=>'] $a,
    BulletPoint['=>'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['=>']
            && $b ~~ BulletPoint['=>'];
}

multi sub infix:<eqv>(
    BulletPoint $,
    BulletPoint $
) is export returns Bool:D
{
    False;
}

# --- --- end BulletPoint }}}

multi sub infix:<eqv>(
    ListItem['Unordered'] $a,
    ListItem['Unordered'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.bullet-point eqv $b.bullet-point
            && $a.text eqv $b.text;
}

# --- end ListItem['Unordered'] }}}

multi sub infix:<eqv>(ListItem $, ListItem $) is export returns Bool:D
{
    False;
}

# end list-item }}}
# parse-tree {{{

multi sub infix:<eqv>(
    Finn::Parser::ParseTree:D $a where *.so,
    Finn::Parser::ParseTree:D $b where *.so
) is export returns Bool:D
{
    my Bool:D $is-same = $a.document eqv $b.document;
}

multi sub infix:<eqv>(
    Finn::Parser::ParseTree:U $,
    Finn::Parser::ParseTree:U $
) is default is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    Finn::Parser::ParseTree $,
    Finn::Parser::ParseTree $
) is export returns Bool:D
{
    False;
}

# end parse-tree }}}
# reference-line-block {{{

multi sub infix:<eqv>(
    ReferenceLineBlock['BlankLine'] $a,
    ReferenceLineBlock['BlankLine'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.blank-line eqv $b.blank-line
            && $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock['CommentBlock'] $a,
    ReferenceLineBlock['CommentBlock'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.comment-block eqv $b.comment-block
            && $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock['HorizontalRule'] $a,
    ReferenceLineBlock['HorizontalRule'] $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.horizontal-rule eqv $b.horizontal-rule
            && $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock['Top'] $a,
    ReferenceLineBlock['Top'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.reference-line eqv $b.reference-line;
}

multi sub infix:<eqv>(
    ReferenceLineBlock $,
    ReferenceLineBlock $
) is export returns Bool:D
{
    False;
}

# end reference-line-block }}}
# sectional-block {{{

multi sub infix:<eqv>(
    LeadingWS:D @a where .elems > 0,
    LeadingWS:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [[&is-true]] @is-same;
}

multi sub infix:<eqv>(
    LeadingWS:D @a,
    LeadingWS:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS @,
    LeadingWS @
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    LeadingWS['Space'] $ where *.so,
    LeadingWS['Space'] $ where *.so
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS['Tab'] $ where *.so,
    LeadingWS['Tab'] $ where *.so
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    LeadingWS $,
    LeadingWS $
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockDelimiter['Backticks'] $a,
    SectionalBlockDelimiter['Backticks'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    SectionalBlockDelimiter['Dashes'] $a,
    SectionalBlockDelimiter['Dashes'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.leading-ws eqv $b.leading-ws;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier['File'] $a,
    SectionalBlockName::Identifier['File'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.file eqv $b.file;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier['Word'] $a,
    SectionalBlockName::Identifier['Word'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.word eqv $b.word;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier $,
    SectionalBlockName::Identifier $
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier::Export:D $ where *.so,
    SectionalBlockName::Identifier::Export:D $ where *.so
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier::Export:U $,
    SectionalBlockName::Identifier::Export:U $
) is default is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Identifier::Export $,
    SectionalBlockName::Identifier::Export $
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator['Additive'] $,
    SectionalBlockName::Operator['Additive'] $
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator['Redefine'] $,
    SectionalBlockName::Operator['Redefine'] $
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator:U $,
    SectionalBlockName::Operator:U $
) is default is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockName::Operator $,
    SectionalBlockName::Operator $
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockContent:D @a where .elems > 0,
    SectionalBlockContent:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    my Bool:D @is-same = do loop (my UInt:D $i = 0; $i < @a.elems; $i++)
    {
        @a[$i] eqv @b[$i]
    }
    my Bool:D $is-same = [[&is-true]] @is-same;
}

multi sub infix:<eqv>(
    SectionalBlockContent:D @a,
    SectionalBlockContent:D @b where { .elems == @a.elems }
) is export returns Bool:D
{
    True;
}

multi sub infix:<eqv>(
    SectionalBlockContent @,
    SectionalBlockContent @
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockContent['IncludeLine'] $a,
    SectionalBlockContent['IncludeLine'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.include-line eqv $b.include-line;
}

multi sub infix:<eqv>(
    SectionalBlockContent['Text'] $a,
    SectionalBlockContent['Text'] $b
) is export returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub infix:<eqv>(
    SectionalBlockContent $,
    SectionalBlockContent $
) is export returns Bool:D
{
    False;
}

multi sub infix:<eqv>(
    SectionalBlockName:D $a,
    SectionalBlockName:D $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.identifier eqv $b.identifier
            && $a.export eqv $b.export
                && $a.operator eqv $b.operator;
}

multi sub infix:<eqv>(
    SectionalBlock:D $a,
    SectionalBlock:D $b
) is export returns Bool:D
{
    my Bool:D $is-same =
        $a.delimiter eqv $b.delimiter
            && $a.name eqv $b.name
                && $a.content eqv $b.content;
}

# end sectional-block }}}

# sub is-true {{{

sub is-true(Bool:D $a, Bool:D $b) returns Bool:D
{
    my Bool:D $is-true = $a && $b;
}

# sub end is-true }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
