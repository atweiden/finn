use v6;
unit role Finn::Parser::Actions::String;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::String

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::String;
unit class Finn::Parser::Actions does Finn::Parser::Actions::String;
=end code

=head DESCRIPTION

Finn::Parser::Actions::String contains rules for constructing a String. It
is meant to be mixed into other actions classes.
=end pod

# end p6doc }}}

# string {{{

# --- string-basic {{{

# --- --- string-basic-char {{{

method string-basic-char:common ($/)
{
    make ~$/;
}

method string-basic-char:tab ($/)
{
    make ~$/;
}

method string-basic-char:escape-sequence ($/)
{
    make $<escape>.made;
}

# --- --- end string-basic-char }}}
# --- --- escape {{{

method escape:sym<b>($/)
{
    make "\b";
}

method escape:sym<t>($/)
{
    make "\t";
}

method escape:sym<n>($/)
{
    make "\n";
}

method escape:sym<f>($/)
{
    make "\f";
}

method escape:sym<r>($/)
{
    make "\r";
}

method escape:sym<quote>($/)
{
    make "\"";
}

method escape:sym<backslash>($/)
{
    make '\\';
}

method escape:sym<u>($/)
{
    make chr(:16(@<hex>.join));
}

method escape:sym<U>($/)
{
    make chr(:16(@<hex>.join));
}

# --- --- end escape }}}

method string-basic-text($/)
{
    make @<string-basic-char>».made.join;
}

method string-basic($/)
{
    make $<string-basic-text>.made;
}

# --- end string-basic }}}
# --- string-literal {{{

# --- --- string-literal-char {{{

method string-literal-char:common ($/)
{
    make ~$/;
}

method string-literal-char:backslash ($/)
{
    make '\\';
}

# --- --- end string-literal-char }}}

method string-literal-text($/)
{
    make @<string-literal-char>».made.join;
}

method string-literal($/)
{
    make $<string-literal-text>.made;
}

# --- end string-literal }}}

method string:basic ($/)
{
    make $<string-basic>.made;
}

method string:literal ($/)
{
    make $<string-literal>.made;
}

# end string }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
