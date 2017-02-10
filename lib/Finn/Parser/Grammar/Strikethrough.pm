use v6;
unit role Finn::Parser::Grammar::Strikethrough;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Strikethrough

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Strikethrough;
grammar Strikethrough does Finn::Parser::Grammar::Strikethrough {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Strikethrough is a role containing the grammar
token C<<strikethrough>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# strikethrough {{{

token strikethrough-delimiter
{
    '~'
}

token strikethrough-text
{
    # a non-whitespace character must come adjacent to
    # C<<strikethrough-delimiter>>s
    <+[\S] -strikethrough-delimiter> <+[\N] -strikethrough-delimiter>*
}

token strikethrough
{
    <strikethrough-delimiter>
    <strikethrough-text>
    # a non-whitespace character must come adjacent to
    # C<<strikethrough-delimiter>>s
    <!after \s>
    <strikethrough-delimiter>
}

# end strikethrough }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
