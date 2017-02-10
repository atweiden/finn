use v6;
unit role Finn::Parser::Grammar::BlankLine;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::BlankLine

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::BlankLine;
grammar BlankLine does Finn::Parser::Grammar::BlankLine {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::BlankLine is a role containing the grammar token
C<<blank-line>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# blank-line {{{

token blank-line
{
    ^^ \h* $$
}

# end blank-line }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
