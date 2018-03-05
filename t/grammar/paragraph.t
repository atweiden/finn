use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(2);

subtest({
    my Str:D $paragraph = q:to/EOF/.trim;
    Lorem ipsizzle dolor sit pot, fo shizzle mah nizzle fo rizzle, mah
    home g-dizzle adipiscing elizzle. Rizzle shizznit velizzle, owned
    volutpizzle, shit quizzle, pimpin' uhuh ... yih!, fizzle. Pellentesque
    eget tortizzle.
    EOF
    my Str:D $rule = 'paragraph';
    ok(Finn::Parser::Grammar.parse($paragraph, :$rule), 'Parses paragraph');
});

subtest({
    my Str:D $paragraph = q:to/EOF/.trim;
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. In accumsan
    et velit vel egestas. Cum sociis natoque penatibus et magnis dis
    parturient montes, nascetur ridiculus mus. Donec id fringilla libero,
    eu bibendum risus. Cras non blandit risus. Phasellus sed velit sed
    dolor tempus interdum. Donec tincidunt bibendum diam nec porta. Duis
    est ipsum, porttitor et odio eu, eleifend cursus neque. Ut id egestas
    orci, id aliquam risus.
    EOF
    my Str:D $rule = 'paragraph';
    ok(Finn::Parser::Grammar.parse($paragraph, :$rule), 'Parses paragraph');
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
