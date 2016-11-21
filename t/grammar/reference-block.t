use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 2;

subtest
{
    my Str:D $reference-block = q:to/EOF/.trim;
    ******************************************************************************

    [1]: https://google.com
    [2]: https://youtube.com
    [3]: https://facebook.com
    [4]: https://twitter.com
    EOF

    ok
        Finn::Parser::Grammar.parse($reference-block, :rule<reference-block>),
        'Parses reference block';
}

subtest
{
    my Str:D $reference-block = q:to/EOF/.trim;
    ******************************************************************************

    [0]: http://stackoverflow.com/questions/40633059/why-write-1-000-000-000-as-100010001000-in-c




    [10]: https://twitter.com/hashtag/KanyeWest?src=hash
    [200]: https://www.facebook.com/202123499894789/photos/363845463722591/



    [3000000000]: https://abc.xyz/?q=%s
    EOF

    ok
        Finn::Parser::Grammar.parse($reference-block, :rule<reference-block>),
        'Parses reference block';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
