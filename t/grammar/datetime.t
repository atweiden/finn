use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 5;

# weekday {{{

subtest
{
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

    @weekday.map({
        ok Finn::Parser::Grammar.parse($_, :rule<weekday>), 'Parses weekday'
    });
}

# end weekday }}}
# weekend {{{

subtest
{
    my Str:D @weekend = qw<
        SAT
        SUN
        Sat
        Sun
    >;

    @weekend.map({
        ok Finn::Parser::Grammar.parse($_, :rule<weekend>), 'Parses weekend'
    });
}

# end weekend }}}
# month {{{

subtest
{
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

    @month.map({
        ok Finn::Parser::Grammar.parse($_, :rule<month>), 'Parses month'
    });
}

# end month }}}
# full-date {{{

subtest
{
    my Str:D @full-date = qw<
        2014-01-01
        2014/01/01
        0000-12-31
        1340-09-05
    >;

    @full-date.map({
        ok Finn::Parser::Grammar.parse($_, :rule<full-date>), 'Parses full-date';
    })
}

# end full-date }}}
# partial-time {{{

subtest
{
    my Str:D @partial-time = qw<
        01:59:15
        12:00:00
        23:15:59
    >;

    @partial-time.map({
        ok Finn::Parser::Grammar.parse($_, :rule<partial-time>), 'Parses partial-time'
    });
}

# end partial-time }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
