use v6;
use Finn::Parser::Grammar::Comment;
unit role Finn::Parser::Grammar::CommentBlock;
also does Finn::Parser::Grammar::Comment;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::CommentBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::CommentBlock;
grammar CommentBlock does Finn::Parser::Grammar::CommentBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::CommentBlock is a role containing grammar token
C<<comment-block>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# comment-block {{{

token comment-block
{
    ^^ \h* <comment> \h* $$
}

# end comment-block }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
