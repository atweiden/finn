use v6;
unit role Finn::Parser::Grammar::URL;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::URL

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::URL;
grammar URL does Finn::Parser::Grammar::URL {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::URL is a role containing grammar token C<<url>>. It
is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# url {{{

token url-scheme
{
    http[s]?
}

token url
{
    <url-scheme> '://' \S+
}

# end url }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
