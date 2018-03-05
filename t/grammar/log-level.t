use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(4);

# log-level-ignore {{{

subtest({
    my Str:D @log-level-ignore = qw<
        DEBUG
        TRACE
    >;
    my Str:D $rule = 'log-level-ignore';
    @log-level-ignore.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses log-level-ignore')
    });
});

# end log-level-ignore }}}
# log-level-info {{{

subtest({
    my Str:D @log-level-info = qw<
        INFO
    >;
    my Str:D $rule = 'log-level-info';
    @log-level-info.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses log-level-info')
    });
});

# end log-level-info }}}
# log-level-warn {{{

subtest({
    my Str:D @log-level-warn = qw<
        WARN
    >;
    my Str:D $rule = 'log-level-warn';
    @log-level-warn.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses log-level-warn')
    });
});

# end log-level-warn }}}
# log-level-error {{{

subtest({
    my Str:D @log-level-error = qw<
        ERROR
        FATAL
    >;
    my Str:D $rule = 'log-level-error';
    @log-level-error.map({
        ok(Finn::Parser::Grammar.parse($_, :$rule), 'Parses log-level-error')
    });
});

# end log-level-error }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
