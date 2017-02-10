use v6;
unit role Finn::Parser::Grammar::Bold;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Bold

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Bold;
grammar Bold does Finn::Parser::Grammar::Bold {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Bold is a role containing the grammar token
C<<bold>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# bold {{{

token bold-delimiter
{
    '**'
}

token bold-text
{
    # a non-whitespace character must come adjacent to
    # C<<bold-delimiter>>s
    <+[\S] -bold-delimiter> <+[\N] -bold-delimiter>*
}

token bold
{
    <bold-delimiter>
    <bold-text>
    # a non-whitespace character must come adjacent to
    # C<<bold-delimiter>>s
    <!after \s>
    <bold-delimiter>
}

# end bold }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
