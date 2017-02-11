use v6;
use Finn::Parser::ParseTree;
unit role Finn::Parser::Actions::File;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::File

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::File;
unit class Finn::Parser::Actions does Finn::Parser::Actions::File;
=end code

=head DESCRIPTION

Finn::Parser::Actions::File contains rules for constructing a File. It
is meant to be mixed into other actions classes.
=end pod

# end p6doc }}}

# file {{{

# --- file-path-char {{{

method file-path-char:common ($/)
{
    make ~$/;
}

method file-path-char:escape-sequence ($/)
{
    make $<file-path-escape>.made;
}

# --- end file-path-char }}}
# --- file-path-escape {{{

method file-path-escape:sym<whitespace>($/)
{
    make ~$/;
}

method file-path-escape:sym<b>($/)
{
    make "\b";
}

method file-path-escape:sym<t>($/)
{
    make "\t";
}

method file-path-escape:sym<n>($/)
{
    make "\n";
}

method file-path-escape:sym<f>($/)
{
    make "\f";
}

method file-path-escape:sym<r>($/)
{
    make "\r";
}

method file-path-escape:sym<single-quote>($/)
{
    make "'";
}

method file-path-escape:sym<double-quote>($/)
{
    make "\"";
}

method file-path-escape:sym<fwdslash>($/)
{
    make '/';
}

method file-path-escape:sym<backslash>($/)
{
    make '\\';
}

method file-path-escape:sym<*>($/)
{
    make ~$/;
}

method file-path-escape:sym<[>($/)
{
    make ~$/;
}

method file-path-escape:sym<]>($/)
{
    make ~$/;
}

method file-path-escape:sym<{>($/)
{
    make ~$/;
}

method file-path-escape:sym<}>($/)
{
    make ~$/;
}

method file-path-escape:sym<u>($/)
{
    make chr(:16(@<hex>.join));
}

method file-path-escape:sym<U>($/)
{
    make chr(:16(@<hex>.join));
}

# --- end file-path-escape }}}
# --- file-protocol {{{

method file-protocol($/)
{
    make ~$/;
}

# --- end file-protocol }}}
# --- file-absolute {{{

multi method file-path-absolute($/ where @<file-path-absolute>.so)
{
    make '/' ~ @<file-path-char>».made.join ~ @<file-path-absolute>».made.join;
}

multi method file-path-absolute($/)
{
    make '/' ~ @<file-path-char>».made.join;
}

multi method file-absolute($/)
{
    my Str:D $file-absolute = $<file-path-absolute>.made;
    make %(:$file-absolute);
}

# --- end file-absolute }}}
# --- file-absolute-protocol {{{

method file-absolute-protocol($/)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my Str:D $file-protocol = $<file-protocol>.made;
    make %(:$file-absolute, :$file-protocol);
}

# --- end file-absolute-protocol }}}
# --- file-relative {{{

multi method file-path-relative($/ where @<file-path-absolute>.so)
{
    make @<file-path-char>».made.join ~ @<file-path-absolute>».made.join;
}

multi method file-path-relative($/)
{
    make @<file-path-char>».made.join;
}

multi method file-relative($/)
{
    my Str:D $file-relative = $<file-path-relative>.made;
    make %(:$file-relative);
}

# --- end file-relative }}}
# --- file-relative-protocol {{{

method file-relative-protocol($/)
{
    my Str:D $file-relative = $<file-relative>.made<file-relative>;
    my Str:D $file-protocol = $<file-protocol>.made;
    make %(:$file-relative, :$file-protocol);
}

# --- end file-relative-protocol }}}

method file:absolute ($/)
{
    my Str:D $file-absolute = $<file-absolute>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    make File['Absolute'].new(:$path);
}

method file:absolute-protocol ($/)
{
    my Str:D $file-absolute = $<file-absolute-protocol>.made<file-absolute>;
    my IO::Path:D $path = IO::Path.new($file-absolute);
    my Str:D $protocol = $<file-absolute-protocol>.made<file-protocol>;
    make File['Absolute', 'Protocol'].new(:$path, :$protocol);
}

method file:relative ($/)
{
    my Str:D $file-relative = $<file-relative>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    make File['Relative'].new(:$path);
}

method file:relative-protocol ($/)
{
    my Str:D $file-relative = $<file-relative-protocol>.made<file-relative>;
    my IO::Path:D $path =
        IO::Path.new($.file.IO.dirname ~ '/' ~ $file-relative);
    my Str:D $protocol = $<file-relative-protocol>.made<file-protocol>;
    make File['Relative', 'Protocol'].new(:$path, :$protocol);
}

# end file }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
