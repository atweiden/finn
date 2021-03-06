use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(3);

subtest({
    my Str:D $list-block = q:to/EOF/.trim-trailing;
    - abcdefghijklmnopqrstuvwxyz /* inner comment */
      ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 /* eol comment */
      - /* inner comment */ abcdefghijklmnopqrstuvwxyz /* eol comment */
        ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 /* eol comment */
        - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
          - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
            - abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890
    EOF
    my Str:D $rule = 'list-block';
    ok(Finn::Parser::Grammar.parse($list-block, :$rule), 'Parses list-block');
});

subtest({
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
    my Str:D $rule = 'list-block';
    ok(Finn::Parser::Grammar.parse($list-block, :$rule), 'Parses list-block');
});

subtest({
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
    my Str:D $rule = 'list-block';
    ok(Finn::Parser::Grammar.parse($list-block, :$rule), 'Parses list-block');
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
