use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 15;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` A
    - A is for Anacortes.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    -- A
    - A is for Anacortes.
    --
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ------------------- A
    - A is for Anacortes.
    ---------------------
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A*
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A* +=
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Additive'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    --- A* :=
    - A is for Anacortes.
    ---
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Dashes'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Redefine'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` A* :=
    - A is for Anacortes.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'A';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Redefine'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = '- A is for Anacortes.';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` Cities in Washington
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    - D is for Davenport.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'Cities in Washington';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = q:to/EOF/.trim-trailing;
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    - D is for Davenport.
    EOF
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/README.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'About this library';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md +=
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/README.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName::Operator['Additive'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'About this library';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /README.md* +=
    About this library
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/README.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName::Identifier::Export $export .= new;
    my SectionalBlockName::Operator['Additive'] $operator .= new;
    my SectionalBlockName $name .= new(:$identifier, :$export, :$operator);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = 'About this library';
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` /doc/TODO.md
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my IO::Path $path .= new('/doc/TODO.md');
    my File['Absolute'] $file .= new(:$path);
    my SectionalBlockName::Identifier['File'] $identifier .= new(:$file);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = q:to/EOF/.trim-trailing;
    Todos
    =====

    [x] Building…
    [!] Construction complete.
    EOF
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` misc
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    § 'misc'
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'misc';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    my Str:D $text-a = q:to/EOF/.trim-trailing;
    - A is for Anacortes.
    - B is for Bellingham.
    - C is for Centralia.
    EOF
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    my Str:D $name-b = 'misc';
    my IncludeLine::Request['Name'] $request-b .= new(:name($name-b));
    my &resolve-b;
    my IncludeLine::Response['Name'] $response-b .= new(:resolve(&resolve-b));
    my IncludeLine['Finn'] $include-line-b .= new(
        :request($request-b),
        :response($response-b)
    );
    my SectionalBlockContent['IncludeLine'] $content-b .= new(
        :include-line($include-line-b)
    );

    # --- end content }}}

    my SectionalBlockContent:D @content = $content-a, $content-b;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

subtest 'sectional-block with indented include-lines',
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim;
    ``` name
      a
      ¶ 'f.ex'
    b
    ¶ 'g.ex'
      c
      § 'h.ex'
    d
    § 'i.ex'
    ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my SectionalBlockDelimiter['Backticks'] $delimiter .= new;

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'name';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    # --- --- a {{{

    my Str:D $text-a = q:to/EOF/.trim-trailing;
      a
    EOF
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- --- end a }}}
    # --- --- b {{{

    my LeadingWS:D @leading-ws-b = LeadingWS['Space'].new xx 2;
    my Str:D $name-b = 'f.ex';
    my IncludeLine::Request['Name'] $request-b .= new(:name($name-b));
    my &resolve-b;
    my IncludeLine::Response['Name'] $response-b .= new(:resolve(&resolve-b));
    my IncludeLine['Text'] $include-line-b .= new(
        :leading-ws(@leading-ws-b),
        :request($request-b),
        :response($response-b)
    );
    my SectionalBlockContent['IncludeLine'] $content-b .= new(
        :include-line($include-line-b)
    );

    # --- --- end b }}}
    # --- --- c {{{

    my Str:D $text-c = q:to/EOF/.trim-trailing;
    b
    EOF
    my SectionalBlockContent['Text'] $content-c .= new(:text($text-c));

    # --- --- end c }}}
    # --- --- d {{{

    my Str:D $name-d = 'g.ex';
    my IncludeLine::Request['Name'] $request-d .= new(:name($name-d));
    my &resolve-d;
    my IncludeLine::Response['Name'] $response-d .= new(:resolve(&resolve-d));
    my IncludeLine['Text'] $include-line-d .= new(
        :request($request-d),
        :response($response-d)
    );
    my SectionalBlockContent['IncludeLine'] $content-d .= new(
        :include-line($include-line-d)
    );

    # --- --- end d }}}
    # --- --- e {{{

    my Str:D $text-e = q:to/EOF/.trim-trailing;
      c
    EOF
    my SectionalBlockContent['Text'] $content-e .= new(:text($text-e));

    # --- --- end e }}}
    # --- --- f {{{

    my LeadingWS:D @leading-ws-f = LeadingWS['Space'].new xx 2;
    my Str:D $name-f = 'h.ex';
    my IncludeLine::Request['Name'] $request-f .= new(:name($name-f));
    my &resolve-f;
    my IncludeLine::Response['Name'] $response-f .= new(:resolve(&resolve-f));
    my IncludeLine['Finn'] $include-line-f .= new(
        :leading-ws(@leading-ws-f),
        :request($request-f),
        :response($response-f)
    );
    my SectionalBlockContent['IncludeLine'] $content-f .= new(
        :include-line($include-line-f)
    );

    # --- --- end f }}}
    # --- --- g {{{

    my Str:D $text-g = q:to/EOF/.trim-trailing;
    d
    EOF
    my SectionalBlockContent['Text'] $content-g .= new(:text($text-g));

    # --- --- end g }}}
    # --- --- h {{{

    my Str:D $name-h = 'i.ex';
    my IncludeLine::Request['Name'] $request-h .= new(:name($name-h));
    my &resolve-h;
    my IncludeLine::Response['Name'] $response-h .= new(:resolve(&resolve-h));
    my IncludeLine['Finn'] $include-line-h .= new(
        :request($request-h),
        :response($response-h)
    );
    my SectionalBlockContent['IncludeLine'] $content-h .= new(
        :include-line($include-line-h)
    );

    # --- --- end h }}}

    # --- end content }}}

    my SectionalBlockContent:D @content =
        $content-a,
        $content-b,
        $content-c,
        $content-d,
        $content-e,
        $content-f,
        $content-g,
        $content-h;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

# same test as the one above, but SectionalBlock is indented four spaces
subtest 'indented sectional-block with indented include-lines',
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $sectional-block = q:to/EOF/.trim-trailing;
        ``` name
          a
          ¶ 'f.ex'
        b
        ¶ 'g.ex'
          c
          § 'h.ex'
        d
        § 'i.ex'
        ```
    EOF
    my Str:D $rule = 'sectional-block';

    # --- delimiter {{{

    my LeadingWS:D @delimiter-leading-ws = LeadingWS['Space'].new xx 4;
    my SectionalBlockDelimiter['Backticks'] $delimiter .= new(
        :leading-ws(@delimiter-leading-ws)
    );

    # --- end delimiter }}}
    # --- name {{{

    my Str:D $word = 'name';
    my SectionalBlockName::Identifier['Word'] $identifier .= new(:$word);
    my SectionalBlockName $name .= new(:$identifier);

    # --- end name }}}
    # --- content {{{

    # --- --- a {{{

    my Str:D $text-a = q:to/EOF/.trim-trailing;
      a
    EOF
    my SectionalBlockContent['Text'] $content-a .= new(:text($text-a));

    # --- --- end a }}}
    # --- --- b {{{

    my LeadingWS:D @leading-ws-b = LeadingWS['Space'].new xx 2;
    my Str:D $name-b = 'f.ex';
    my IncludeLine::Request['Name'] $request-b .= new(:name($name-b));
    my &resolve-b;
    my IncludeLine::Response['Name'] $response-b .= new(:resolve(&resolve-b));
    my IncludeLine['Text'] $include-line-b .= new(
        :leading-ws(@leading-ws-b),
        :request($request-b),
        :response($response-b)
    );
    my SectionalBlockContent['IncludeLine'] $content-b .= new(
        :include-line($include-line-b)
    );

    # --- --- end b }}}
    # --- --- c {{{

    my Str:D $text-c = q:to/EOF/.trim-trailing;
    b
    EOF
    my SectionalBlockContent['Text'] $content-c .= new(:text($text-c));

    # --- --- end c }}}
    # --- --- d {{{

    my Str:D $name-d = 'g.ex';
    my IncludeLine::Request['Name'] $request-d .= new(:name($name-d));
    my &resolve-d;
    my IncludeLine::Response['Name'] $response-d .= new(:resolve(&resolve-d));
    my IncludeLine['Text'] $include-line-d .= new(
        :request($request-d),
        :response($response-d)
    );
    my SectionalBlockContent['IncludeLine'] $content-d .= new(
        :include-line($include-line-d)
    );

    # --- --- end d }}}
    # --- --- e {{{

    my Str:D $text-e = q:to/EOF/.trim-trailing;
      c
    EOF
    my SectionalBlockContent['Text'] $content-e .= new(:text($text-e));

    # --- --- end e }}}
    # --- --- f {{{

    my LeadingWS:D @leading-ws-f = LeadingWS['Space'].new xx 2;
    my Str:D $name-f = 'h.ex';
    my IncludeLine::Request['Name'] $request-f .= new(:name($name-f));
    my &resolve-f;
    my IncludeLine::Response['Name'] $response-f .= new(:resolve(&resolve-f));
    my IncludeLine['Finn'] $include-line-f .= new(
        :leading-ws(@leading-ws-f),
        :request($request-f),
        :response($response-f)
    );
    my SectionalBlockContent['IncludeLine'] $content-f .= new(
        :include-line($include-line-f)
    );

    # --- --- end f }}}
    # --- --- g {{{

    my Str:D $text-g = q:to/EOF/.trim-trailing;
    d
    EOF
    my SectionalBlockContent['Text'] $content-g .= new(:text($text-g));

    # --- --- end g }}}
    # --- --- h {{{

    my Str:D $name-h = 'i.ex';
    my IncludeLine::Request['Name'] $request-h .= new(:name($name-h));
    my &resolve-h;
    my IncludeLine::Response['Name'] $response-h .= new(:resolve(&resolve-h));
    my IncludeLine['Finn'] $include-line-h .= new(
        :request($request-h),
        :response($response-h)
    );
    my SectionalBlockContent['IncludeLine'] $content-h .= new(
        :include-line($include-line-h)
    );

    # --- --- end h }}}

    # --- end content }}}

    my SectionalBlockContent:D @content =
        $content-a,
        $content-b,
        $content-c,
        $content-d,
        $content-e,
        $content-f,
        $content-g,
        $content-h;

    cmp-ok
        Finn::Parser::Grammar.parse($sectional-block, :$rule, :$actions).made,
        &cmp-ok-sectional-block,
        SectionalBlock.new(:$delimiter, :$name, :@content),
        'SectionalBlock OK';
}

sub cmp-ok-sectional-block(
    SectionalBlock:D $a,
    SectionalBlock:D $b
) returns Bool:D
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
