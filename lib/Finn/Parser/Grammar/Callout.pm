use v6;
unit role Finn::Parser::Grammar::Callout;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Callout

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Callout;
grammar Callout does Finn::Parser::Grammar::Callout {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Callout is a role containing grammar token
C<<callout>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# callout {{{

proto token callout      {*}
token callout:sym<FIXME> { <sym> }
token callout:sym<TODO>  { <sym> }
token callout:sym<XXX>   { <sym> }

# end callout }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
