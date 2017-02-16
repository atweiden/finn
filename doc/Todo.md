Todo
====

Finn::Parser::Grammar
---------------------

### improve `SectionalBlockContent['Text']` handling

- construct `SectionalBlockContent['Text']` from contiguous lines of text
  (non SectionalInlines), as opposed to constructing it one line of text
  at a time

### deeply parse other text

- grammar `token <text>` could parse itself for:
  - comment
  - bold
  - italic
  - underline
  - strikethrough
  - boolean
  - datetime
  - callout
  - log-level
  - url
  - file
  - reference-inline
  - code-inline
  - sectional-link


Finn::Parser::ParseTree
-----------------------

### Validate file paths are not to directory in `submethod TWEAK`

- sectional-inline file-path can't resolve to `~`, `/`, or any other
  directory path
  - “If all you need to do is checking things after the actual
     construction, or modify attributes after the object construction,
     writing a submethod TWEAK is a good approach (available in v6.d /
     Rakudo 2016.11)”

### Validate that BySectionalBlockName Sectional Inlines appear only within Sectional Blocks in `submethod TWEAK`

- Intra-file Sectional Inlines come in only one flavor: *By Sectional
  Block Name*. This type of Sectional Inline can only appear within a
  Sectional Block.


Test
----

### test Syntax.md examples

- extract examples and test


Syntax Documentation
--------------------

### document the horizontal-rule-soft relationship with chapters

- document the `~` horizontal-rule-soft relationship with chapters

### explore idea of cutaway blocks

- cutaway-block-reference
  - double `*` horizontal-rule-hard with reference citations in between
    - as a parallel, specify reference-block needs to come at end
      of document
