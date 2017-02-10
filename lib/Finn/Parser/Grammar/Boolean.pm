use v6;
unit role Finn::Parser::Grammar::Boolean;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Boolean

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Boolean;
grammar Boolean does Finn::Parser::Grammar::Boolean {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Boolean is a role containing the grammar token
C<<boolean>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# boolean {{{

proto token boolean      {*}
token boolean:sym<true>  { <sym> }
token boolean:sym<false> { <sym> }

# end boolean }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
