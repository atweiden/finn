use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan(35);

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "A"';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'A';
    my IncludeLine::Request['Name'] $request .= new(:$name);
    my &resolve;
    my IncludeLine::Resolver['Name'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Abc"';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Abc';
    my IncludeLine::Request['Name'] $request .= new(:$name);
    my &resolve;
    my IncludeLine::Resolver['Name'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Abc Foo Bar"';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Abc Foo Bar';
    my IncludeLine::Request['Name'] $request .= new(:$name);
    my &resolve;
    my IncludeLine::Resolver['Name'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ /';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('/');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ ~';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('~');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ /finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('/finn/share/vimfmt');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ ~/finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('~/finn/share/vimfmt');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ file:///';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('/');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ file://~';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('~');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ file:///finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('/finn/share/vimfmt');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ file://~/finn/share/vimfmt';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('~/finn/share/vimfmt');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ [0]';
    my Str:D $rule = 'include-line';
    my UInt:D $number = 0;
    my ReferenceInline $reference-inline .= new(:$number);
    my IncludeLine::Request['Reference'] $request .= new(:$reference-inline);
    my &resolve;
    my IncludeLine::Resolver['Reference'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ [1]';
    my Str:D $rule = 'include-line';
    my UInt:D $number = 1;
    my ReferenceInline $reference-inline .= new(:$number);
    my IncludeLine::Request['Reference'] $request .= new(:$reference-inline);
    my &resolve;
    my IncludeLine::Resolver['Reference'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ [1010101010101]';
    my Str:D $rule = 'include-line';
    my UInt:D $number = 1010101010101;
    my ReferenceInline $reference-inline .= new(:$number);
    my IncludeLine::Request['Reference'] $request .= new(:$reference-inline);
    my &resolve;
    my IncludeLine::Resolver['Reference'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = "§ 'Name Of Section To Embed' /";
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = "§ 'Name Of Section To Embed' ~";
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = "§ 'Name Of Section To Embed' /a/b/c/d";
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/a/b/c/d');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = "§ 'Name Of Section To Embed' ~/a/b/c/d";
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~/a/b/c/d');
    my File['Absolute'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = "§ 'Name Of Section To Embed' file:///";
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" file://~';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" file:///a/b/c/d';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('/a/b/c/d');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" file://~/a/b/c/d';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('~/a/b/c/d');
    my Str:D $protocol = 'file://';
    my File['Absolute', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" [0]';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my UInt:D $number = 0;
    my ReferenceInline $reference-inline .= new(:$number);
    my IncludeLine::Request['Name', 'Reference'] $request .= new(
        :$name,
        :$reference-inline
    );
    my &resolve;
    my IncludeLine::Resolver['Name', 'Reference'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" [1]';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my UInt:D $number = 1;
    my ReferenceInline $reference-inline .= new(:$number);
    my IncludeLine::Request['Name', 'Reference'] $request .= new(
        :$name,
        :$reference-inline
    );
    my &resolve;
    my IncludeLine::Resolver['Name', 'Reference'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" [1010101010101]';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my UInt:D $number = 1010101010101;
    my ReferenceInline $reference-inline .= new(:$number);
    my IncludeLine::Request['Name', 'Reference'] $request .= new(
        :$name,
        :$reference-inline
    );
    my &resolve;
    my IncludeLine::Resolver['Name', 'Reference'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" relative-path';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('./relative-path');
    my File['Relative'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "Name Of Section To Embed" relative/path';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'Name Of Section To Embed';
    my IO::Path $path .= new('./relative/path');
    my File['Relative'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ relative-path';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('./relative-path');
    my File['Relative'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ relative/path';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('./relative/path');
    my File['Relative'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    # XXX: backslash in file path doesn't work
    my Str:D $include-line = '§ a/b\/c\ d';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('./a/b/c d');
    my File['Relative'] $file .= new(:$path);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    # XXX: backslash in file path doesn't work
    my Str:D $include-line = Q{§ "z\\" a/b\/c\ d};
    my Str:D $rule = 'include-line';
    my Str:D $name = 'z\\';
    my IO::Path $path .= new('./a/b/c d');
    my File['Relative'] $file .= new(:$path);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ file://a';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('./a');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ file://a/b\/c\ d';
    my Str:D $rule = 'include-line';
    my IO::Path $path .= new('./a/b/c d');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['File'] $request .= new(:$file);
    my &resolve;
    my IncludeLine::Resolver['File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '§ "a" file://a';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'a';
    my IO::Path $path .= new('./a');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Finn'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $include-line = '¶ "a" file://a';
    my Str:D $rule = 'include-line';
    my Str:D $name = 'a';
    my IO::Path $path .= new('./a');
    my Str:D $protocol = 'file://';
    my File['Relative', 'Protocol'] $file .= new(:$path, :$protocol);
    my IncludeLine::Request['Name', 'File'] $request .= new(:$name, :$file);
    my &resolve;
    my IncludeLine::Resolver['Name', 'File'] $resolver .= new(:&resolve);
    cmp-ok(
        Finn::Parser::Grammar.parse($include-line, :$rule, :$actions).made,
        &cmp-ok-include-line,
        IncludeLine['Text'].new(:$request, :$resolver),
        'IncludeLine OK'
    );
});

sub cmp-ok-include-line(
    IncludeLine:D $a,
    IncludeLine:D $b
    --> Bool:D
)
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
