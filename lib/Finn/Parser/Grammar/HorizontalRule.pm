use v6;
unit role Finn::Parser::Grammar::HorizontalRule;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::HorizontalRule

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::HorizontalRule;
grammar HorizontalRule does Finn::Parser::Grammar::HorizontalRule {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::HorizontalRule is a role containing the grammar
token C<<horizontal-rule>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# horizontal-rule {{{

token horizontal-rule-soft-symbol
{
    '~'
}

token horizontal-rule-hard-symbol
{
    '*'
}

token horizontal-rule-soft
{
    ^^ <horizontal-rule-soft-symbol> ** 2 <horizontal-rule-soft-symbol>* $$
}

token horizontal-rule-hard
{
    ^^ <horizontal-rule-hard-symbol> ** 2 <horizontal-rule-hard-symbol>* $$
}

proto token horizontal-rule {*}
token horizontal-rule:soft  { <horizontal-rule-soft> }
token horizontal-rule:hard  { <horizontal-rule-hard> }

# end horizontal-rule }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
