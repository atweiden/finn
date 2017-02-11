use v6;
use Finn::Parser::Grammar::File;
use Finn::Parser::Grammar::ReferenceInline;
use Finn::Parser::Grammar::String;
unit role Finn::Parser::Grammar::SectionalInline;
also does Finn::Parser::Grammar::File;
also does Finn::Parser::Grammar::ReferenceInline;
also does Finn::Parser::Grammar::String;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalInline

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::SectionalInline;
grammar SectionalInline does Finn::Parser::Grammar::SectionalInline {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalInline is a role containing grammar
token C<<sectional-inline>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# sectional-inline {{{

token section-sign
{
    '§'
}

proto token sectional-inline-text {*}

token sectional-inline-text:name-and-file
{
    <sectional-inline-name=string> \h <sectional-inline-file=file>
}

token sectional-inline-text:name-and-reference
{
    <sectional-inline-name=string> \h <sectional-inline-reference=reference-inline>
}

token sectional-inline-text:file-only
{
    <sectional-inline-file=file>
}

token sectional-inline-text:reference-only
{
    <sectional-inline-reference=reference-inline>
}

token sectional-inline-text:name-only
{
    <sectional-inline-name=string>
}

token sectional-inline
{
    ^^ \h* <section-sign> \h <sectional-inline-text> $$
}

# end sectional-inline }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
