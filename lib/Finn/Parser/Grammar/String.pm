use v6;
unit role Finn::Parser::Grammar::String;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::String

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::String;
grammar String does Finn::Parser::Grammar::String {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::String is a role containing grammar token
C<<string>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# string {{{

# --- string-basic {{{

# --- --- string-basic-char {{{

proto token string-basic-char {*}

token string-basic-char:common
{
    # anything but linebreaks, double-quotes, backslashes and control
    # characters (U+0000 to U+001F)
    <+[\N] -[\" \\] -[\x00..\x1F]>
}

token string-basic-char:tab
{
    \t
}

token string-basic-char:escape-sequence
{
    # backslash followed by a valid (TOML) escape code, or error
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

# --- --- end string-basic-char }}}
# --- --- escape {{{

token hex
{
    <[0..9A..F]>
}

# For convenience, some popular characters have a compact escape sequence.
#
# \b         - backspace       (U+0008)
# \t         - tab             (U+0009)
# \n         - linefeed        (U+000A)
# \f         - form feed       (U+000C)
# \r         - carriage return (U+000D)
# \"         - quote           (U+0022)
# \\         - backslash       (U+005C)
# \uXXXX     - unicode         (U+XXXX)
# \UXXXXXXXX - unicode         (U+XXXXXXXX)
proto token escape          {*}
token escape:sym<b>         { <sym> }
token escape:sym<t>         { <sym> }
token escape:sym<n>         { <sym> }
token escape:sym<f>         { <sym> }
token escape:sym<r>         { <sym> }
token escape:sym<quote>     { \" }
token escape:sym<backslash> { \\ }
token escape:sym<u>         { <sym> <hex> ** 4 }
token escape:sym<U>         { <sym> <hex> ** 8 }

# --- --- end escape }}}

token string-basic-text
{
    <string-basic-char>+
}

token string-basic
{
    '"' <string-basic-text> '"'
}

# --- end string-basic }}}
# --- string-literal {{{

# --- --- string-literal-char {{{

proto token string-literal-char {*}

token string-literal-char:common
{
    # anything but linebreaks and single quotes
    # Since there is no escaping, there is no way to write a single
    # quote inside a literal string enclosed by single quotes.
    <+[\N] -[\']>
}

token string-literal-char:backslash
{
    \\
}

# --- --- end string-literal-char }}}

token string-literal-text
{
    <string-literal-char>+
}

token string-literal
{
    \' <string-literal-text> \'
}

# --- end string-literal }}}

proto token string   {*}
token string:basic   { <string-basic> }
token string:literal { <string-literal> }

# end string }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
