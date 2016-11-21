use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

# log-level-ignore {{{

subtest
{
    my Str:D @log-level-ignore = qw<
        DEBUG
        TRACE
    >;

    @log-level-ignore.map({
        ok
            Finn::Parser::Grammar.parse($_, :rule<log-level-ignore>),
            'Parses log-level-ignore'
    });
}

# end log-level-ignore }}}
# log-level-info {{{

subtest
{
    my Str:D @log-level-info = qw<
        INFO
    >;

    @log-level-info.map({
        ok
            Finn::Parser::Grammar.parse($_, :rule<log-level-info>),
            'Parses log-level-info'
    });
}

# end log-level-info }}}
# log-level-warn {{{

subtest
{
    my Str:D @log-level-warn = qw<
        WARN
    >;

    @log-level-warn.map({
        ok
            Finn::Parser::Grammar.parse($_, :rule<log-level-warn>),
            'Parses log-level-warn'
    });
}

# end log-level-warn }}}
# log-level-error {{{

subtest
{
    my Str:D @log-level-error = qw<
        ERROR
        FATAL
    >;

    @log-level-error.map({
        ok
            Finn::Parser::Grammar.parse($_, :rule<log-level-error>),
            'Parses log-level-error';
    })
}

# end log-level-error }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
