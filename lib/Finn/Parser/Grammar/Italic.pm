use v6;
unit role Finn::Parser::Grammar::Italic;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Italic

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Italic;
grammar Italic does Finn::Parser::Grammar::Italic {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Italic is a role containing the grammar token
C<<italic>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
