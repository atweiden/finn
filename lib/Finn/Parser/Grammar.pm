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

I<Inline text> types cannot be mixed and matched. If something is bold
it cannot be italic. If something is a date, it can't be underlined.

=over
=item bold
=item italic
=item underline
=item strikethrough
=item date
=item time
=item callout
=item log-level
=item code-span
=item url
=item file
=item reference
=back

=head3 Block Text

I<Block text> may contain I<inline text> types.

=over
=item comment-text
=item header-text
=item paragraph-text
=item reference-block-text
=item list-ordered-item-text
=item list-unordered-item-text
=item list-todo-item-text
=item log-message-text
=back
=end pod

# end p6doc }}}

=begin pod
=head Block Text
=end pod

# blank {{{

token blank
{
    ^^ \h* $$
}

# end blank }}}
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

# end comment }}}
# header {{{

token header-text
{
    \N+
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
    # header3 is differentiated from one-line paragraph by a lack of a
    # period (C<.>) or comma (C<,>) at line-ending
    ^^ <header-text> <!after <[.,]>> $$
}

# end header }}}
# paragraph {{{

token paragraph
{

}

# end paragraph }}}
# list-ordered-item {{{

# --- numbers {{{

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

# --- end numbers }}}

token list-ordered-item-text-offset(UInt:D $offset)
{
    $<leading-whitespace> = \h* {}
    :my UInt:D $leading-whitespace = $/<leading-whitespace>.chars;
    <?{ $leading-whitespace == $offset }>
    \N+
}

# C<$offset> is the amount of leading whitespace needed for
# newline-separated adjoining text to be considered a part of this
# C<list-ordered-item-text>
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
    # adjoining text belonging to the same C<list-unordered-item>
    :my UInt:D $offset = $leading-whitespace + $item-number-chars + 1;

    [ \h <list-ordered-item-text($offset)> ]?

    $$
}

# end list-ordered-item }}}
# list-unordered-item {{{

# --- bullet-point {{{

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

# --- end bullet-point }}}

token list-unordered-item-text-offset(UInt:D $offset)
{
    $<leading-whitespace> = \h* {}
    :my UInt:D $leading-whitespace = $/<leading-whitespace>.chars;
    <?{ $leading-whitespace == $offset }>
    \N+
}

# C<$offset> is the amount of leading whitespace needed for
# newline-separated adjoining text to be considered a part of this
# C<list-unordered-item-text>
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
    # adjoining text belonging to the same C<list-unordered-item>
    :my UInt:D $offset = $leading-whitespace + $bullet-point + 1;

    [ \h <list-unordered-item-text($offset)> ]?

    $$
}

# end list-unordered-item }}}
# list-todo-item {{{

# --- checkbox {{{

token checkbox-checked
{

}

token checkbox-etc
{

}

token checkbox-exception
{

}

token checkbox
{

}

# --- end checkbox }}}

token list-todo-item
{

}

# end list-todo-item }}}
# reference-block {{{

token reference-block-text
{

}

token reference-block
{

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
# sectional {{{

token sectional-code-block-name-annot-export { '*' }

proto token sectional-code-block-name-operative {*}
token sectional-code-block-name-operative:additive { '+=' }
token sectional-code-block-name-operative:redefine { ':=' }

proto token sectional-code-block-name-text {*}
token sectional-code-block-name-text:path { <file> }
token sectional-code-block-name-text:normal { \N+ }

token sectional-code-block-name
{
    <sectional-code-block-name-text>
    <sectional-code-block-name-annot-export>?
    [ \h <sectional-code-block-name-operative> ]?
}

proto token sectional-code-block {*}

token sectional-code-block:backticks
{
    ^^
    <sectional-code-block-delimiter-backticks=code-block-delimiter-backticks>
    \h
    <sectional-code-block-name>
    $$
    \n

    [ ^^ <sectional-code-block-line-backticks=code-block-line-backticks> $$ \n ]*

    ^^
    <sectional-code-block-delimiter-backticks=code-block-delimiter-backticks>
    $$
}

token sectional-code-block:dashes
{
    ^^
    <sectional-code-block-delimiter-dashes=code-block-delimiter-dashes>
    \h
    <sectional-code-block-name>
    $$
    \n

    [ ^^ <sectional-code-block-line-dashes=code-block-line-dashes> $$ \n ]*

    ^^
    <sectional-code-block-delimiter-dashes=code-block-delimiter-dashes>
    $$
}

token section-sign
{

}

token sectional-embed-directive
{

}

# end sectional }}}

# horizontal-rule {{{

token horizontal-rule-soft
{
    ^^ '~' ** 6 '~'* $$
}

token horizontal-rule-hard
{
    ^^ '*' ** 6 '*'* $$
}

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
    <+[\N] -bold-delimiter>*
}

token bold
{
    <bold-delimiter>
    <bold-text>
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
    <+[\N] -italic-delimiter>*
}

token italic
{
    <italic-delimiter>
    <italic-text>
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
    # underline can span multiple lines
    <-underline-delimiter>*
}

token underline
{
    <underline-delimiter>
    <underline-text>
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
    <+[\N] -strikethrough-delimiter>*
}

token strikethrough
{
    <strikethrough-delimiter>
    <strikethrough-text>
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
    # The grammar element time-second may have the value "60" at the end
    # of months in which a leap second occurs.
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

token url
{

}

# end url }}}
# file {{{

token file
{

}

# end file }}}
# reference-inline {{{

token reference-inline
{

}

# end reference-inline }}}
# code-span {{{

token code-span-delimiter
{
    '`'
}

token code-span-text
{
    <+[\N] -code-span-delimiter>*
}

token code-span
{
    <code-span-delimiter>
    <code-span-text>
    <code-span-delimiter>
}

# end code-span }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
