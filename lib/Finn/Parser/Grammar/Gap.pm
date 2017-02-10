use v6;
use Finn::Parser::Grammar::Comment;
unit role Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::Comment;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Gap

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Gap;
grammar Gap does Finn::Parser::Grammar::Gap {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Gap is a role containing the grammar token
C<<gap>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# gap {{{

proto token gap   {*}
token gap:newline { \n }
token gap:comment { <.comment> \h* $$ \n }

# end gap }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
