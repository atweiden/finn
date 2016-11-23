# Syntax

Finn is a superset of [vim-journal]'s syntax. The biggest difference from
[vim-journal] is the concept of a Sectional Block, which is a modified
[vim-journal] code block that receives special treatment from the Finn
compiler.


## Sectional Blocks

Sectional Blocks are for all intents and purposes the same as regular
code blocks, but with three key differences.

The first key difference is that Sectional Blocks are parsed for Sectional
Inlines. Sectional Inlines are essentially the Finn version of *include
directives* found in Haml and other HTML templating languages.

The second key difference is that Sectional Blocks can be added to
and modified by name after being declared, much like variables in a
programming language. Sectional Blocks can be privately scoped to the
file in which they're declared, or they can be exported and referenced
outside of the file in which they're declared.

The third key difference is that Sectional Blocks, if specially marked,
generate files on-disk from Sectional Block Content. This enables Finn
to generate a full codebase from its source files.

A basic Sectional Block looks like this:

```finn
--- Name
content
---
```

Or this:

```finn
-- Name
content
-------
```

Or this:

    ``` Name
    content
    ```

In the above Sectional Blocks, `Name` is the Sectional Block
Name. `content` is the Sectional Block Content. The Sectional Block
Delimiters would be the triple dashes or triple backticks.

The above Sectional Blocks are privately scoped, i.e. they can't be
modified or referenced from any other Finn source file. They are limited
in scope to the Finn source file that they appear in.

To create an exported Sectional Block that can be referenced by copy
from other Finn source files, append an asterisk (`*`) to the Sectional
Block Name, like this:

```finn
--- Exported*
exported content
---
```

Or, equivalently:

    ``` Exported*
    exported content
    ```

To differentiate Finn Sectional Blocks from [vim-journal]'s normal unnamed
code blocks, exactly one horizontal whitespace must exist between the
Sectional Block Delimiter and the Sectional Block Name.

This is an invalid Sectional Block:

```finn
---DON'T DO THIS
invalid sectional block content
---
```

```finn
---DON'T DO THIS*
invalid exported sectional block content
---
```

This is a regular code block:

```finn
---perl6
my Str $greeting = 'Hello, World';
---
```


## Sectional Inlines

*Sectional Inlines* begin with a Section Sign (`§`). The Section Sign
must appear at the start of a line in a Sectional Block, although it
may be offset by leading whitespace. If it is offset by whitespace,
the content being embedded will be soft-indented by an equal amount of
leading whitespace.

The Section Sign must be followed by exactly one horizontal
whitespace. Sectional Inlines come in two flavors:

1. Intra-file
2. Inter-file

Depending on the flavor of Sectional Inline, the horizontal whitespace
following the Section sign must be followed by either a Sectional Block
Name, a Sectional Block Name plus a file path, or just a file path.

### Intra-file Sectional Inlines

Intra-file Sectional Inlines come in one flavor: *By Sectional Block
Name*. This type of Sectional Inline can only appear within a Sectional
Block.

#### Intra-file By Sectional Block Name

This flavor of Sectional Inline embeds a Sectional Block that appears
within the same file of the Sectional Inline by referencing a target
Sectional Block Name. This target Sectional Block may appear either
above or below the Sectional Inline, so long as it's in the same file.

Example:

```finn
--- Cities By State
§ Cities in Washington
---

--- Cities in Washington
- A is for Anacortes.
- B is for Bellingham.
- C is for Centralia.
- D is for Davenport.
---
```

### Inter-file Sectional Inlines

Inter-file Sectional Inlines come in two flavors: *By Sectional Block
Name*, and *By File Path*.

#### Inter-file By Sectional Block Name

In this flavor of Inter-file Sectional Inline, an exported Sectional
Block (its Sectional Block Name having an asterisk `*` appended to it)
from a different Finn source file is referenced by its Sectional Block
Name. Given:

    $ cat finn/cities-in-ca/a-through-c.finn
    ``` Cities Beginning with the Letter A*
    - A is for Anaheim.
    ```

    ``` Cities Beginning with the Letter B*
    - B is for Berkeley.
    ```

    ``` Cities Beginning with the Letter C*
    - C is for Crescent City.
    ```

The following Finn source code will render `- A is for Anaheim.`:

```finn
§ Cities Beginning with the Letter A /finn/cities-in-ca/a-through-f.finn
```

Or, equivalently:

```finn
§ Cities Beginning with the Letter A [1]


******************************************************************************

[1]: /finn/cities-in-ca/a-through-f.finn
```

Another example:

```sh
cat finn/share/recipes.finn
--- Egg Recipe*
Put eggs in skillet. Cook.
---

--- Bacon Recipe*
Lay bacon on baking pan. Bake.
---

--- Secret Sauce
Sprinkle in Mrs. Dash, Salt and Pepper.
---
```

To reference an exported Sectional Block from `finn/share/recipes.finn`:

```finn
§ Egg Recipe [1]


******************************************************************************

[1]: /finn/share/recipes.finn
```

Or, equivalently:

```finn
§ Egg Recipe /finn/share/recipes.finn
```

Compiler error, `Secret Sauce` Sectional Block not exported from Finn
source file:

```finn
§ Secret Sauce /finn/share/recipes.finn
```

This type of Sectional Inline can appear inside and outside of Sectional
Blocks. However, if it appears outside of a Sectional Block, it must:

- appear at the very top of the Finn source file, or
- appear following a blank line, horizontal rule, or comment block
- appear as part of a consecutive series of Sectional Inlines separated
  by newline

#### Inter-file By File Path

In this flavor of Inter-file Sectional Inline, the contents of an
entire file referenced by path are embedded.

```finn
§ /finn/cities-in-ca/a-through-f.finn
```

Or, equivalently:

```finn
§ [1]


******************************************************************************

[1]: /finn/cities-in-ca/a-through-f.finn
```

This type of Sectional Inline can appear inside and outside of Sectional
Blocks. However, if it appears outside of a Sectional Block, it must:

- appear at the very top of the Finn source file, or
- appear following a blank line, horizontal rule, or comment block
- appear as part of a consecutive series of Sectional Inlines separated
  by newline


## Sectional Block Operators

### The Additive Operator

Sectional Blocks can be appended to by creating additional Sectional
Blocks under the same Sectional Block Name but with the *additive
operator* attached to the end (`+=`). Additive operators must be separated
from the Sectional Block Name by a single horizontal whitespace.

Example:

```finn
--- Cities in Washington
§ A
§ B
§ C
---

--- A
- A is for Anacortes.
---

--- B
- B is for Bellingham.
---

--- C
- C is for Centralia.
---
```

We can add to the `Cities in Washington` Sectional Block using the
*additive operator*:

```finn
--- Cities in Washington +=
- D is for Davenport.
---
```

After using the *additive operator*, the contents of the Sectional Block
named `Cities in Washington` would be as follows:

```
- A is for Anacortes.
- B is for Bellingham.
- C is for Centralia.
- D is for Davenport.
```

Exported Sectional Blocks can only be appended to within the same file
in which they are originally declared. From other files, it is possible
to reference exported Sectional Blocks by copy in a new Sectional Block,
and that new Sectional Block can then be appended to.

#### Appending Content To Exported Sectional Blocks

When adding content to an exported Sectional Block with the additive
operator (`+=`) from within the same file that the exported Sectional
Block is first declared, the export symbol (`*`) is optional. Example:

```finn
--- Florence*
About Florence, Italy

---

--- Florence +=
More about Florence.
---

--- Florence* +=

Even more about Florence.
---
```

Results in:

```markdown
About Florence, Italy

More about Florence.

Even more about Florence.
```

### The Redefine Operator

Sectional Blocks can be redefined by creating additional Sectional Blocks
under the same Sectional Block Name but with the *redefine operator*
attached to the end (`:=`). Redefine operators must be separated from
the Sectional Block Name by a single horizontal whitespace.

Example:

```finn
--- Materials
- Plastic
---

--- Materials :=
- Glass
---
```

In the above example, the `Materials` Sectional Block would contain the
text `- Glass`.

Exported Sectional Blocks can only be redefined within the same file in
which they are originally declared. From other files, it is possible to
reference exported Sectional Blocks by copy in a new Sectional Block,
and that new Sectional Block can then be appended to.


## Writing Sectional Blocks To A File By Path

Prepending a forward slash to a Sectional Block Name tells the Finn
compiler to expect the Sectional Block Name to be the file path at which
to write the contents of the parsed Sectional Block Content.

Let's look at the following code snippet:

```finn
--- /cities/WA.md
Washington
==========

---
```

In the above snippet, the contents of the Sectional Block `/cities/WA.md`
will be written to `$PROJECT_ROOT/cities/WA.md`.

Let's add some cities to `$PROJECT_ROOT/cities/WA.md`:

```finn
--- /cities/WA.md +=
§ Cities in Washington
---
```

`$PROJECT_ROOT/cities/WA.md` will now appear as follows:

```markdown
Washington
==========

- A is for Anacortes.
- B is for Bellingham.
- C is for Centralia.
- D is for Davenport.
```

Functionally, treating the leading `/` in the file path as the
`$PROJECT_ROOT` is of paramount importance for DWIM, as it enables you
to create nested directory trees full of Finn source files that may each
write to an arbitrary file path under the project root.

Note that prepending a Sectional Inline inside of a Sectional Block
with leading whitespace will result in the Sectional Inline's linked-to
Sectional Block Content being rendered padded with the same amount of
leading whitespace:

```finn
--- /green.pl6
loop
{
    § Get User Input
    § Check User Input
}
---

--- Get User Input
my Str:D $input = $*IN.get;
---

--- Check User Input
last if $input eq 'green';
---
```

The resulting `green.pl6` file:

```perl6
loop
{
    my Str:D $input = $*IN.get;
    last if $input eq 'green';
}
```

If you wish to write to a file path outside of `$PROJECT_ROOT`, prepend
the file path with `file://`. The following Sectional Block writes its
content to `/tmp/app/cmd-history.txt`:

```finn
--- file:///tmp/app/cmd-history.txt
cat TODO.md
---
```

Similarly, starting the file path with `~/` will write content to a path
under `$HOME`:

```finn
--- ~/.vimrc
set nocompatible
---
```

Sectional Blocks with a file path destination are globally scoped, and
can be added to or redefined from any Finn source file being compiled
using the additive or redefine operators (`+=`, `:=` respectively).


[vim-journal]: https://github.com/junegunn/vim-journal
