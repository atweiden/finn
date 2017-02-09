use v6;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
unit class Finn::Parser::Grammar::SectionalBlockContent;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::SectionalBlockContent

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::SectionalBlockContent;
use Finn::Parser::ParseTree;
my SectionalBlockContent:D @content =
    Finn::Parser::Grammar::SectionalBlockContent.parse('content');
=end code

=head DESCRIPTION

Finn::Parser::Grammar::SectionalBlockContent contains a private grammar
for parsing Sectional Block Content. Parsing Sectional Block Content is
necessary for detection of embedded Sectional Inlines.

The class method C<parse> instantiates a C<SectionalBlockContentActions>
class and parses Sectional Block Content with the included private
grammar, returning C<Array[SectionalBlockContent:D]>.
=end pod

# end p6doc }}}

# my grammar SectionalBlockContentGrammar {{{

my grammar SectionalBlockContentGrammar is Finn::Parser::Grammar
{
    token TOP { <content>? \n? }

    token content { <line> [ \n <line> ]* }

    proto token line            {*}
    token line:sectional-inline { <sectional-inline> }
    token line:text             { ^^ <!before <sectional-inline>> \N* $$ }
}

# end my grammar SectionalBlockContentGrammar }}}
# my class SectionalBlockContentActions {{{

my class SectionalBlockContentActions
{
    multi method TOP($/ where $<content>.so)
    {
        make $<content>.made;
    }

    multi method TOP($/)
    {
        make Nil;
    }

    method content($/)
    {
        make @<line>».made;
    }

    method line:sectional-inline ($/)
    {
        my SectionalInline:D $sectional-inline = $<sectional-inline>.made;
        make SectionalBlockContent['SectionalInline'].new(:$sectional-inline);
    }

    method line:text ($/)
    {
        my Str:D $text = ~$/;
        make SectionalBlockContent['Text'].new(:$text);
    }
}

# end my class SectionalBlockContentActions }}}

# method parse {{{

method parse(Str:D $content) returns Array:D
{
    my SectionalBlockContentActions:D $actions =
        SectionalBlockContentActions.new;
    my SectionalBlockContent:D @content =
        SectionalBlockContentGrammar.parse($content, :$actions).made;
}

# end method parse }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
