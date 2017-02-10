use v6;
use Finn::Parser::Grammar::CodeBlock;
use Finn::Parser::Grammar::Comment;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::HorizontalRule;
use Finn::Parser::Grammar::ListItem;
use Finn::Parser::Grammar::Paragraph;
use Finn::Parser::Grammar::SectionalBlock;
use Finn::Parser::Grammar::SectionalInlineBlock;
unit role Finn::Parser::Grammar::Header;
also does Finn::Parser::Grammar::CodeBlock;
also does Finn::Parser::Grammar::Comment;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::HorizontalRule;
also does Finn::Parser::Grammar::ListItem;
also does Finn::Parser::Grammar::Paragraph;
also does Finn::Parser::Grammar::SectionalBlock;
also does Finn::Parser::Grammar::SectionalInlineBlock;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Header

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Header;
grammar Header does Finn::Parser::Grammar::Header {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Header is a role containing grammar token
C<<header>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# header {{{

token header-text
{
    <!before
        | <comment>
        | <code-block>
        | <sectional-block>
        | <sectional-inline-block>
        | <horizontal-rule>
        | <list-item>
    >

    # C<<header-text>> cannot contain leading whitespace
    \S \N*
}

token header1
{
    ^^ <header-text> $$ <.gap>
    ^^ '='+ $$
}

token header2
{
    ^^ <header-text> $$ <.gap>
    ^^ '-'+ $$
}

token header3
{
    ^^

    <header-text>

    # C<<header3>> is distinguishable from a one-line paragraph by a
    # lack of a period (C<.>) or comma (C<,>) at line-ending
    <!after <[.,]> [ \h* <.comment> \h* ]?>

    $$

    # C<<header3>> also can't come before a C<<paragraph-line>>,
    # but it can come before a C<<list-block>> and other blocks
    <!before <.gap> <paragraph-line>>
}

proto token header {*}
token header:h1    { <header1> }
token header:h2    { <header2> }
token header:h3    { <header3> }

# end header }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
