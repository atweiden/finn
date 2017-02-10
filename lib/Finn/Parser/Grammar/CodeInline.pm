use v6;
unit role Finn::Parser::Grammar::CodeInline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::CodeInline

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::CodeInline;
grammar CodeInline does Finn::Parser::Grammar::CodeInline {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::CodeInline is a role containing grammar token
C<<code-inline>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

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
