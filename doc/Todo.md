Todo
====

Finn
----

### fix `$/.orig` in Actions

- `$/.orig` grabs too much of the Match text

### fix code-block and sectional-block grammar

- delimiters must come at start of line (`^^`)

### test Syntax.md examples

- extract examples and test

### document the horizontal-rule-soft relationship with chapters

- document the `~` horizontal-rule-soft relationship with chapters

### parse sectional-blocks for sectional-inlines

- parse sectional-blocks for sectional-inlines
  - `Str.lines` method might be faster than re-parsing with grammar

### deeply parse other text?

- grammar `token <text>` could parse itself for:
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

### idea of cutaway blocks

Add, test and document Cutaway Blocks:
1. cutaway-block-reference
  - double `*` horizontal-rule-hard with reference citations in between
    - as a parallel, specify reference-block needs to come at end of document


Finn::Parser::ParseTree
-----------------------

### Validate that file paths to be written do not exist before writing

- otherwise `finn/shared` could be overwritten during tangle

### Validate is-additive and is-redefine mutual exclusivity in `submethod TWEAK`

- Sectional Blocks cannot be both `is-additive` and `is-redefine` since
  only one operator is allowed per Sectional Block

### Validate that BySectionalBlockName Sectional Inlines appear only within Sectional Blocks in `submethod TWEAK`

- Intra-file Sectional Inlines come in only one flavor: *By Sectional
  Block Name*. This type of Sectional Inline can only appear within a
  Sectional Block.
  - “If all you need to do is checking things after the actual
     construction, or modify attributes after the object construction,
     writing a submethod TWEAK is a good approach (available in v6.d /
     Rakudo 2016.11)”

### Validate file paths in `submethod TWEAK`

- sectional-inline file-path can't resolve to `~`, `/`, or any other
  directory path
