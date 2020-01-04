use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(13);

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` A
    - A is for Anacortes.
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    -- A
    - A is for Anacortes.
    --
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ------------------- A
    - A is for Anacortes.
    ---------------------
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A*
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A* +=
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A* :=
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` A* :=
    - A is for Anacortes.
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` Cities in Washington
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    - D is for Davenport.
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md +=
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md* +=
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /doc/TODO.md
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

subtest({
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` misc
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    § 'misc'
    ```
    EOF
    my Str:D $rule = 'sectional-block';
    ok(
        Finn::Parser::Grammar.parse($sectional-block, :$rule),
        'Parses sectional-block'
    );
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
