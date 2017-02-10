use v6;
unit role Finn::Parser::Grammar::Underline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Underline

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Underline;
grammar Underline does Finn::Parser::Grammar::Underline {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Underline is a role containing the grammar token
C<<underline>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
