use v6;
unit role Finn::Parser::Grammar::File;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::File

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::File;
grammar File does Finn::Parser::Grammar::File {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::File is a role containing grammar token
C<<file>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# file {{{

# --- file-path-char {{{

proto token file-path-char {*}

token file-path-char:common
{
    # anything but linebreaks, whitespace, single-quotes, double-quotes,
    # fwdslashes, backslashes, square brackets, curly braces and control
    # characters (U+0000 to U+001F)
    <+[\N] -[\h] -[\' \" / \\] -[\[ \] \{ \}] -[\x00..\x1F]>
}

token file-path-char:escape-sequence
{
    # backslash followed by a valid file-path-escape code, or error
    \\
    [
        <file-path-escape>

        ||

        .
        {
            die;
        }
    ]
}

# --- end file-path-char }}}
# --- file-path-escape {{{

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
# \*         - asterisk        (U+002a)
# \[         - left bracket    (U+005b)
# \]         - right bracket   (U+005d)
# \{         - left brace      (U+007b)
# \}         - right brace     (U+007d)
# \uXXXX     - unicode         (U+XXXX)
# \UXXXXXXXX - unicode         (U+XXXXXXXX)
proto token file-path-escape             {*}
token file-path-escape:sym<whitespace>   { \h }
token file-path-escape:sym<b>            { <sym> }
token file-path-escape:sym<t>            { <sym> }
token file-path-escape:sym<n>            { <sym> }
token file-path-escape:sym<f>            { <sym> }
token file-path-escape:sym<r>            { <sym> }
token file-path-escape:sym<single-quote> { \' }
token file-path-escape:sym<double-quote> { \" }
token file-path-escape:sym<fwdslash>     { '/' }
token file-path-escape:sym<backslash>    { \\ }
token file-path-escape:sym<*>            { <sym> }
token file-path-escape:sym<[>            { <sym> }
token file-path-escape:sym<]>            { <sym> }
token file-path-escape:sym<{>            { <sym> }
token file-path-escape:sym<}>            { <sym> }
token file-path-escape:sym<u>            { <sym> <hex> ** 4 }
token file-path-escape:sym<U>            { <sym> <hex> ** 8 }

# --- end file-path-escape }}}
# --- file-protocol {{{

token file-protocol
{
    'file://'
}

# --- end file-protocol }}}
# --- file-absolute {{{

token file-path-absolute
{
    '/' <file-path-char>+ <file-path-absolute>*
}

token file-absolute
{
    | '~'? <file-path-absolute>
    | '~'
    | '/'
}

# --- end file-absolute }}}
# --- file-absolute-protocol {{{

token file-absolute-protocol
{
    <file-protocol> <file-absolute>
}

# --- end file-absolute-protocol }}}
# --- file-relative {{{

token file-path-relative
{
    <file-path-char>+ <file-path-absolute>*
}

token file-relative
{
    <file-path-relative>
}

# --- end file-relative }}}
# --- file-relative-protocol {{{

token file-relative-protocol
{
    <file-protocol> <file-relative>
}

# --- end file-relative-protocol }}}

proto token file             {*}
token file:absolute-protocol { <file-absolute-protocol> }
token file:relative-protocol { <file-relative-protocol> }
token file:absolute          { <file-absolute> }
token file:relative          { <file-relative> }

# end file }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
