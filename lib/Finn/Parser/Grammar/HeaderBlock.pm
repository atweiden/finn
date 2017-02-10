use v6;
use Finn::Parser::Grammar::Header;
use Finn::Parser::Grammar::BlankLine;
use Finn::Parser::Grammar::CommentBlock;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::HorizontalRule;
unit role Finn::Parser::Grammar::HeaderBlock;
also does Finn::Parser::Grammar::Header;
also does Finn::Parser::Grammar::BlankLine;
also does Finn::Parser::Grammar::CommentBlock;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::HorizontalRule;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::HeaderBlock

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::HeaderBlock;
grammar HeaderBlock does Finn::Parser::Grammar::HeaderBlock {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::HeaderBlock is a role containing grammar token
C<<header-block>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# header-block {{{

# C<<header-block>> must be separated from text blocks above it
# with a C<<blank-line>>, C<<comment-block>> or C<<horizontal-rule>>,
# or the header must appear at the very top of the document
proto token header-block                 {*}
token header-block:top                   { ^ <header> }
token header-block:after-blank-line      { <blank-line>  <.gap> <header> }
token header-block:after-comment-block   { <comment-block> <.gap> <header> }
token header-block:after-horizontal-rule { <horizontal-rule> <.gap> <header> }

# end header-block }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
