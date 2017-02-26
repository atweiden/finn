use v6;
unit role Finn::Tangler;

# p6doc {{{

=begin pod
=head NAME

Finn::Tangler

=head SYNOPSIS

=begin code
use Finn::Parser;
my Str:D %tangle{Str:D} = Finn::Parser.parsefile('hello.finn').made.tangle;
=end code

=head DESCRIPTION

C<Finn::Tangler> is a role implemented by C<Finn::Parser::ParseTree> for
converting a properly instantiated C<Finn::Parser::ParseTree> to a C<Hash>
of source code file strings indexed by associated target file path.
=end pod

# end p6doc }}}

# method tangle {{{

method tangle(?::CLASS:D:) returns Hash[List:D,Str:D]
{
    # get C<List> of all Sectional Blocks from C<Finn::Parser::ParseTree>
    # --- {{{

    # --- }}}

    # grep C<List> of all Sectional Blocks for those with file path
    # as Sectional Block Name
    # --- {{{

    # --- }}}

    # foreach Sectional Block returned, return instantiated class with
    # C<List> of C<SectionalBlockLine>s instantiated from Sectional
    # Block Content, and the beginning and ending of the Sectional Block
    # in origin file:line:column terms
    #
    # if an Include is encountered in the Sectional Block Content,
    # the C<SectionalBlockLine> is a special class with C<List> of
    # C<SectionalBlockLine>s instantiated from the linked Sectional Block
    # Content, and the beginning and ending of the linked Sectional
    # Block in origin file:line:column terms
    # --- {{{

    # --- }}}

    # foreach class returned, resolve all Sectional Block Content from
    # class C<SectionalBlockLine>s and return C<Hash> of C<2D Array>
    # of Sectional Block Content string line and origin file:line:column
    # of that string line, indexed by destination file path
    #
    # in 2D array, C<[0][0]> would be Sectional Block Content line
    # number 0 and C<[0][1]> would be origin file:line:column for
    # line number 0; C<[1][0]> would be Sectional Block Content
    # line number 1 and C<[1][1]> would be origin file:line:column
    # for line number 1
    # --- {{{
    my List:D %h{Str:D};
    # --- }}}
}

# end method tangle }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
