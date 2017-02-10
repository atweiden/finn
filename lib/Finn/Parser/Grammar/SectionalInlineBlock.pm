use v6;
use Finn::Parser::Grammar::BlankLine;
use Finn::Parser::Grammar::CommentBlock;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::HorizontalRule;
use Finn::Parser::Grammar::SectionalInline;
unit role Finn::Parser::Grammar::SectionalInlineBlock;
also does Finn::Parser::Grammar::BlankLine;
also does Finn::Parser::Grammar::CommentBlock;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::HorizontalRule;
also does Finn::Parser::Grammar::SectionalInline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalInlineBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::SectionalInlineBlock;
grammar SectionalInlineBlock
    does Finn::Parser::Grammar::SectionalInlineBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalInlineBlock is a role containing grammar
token C<<sectional-inline-block>>. It is meant to be mixed into other
grammars.
=end pod

# end p6doc }}}

# sectional-inline-block {{{

# C<<sectional-inline-block>> must be separated from other text blocks
# with a C<<blank-line>>, C<<comment-block>> or C<<horizontal-rule>>,
# or it must appear at the very top of the document
proto token sectional-inline-block {*}

token sectional-inline-block:top
{
    ^ <sectional-inline> [ <.gap> <sectional-inline> ]*
}

token sectional-inline-block:after-blank-line
{
    <blank-line> [ <.gap> <sectional-inline> ]+
}

token sectional-inline-block:after-comment-block
{
    <comment-block> [ <.gap> <sectional-inline> ]+
}

token sectional-inline-block:after-horizontal-rule
{
    <horizontal-rule> [ <.gap> <sectional-inline> ]+
}

# end sectional-inline-block }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
