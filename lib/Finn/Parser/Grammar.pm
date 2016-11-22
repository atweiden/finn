use v6;
unit grammar Finn::Parser::Grammar;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar;
my $match = Finn::Parser::Grammar.parse('text');
=end code

=head DESCRIPTION

Parses Finn file format.

Parses block text first, then re-parses block text for inline text.

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
=item url
=item file
=item reference-inline
=item code-inline
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
=item paragraph-block
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

proto token chunk {*}
token chunk:sectional-inline-block { <sectional-inline-block> }
token chunk:sectional-block { <sectional-block> }
token chunk:code-block { <code-block> }
token chunk:reference-block { <reference-block> }
token chunk:header-block { <header-block> }
token chunk:list-block { <list-block> }
token chunk:paragraph-block { <paragraph> }
token chunk:horizontal-rule { <horizontal-rule> }
token chunk:comment-block { <comment-block> }
token chunk:blank-line { <blank-line> }

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
# header {{{

token header-text
{
    # C<<header-text>> will be construed as C<<list-unordered-item>>,
    # C<<list-todo>>, C<<list-ordered-item>> or C<<sectional-inline>>
    # in the presence of a leading C<<bullet-point>>, C<<checkbox>>,
    # C<<list-ordered-item-number>> or C<<section-sign>> respectively
    <!before
        | <bullet-point>
        | <checkbox>
        | <comment>
        | <list-ordered-item-number>
        | <section-sign>
    >

    # C<<header-text>> cannot contain leading whitespace
    \S \N*
}

token header1
{
    ^^ <header-text> $$ \n
    ^^ '='+ $$
}

token header2
{
    ^^ <header-text> $$ \n
    ^^ '-'+ $$
}

token header3
{
    ^^

    <header-text>

    # C<<header3>> is distinguishable from a one-line paragraph by a
    # lack of a period (C<.>) or comma (C<,>) at line-ending
    <!after <[.,]>>

    $$
}

proto token header {*}
token header:h1 { <header1> }
token header:h2 { <header2> }
token header:h3 { <header3> }

# C<<header-block>> must be separated from other text blocks with a
# C<<blank-line>>, C<<comment-block>> or C<<horizontal-rule>>, or it
# must appear at the very top of the document
proto token header-block {*}

token header-block:top
{
    ^ <header>
}

token header-block:dispersed
{
    [ <blank-line> | <comment-block> | <horizontal-rule> ] \n <header>
}

# end header }}}
# list-block {{{

# --- list-ordered-item {{{

# --- --- list-ordered-item-number {{{

token list-ordered-item-number-value
{
    \d+
}

proto token list-ordered-item-number-terminator {*}
token list-ordered-item-number-terminator:sym<.> { <sym> }
token list-ordered-item-number-terminator:sym<:> { <sym> }
token list-ordered-item-number-terminator:sym<)> { <sym> }

token list-ordered-item-number
{
    <list-ordered-item-number-value>
    <list-ordered-item-number-terminator>
}

# --- --- end list-ordered-item-number }}}

token list-ordered-item-text-offset(UInt:D $offset)
{
    $<leading-whitespace> = \h* {}
    :my UInt:D $leading-whitespace = $/<leading-whitespace>.chars;
    <?{ $leading-whitespace == $offset }>
    \N+
}

# C<$offset> is the amount of leading whitespace needed for
# newline-separated adjoining text to be considered a part of this
# C<<list-ordered-item-text>>
token list-ordered-item-text(UInt:D $offset)
{
    \N+

    # optional additional lines of offset text
    [ $$ \n ^^ <list-ordered-item-text-offset($offset)> ]*
}

token list-ordered-item
{
    ^^

    $<leading-whitespace> = \h* {}
    :my UInt:D $leading-whitespace = $/<leading-whitespace>.chars;

    <list-ordered-item-number> {}
    :my UInt:D $item-number-chars = $<list-ordered-item-number>.chars;

    # C<$offset> is the required amount of leading whitespace for
    # adjoining text belonging to the same C<<list-unordered-item>>
    :my UInt:D $offset = $leading-whitespace + $item-number-chars + 1;

    [ \h <list-ordered-item-text($offset)> ]?

    $$
}

# --- end list-ordered-item }}}
# --- list-unordered-item {{{

# --- --- bullet-point {{{

proto token bullet-point {*}
token bullet-point:sym<-> { <sym> }
token bullet-point:sym<@> { <sym> }
token bullet-point:sym<#> { <sym> }
token bullet-point:sym<$> { <sym> }
token bullet-point:sym<*> { <sym> }
token bullet-point:sym<:> { <sym> }
token bullet-point:sym<x> { <sym> }
token bullet-point:sym<o> { <sym> }
token bullet-point:sym<+> { <sym> }
token bullet-point:sym<=> { <sym> }
token bullet-point:sym<!> { <sym> }
token bullet-point:sym<~> { <sym> }
token bullet-point:sym«>» { <sym> }
token bullet-point:sym«<-» { <sym> }
token bullet-point:sym«<=» { <sym> }
token bullet-point:sym«->» { <sym> }
token bullet-point:sym«=>» { <sym> }

# --- --- end bullet-point }}}

token list-unordered-item-text-offset(UInt:D $offset)
{
    $<leading-whitespace> = \h* {}
    :my UInt:D $leading-whitespace = $/<leading-whitespace>.chars;
    <?{ $leading-whitespace == $offset }>
    \N+
}

# C<$offset> is the amount of leading whitespace needed for
# newline-separated adjoining text to be considered a part of this
# C<<list-unordered-item-text>>
token list-unordered-item-text(UInt:D $offset)
{
    \N+

    # optional additional lines of offset text
    [ $$ \n ^^ <list-unordered-item-text-offset($offset)> ]*
}

token list-unordered-item
{
    ^^

    $<leading-whitespace> = \h* {}
    :my UInt:D $leading-whitespace = $/<leading-whitespace>.chars;

    <bullet-point> {}
    :my UInt:D $bullet-point = $<bullet-point>.chars;

    # C<$offset> is the required amount of leading whitespace for
    # adjoining text belonging to the same C<<list-unordered-item>>
    :my UInt:D $offset = $leading-whitespace + $bullet-point + 1;

    [ \h <list-unordered-item-text($offset)> ]?

    $$
}

# --- end list-unordered-item }}}
# --- list-todo-item {{{

# --- --- checkbox {{{

proto token checkbox-checked-char {*}
token checkbox-checked-char:sym<x> { <sym> }
token checkbox-checked-char:sym<o> { <sym> }
token checkbox-checked-char:sym<v> { <sym> }

token checkbox-checked
{
    '[' <checkbox-checked-char> ']'
}

proto token checkbox-etc-char {*}
token checkbox-etc-char:sym<+> { <sym> }
token checkbox-etc-char:sym<=> { <sym> }
token checkbox-etc-char:sym<-> { <sym> }

token checkbox-etc
{
    '[' <checkbox-etc-char> ']'
}

proto token checkbox-exception-char {*}
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

proto token checkbox {*}
token checkbox:checked { <checkbox-checked> }
token checkbox:etc { <checkbox-etc> }
token checkbox:exception { <checkbox-exception> }
token checkbox:unchecked { <checkbox-unchecked> }

# --- --- end checkbox }}}

token list-todo-item-text
{
    \N+
}

token list-todo-item
{
    <checkbox> \h <list-todo-item-text>
}

# --- end list-todo-item }}}

token list-block
{
    # XXX placeholder
    .
}

# end list-block }}}
# reference-block {{{

token reference-block-line-text
{
    \N+
}

token reference-block-line
{
    ^^ <reference-inline> ':' \h <reference-block-line-text> $$
}

token reference-block
{
    <horizontal-rule-hard> \n+
    <reference-block-line> [ \n+ <reference-block-line> ]*
}

# end reference-block }}}
# code-block {{{

token code-block-delimiter-backticks
{
    '```'
}

token code-block-delimiter-dashes
{
    '-' '-'+
}

token code-block-language
{
    \w+
}

token code-block-line-backticks
{
    # 3 non-newline chars are the minimum threshold for triple backticks
    #
    # if >= 3 non-newline chars, make sure we haven't seen a closing
    # triple backtick delimiter
    #
    # if less than 3 non-newline chars exist, triple backticks are
    # impossible
    #
    | \N ** 0
    | \N ** 1..2
    | \N ** 3 <!after <code-block-delimiter-backticks>> \N*
}

token code-block-line-dashes
{
    # 2 non-newline chars are the minimum threshold for dashes
    #
    # if >= 2 non-newline chars, make sure we haven't seen a closing
    # dashes delimiter
    #
    # if less than 2 non-newline chars exist, dashes are impossible
    #
    | \N ** 0
    | \N ** 1
    | \N ** 2 <!after <code-block-delimiter-dashes>> \N*
}

proto token code-block {*}

token code-block:backticks
{
    ^^ \h* <code-block-delimiter-backticks> <code-block-language>? $$ \n
    [ ^^ <code-block-line-backticks>? $$ \n ]*
    ^^ \h* <code-block-delimiter-backticks> $$
}

token code-block:dashes
{
    ^^ \h* <code-block-delimiter-dashes> [ <code-block-language> '-'* ]? $$ \n
    [ ^^ <code-block-line-dashes>? $$ \n ]*
    ^^ \h* <code-block-delimiter-dashes> $$
}

# end code-block }}}
# sectional-block {{{

token sectional-block-name-text-char
{
    <+[\w] +[,.¡!¿?\'\"“”‘’()\{\}@\#$%^&`\\]>
}


token sectional-block-name-text-word
{
    <sectional-block-name-text-char>+
}

proto token sectional-block-name-text {*}

token sectional-block-name-text:path
{
    <file>
}

token sectional-block-name-text:normal
{
    <+sectional-block-name-text-word -file>
    [ \h+ <+sectional-block-name-text-word -file> ]*
}

token sectional-block-name-annot-export
{
    '*'
}

proto token sectional-block-name-operative {*}
token sectional-block-name-operative:additive { '+=' }
token sectional-block-name-operative:redefine { ':=' }

token sectional-block-name
{
    <sectional-block-name-text>
    <sectional-block-name-annot-export>?
    [ \h <sectional-block-name-operative> ]?
}

proto token sectional-block {*}

token sectional-block:backticks
{
    ^^
    <sectional-block-delimiter-backticks=code-block-delimiter-backticks>
    \h
    <sectional-block-name>
    $$
    \n

    [ ^^ <sectional-block-line-backticks=code-block-line-backticks> $$ \n ]*

    ^^
    <sectional-block-delimiter-backticks=code-block-delimiter-backticks>
    $$
}

token sectional-block:dashes
{
    ^^
    <sectional-block-delimiter-dashes=code-block-delimiter-dashes>
    \h
    <sectional-block-name>
    $$
    \n

    [ ^^ <sectional-block-line-dashes=code-block-line-dashes> $$ \n ]*

    ^^
    <sectional-block-delimiter-dashes=code-block-delimiter-dashes>
    $$
}

# end sectional-block }}}
# sectional-inline-block {{{

# --- sectional-inline {{{

token section-sign
{
    '§'
}

token sectional-inline-name-text-word
{
    <sectional-inline-name-text-char=sectional-block-name-text-char>+
}

token sectional-inline-name
{
    <+sectional-inline-name-text-word -file>
    [ \h+ <+sectional-inline-name-text-word -file> ]*
}

proto token sectional-inline-text {*}

token sectional-inline-text:file-only
{
    <sectional-inline-file=file>
}

token sectional-inline-text:reference-only
{
    <sectional-inline-reference=reference-inline>
}

token sectional-inline-text:name-and-file
{
    <sectional-inline-name> \h <sectional-inline-file=file>
}

token sectional-inline-text:name-and-reference
{
    <sectional-inline-name> \h <sectional-inline-reference=reference-inline>
}

token sectional-inline
{
    ^^ \h* <section-sign> \h <sectional-inline-text> $$
}

# --- end sectional-inline }}}

# C<<sectional-inline-block>> must be separated from other text blocks
# with a C<<blank-line>>, C<<comment-block>> or C<<horizontal-rule>>,
# or it must appear at the very top of the document
proto token sectional-inline-block {*}

token sectional-inline-block:top
{
    ^ <sectional-inline>
    [ \n <sectional-inline> ]*
}

token sectional-inline-block:dispersed
{
    [ <blank-line> | <comment-block> | <horizontal-rule> ]
    [ \n <sectional-inline> ]+
}

# end sectional-inline-block }}}
# paragraph {{{

token paragraph-line
{
    \N+
}

token paragraph
{
    ^^ <paragraph-line> $$ [ \n ^^ <paragraph-line> $$ ]*
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
token horizontal-rule:soft { <horizontal-rule-soft> }
token horizontal-rule:hard { <horizontal-rule-hard> }

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

proto token boolean {*}
token boolean:sym<true> { <sym> }
token boolean:sym<false> { <sym> }

# end boolean }}}
# datetime {{{

# --- weekday {{{

proto token weekday {*}
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

proto token weekend {*}
token weekend:sym<SAT> { <sym> }
token weekend:sym<SUN> { <sym> }
token weekend:sym<Sat> { <sym> }
token weekend:sym<Sun> { <sym> }

# --- end weekend }}}
# --- month {{{

proto token month {*}
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

proto token full-date-separator {*}
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

proto token callout {*}
token callout:sym<FIXME> { <sym> }
token callout:sym<TODO> { <sym> }
token callout:sym<XXX> { <sym> }

# end callout }}}
# log-level {{{

proto token log-level-ignore {*}
token log-level-ignore:sym<DEBUG> { <sym> }
token log-level-ignore:sym<TRACE> { <sym> }

proto token log-level-info {*}
token log-level-info:sym<INFO> { <sym> }

proto token log-level-warn {*}
token log-level-warn:sym<WARN> { <sym> }

proto token log-level-error {*}
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
# file {{{

proto token file-path-char {*}

token file-path-char:common
{
    # anything but linebreaks, whitespace, single-quotes, double-quotes,
    # fwdslashes, backslashes and control characters (U+0000 to U+001F)
    <+[\N] -[\h] -[\' \" / \\] -[\x00..\x1F]>
}

token file-path-char:escape-sequence
{
    # backslash followed by a valid escape code, or error
    \\
    [
        <escape>

        ||

        .
        {
            die;
        }
    ]
}

# For convenience, some popular characters have a compact escape sequence.
#
# \          - whitespace      (U+0020)
# \b         - backspace       (U+0008)
# \t         - tab             (U+0009)
# \n         - linefeed        (U+000A)
# \f         - form feed       (U+000C)
# \r         - carriage return (U+000D)
# \'         - single-quote    (U+0027)
# \"         - double-quote    (U+0022)
# \/         - fwdslash        (U+002f)
# \\         - backslash       (U+005C)
# \uXXXX     - unicode         (U+XXXX)
# \UXXXXXXXX - unicode         (U+XXXXXXXX)
proto token escape {*}
token escape:sym<whitespace> { \h }
token escape:sym<b> { <sym> }
token escape:sym<t> { <sym> }
token escape:sym<n> { <sym> }
token escape:sym<f> { <sym> }
token escape:sym<r> { <sym> }
token escape:sym<single-quote> { \' }
token escape:sym<double-quote> { \" }
token escape:sym<fwdslash> { '/' }
token escape:sym<backslash> { \\ }
token escape:sym<u> { <sym> <hex> ** 4 }
token escape:sym<U> { <sym> <hex> ** 8 }

token hex
{
    <[0..9A..F]>
}

token file-path-absolute
{
    '/' <file-path-char>+ <file-path-absolute>*
}

token file
{
    'file://'?
    [
        | '~'? <file-path-absolute>
        | '~'
        | '/'
    ]
}

# end file }}}
# reference-inline {{{

token reference-inline-number
{
    0

    |

    # Leading zeros are not allowed.
    <[1..9]> [ \d+ ]?
}

token reference-inline
{
    '[' <reference-inline-number> ']'
}

# end reference-inline }}}
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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
