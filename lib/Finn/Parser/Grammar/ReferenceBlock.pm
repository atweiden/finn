use v6;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::HorizontalRule;
use Finn::Parser::Grammar::ReferenceInline;
unit role Finn::Parser::Grammar::ReferenceBlock;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::HorizontalRule;
also does Finn::Parser::Grammar::ReferenceInline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::ReferenceBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::ReferenceBlock;
grammar ReferenceBlock does Finn::Parser::Grammar::ReferenceBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::ReferenceBlock is a role containing grammar token
C<<reference-block>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# reference-block {{{

token reference-block-reference-line-text
{
    \N+
}

token reference-block-reference-line
{
    ^^ <reference-inline> ':' \h <reference-block-reference-line-text> $$
}

token reference-block
{
    <horizontal-rule-hard>
    <.gap>+
    <reference-block-reference-line>
    [ <.gap>+ <reference-block-reference-line> ]*
}

# end reference-block }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
