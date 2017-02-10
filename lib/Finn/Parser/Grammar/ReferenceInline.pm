use v6;
unit role Finn::Parser::Grammar::ReferenceInline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::ReferenceInline

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::ReferenceInline;
grammar ReferenceInline does Finn::Parser::Grammar::ReferenceInline {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::ReferenceInline is a role containing grammar
token C<<reference-inline>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# reference-inline {{{

token reference-inline-number
{
    0

    |

    # Leading zeros are not allowed.
    <[1..9]> [ \d+ ]?
}

token reference-inline
{
    '[' <reference-inline-number> ']'
}

# end reference-inline }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
