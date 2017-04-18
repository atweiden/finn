use v6;
unit class Finn::Parser::Actions::Cache;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Actions::Cache

=head SYNOPSIS

=begin code
use Finn::Parser::Actions::Cache;
my Str:D $path-to-document = 'path/to/document';
%Finn::Parser::Actions::Cache::document{$path-to-document} = Document.new(...);
%Finn::Parser::Actions::Cache::file{$path-to-file} = File.new(...);
=end code

=head DESCRIPTION

Stores containers to avoid re-parsing. Useful when building a parse tree
from Finn source documents.
=end pod

# end p6doc }}}

=begin pod
=head Variables
=end pod

# public variables {{{

our %document;
our %file;

# end public variables }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
