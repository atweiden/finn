use v6;
use Finn::Parser::Actions;
use Finn::Parser::ParseTree;
unit class Finn::Parser::Actions::SectionalBlockContent;
also is Finn::Parser::Actions;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::SectionalBlockContent

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::SectionalBlockContent;
use Finn::Parser::Grammar::SectionalBlockContent;
use Finn::Parser::ParseTree;

my Finn::Parser::Actions::SectionalBlockContent $actions .= new;
my SectionalBlockContent:D @content =
    Finn::Parser::Grammar::SectionalBlockContent.parse('text', :$actions).made;
=end code

=head DESCRIPTION

Constructs a parse tree from Sectional Block Content.
=end pod

# end p6doc }}}

# TOP {{{

multi method TOP($/ where $<content>.so)
{
    make $<content>.made;
}

multi method TOP($/)
{
    make Nil;
}

# end TOP }}}
# content {{{

method content($/)
{
    make @<line>».made;
}

# end content }}}
# line {{{

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

# end line }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
