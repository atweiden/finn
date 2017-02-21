Todo
====

Finn::Parser::Grammar
---------------------

### store leading whitespace in `SectionalInline` attribute

- necessary for Finn document processing to yield correct amount
  of leading indentation

### improve sectional-link parsing

- detect String and File

### improve multiline text handling

- extraneous whitespace should be dropped similar to TOML basic multiline
  strings with `line ending with \` in text (`ws-remover` grammar token)

### improve `<.gap>` parsing

- header-text, paragraph-text, list-item-text contain comments but the
  comments should be dropped
  - this is due to grammar making excessive use of `\N*` with no
    ratcheting
    - fix by parsing one word at a time similar to SectionalBlockName

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
  Block Name*. This type of Sectional Inline can only appear within
  a Sectional Block.


Test
----

### test Syntax.md examples

- extract examples and test


Syntax Documentation
--------------------

### document the horizontal-rule-soft relationship with chapters

- document the `~` horizontal-rule-soft relationship with chapters


Other
-----

### warn about faulty `\\` handling in IO::Path

- file names that purposefully contain backslashes don't work
