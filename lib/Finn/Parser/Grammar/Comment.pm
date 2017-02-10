use v6;
unit role Finn::Parser::Grammar::Comment;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Comment

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Comment;
grammar Comment does Finn::Parser::Grammar::Comment {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Comment is a role containing the grammar token
C<<comment>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# comment {{{

token comment-delimiter-opening
{
    '/*'
}

token comment-delimiter-closing
{
    '*/'
}

token comment-text
{
    <-comment-delimiter-closing>*
}

token comment
{
    <comment-delimiter-opening>
    <comment-text>
    <comment-delimiter-closing>
}

# end comment }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
