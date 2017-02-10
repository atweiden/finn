use v6;
use Finn::Parser::Grammar::CodeBlock;
use Finn::Parser::Grammar::CommentBlock;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::HorizontalRule;
use Finn::Parser::Grammar::SectionalBlock;
unit role Finn::Parser::Grammar::ListItem;
also does Finn::Parser::Grammar::CodeBlock;
also does Finn::Parser::Grammar::CommentBlock;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::HorizontalRule;
also does Finn::Parser::Grammar::SectionalBlock;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::ListItem

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::ListItem;
grammar ListItem does Finn::Parser::Grammar::ListItem {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::ListItem is a role containing grammar token
C<<list-item>>. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# list-item {{{

# --- list-todo-item {{{

# --- --- checkbox {{{

proto token checkbox-checked-char  {*}
token checkbox-checked-char:sym<x> { <sym> }
token checkbox-checked-char:sym<o> { <sym> }
token checkbox-checked-char:sym<v> { <sym> }

token checkbox-checked
{
    '[' <checkbox-checked-char> ']'
}

proto token checkbox-etc-char  {*}
token checkbox-etc-char:sym<+> { <sym> }
token checkbox-etc-char:sym<=> { <sym> }
token checkbox-etc-char:sym<-> { <sym> }

token checkbox-etc
{
    '[' <checkbox-etc-char> ']'
}

proto token checkbox-exception-char  {*}
token checkbox-exception-char:sym<*> { <sym> }
token checkbox-exception-char:sym<!> { <sym> }

token checkbox-exception
{
    '[' <checkbox-exception-char> ']'
}

token checkbox-unchecked
{
    '[ ]'
}

proto token checkbox     {*}
token checkbox:checked   { <checkbox-checked> }
token checkbox:etc       { <checkbox-etc> }
token checkbox:exception { <checkbox-exception> }
token checkbox:unchecked { <checkbox-unchecked> }

# --- --- end checkbox }}}

token list-todo-item-text
{
    \N+
}

token list-todo-item
{
    ^^ \h* <checkbox> \h <list-todo-item-text> $$
}

# --- end list-todo-item }}}
# --- list-unordered-item {{{

# --- --- bullet-point {{{

proto token bullet-point   {*}
token bullet-point:sym<->  { <sym> }
token bullet-point:sym<@>  { <sym> }
token bullet-point:sym<#>  { <sym> }
token bullet-point:sym<$>  { <sym> }
token bullet-point:sym<*>  { <sym> }
token bullet-point:sym<:>  { <sym> }
token bullet-point:sym<x>  { <sym> }
token bullet-point:sym<o>  { <sym> }
token bullet-point:sym<+>  { <sym> }
token bullet-point:sym<=>  { <sym> }
token bullet-point:sym<!>  { <sym> }
token bullet-point:sym<~>  { <sym> }
token bullet-point:sym«>»  { <sym> }
token bullet-point:sym«<-» { <sym> }
token bullet-point:sym«<=» { <sym> }
token bullet-point:sym«->» { <sym> }
token bullet-point:sym«=>» { <sym> }

# --- --- end bullet-point }}}

token list-unordered-item-text-first-line
{
    \N+
}

token list-unordered-item-text-continuation
{
    <!before
        | <comment-block>
        | <code-block>
        | <sectional-block>
        | <horizontal-rule>
        | <list-item>
    >
    \N+
}

token list-unordered-item-text
{
    <list-unordered-item-text-first-line>

    # optional additional lines of continued text
    [ $$ <.gap> ^^ <list-unordered-item-text-continuation> ]*
}

token list-unordered-item
{
    ^^ \h* <bullet-point> [ \h <list-unordered-item-text> ]? $$
}

# --- end list-unordered-item }}}
# --- list-ordered-item {{{

# --- --- list-ordered-item-number {{{

token list-ordered-item-number-value
{
    \d+
}

proto token list-ordered-item-number-terminator  {*}
token list-ordered-item-number-terminator:sym<.> { <sym> }
token list-ordered-item-number-terminator:sym<:> { <sym> }
token list-ordered-item-number-terminator:sym<)> { <sym> }

token list-ordered-item-number
{
    <list-ordered-item-number-value>
    <list-ordered-item-number-terminator>
}

# --- --- end list-ordered-item-number }}}

token list-ordered-item-text-first-line
{
    \N+
}

token list-ordered-item-text-continuation
{
    <!before
        | <comment-block>
        | <code-block>
        | <sectional-block>
        | <horizontal-rule>
        | <list-item>
    >
    \N+
}

token list-ordered-item-text
{
    <list-ordered-item-text-first-line>

    # optional additional lines of continued text
    [ $$ <.gap> ^^ <list-ordered-item-text-continuation> ]*
}

token list-ordered-item
{
    ^^ \h* <list-ordered-item-number> [ \h <list-ordered-item-text> ]? $$
}

# --- end list-ordered-item }}}

proto token list-item     {*}
token list-item:unordered { <list-unordered-item> }
token list-item:todo      { <list-todo-item> }
token list-item:ordered   { <list-ordered-item> }

# end list-item }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
