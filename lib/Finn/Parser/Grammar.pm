use v6;

# use modules {{{

# --- block text {{{

use Finn::Parser::Grammar::BlankLine;
use Finn::Parser::Grammar::CodeBlock;
use Finn::Parser::Grammar::Comment;
use Finn::Parser::Grammar::CommentBlock;
use Finn::Parser::Grammar::Gap;
use Finn::Parser::Grammar::Header;
use Finn::Parser::Grammar::HeaderBlock;
use Finn::Parser::Grammar::HorizontalRule;
use Finn::Parser::Grammar::ListBlock;
use Finn::Parser::Grammar::ListItem;
use Finn::Parser::Grammar::Paragraph;
use Finn::Parser::Grammar::ReferenceBlock;
use Finn::Parser::Grammar::SectionalBlock;
use Finn::Parser::Grammar::SectionalInline;
use Finn::Parser::Grammar::SectionalInlineBlock;

# --- end block text }}}
# --- inline text {{{

use Finn::Parser::Grammar::Bold;
use Finn::Parser::Grammar::Boolean;
use Finn::Parser::Grammar::Callout;
use Finn::Parser::Grammar::CodeInline;
use Finn::Parser::Grammar::DateTime;
use Finn::Parser::Grammar::File;
use Finn::Parser::Grammar::Italic;
use Finn::Parser::Grammar::LogLevel;
use Finn::Parser::Grammar::ReferenceInline;
use Finn::Parser::Grammar::SectionalLink;
use Finn::Parser::Grammar::Strikethrough;
use Finn::Parser::Grammar::String;
use Finn::Parser::Grammar::URL;
use Finn::Parser::Grammar::Underline;

# --- end inline text }}}

# end use modules }}}

unit grammar Finn::Parser::Grammar;
also does Finn::Parser::Grammar::BlankLine;
also does Finn::Parser::Grammar::Bold;
also does Finn::Parser::Grammar::Boolean;
also does Finn::Parser::Grammar::Callout;
also does Finn::Parser::Grammar::CodeBlock;
also does Finn::Parser::Grammar::CodeInline;
also does Finn::Parser::Grammar::Comment;
also does Finn::Parser::Grammar::CommentBlock;
also does Finn::Parser::Grammar::DateTime;
also does Finn::Parser::Grammar::File;
also does Finn::Parser::Grammar::Gap;
also does Finn::Parser::Grammar::Header;
also does Finn::Parser::Grammar::HeaderBlock;
also does Finn::Parser::Grammar::HorizontalRule;
also does Finn::Parser::Grammar::Italic;
also does Finn::Parser::Grammar::ListBlock;
also does Finn::Parser::Grammar::ListItem;
also does Finn::Parser::Grammar::LogLevel;
also does Finn::Parser::Grammar::Paragraph;
also does Finn::Parser::Grammar::ReferenceBlock;
also does Finn::Parser::Grammar::ReferenceInline;
also does Finn::Parser::Grammar::SectionalBlock;
also does Finn::Parser::Grammar::SectionalInline;
also does Finn::Parser::Grammar::SectionalInlineBlock;
also does Finn::Parser::Grammar::SectionalLink;
also does Finn::Parser::Grammar::Strikethrough;
also does Finn::Parser::Grammar::String;
also does Finn::Parser::Grammar::URL;
also does Finn::Parser::Grammar::Underline;

# p6doc {{{

=begin pod
=head NAME

Finn::Parser::Grammar

=head SYNOPSIS

=begin code
use Finn::Parser::Grammar;
grammar Document is Finn::Parser::Grammar { token TOP { .* } }
my Match:D $match = Document.parse('text');
=end code

=head DESCRIPTION

Finn::Parser::Grammar is an abstract base grammar for the Finn file
format. It is meant to be extended by other grammar instances.

=head2 Inline Vs. Block Text

=head3 Inline Text

In general, I<inline text> types cannot be mixed and matched. If
something is bold it cannot be italic. If something is a date, it can't
be underlined.

=over
=item bold
=item italic
=item underline
=item strikethrough
=item boolean
=item date
=item time
=item callout
=item log-level
=item string
=item url
=item file
=item reference-inline
=item code-inline
=item sectional-link
=back

=head3 Block Text

In general, I<block text> may contain certain I<inline text> types.

=over
=item sectional-inline-block
=item sectional-block
=item code-block
=item reference-block
=item header-block
=item list-block
=item paragraph
=item horizontal-rule
=item comment-block
=item blank-line
=back
=end pod

# end p6doc }}}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
