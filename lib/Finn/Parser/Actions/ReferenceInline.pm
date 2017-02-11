use v6;
use Finn::Parser::ParseTree;
unit role Finn::Parser::Actions::ReferenceInline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::ReferenceInline

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::ReferenceInline;
unit class Finn::Parser::Actions does Finn::Parser::Actions::ReferenceInline;
=end code

=head DESCRIPTION

Finn::Parser::Actions::ReferenceInline contains rules for constructing
a ReferenceInline. It is meant to be mixed into other actions classes.
=end pod

# end p6doc }}}

# reference-inline {{{

method reference-inline-number($/)
{
    make +$/;
}

method reference-inline($/)
{
    my UInt:D $number = $<reference-inline-number>.made;
    make ReferenceInline.new(:$number);
}

# end reference-inline }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
