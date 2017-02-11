use v6;
use Finn::Parser::Actions::File;
use Finn::Parser::Actions::ReferenceInline;
use Finn::Parser::Actions::String;
use Finn::Parser::ParseTree;
unit role Finn::Parser::Actions::SectionalInline;
also does Finn::Parser::Actions::File;
also does Finn::Parser::Actions::ReferenceInline;
also does Finn::Parser::Actions::String;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::SectionalInline

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::SectionalInline;
unit class Finn::Parser::Actions does Finn::Parser::Actions::SectionalInline;
=end code

=head DESCRIPTION

Finn::Parser::Actions::SectionalInline contains rules for constructing
a SectionalInline. It is meant to be mixed into other actions classes.
=end pod

# end p6doc }}}

# sectional-inline {{{

method sectional-inline-text:name-and-file ($/)
{
    my Str:D $name = $<sectional-inline-name>.made;
    my File:D $file = $<sectional-inline-file>.made;
    make SectionalInline['Name', 'File'].new(:$name, :$file);
}

method sectional-inline-text:name-and-reference ($/)
{
    my Str:D $name = $<sectional-inline-name>.made;
    my ReferenceInline:D $reference-inline = $<sectional-inline-reference>.made;
    make SectionalInline['Name', 'Reference'].new(:$name, :$reference-inline);
}

method sectional-inline-text:file-only ($/)
{
    my File:D $file = $<sectional-inline-file>.made;
    make SectionalInline['File'].new(:$file);
}

method sectional-inline-text:reference-only ($/)
{
    my ReferenceInline:D $reference-inline = $<sectional-inline-reference>.made;
    make SectionalInline['Reference'].new(:$reference-inline);
}

method sectional-inline-text:name-only ($/)
{
    my Str:D $name = $<sectional-inline-name>.made;
    make SectionalInline['Name'].new(:$name);
}

method sectional-inline($/)
{
    make $<sectional-inline-text>.made;
}

# end sectional-inline }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
