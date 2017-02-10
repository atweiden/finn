use v6;
unit role Finn::Parser::Grammar::SectionalLink;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalLink

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::SectionalLink;
grammar SectionalLink does Finn::Parser::Grammar::SectionalLink {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalLink is a role containing grammar token
C<<sectional-link>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

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
