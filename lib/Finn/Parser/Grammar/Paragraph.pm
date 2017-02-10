use v6;
use Finn::Parser::Grammar::CodeBlock;
use Finn::Parser::Grammar::CommentBlock;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::HorizontalRule;
use Finn::Parser::Grammar::ListItem;
use Finn::Parser::Grammar::SectionalBlock;
unit role Finn::Parser::Grammar::Paragraph;
also does Finn::Parser::Grammar::CodeBlock;
also does Finn::Parser::Grammar::CommentBlock;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::HorizontalRule;
also does Finn::Parser::Grammar::ListItem;
also does Finn::Parser::Grammar::SectionalBlock;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Paragraph

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Paragraph;
grammar Paragraph does Finn::Parser::Grammar::Paragraph {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Paragraph is a role containing grammar token
C<<paragraph>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# paragraph {{{

# --- word {{{

token word
{
    \S+
}

# --- end word }}}

token paragraph-line
{
    ^^

    <!before
        | <comment-block>
        | <code-block>
        | <sectional-block>
        | <horizontal-rule>
        | <list-item>
    >

    \h* <word> [ \h+ <word> ]*

    $$
}

token paragraph
{
    <paragraph-line> [ <.gap> <paragraph-line> ]*
}

# end paragraph }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
