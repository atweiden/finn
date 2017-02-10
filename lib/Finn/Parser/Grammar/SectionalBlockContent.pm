use v6;
use Finn::Parser::Grammar;
unit grammar Finn::Parser::Grammar::SectionalBlockContent;
also is Finn::Parser::Grammar;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalBlockContent

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::SectionalBlockContent;
use Finn::Parser::Grammar::SectionalBlockContent;
use Finn::Parser::ParseTree;

my Finn::Parser::Actions::SectionalBlockContent $actions .= new;
my SectionalBlockContent:D @content =
    Finn::Parser::Grammar::SectionalBlockContent.parse('content', :$actions);
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalBlockContent is a grammar for parsing
Sectional Block Content. Parsing Sectional Block Content is necessary
for handling embedded Sectional Inlines.
=end pod

# end p6doc }}}

# TOP {{{

token TOP
{
    <content>? \n?
}

# end TOP }}}
# content {{{

token content
{
    <line> [ \n <line> ]*
}

# end content }}}
# line {{{

proto token line            {*}
token line:sectional-inline { <sectional-inline> }
token line:text             { ^^ <!before <sectional-inline>> \N* $$ }

# end line }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
