Todo
====

Finn::Parser
------------

### store leading whitespace in `Include` attribute

- necessary for Finn document processing to yield correct amount of
  leading indentation

### check for circular include directives

**obstacles preventing assured stringification of SectionalBlockContent**

- circular include directives
  - `SectionalBlockContent['IncludeLine'] $a` requests another
    SectionalBlock whose `SectionalBlockContent['IncludeLine'] $b`
    requests the SectionalBlock containing `$a`
    - `IncludeLine $a` (`IncludeLine::Request['File']`) requests text
      that tries to include the Document containing `$a`
  - `SectionalBlockContent['IncludeLine'] $a` requests the SectionalBlock
    it is a part of

### improve multiline text handling

- extraneous whitespace should be dropped similar to TOML basic multiline
  strings with `line ending with \` in text (`ws-remover` grammar token)

### improve `<.gap>` parsing

- header-text, paragraph-text, list-item-text contain comments but the
  comments should be dropped
  - this is due to grammar making excessive use of `\N*` with no
    ratcheting
    - fix by parsing one word at a time similar to SectionalBlockName

### improve sectional-link parsing

- detect String and File

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
  of Includes are allowed:
  - those whose contents resolve to a `SectionalBlock` (which can be
    stringified):
    - `§ 'name'`
      - `IncludeLine['Finn']`
        - `IncludeLine::Request['Name']`
    - `§ 'name' path/to/file`
      - `IncludeLine['Finn']`
        - `IncludeLine::Request['Name', 'File']`
    - `§ 'name' [1]`
      - `IncludeLine['Finn']`
        - `IncludeLine::Request['Name', 'Reference']`
  - those whose contents directly resolve to a `Str`:
    - `¶ 'name'`
      - `IncludeLine['Text']`
        - `IncludeLine::Request['Name']`
    - `¶ path/to/file`
      - `IncludeLine['Text']`
        - `IncludeLine::Request['File']`
    - `¶ [1]`
      - `IncludeLine['Text']`
        - `IncludeLine::Request['Reference']`
    - `¶ 'name' path/to/file`
      - `IncludeLine['Text']`
        - `IncludeLine::Request['Name', 'File']`
    - `¶ 'name' [1]`
      - `IncludeLine['Text']`
        - `IncludeLine::Request['Name', 'Reference']`

- at Document top level, all types of Includes are allowed (see:
  IncludeLineBlock)

- at Document top level, when `§ path/to/document` is encountered
  in IncludeLineBlock, Finn instantiates from it a `Document`, and all
  `Chunk`s inside that `Document` will be marked children of the parent
  `Document` (see: TXN::Parser's handling of include directives with
  `[0, 0]` entry number)

```finn
§ process/in/finn/mode
¶ process/in/text/mode
```

- in **Finn mode**, parser processes text:
  - as Finn source document:
    - `IncludeLine::Request['File']`
    - `IncludeLine::Request['Reference']`
    - and returns `Document`
  - as Finn SectionalBlock:
    - `IncludeLine::Request['Name']`
    - `IncludeLine::Request['Name', 'File']`
    - `IncludeLine::Request['Name', 'Reference']`
    - and returns `Array[SectionalBlockContent]`
- in **Text mode**, parser does not process text:
  - and returns `Str`


Other
-----

### warn about faulty `\\` handling in IO::Path

- file names that purposefully contain backslashes don't work
