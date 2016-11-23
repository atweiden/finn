use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 7;

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;

    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    /*
     *
     * comment
     * comment
     * comment
     *
     */
    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    /* a comment block */
    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
      - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
            1234567890 abcdefghijklmnopqrstuvwxyz
            ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
              1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

subtest
{
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    1. abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
       - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
         [*] abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
           - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
             1234567890 abcdefghijklmnopqrstuvwxyz
    2. ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
       3. 1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ
     x asdfasdf
       o asdfasdf
         + abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
           1234567890
           <- abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
              1234567890
    EOF

    ok
        Finn::Parser::Grammar.parse($list-block, :rule<list-block>),
        'Parses list-block';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
