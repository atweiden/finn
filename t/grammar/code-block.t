use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 3;

subtest
{
    my Str:D $code-block = q:to/EOF/.trim;
    ```
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    ```
    EOF

    ok
        Finn::Parser::Grammar.parse($code-block, :rule<code-block>),
        'Parses code-block';
}

subtest
{
    my Str:D $code-block = q:to/EOF/.trim;
    ```sh
    $ cat TODO.md
    ```
    EOF

    ok
        Finn::Parser::Grammar.parse($code-block, :rule<code-block>),
        'Parses code-block';
}

subtest
{
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

    ok
        Finn::Parser::Grammar.parse($code-block, :rule<code-block>),
        'Parses code-block';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
