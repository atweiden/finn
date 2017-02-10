use v6;
unit role Finn::Parser::Grammar::LogLevel;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar::LogLevel

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar::LogLevel;
grammar LogLevel does Finn::Parser::Grammar::LogLevel {...}
=end code

=head DESCRIPTION

Finn::Parser::Grammar::LogLevel is a role containing log-level topical
grammar tokens. It is meant to be mixed into other grammars.
=end pod

# end p6doc }}}

# log-level {{{

proto token log-level-ignore      {*}
token log-level-ignore:sym<DEBUG> { <sym> }
token log-level-ignore:sym<TRACE> { <sym> }

proto token log-level-info     {*}
token log-level-info:sym<INFO> { <sym> }

proto token log-level-warn     {*}
token log-level-warn:sym<WARN> { <sym> }

proto token log-level-error      {*}
token log-level-error:sym<ERROR> { <sym> }
token log-level-error:sym<FATAL> { <sym> }

# end log-level }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
