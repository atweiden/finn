use v6;
use Finn::Parser::Grammar::CodeBlock;
use Finn::Parser::Grammar::File;
unit role Finn::Parser::Grammar::SectionalBlock;
also does Finn::Parser::Grammar::CodeBlock;
also does Finn::Parser::Grammar::File;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::SectionalBlock;
grammar SectionalBlock does Finn::Parser::Grammar::SectionalBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalBlock is a role containing grammar token
C<<sectional-block>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# sectional-block {{{

# --- sectional-block-delimiter-opening {{{

token sectional-block-delimiter-opening-backticks
{
    <.code-block-delimiter-opening-backticks>
}

token sectional-block-delimiter-opening-dashes
{
    <.code-block-delimiter-opening-dashes>
}

# --- end sectional-block-delimiter-opening }}}
# --- sectional-block-name {{{

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

# --- end sectional-block-name }}}
# --- sectional-block-content {{{

token sectional-block-content-backticks
{
    <-sectional-block-delimiter-closing-backticks>*
}

token sectional-block-content-dashes
{
    <-sectional-block-delimiter-closing-dashes>*
}

# --- end sectional-block-content }}}
# --- sectional-block-delimiter-closing {{{

token sectional-block-delimiter-closing-backticks
{
    <.code-block-delimiter-closing-backticks>
}

token sectional-block-delimiter-closing-dashes
{
    <.code-block-delimiter-closing-dashes>
}

# --- end sectional-block-delimiter-closing }}}

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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
