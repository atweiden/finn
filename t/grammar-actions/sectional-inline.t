use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 35;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "A"';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'A';
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name'].new(:$mode, :$name),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Abc"';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Abc';
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name'].new(:$mode, :$name),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Abc Foo Bar"';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Abc Foo Bar';
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name'].new(:$mode, :$name),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ /';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('/');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ ~';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('~');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ /finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('/finn/share/vimfmt');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ ~/finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('~/finn/share/vimfmt');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ file:///';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('/');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ file://~';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('~');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ file:///finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('/finn/share/vimfmt');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ file://~/finn/share/vimfmt';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('~/finn/share/vimfmt');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ [0]';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my UInt:D $number = 0;
    my ReferenceInline $reference-inline .= new(:$number);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Reference'].new(:$mode, :$reference-inline),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ [1]';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my UInt:D $number = 1;
    my ReferenceInline $reference-inline .= new(:$number);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Reference'].new(:$mode, :$reference-inline),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ [1010101010101]';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my UInt:D $number = 1010101010101;
    my ReferenceInline $reference-inline .= new(:$number);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Reference'].new(:$mode, :$reference-inline),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' /";
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' ~";
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' /a/b/c/d";
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/a/b/c/d');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' ~/a/b/c/d";
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~/a/b/c/d');
    my File['Absolute'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = "§ 'Name Of Section To Embed' file:///";
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" file://~';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" file:///a/b/c/d';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/a/b/c/d');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" file://~/a/b/c/d';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~/a/b/c/d');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" [0]';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my UInt:D $number = 0;
    my ReferenceInline $reference-inline .= new(:$number);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'Reference'].new(:$mode, :$name, :$reference-inline),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" [1]';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my UInt:D $number = 1;
    my ReferenceInline $reference-inline .= new(:$number);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'Reference'].new(:$mode, :$name, :$reference-inline),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" [1010101010101]';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my UInt:D $number = 1010101010101;
    my ReferenceInline $reference-inline .= new(:$number);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'Reference'].new(:$mode, :$name, :$reference-inline),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" relative-path';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('./relative-path');
    my File['Relative'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "Name Of Section To Embed" relative/path';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('./relative/path');
    my File['Relative'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ relative-path';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('./relative-path');
    my File['Relative'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ relative/path';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('./relative/path');
    my File['Relative'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    # XXX: backslash in file path doesn't work
    my Str:D $sectional-inline = '§ a/b\/c\ d';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('./a/b/c d');
    my File['Relative'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    # XXX: backslash in file path doesn't work
    my Str:D $sectional-inline = Q{§ "z\\" a/b\/c\ d};
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'z\\';
    my IO::Path $path .= new('./a/b/c d');
    my File['Relative'] $file .= new(:$path);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ file://a';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('./a');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ file://a/b\/c\ d';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my IO::Path $path .= new('./a/b/c d');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['File'].new(:$mode, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '§ "a" file://a';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = FINN;
    my Str:D $name = 'a';
    my IO::Path $path .= new('./a');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-inline = '¶ "a" file://a';
    my Str:D $rule = 'sectional-inline';
    my Mode:D $mode = TEXT;
    my Str:D $name = 'a';
    my IO::Path $path .= new('./a');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    cmp-ok
        Finn::Parser::Grammar.parse($sectional-inline, :$rule, :$actions).made,
        &cmp-ok-sectional-inline,
        SectionalInline['Name', 'File'].new(:$mode, :$name, :$file),
        'SectionalInline OK';
}

sub cmp-ok-sectional-inline(
    SectionalInline:D $a,
    SectionalInline:D $b
) returns Bool:D
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
