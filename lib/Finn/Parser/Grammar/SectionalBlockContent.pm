use v6;
use Finn::Parser::Grammar::SectionalInline;
unit grammar Finn::Parser::Grammar::SectionalBlockContent;
also does Finn::Parser::Grammar::SectionalInline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalBlockContent

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::SectionalBlockContent;
my Match:D $match =
    Finn::Parser::Grammar::SectionalBlockContent.parse('content');
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalBlockContent contains a grammar for
parsing Sectional Block Content. Parsing Sectional Block Content is
necessary for detection of embedded Sectional Inlines.
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
