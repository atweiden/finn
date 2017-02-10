use v6;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::ListItem;
unit role Finn::Parser::Grammar::ListBlock;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::ListItem;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::ListBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::ListBlock;
grammar ListBlock does Finn::Parser::Grammar::ListBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::ListBlock is a role containing grammar token
C<<list-block>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# list-block {{{

token list-block
{
    ^^ <list-item> $$
    [ <.gap> ^^ <list-item> $$ ]*
}

# end list-block }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
