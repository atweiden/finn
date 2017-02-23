Todo
====

Finn::Parser
------------

### implement finn-mode and text-mode include directive processing

```finn
§ process/in/finn/mode
¶ process/in/text/mode
```

- in **Finn mode**, parser processes text:
  - as Finn source document:
    - `SectionInline['File']`
    - `SectionInline['Reference']`
    - and returns `Document`
  - as Finn SectionalBlock:
    - `SectionInline['Name']`
    - `SectionInline['Name', 'File']`
    - `SectionInline['Name', 'Reference']`
    - and returns `Array[SectionalBlockContent]`
- in **Text mode**, parser does not process text:
  - and returns `Str`

### check for circular include directives

- circular include directives
  - one obstacle preventing assured stringification
    of SectionalBlockContent is in a case where
    `SectionalBlockContent['SectionalInline'] $a` links to another
    SectionalBlock whose `SectionalBlockContent['SectionalInline'] $b`
    links back to the SectionalBlock containing `$a`.
  - another case is where a `¶` *Text-mode*  SectionalInline grabs text
    that tries to embed the document it is requested from

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

### improve include directive syntax documentation

- inside a Sectional Block (`SectionalBlockContent`), only these types
  of Sectional Inlines are allowed:
  - those whose contents resolve to a `SectionalBlock` (which can be
    stringified):
    - `§ 'name'`
      - `SectionalInline['Name']`
    - `§ 'name' path/to/file`
      - `SectionalInline['Name', 'File']`
    - `§ 'name' [1]`
      - `SectionalInline['Name', 'Reference']`
  - those whose contents directly resolve to a `Str`:
    - `¶ 'name'`
      - `SectionalInline['Name']`
    - `¶ path/to/file`
      - `SectionalInline['File']`
    - `¶ [1]`
      - `SectionalInline['Reference']`
    - `¶ 'name' path/to/file`
      - `SectionalInline['Name', 'File']`
    - `¶ 'name' [1]`
      - `SectionalInline['Name', 'Reference']`

- at Document top level, all types of Sectional Inlines are allowed
  (see: SectionalInlineBlock)

- at Document top level, when `§ path/to/document` is encountered in
  SectionalInlineBlock, Finn instantiates from it a `Document`, and all `Chunk`s
  inside that `Document` will be marked children of the parent `Document`
  (see: TXN::Parser's handling of include directives with `[0, 0]`
  entry number)


Other
-----

### warn about faulty `\\` handling in IO::Path

- file names that purposefully contain backslashes don't work
