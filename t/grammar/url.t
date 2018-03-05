use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(1);

subtest({
    my Str:D @url = qw<
        http://google.com
        https://google.com
        https://abc.xyz/?q=Query&#123
    >;
    my Str:D $rule = 'url';
    @url.map({ ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses url') });
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
