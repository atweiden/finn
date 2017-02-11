use v6;
use Finn::Parser::Grammar::File;
use Finn::Parser::Grammar::ReferenceInline;
use Finn::Parser::Grammar::SectionalInline;
use Finn::Parser::Grammar::String;
unit grammar Finn::Parser::Grammar;
also does Finn::Parser::Grammar::File;
also does Finn::Parser::Grammar::ReferenceInline;
also does Finn::Parser::Grammar::SectionalInline;
also does Finn::Parser::Grammar::String;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar;
my Match:D $match = Finn::Parser::Grammar.parse('text');
=end code

=head DESCRIPTION

Finn source document parser.

=head2 Inline Vs. Block Text

=head3 Inline Text

In general, I<inline text> types cannot be mixed and matched. If
something is bold it cannot be italic. If something is a date, it can't
be underlined.

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

=head3 Block Text

In general, I<block text> may contain certain I<inline text> types.

=over
=item sectional-inline-block
=item sectional-block
=item code-block
=item reference-block
=item header-block
=item list-block
=item paragraph
=item horizontal-rule
=item comment-block
=item blank-line
=back
=end pod

# end p6doc }}}

=begin pod
=head Document
=end pod

# document {{{

# --- chunk {{{

proto token chunk                  {*}
token chunk:sectional-inline-block { <sectional-inline-block> }
token chunk:sectional-block        { <sectional-block> }
token chunk:code-block             { <code-block> }
token chunk:reference-block        { <reference-block> }
token chunk:header-block           { <header-block> }
token chunk:list-block             { <list-block> }
token chunk:paragraph              { <paragraph> }
token chunk:horizontal-rule        { <horizontal-rule> }
token chunk:comment-block          { <comment-block> }
token chunk:blank-line             { <blank-line> }

# --- end chunk }}}

token document
{
    <chunk> [ \n <chunk> ]*
}

# end document }}}
# TOP {{{

token TOP
{
    <document>? \n?
}

# end TOP }}}

=begin pod
=head Block Text
=end pod

# blank-line {{{

token blank-line
{
    ^^ \h* $$
}

# end blank-line }}}
# comment {{{

token comment-delimiter-opening
{
    '/*'
}

token comment-delimiter-closing
{
    '*/'
}

token comment-text
{
    <-comment-delimiter-closing>*
}

token comment
{
    <comment-delimiter-opening>
    <comment-text>
    <comment-delimiter-closing>
}

token comment-block
{
    ^^ \h* <comment> \h* $$
}

# end comment }}}
# gap {{{

proto token gap   {*}
token gap:newline { \n }
token gap:comment { <.comment> \h* $$ \n }

# end gap }}}
# header {{{

token header-text
{
    <!before
        | <comment>
        | <code-block>
        | <sectional-block>
        | <sectional-inline-block>
        | <horizontal-rule>
        | <list-item>
    >

    # C<<header-text>> cannot contain leading whitespace
    \S \N*
}

token header1
{
    ^^ <header-text> $$ <.gap>
    ^^ '='+ $$
}

token header2
{
    ^^ <header-text> $$ <.gap>
    ^^ '-'+ $$
}

token header3
{
    ^^

    <header-text>

    # C<<header3>> is distinguishable from a one-line paragraph by a
    # lack of a period (C<.>) or comma (C<,>) at line-ending
    <!after <[.,]> [ \h* <.comment> \h* ]?>

    $$

    # C<<header3>> also can't come before a C<<paragraph-line>>,
    # but it can come before a C<<list-block>> and other blocks
    <!before <.gap> <paragraph-line>>
}

proto token header {*}
token header:h1    { <header1> }
token header:h2    { <header2> }
token header:h3    { <header3> }

# C<<header-block>> must be separated from text blocks above it
# with a C<<blank-line>>, C<<comment-block>> or C<<horizontal-rule>>,
# or the header must appear at the very top of the document
proto token header-block                 {*}
token header-block:top                   { ^ <header> }
token header-block:after-blank-line      { <blank-line>  <.gap> <header> }
token header-block:after-comment-block   { <comment-block> <.gap> <header> }
token header-block:after-horizontal-rule { <horizontal-rule> <.gap> <header> }

# end header }}}
# list-block {{{

# --- list-todo-item {{{

# --- --- checkbox {{{

proto token checkbox-checked-char  {*}
token checkbox-checked-char:sym<x> { <sym> }
token checkbox-checked-char:sym<o> { <sym> }
token checkbox-checked-char:sym<v> { <sym> }

token checkbox-checked
{
    '[' <checkbox-checked-char> ']'
}

proto token checkbox-etc-char  {*}
token checkbox-etc-char:sym<+> { <sym> }
token checkbox-etc-char:sym<=> { <sym> }
token checkbox-etc-char:sym<-> { <sym> }

token checkbox-etc
{
    '[' <checkbox-etc-char> ']'
}

proto token checkbox-exception-char  {*}
token checkbox-exception-char:sym<*> { <sym> }
token checkbox-exception-char:sym<!> { <sym> }

token checkbox-exception
{
    '[' <checkbox-exception-char> ']'
}

token checkbox-unchecked
{
    '[ ]'
}

proto token checkbox     {*}
token checkbox:checked   { <checkbox-checked> }
token checkbox:etc       { <checkbox-etc> }
token checkbox:exception { <checkbox-exception> }
token checkbox:unchecked { <checkbox-unchecked> }

# --- --- end checkbox }}}

token list-todo-item-text
{
    \N+
}

token list-todo-item
{
    ^^ \h* <checkbox> \h <list-todo-item-text> $$
}

# --- end list-todo-item }}}
# --- list-unordered-item {{{

# --- --- bullet-point {{{

proto token bullet-point   {*}
token bullet-point:sym<->  { <sym> }
token bullet-point:sym<@>  { <sym> }
token bullet-point:sym<#>  { <sym> }
token bullet-point:sym<$>  { <sym> }
token bullet-point:sym<*>  { <sym> }
token bullet-point:sym<:>  { <sym> }
token bullet-point:sym<x>  { <sym> }
token bullet-point:sym<o>  { <sym> }
token bullet-point:sym<+>  { <sym> }
token bullet-point:sym<=>  { <sym> }
token bullet-point:sym<!>  { <sym> }
token bullet-point:sym<~>  { <sym> }
token bullet-point:sym«>»  { <sym> }
token bullet-point:sym«<-» { <sym> }
token bullet-point:sym«<=» { <sym> }
token bullet-point:sym«->» { <sym> }
token bullet-point:sym«=>» { <sym> }

# --- --- end bullet-point }}}

token list-unordered-item-text-first-line
{
    \N+
}

token list-unordered-item-text-continuation
{
    <!before
        | <comment-block>
        | <code-block>
        | <sectional-block>
        | <horizontal-rule>
        | <list-item>
    >
    \N+
}

token list-unordered-item-text
{
    <list-unordered-item-text-first-line>

    # optional additional lines of continued text
    [ $$ <.gap> ^^ <list-unordered-item-text-continuation> ]*
}

token list-unordered-item
{
    ^^ \h* <bullet-point> [ \h <list-unordered-item-text> ]? $$
}

# --- end list-unordered-item }}}
# --- list-ordered-item {{{

# --- --- list-ordered-item-number {{{

token list-ordered-item-number-value
{
    \d+
}

proto token list-ordered-item-number-terminator  {*}
token list-ordered-item-number-terminator:sym<.> { <sym> }
token list-ordered-item-number-terminator:sym<:> { <sym> }
token list-ordered-item-number-terminator:sym<)> { <sym> }

token list-ordered-item-number
{
    <list-ordered-item-number-value>
    <list-ordered-item-number-terminator>
}

# --- --- end list-ordered-item-number }}}

token list-ordered-item-text-first-line
{
    \N+
}

token list-ordered-item-text-continuation
{
    <!before
        | <comment-block>
        | <code-block>
        | <sectional-block>
        | <horizontal-rule>
        | <list-item>
    >
    \N+
}

token list-ordered-item-text
{
    <list-ordered-item-text-first-line>

    # optional additional lines of continued text
    [ $$ <.gap> ^^ <list-ordered-item-text-continuation> ]*
}

token list-ordered-item
{
    ^^ \h* <list-ordered-item-number> [ \h <list-ordered-item-text> ]? $$
}

# --- end list-ordered-item }}}

proto token list-item     {*}
token list-item:unordered { <list-unordered-item> }
token list-item:todo      { <list-todo-item> }
token list-item:ordered   { <list-ordered-item> }

token list-block
{
    ^^ <list-item> $$
    [ <.gap> ^^ <list-item> $$ ]*
}

# end list-block }}}
# reference-block {{{

token reference-block-reference-line-text
{
    \N+
}

token reference-block-reference-line
{
    ^^ <reference-inline> ':' \h <reference-block-reference-line-text> $$
}

token reference-block
{
    <horizontal-rule-hard>
    <.gap>+
    <reference-block-reference-line>
    [ <.gap>+ <reference-block-reference-line> ]*
}

# end reference-block }}}
# code-block {{{

token code-block-delimiter-opening-backticks
{
    '```'
}

token code-block-delimiter-opening-dashes
{
    '-' '-'+
}

token code-block-language
{
    \w+
}

token code-block-content-backticks
{
    <-code-block-delimiter-closing-backticks>*
}

token code-block-content-dashes
{
    <-code-block-delimiter-closing-dashes>*
}

token code-block-delimiter-closing-backticks
{
    ^^ \h* <code-block-delimiter-opening-backticks> $$
}

token code-block-delimiter-closing-dashes
{
    ^^ \h* <code-block-delimiter-opening-dashes> $$
}

proto token code-block {*}

token code-block:backticks
{
    ^^
    \h*
    <code-block-delimiter-opening-backticks>
    <code-block-language>?
    $$
    \n

    <code-block-content-backticks>

    <code-block-delimiter-closing-backticks>
}

token code-block:dashes
{
    ^^
    \h*
    <code-block-delimiter-opening-dashes>
    [ <code-block-language> '-'* ]?
    $$
    \n

    <code-block-content-dashes>

    <code-block-delimiter-closing-dashes>
}

# end code-block }}}
# sectional-block {{{

token sectional-block-delimiter-opening-backticks
{
    <.code-block-delimiter-opening-backticks>
}

token sectional-block-delimiter-opening-dashes
{
    <.code-block-delimiter-opening-dashes>
}

token sectional-block-name-identifier-char
{
    <+[\w] +[,.¡!¿?\'\"“”‘’@\#$%^&`\\]>
}

token sectional-block-name-identifier-word
{
    <sectional-block-name-identifier-char>+
}

proto token sectional-block-name-identifier-file {*}

token sectional-block-name-identifier-file:absolute
{
    <file-absolute>
}

token sectional-block-name-identifier-file:absolute-protocol
{
    <file-absolute-protocol>
}

token sectional-block-name-identifier-file:relative-protocol
{
    <file-relative-protocol>
}

proto token sectional-block-name-identifier {*}

token sectional-block-name-identifier:file
{
    <sectional-block-name-identifier-file>
}

token sectional-block-name-identifier:word
{
    <+sectional-block-name-identifier-word
     -sectional-block-name-identifier-file>
    [
        \h+
        <+sectional-block-name-identifier-word
         -sectional-block-name-identifier-file>
    ]*
}

token sectional-block-name-identifier-export
{
    '*'
}

proto token sectional-block-name-operator    {*}
token sectional-block-name-operator:additive { '+=' }
token sectional-block-name-operator:redefine { ':=' }

token sectional-block-name
{
    <sectional-block-name-identifier>
    <sectional-block-name-identifier-export>?
    [ \h <sectional-block-name-operator> ]?
}

token sectional-block-content-backticks
{
    <-sectional-block-delimiter-closing-backticks>*
}

token sectional-block-content-dashes
{
    <-sectional-block-delimiter-closing-dashes>*
}

token sectional-block-delimiter-closing-backticks
{
    <.code-block-delimiter-closing-backticks>
}

token sectional-block-delimiter-closing-dashes
{
    <.code-block-delimiter-closing-dashes>
}

proto token sectional-block {*}

token sectional-block:backticks
{
    ^^
    \h*
    <sectional-block-delimiter-opening-backticks>
    \h
    <sectional-block-name>
    $$
    \n

    <sectional-block-content-backticks>

    <sectional-block-delimiter-closing-backticks>
}

token sectional-block:dashes
{
    ^^
    \h*
    <sectional-block-delimiter-opening-dashes>
    \h
    <sectional-block-name>
    $$
    \n

    <sectional-block-content-dashes>

    <sectional-block-delimiter-closing-dashes>
}

# end sectional-block }}}
# sectional-inline-block {{{

# C<<sectional-inline-block>> must be separated from other text blocks
# with a C<<blank-line>>, C<<comment-block>> or C<<horizontal-rule>>,
# or it must appear at the very top of the document
proto token sectional-inline-block {*}

token sectional-inline-block:top
{
    ^ <sectional-inline> [ <.gap> <sectional-inline> ]*
}

token sectional-inline-block:after-blank-line
{
    <blank-line> [ <.gap> <sectional-inline> ]+
}

token sectional-inline-block:after-comment-block
{
    <comment-block> [ <.gap> <sectional-inline> ]+
}

token sectional-inline-block:after-horizontal-rule
{
    <horizontal-rule> [ <.gap> <sectional-inline> ]+
}

# end sectional-inline-block }}}
# paragraph {{{

# --- word {{{

token word
{
    \S+
}

# --- end word }}}

token paragraph-line
{
    ^^

    <!before
        | <comment-block>
        | <code-block>
        | <sectional-block>
        | <horizontal-rule>
        | <list-item>
    >

    \h* <word> [ \h+ <word> ]*

    $$
}

token paragraph
{
    <paragraph-line> [ <.gap> <paragraph-line> ]*
}

# end paragraph }}}

# horizontal-rule {{{

token horizontal-rule-soft-symbol
{
    '~'
}

token horizontal-rule-hard-symbol
{
    '*'
}

token horizontal-rule-soft
{
    ^^ <horizontal-rule-soft-symbol> ** 2 <horizontal-rule-soft-symbol>* $$
}

token horizontal-rule-hard
{
    ^^ <horizontal-rule-hard-symbol> ** 2 <horizontal-rule-hard-symbol>* $$
}

proto token horizontal-rule {*}
token horizontal-rule:soft  { <horizontal-rule-soft> }
token horizontal-rule:hard  { <horizontal-rule-hard> }

# end horizontal-rule }}}

=begin pod
=head Inline Text
=end pod

# bold {{{

token bold-delimiter
{
    '**'
}

token bold-text
{
    # a non-whitespace character must come adjacent to
    # C<<bold-delimiter>>s
    <+[\S] -bold-delimiter> <+[\N] -bold-delimiter>*
}

token bold
{
    <bold-delimiter>
    <bold-text>
    # a non-whitespace character must come adjacent to
    # C<<bold-delimiter>>s
    <!after \s>
    <bold-delimiter>
}

# end bold }}}
# italic {{{

token italic-delimiter
{
    '*'
}

token italic-text
{
    # a non-whitespace character must come adjacent to
    # C<<italic-delimiter>>s
    <+[\S] -italic-delimiter> <+[\N] -italic-delimiter>*
}

token italic
{
    <italic-delimiter>
    <italic-text>
    # a non-whitespace character must come adjacent to
    # C<<italic-delimiter>>s
    <!after \s>
    <italic-delimiter>
}

# end italic }}}
# underline {{{

token underline-delimiter
{
    '_'
}

token underline-text
{
    # a non-whitespace character must come adjacent to
    # C<<underline-delimiter>>s
    <+[\S] -underline-delimiter>

    # underline can span multiple lines
    <-underline-delimiter>*
}

token underline
{
    <underline-delimiter>
    <underline-text>
    # a non-whitespace character must come adjacent to
    # C<<underline-delimiter>>s
    <!after \s>
    <underline-delimiter>
}

# end underline }}}
# strikethrough {{{

token strikethrough-delimiter
{
    '~'
}

token strikethrough-text
{
    # a non-whitespace character must come adjacent to
    # C<<strikethrough-delimiter>>s
    <+[\S] -strikethrough-delimiter> <+[\N] -strikethrough-delimiter>*
}

token strikethrough
{
    <strikethrough-delimiter>
    <strikethrough-text>
    # a non-whitespace character must come adjacent to
    # C<<strikethrough-delimiter>>s
    <!after \s>
    <strikethrough-delimiter>
}

# end strikethrough }}}
# boolean {{{

proto token boolean      {*}
token boolean:sym<true>  { <sym> }
token boolean:sym<false> { <sym> }

# end boolean }}}
# datetime {{{

# --- weekday {{{

proto token weekday    {*}
token weekday:sym<MON> { <sym> }
token weekday:sym<TUE> { <sym> }
token weekday:sym<WED> { <sym> }
token weekday:sym<THU> { <sym> }
token weekday:sym<FRI> { <sym> }
token weekday:sym<Mon> { <sym> }
token weekday:sym<Tue> { <sym> }
token weekday:sym<Wed> { <sym> }
token weekday:sym<Thu> { <sym> }
token weekday:sym<Fri> { <sym> }

# --- end weekday }}}
# --- weekend {{{

proto token weekend    {*}
token weekend:sym<SAT> { <sym> }
token weekend:sym<SUN> { <sym> }
token weekend:sym<Sat> { <sym> }
token weekend:sym<Sun> { <sym> }

# --- end weekend }}}
# --- month {{{

proto token month    {*}
token month:sym<JAN> { <sym> }
token month:sym<FEB> { <sym> }
token month:sym<MAR> { <sym> }
token month:sym<APR> { <sym> }
token month:sym<MAY> { <sym> }
token month:sym<JUN> { <sym> }
token month:sym<JUL> { <sym> }
token month:sym<AUG> { <sym> }
token month:sym<SEP> { <sym> }
token month:sym<OCT> { <sym> }
token month:sym<NOV> { <sym> }
token month:sym<DEC> { <sym> }
token month:sym<Jan> { <sym> }
token month:sym<Feb> { <sym> }
token month:sym<Mar> { <sym> }
token month:sym<Apr> { <sym> }
token month:sym<May> { <sym> }
token month:sym<Jun> { <sym> }
token month:sym<Jul> { <sym> }
token month:sym<Aug> { <sym> }
token month:sym<Sep> { <sym> }
token month:sym<Oct> { <sym> }
token month:sym<Nov> { <sym> }
token month:sym<Dec> { <sym> }

# --- end month }}}
# --- full-date {{{

token date-fullyear
{
    \d ** 4
}

token date-month
{
    0 <[1..9]> | 1 <[0..2]>
}

token date-mday
{
    0 <[1..9]> | <[1..2]> \d | 3 <[0..1]>
}

proto token full-date-separator  {*}
token full-date-separator:sym<-> { <sym> }
token full-date-separator:sym</> { <sym> }

token full-date
{
    <date-fullyear>
    <full-date-separator>
    <date-month>
    <full-date-separator>
    <date-mday>
}

# --- end full-date }}}
# --- partial-time {{{

token time-hour
{
    <[0..1]> \d | 2 <[0..3]>
}

token time-minute
{
    <[0..5]> \d
}

token time-second
{
    # The grammar element C<<time-second>> may have the value "60"
    # at the end of months in which a leap second occurs.
    <[0..5]> \d | 60
}

token time-secfrac
{
    <[.,]> \d+
}

token partial-time
{
    <time-hour> ':' <time-minute> ':' <time-second> <time-secfrac>?
}

# --- end partial-time }}}

# end datetime }}}
# callout {{{

proto token callout      {*}
token callout:sym<FIXME> { <sym> }
token callout:sym<TODO>  { <sym> }
token callout:sym<XXX>   { <sym> }

# end callout }}}
# log-level {{{

proto token log-level-ignore      {*}
token log-level-ignore:sym<DEBUG> { <sym> }
token log-level-ignore:sym<TRACE> { <sym> }

proto token log-level-info     {*}
token log-level-info:sym<INFO> { <sym> }

proto token log-level-warn     {*}
token log-level-warn:sym<WARN> { <sym> }

proto token log-level-error      {*}
token log-level-error:sym<ERROR> { <sym> }
token log-level-error:sym<FATAL> { <sym> }

# end log-level }}}
# url {{{

token url-scheme
{
    http[s]?
}

token url
{
    <url-scheme> '://' \S+
}

# end url }}}
# code-inline {{{

token code-inline-delimiter
{
    '`'
}

token code-inline-text
{
    <+[\N] -code-inline-delimiter>*
}

token code-inline
{
    <code-inline-delimiter>
    <code-inline-text>
    <code-inline-delimiter>
}

# end code-inline }}}
# sectional-link {{{

token sectional-link-delimiter
{
    '|'
}

token sectional-link-text
{
    # a non-whitespace character must come adjacent to
    # C<<sectional-link-delimiter>>s
    <+[\S] -sectional-link-delimiter> <+[\N] -sectional-link-delimiter>*
}

token sectional-link
{
    <sectional-link-delimiter>
    <sectional-link-text>
    # a non-whitespace character must come adjacent to
    # C<<sectional-link-delimiter>>s
    <!after \s>
    <sectional-link-delimiter>
}

# end sectional-link }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
