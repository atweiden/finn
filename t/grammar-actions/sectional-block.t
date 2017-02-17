use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 13;

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

    my Str:D $text-a = q:to/EOF/.trim-trailing;
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    - D is for Davenport.
    EOF
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

    my Str:D $text-a = q:to/EOF/.trim-trailing;
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    EOF
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
    ``` misc
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    § 'misc'
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'misc';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = q:to/EOF/.trim-trailing;
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    EOF
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    my Str:D $name-b = 'misc';
    my SectionalInline['Name'] $sectional-inline-b .= new(:name($name-b));
    my SectionalBlockContent['SectionalInline'] $content-b .= new(
        :sectional-inline($sectional-inline-b)
    );

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a, $content-b;

    is-deeply
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
