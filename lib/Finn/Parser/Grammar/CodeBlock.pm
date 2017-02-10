use v6;
unit role Finn::Parser::Grammar::CodeBlock;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::CodeBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::CodeBlock;
grammar CodeBlock does Finn::Parser::Grammar::CodeBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::CodeBlock is a role containing the grammar token
C<<code-block>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# code-block {{{

# --- code-block-delimiter-opening {{{

token code-block-delimiter-opening-backticks
{
    '```'
}

token code-block-delimiter-opening-dashes
{
    '-' '-'+
}

# --- end code-block-delimiter-opening }}}
# --- code-block-language {{{

token code-block-language
{
    \w+
}

# --- end code-block-language }}}
# --- code-block-content {{{

token code-block-content-backticks
{
    <-code-block-delimiter-closing-backticks>*
}

token code-block-content-dashes
{
    <-code-block-delimiter-closing-dashes>*
}

# --- end code-block-content }}}
# --- code-block-delimiter-closing {{{

token code-block-delimiter-closing-backticks
{
    ^^ \h* <code-block-delimiter-opening-backticks> $$
}

token code-block-delimiter-closing-dashes
{
    ^^ \h* <code-block-delimiter-opening-dashes> $$
}

# --- end code-block-delimiter-closing }}}

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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
