Syntax
======

Finn is a superset of [vim-journal]'s syntax. The biggest difference
from [vim-journal] is the concept of a Sectional Code Block, which is a
modified [vim-journal] code block that receives special treatment from
the Finn compiler.


Sectional Code Blocks
---------------------

A basic Sectional Code Block looks like this:

```finn
--- Name
content
---
```

Or this:

    ``` Name
    content
    ```

In the above Sectional Code Blocks, `Name` is the Sectional Code Block
Name. `content` is the Sectional Code Block Content. The Sectional Code
Block Delimiters would be the triple dashes or triple backticks.

The above Sectional Code Blocks would be privately scoped, i.e. they
can't be modified or referenced from any other Finn source file. They
are limited in scope to the Finn source file that they appear in.

To create an exported Sectional Code Block that can be referenced by copy
from other Finn source files, append an asterisk (`*`) to the Sectional
Code Block Name, like this:

```finn
--- Exported*
exported content
---
```

Or, equivalently:

    ``` Exported*
    exported content
    ```

To differentiate Finn Sectional Code Blocks from [vim-journal]'s normal
unnamed code blocks, exactly one horizontal whitespace must exist between
the Sectional Code Block Delimiter and the Sectional Code Block Name.

This is an invalid Sectional Code Block:

```finn
---DON'T DO THIS
invalid sectional code block content
---
```

```finn
---DON'T DO THIS*
invalid exported sectional code block content
---
```

This is a regular code block:

```finn
---perl6
my Str $greeting = 'Hello, World';
---
```


Embedding Sectional Code Blocks Inside Other Sectional Code Blocks
------------------------------------------------------------------

Embedding Sectional Code Blocks inside of other Sectional Code Blocks
looks like this:

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

--- Cities in Washington +=
- D is for Davenport.
---
```

In the above example, the contents of the Sectional Code Block named
`Cities in Washington` would be as follows:

```
- A is for Anacortes.
- B is for Bellingham.
- C is for Centralia.
- D is for Davenport.
```

Note that the Section Sign (`§`) must appear at the start of a line,
although it may be offset by whitespace.

Note that the Section Sign (`§`) must be followed by exactly one
horizontal whitespace, followed by a Sectional Code Block Name, the
contents of which are to be included at that particular point in the
Sectional Code Block referencing it.

Note that Sectional Code Blocks can embed other Sectional Code Blocks
even if they are defined after the current Sectional Code Block.

Finally, note that Sectional Code Blocks can be appended to by creating
additional Sectional Code Blocks under the same Sectional Code Block
Name but with the additive modifier attached to the end (`+=`).


Writing Sectional Code Blocks To A File By Path
-----------------------------------------------

Prepending a forward slash to a Sectional Code Block Name tells the Finn
compiler to expect the Sectional Code Block Name to be the file path at
which to write the contents of the associated Sectional Code Block.

Let's look at the following code snippet:

```finn
--- /cities/WA.md
Washington
==========

---
```

In the above snippet, the contents of the Sectional Code Block
`/cities/WA.md` will be written to `$PROJECT_ROOT/cities/WA.md`.

Let's add some cities to `$PROJECT_ROOT/cities/WA.md`:

```finn
--- /cities/WA.md
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

Sectional Code Blocks with a file path destination are globally scoped,
and can be added to from any Finn source file being compiled.


Embedding Finn Source Files Inside Other Finn Source Files
----------------------------------------------------------

```sh
$ cat finn/cities-in-wa/e-through-h.finn
- E is for Enumclaw.
- F is for Ferndale.
- G is for Goldendale.
- H is for Hoquiam.
```

```finn
§ /finn/cities-in-wa/e-through-h.finn
```

Or, equivalently:

```finn
§ [1]

[1]: /finn/cities-in-wa/e-through-h.finn
```

This syntax works inside and outside of Sectional Code Blocks.


Referencing Exported Sectional Code Blocks
------------------------------------------

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

Referencing an exported Sectional Code Block from
`finn/share/recipes.finn`:

```finn
§ Egg Recipe [1]

[1]: /finn/share/recipes.finn
```

This syntax works inside and outside of Sectional Code Blocks.

Compiler error, `Secret Sauce` Sectional Code Block not exported from
Finn source file:

```finn
§ Secret Sauce [1]

[1]: /finn/share/recipes.finn
```


Appending Content To Exported Sectional Code Blocks
---------------------------------------------------

When adding content to an exported Sectional Code Block with the additive
operator (`+=`), the export symbol (`*`) is optional.

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

```markdown
About Florence, Italy

More about Florence.

Even more about Florence.
```


[vim-journal]: https://github.com/junegunn/vim-journal
