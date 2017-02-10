use v6;
use Finn::Parser::Grammar;
unit grammar Finn::Parser::Grammar::Document;
also is Finn::Parser::Grammar;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::Document

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::Document;
my Match:D $match = Finn::Parser::Grammar::Document.parse('text');
=end code

=head DESCRIPTION

Finn::Parser::Grammar::Document parses Finn Documents.
=end pod

# end p6doc }}}

=begin pod
=head Document
=end pod

# document {{{

# --- chunk {{{

proto token chunk                  {*}
token chunk:sectional-inline-block { <sectional-inline-block> }
token chunk:sectional-block        { <sectional-block> }
token chunk:code-block             { <code-block> }
token chunk:reference-block        { <reference-block> }
token chunk:header-block           { <header-block> }
token chunk:list-block             { <list-block> }
token chunk:paragraph              { <paragraph> }
token chunk:horizontal-rule        { <horizontal-rule> }
token chunk:comment-block          { <comment-block> }
token chunk:blank-line             { <blank-line> }

# --- end chunk }}}

token document
{
    <chunk> [ \n <chunk> ]*
}

# end document }}}
# TOP {{{

token TOP
{
    <document>? \n?
}

# end TOP }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
