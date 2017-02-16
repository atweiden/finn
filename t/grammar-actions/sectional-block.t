use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 12;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` A
    - A is for Anacortes.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    -- A
    - A is for Anacortes.
    --
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ------------------- A
    - A is for Anacortes.
    ---------------------
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A*
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A* +=
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Additive'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A* :=
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Redefine'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` A* :=
    - A is for Anacortes.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Redefine'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` Cities in Washington
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    - D is for Davenport.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'Cities in Washington';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    my Str:D $text-b = '- B is for Bellingham.';
    my SectionalBlockContent['Text'] $content-b .= new(:text($text-b));

    my Str:D $text-c = '- C is for Centralia.';
    my SectionalBlockContent['Text'] $content-c .= new(:text($text-c));

    my Str:D $text-d = '- D is for Davenport.';
    my SectionalBlockContent['Text'] $content-d .= new(:text($text-d));

    # --- end content }}}

    my SectionalBlockContent:D @content =
        $content-a,
        $content-b,
        $content-c,
        $content-d;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/README.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'About this library';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md +=
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/README.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName::Operator['Additive'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'About this library';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md* +=
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/README.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Additive'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'About this library';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /doc/TODO.md
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/doc/TODO.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'Todos';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    my Str:D $text-b = '=====';
    my SectionalBlockContent['Text'] $content-b .= new(:text($text-b));

    my Str:D $text-c = '';
    my SectionalBlockContent['Text'] $content-c .= new(:text($text-c));

    my Str:D $text-d = '[x] Building…';
    my SectionalBlockContent['Text'] $content-d .= new(:text($text-d));

    my Str:D $text-e = '[!] Construction complete.';
    my SectionalBlockContent['Text'] $content-e .= new(:text($text-e));

    # --- end content }}}

    my SectionalBlockContent:D @content =
        $content-a,
        $content-b,
        $content-c,
        $content-d,
        $content-e;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
