# Finn

Literate programming made easy.

Inspired by [vim-journal] and [Literate].


## Synopsis

**cmdline**

```sh
finn tangle path/to/finn/source/file
```

**perl6**

```perl6
use Finn;
my Str $file = 'Story';
Finn.tangle(:$file);
```


## Differences from [Literate]

Literate source files are a dialect of Markdown. Finn source files are
a superset of [vim-journal].

Literate is designed to produce HTML documentation. Finn is designed
to look pretty in Vim.

Literate source files contain embedded frontmatter. Finn source files
don't.


## Installation

### Dependencies

- Rakudo Perl6
- [Config::TOML](https://github.com/atweiden/config-toml)

### Test Dependencies

- [Peru](https://github.com/buildinspace/peru)

To run the tests:

```
$ git clone https://github.com/atweiden/finn && cd finn
$ peru --file=.peru.yml --sync-dir="$PWD" sync
$ PERL6LIB=lib prove -r -e perl6
```


## Licensing

This is free and unencumbered public domain software. For more
information, see http://unlicense.org/ or the accompanying UNLICENSE file.


[vim-journal]: https://github.com/junegunn/vim-journal
[Literate]: https://github.com/zyedidia/Literate
