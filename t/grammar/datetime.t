use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(5);

# weekday {{{

subtest({
    my Str:D @weekday = qw<
        MON
        TUE
        WED
        THU
        FRI
        Mon
        Tue
        Wed
        Thu
        Fri
    >;
    my Str:D $rule = 'weekday';
    @weekday.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses weekday')
    });
});

# end weekday }}}
# weekend {{{

subtest({
    my Str:D @weekend = qw<
        SAT
        SUN
        Sat
        Sun
    >;
    my Str:D $rule = 'weekend';
    @weekend.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses weekend')
    });
});

# end weekend }}}
# month {{{

subtest({
    my Str:D @month = qw<
        JAN
        FEB
        MAR
        APR
        MAY
        JUN
        JUL
        AUG
        SEP
        OCT
        NOV
        DEC
        Jan
        Feb
        Mar
        Apr
        May
        Jun
        Jul
        Aug
        Sep
        Oct
        Nov
        Dec
    >;
    my Str:D $rule = 'month';
    @month.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses month')
    });
});

# end month }}}
# full-date {{{

subtest({
    my Str:D @full-date = qw<
        2014-01-01
        2014/01/01
        0000-12-31
        1340-09-05
    >;
    my Str:D $rule = 'full-date';
    @full-date.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses full-date')
    });
});

# end full-date }}}
# partial-time {{{

subtest({
    my Str:D @partial-time = qw<
        01:59:15
        12:00:00
        23:15:59
    >;
    my Str:D $rule = 'partial-time';
    @partial-time.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses partial-time')
    });
});

# end partial-time }}}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
