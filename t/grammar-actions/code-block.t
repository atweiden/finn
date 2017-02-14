use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 3;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $code-block = q:to/EOF/.trim;
    ```
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    ```
    EOF
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $text = q:to/EOF/.trim-leading;
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    EOF
    is-deeply
        Finn::Parser::Grammar.parse($code-block, :rule<code-block>, :$actions).made,
        CodeBlock.new(:$delimiter, :$text),
        'CodeBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $code-block = q:to/EOF/.trim;
    ```sh
    $ cat TODO.md
    ```
    EOF
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $language = 'sh';
    my Str:D $text = q:to/EOF/.trim-leading;
    $ cat TODO.md
    EOF
    is-deeply
        Finn::Parser::Grammar.parse($code-block, :rule<code-block>, :$actions).made,
        CodeBlock.new(:$delimiter, :$language, :$text),
        'CodeBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $code-block = q:to/EOF/.trim;
    ```markdown
    Language   | Ways to say meow
    --------   | ----------------
    Albanian   | mjaullin
    Basque     | Meow
    Belarusian | мяў
    Bosnian    | Mjau
    Bulgarian  | мяу
    Catalan    | meu
    Croatian   | mijau
    Czech      | mňau
    Danish     | miav
    Dutch      | miauw
    Estonian   | Mjäu
    Finnish    | Miau
    French     | Miaou
    Galician   | miar
    German     | Miau
    Greek      | Μιάου
    Hungarian  | miáú
    Icelandic  | mjá
    Irish      | meow
    Italian    | Miao
    Latvian    | Mjau
    Lithuanian | Miau
    Macedonian | meow
    Maltese    | mjaw
    Norwegian  | mjau
    Polish     | Miau
    Portuguese | Miau
    Romanian   | miau
    Russian    | мяу
    Serbian    | мјау
    Slovak     | mňau
    Slovenian  | mijav
    Spanish    | maullar
    Swedish    | mjau
    Ukrainian  | Мяу
    Welsh      | Meow
    ```
    EOF
    my CodeBlockDelimiter['Backticks'] $delimiter .= new;
    my Str:D $language = 'markdown';
    my Str:D $text = q:to/EOF/.trim-leading;
    Language   | Ways to say meow
    --------   | ----------------
    Albanian   | mjaullin
    Basque     | Meow
    Belarusian | мяў
    Bosnian    | Mjau
    Bulgarian  | мяу
    Catalan    | meu
    Croatian   | mijau
    Czech      | mňau
    Danish     | miav
    Dutch      | miauw
    Estonian   | Mjäu
    Finnish    | Miau
    French     | Miaou
    Galician   | miar
    German     | Miau
    Greek      | Μιάου
    Hungarian  | miáú
    Icelandic  | mjá
    Irish      | meow
    Italian    | Miao
    Latvian    | Mjau
    Lithuanian | Miau
    Macedonian | meow
    Maltese    | mjaw
    Norwegian  | mjau
    Polish     | Miau
    Portuguese | Miau
    Romanian   | miau
    Russian    | мяу
    Serbian    | мјау
    Slovak     | mňau
    Slovenian  | mijav
    Spanish    | maullar
    Swedish    | mjau
    Ukrainian  | Мяу
    Welsh      | Meow
    EOF
    is-deeply
        Finn::Parser::Grammar.parse($code-block, :rule<code-block>, :$actions).made,
        CodeBlock.new(:$delimiter, :$language, :$text),
        'CodeBlock OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
