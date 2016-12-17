use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 6;

subtest 'finn-examples/app',
{
    my Str:D $document = 't/data/app/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Your App or Library Name Goes Here
        ==================================
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Introduction
        ------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        The `Story` file is the self-contained story of the software being
        assembled by Finn. All content must be assembled from this file.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        We'll begin by constructing the project's readme and licensing files,
        then move on to constructing the app's library.
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § /finn/README.md.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § /finn/UNLICENSE.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § /finn/lib/App.pm.finn
        EOF
        '',
        '~' x 78;

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<header-block><blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[2]<header-block><header>, @chunk[4];
    is-deeply ~$match<document><chunk>[3]<blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<paragraph>, @chunk[6];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<paragraph>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[8]<horizontal-rule>, @chunk[10];
    is-deeply ~$match<document><chunk>[9]<sectional-inline-block><blank-line>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<sectional-inline-block><sectional-inline>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<blank-line>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<horizontal-rule>, @chunk[14];
    is-deeply ~$match<document><chunk>[12]<sectional-inline-block><blank-line>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<sectional-inline-block><sectional-inline>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<blank-line>, @chunk[17];
    is-deeply ~$match<document><chunk>[14]<horizontal-rule>, @chunk[18];
    is-deeply ~$match<document><chunk>[15]<sectional-inline-block><blank-line>, @chunk[19];
    is-deeply ~$match<document><chunk>[15]<sectional-inline-block><sectional-inline>, @chunk[20];
    is-deeply ~$match<document><chunk>[16]<blank-line>, @chunk[21];
    is-deeply ~$match<document><chunk>[17]<horizontal-rule>, @chunk[22];
    ok $match<document><chunk>[18].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/hangman',
{
    my Str:D $document = 't/data/hangman/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Hangman
        =======
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Introduction
        ------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        This is a Hangman program written in Perl6 [1]. It lets you make guesses
        about which letters are in an unknown word. On the eighth incorrect
        guess you lose.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        The structure of the hangman program will look like this:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- /hangman.pl6
        'Welcome to hangman!'.say;
        § "Setup"
        my UInt:D $lives-left = 8;
        while $lives-left > 0
        {
            § "User input"
            § "Check input"
            § "Check win"
        }

        § "End"
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        The Setup
        ---------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        First, we have the computer come up with a secret word which it chooses
        randomly from a list of words read from a text file.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Setup
        my Str:D @words = 'words.txt'.IO.lines.split(/\s+/);
        my Str:D $secret-word = @words.pick;
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Next we initialize the variable to hold the dashes.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Setup +=
        my Str:D @dashes = ('-' x $secret-word.chars).comb;
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        Getting User Input
        ------------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Now we can start the game. We ask for the user's guess and store it in
        the `$guess` variable.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- User input
        § "print dashes array"
        "You have $lives-left lives left".say;
        "What's your guess? ".print;
        my Str:D $guess = $*IN.get;
        ''.say;
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        Checking the User's Guess
        -------------------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        We loop through the secret word, checking if any of its letters were
        guessed. If they were, reveal that letter in the dashes array. If
        none of the letters in secret word were equal to the guess, then
        `$got-one-correct` will be false, and one life will be deducted.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Check input
        my Bool:D $got-one-correct = False;
        loop (my UInt:D $i = 0; $i < $secret-word.chars; $i++)
        {
            if $secret-word.comb[$i] eq $guess
            {
                $got-one-correct = True;
                @dashes[$i] = $guess;
            }
        }

        $lives-left -= 1 unless $got-one-correct;
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        Checking for Victory
        --------------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Now we should check if the user has guessed all the letters.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Here we see if there are any dashes left in the array that holds the
        dashes. If there aren't, the user has won.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Check win
        if @dashes.grep('-').not
        {
            "You win! The word was $secret-word".say;
            exit 0;
        }
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        Pretty Printing the Dashes
        --------------------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        We want the dashes to look pretty when they are printed, not look like
        an array of chars. Instead of `['-', '-', '-', '-']`, we want `----`.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- print dashes array
        @dashes.join.say;
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        The End
        -------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- End
        "You lose. The word was $secret-word".say;
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing,
        Words
        -----
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Here is the file containing all the words for the game. It's just a
        simple text file with words split by whitespace.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- /words.txt
        able about account acid across act addition adjustment
        advertisement after again against agreement almost among
        attempt attention attraction authority automatic awake
        baby back bad bag balance ball band base basin basket bath be
        beautiful because bed bee before behaviour belief bell
        bent berry between bird birth bit bite bitter black blade blood
        carriage cart cat cause certain chain chalk chance
        change cheap cheese chemical chest chief chin church circle clean clear
        clock cloth cloud coal coat cold collar colour comb
        come comfort committee common company comparison competition complete
        complex condition connection conscious control cook copper copy
        cord cork cotton cough country cover cow crack credit crime
        delicate dependent design desire destruction detail development
        different digestion direction dirty discovery discussion disease
        last late laugh law lead leaf learning leather left letter level
        library lift light like limit line linen lip liquid
        morning mother motion mountain mouth move much muscle music nail
        name narrow nation natural near necessary neck need needle
        private probable process produce profit property prose protest public
        pull pump punishment purpose push put quality question
        seem selection self send sense separate serious servant shade shake
        shame sharp sheep shelf ship shirt shock shoe short
        square stage stamp star start statement station steam steel stem step
        stick sticky stiff still stitch stocking stomach stone
        stop store story straight strange street stretch strong structure
        substance such sudden sugar suggestion summer sun support surprise
        very vessel view violent voice waiting walk wall war warm wash waste
        watch water wave wax way weather week weight well west
        wet wheel when where while whip whistle white who why wide will wind
        window wine wing winter wire wise with woman wood wool word
        work worm wound writing wrong year yellow yesterday young
        ---
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing;
        ******************************************************************************

        [1]: https://github.com/zyedidia/Literate/blob/master/examples/hangman.lit
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<header-block><blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[2]<header-block><header>, @chunk[4];
    is-deeply ~$match<document><chunk>[3]<blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<paragraph>, @chunk[6];
    is-deeply ~$match<document><chunk>[5]<header-block><blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[5]<header-block><header>, @chunk[8];
    is-deeply ~$match<document><chunk>[6]<blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<sectional-block>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<blank-line>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<header-block><blank-line>, @chunk[12];
    is-deeply ~$match<document><chunk>[9]<header-block><header>, @chunk[13];
    is-deeply ~$match<document><chunk>[10]<blank-line>, @chunk[14];
    is-deeply ~$match<document><chunk>[11]<paragraph>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<blank-line>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<sectional-block>, @chunk[17];
    is-deeply ~$match<document><chunk>[14]<blank-line>, @chunk[18];
    is-deeply ~$match<document><chunk>[15]<paragraph>, @chunk[19];
    is-deeply ~$match<document><chunk>[16]<blank-line>, @chunk[20];
    is-deeply ~$match<document><chunk>[17]<sectional-block>, @chunk[21];
    is-deeply ~$match<document><chunk>[18]<blank-line>, @chunk[22];
    is-deeply ~$match<document><chunk>[19]<header-block><blank-line>, @chunk[23];
    is-deeply ~$match<document><chunk>[19]<header-block><header>, @chunk[24];
    is-deeply ~$match<document><chunk>[20]<blank-line>, @chunk[25];
    is-deeply ~$match<document><chunk>[21]<paragraph>, @chunk[26];
    is-deeply ~$match<document><chunk>[22]<blank-line>, @chunk[27];
    is-deeply ~$match<document><chunk>[23]<sectional-block>, @chunk[28];
    is-deeply ~$match<document><chunk>[24]<blank-line>, @chunk[29];
    is-deeply ~$match<document><chunk>[25]<header-block><blank-line>, @chunk[30];
    is-deeply ~$match<document><chunk>[25]<header-block><header>, @chunk[31];
    is-deeply ~$match<document><chunk>[26]<blank-line>, @chunk[32];
    is-deeply ~$match<document><chunk>[27]<paragraph>, @chunk[33];
    is-deeply ~$match<document><chunk>[28]<blank-line>, @chunk[34];
    is-deeply ~$match<document><chunk>[29]<sectional-block>, @chunk[35];
    is-deeply ~$match<document><chunk>[30]<blank-line>, @chunk[36];
    is-deeply ~$match<document><chunk>[31]<header-block><blank-line>, @chunk[37];
    is-deeply ~$match<document><chunk>[31]<header-block><header>, @chunk[38];
    is-deeply ~$match<document><chunk>[32]<blank-line>, @chunk[39];
    is-deeply ~$match<document><chunk>[33]<paragraph>, @chunk[40];
    is-deeply ~$match<document><chunk>[34]<blank-line>, @chunk[41];
    is-deeply ~$match<document><chunk>[35]<paragraph>, @chunk[42];
    is-deeply ~$match<document><chunk>[36]<blank-line>, @chunk[43];
    is-deeply ~$match<document><chunk>[37]<sectional-block>, @chunk[44];
    is-deeply ~$match<document><chunk>[38]<blank-line>, @chunk[45];
    is-deeply ~$match<document><chunk>[39]<header-block><blank-line>, @chunk[46];
    is-deeply ~$match<document><chunk>[39]<header-block><header>, @chunk[47];
    is-deeply ~$match<document><chunk>[40]<blank-line>, @chunk[48];
    is-deeply ~$match<document><chunk>[41]<paragraph>, @chunk[49];
    is-deeply ~$match<document><chunk>[42]<blank-line>, @chunk[50];
    is-deeply ~$match<document><chunk>[43]<sectional-block>, @chunk[51];
    is-deeply ~$match<document><chunk>[44]<blank-line>, @chunk[52];
    is-deeply ~$match<document><chunk>[45]<header-block><blank-line>, @chunk[53];
    is-deeply ~$match<document><chunk>[45]<header-block><header>, @chunk[54];
    is-deeply ~$match<document><chunk>[46]<blank-line>, @chunk[55];
    is-deeply ~$match<document><chunk>[47]<sectional-block>, @chunk[56];
    is-deeply ~$match<document><chunk>[48]<blank-line>, @chunk[57];
    is-deeply ~$match<document><chunk>[49]<header-block><blank-line>, @chunk[58];
    is-deeply ~$match<document><chunk>[49]<header-block><header>, @chunk[59];
    is-deeply ~$match<document><chunk>[50]<blank-line>, @chunk[60];
    is-deeply ~$match<document><chunk>[51]<paragraph>, @chunk[61];
    is-deeply ~$match<document><chunk>[52]<blank-line>, @chunk[62];
    is-deeply ~$match<document><chunk>[53]<sectional-block>, @chunk[63];
    is-deeply ~$match<document><chunk>[54]<blank-line>, @chunk[64];
    is-deeply ~$match<document><chunk>[55]<blank-line>, @chunk[65];
    is-deeply ~$match<document><chunk>[56]<reference-block>, @chunk[66];
    ok $match<document><chunk>[57].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/hard',
{
    my Str:D $document = 't/data/hard/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Hard Example
        ============
        EOF
        q:to/EOF/.trim-trailing,
        this should be parsed as a `paragraph` since no `blank-line`,
        `comment-line` or `horizontal-rule` precedes it, and a line follows it
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be parsed as a `header3`
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should also be parsed as a `header3` /* eol comment */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be a paragraph since it ends in a comma (`,`),
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should also be a paragraph since it ends in a comma (`,`), /* eol comment */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be a paragraph since it ends in a period (`.`).
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should also be a paragraph since it ends in a period (`.`). /* eol comment */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this too should be a paragraph since it ends in a period (`.`). /*
        comment-text                                                     *
        comment-text                                                     *
        comment-text                                                     *
        comment-text                                                     *
        comment-text                                                     */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        /* lists
         * {{{
         */
        EOF
        '',
        '[9] (header3 with trailing whitespace)                 ',
        q:to/EOF/.trim-trailing,
        - nine
          ! nine
            o nine
              <- nine
                -> nine
                  = nine
                    => nine
                      <= nine
                        @ nine
                          $ nine
                            : nine
        EOF
        '',
        q:to/EOF/.trim-trailing,
        [0] (header2)
        --------------------
        EOF
        q:to/EOF/.trim-trailing,
        - zero
          # zero
            * zero
              x zero
                + zero
                  ! zero
                    ~ zero
                      > zero
                        - zero /* eol comment */
                          - z /* inner word comment */ ero
                            - /* leading comment */ zero
        EOF
        '',
        q:to/EOF/.trim-trailing,
        [909] (header1)
        ============================
        EOF
        q:to/EOF/.trim-trailing,
        - nine zero nine
        EOF
        q:to/EOF/.trim-trailing,
          /* comment */
        EOF
        q:to/EOF/.trim-trailing,
          - nine zero nine
        EOF
        q:to/EOF/.trim-trailing,
            /*
             * comment
             * comment
             * comment
             */
        EOF
        q:to/EOF/.trim-trailing,
            - nine zero nine /*
              comment         *
              comment         *
              comment         */
              - nine zero 「nine」
                - nine zero «nine»
                  - nine zero ⟅nine⟆
                    - nine zero ᚛nine᚜
                      - nine zero _nine_
                        - **nine** zero |nine|
                          - nine *zero* {nine}
                            - nine zero ~nine~
        EOF
        '',
        q:to/EOF/.trim-trailing,
        /*
         * }}}
         end lists */
        EOF
        '',
        q:to/EOF/.trim-trailing,
        /**/ this should be parsed as a paragraph
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Header2
        -
        EOF
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Another Header2
        -
        EOF
        q:to/EOF/.trim-trailing,
        This is a paragraph since it is not preceded by a `blank-line`,
        `comment-block` or `horizontal-rule`. We just saw a `header2`.
        EOF
        '',
        '~' x 78,
        q:to/EOF/.trim-trailing,
        this should be parsed as a `header3` since a `horizontal-rule-soft` precedes it
        EOF
        '',
        q:to/EOF/.trim-trailing,
        **another header3 since a `blank-line` precedes it**
        EOF
        '',
        '*' x 78,
        q:to/EOF/.trim-trailing,
        this should be parsed as a `header3` since a `horizontal-rule-hard` precedes it
        EOF
        '*' x 78,
        q:to/EOF/.trim-trailing,
        this should not be a `header3` since one line of text comes after it
        {{{one line of text goes here}}}
        EOF
        '',
        '~' x 78,
        q:to/EOF/.trim-trailing,
        this should not be a `header3` since one line of text comes after it
        one line of text goes here
        EOF
        '',
        q:to/EOF/.trim-trailing,
        this should be a `header3`
        EOF
        q:to/EOF/.trim-trailing,
        x because a `blank-line` comes before it
        [*] because a list comes after it
        1. the list continues \ / _$@$#%$^%Y&&^%%@$$#$T%Y^U&^' ' ~with~ *offset*
           **gibberish** underlined up to here_. file://~/tmp/ /a\/b.txt
           {} [] some symbols come on the next offset line
          2. indented list-item
        EOF
        q:to/EOF/.trim-trailing,
            ```perl6
            # indented perl6 code-block
            my Str:D $greeting = 'Hello';
            ```
        EOF
        q:to/EOF/.trim-trailing,
            /* ------------- *
             * comment-block *
             * comment-block *
             * comment-block *
             * ------------- */
        EOF
        q:to/EOF/.trim-trailing,
            -> here comes another code-block /* eol comment goes here */
        EOF
        q:to/EOF/.trim-trailing,
              --perl6
              # indented perl6 code-block
              my Str:D $greeting = 'Hello';
              --
        EOF
        q:to/EOF/.trim-trailing,
        --- The Simpsons Quotes
        'Doh!
        ---
        EOF
        q:to/EOF/.trim-trailing,
        ``` The Simpsons Quotes +=
        Dental Plan!
        ```
        EOF
        q:to/EOF/.trim-trailing,
        -- The Simpsons Quotes +=
        Lisa needs braces!
        -------------------------------
        EOF
        q:to/EOF/.trim-trailing,
        -- The Simpsons Quotes +=
        Bart! Why you little
        --
        EOF
        '',
        '~' x 2,
        q:to/EOF/.trim-trailing,
        this should be a `header3`
        EOF
        q:to/EOF/.trim-trailing,
        [o] because a `horizontal-rule` comes before it
        [o] because a list comes after it
        EOF
        '',
        '*' x 2,
        q:to/EOF/.trim-trailing,
        this should be a `header3`
        EOF
        q:to/EOF/.trim-trailing,
        [=] because a `horizontal-rule` comes before it
        [=] because a list comes after it
        EOF
        '',
        q:to/EOF/.trim-trailing,
              INFO Robot
        EOF
        '',
        q:to/EOF/.trim-trailing,
                           FIXME
        EOF
        q:to/EOF/.trim-trailing,
                            ```
                            \_/
                            |:|
                            -|-
                            / \
                            ```
        EOF
        '',
        q:to/EOF/.trim-trailing,
              DEBUG System
        EOF
        '',
        '',
        '',
        Q:to/EOF/.trim-trailing;
        ******************************************************************************

        [1]: https://[2[3[4]]].finn
        [9]: /\\/\/\/\/\/\/\/\/\/\/\/\/\\/
        [0]: 1234567890-=`1234567890`
        [909]: a
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<paragraph>, @chunk[3];
    is-deeply ~$match<document><chunk>[3]<header-block><blank-line>, @chunk[4];
    is-deeply ~$match<document><chunk>[3]<header-block><header>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<header-block><blank-line>, @chunk[6];
    is-deeply ~$match<document><chunk>[4]<header-block><header>, @chunk[7];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[8];
    is-deeply ~$match<document><chunk>[6]<paragraph>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<blank-line>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<paragraph>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<blank-line>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<paragraph>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<blank-line>, @chunk[14];
    is-deeply ~$match<document><chunk>[12]<paragraph>, @chunk[15];
    is-deeply ~$match<document><chunk>[13]<blank-line>, @chunk[16];
    is-deeply ~$match<document><chunk>[14]<paragraph>, @chunk[17];
    is-deeply ~$match<document><chunk>[15]<blank-line>, @chunk[18];
    is-deeply ~$match<document><chunk>[16]<comment-block>, @chunk[19];
    is-deeply ~$match<document><chunk>[17]<header-block><blank-line>, @chunk[20];
    is-deeply ~$match<document><chunk>[17]<header-block><header>, @chunk[21];
    is-deeply ~$match<document><chunk>[18]<list-block>, @chunk[22];
    is-deeply ~$match<document><chunk>[19]<header-block><blank-line>, @chunk[23];
    is-deeply ~$match<document><chunk>[19]<header-block><header>, @chunk[24];
    is-deeply ~$match<document><chunk>[20]<list-block>, @chunk[25];
    is-deeply ~$match<document><chunk>[21]<header-block><blank-line>, @chunk[26];
    is-deeply ~$match<document><chunk>[21]<header-block><header>, @chunk[27];
    is-deeply ~$match<document><chunk>[22]<list-block>, @chunk[28];
    is-deeply ~$match<document><chunk>[23]<comment-block>, @chunk[29];
    is-deeply ~$match<document><chunk>[24]<list-block>, @chunk[30];
    is-deeply ~$match<document><chunk>[25]<comment-block>, @chunk[31];
    is-deeply ~$match<document><chunk>[26]<list-block>, @chunk[32];
    is-deeply ~$match<document><chunk>[27]<blank-line>, @chunk[33];
    is-deeply ~$match<document><chunk>[28]<comment-block>, @chunk[34];
    is-deeply ~$match<document><chunk>[29]<blank-line>, @chunk[35];
    is-deeply ~$match<document><chunk>[30]<paragraph>, @chunk[36];
    is-deeply ~$match<document><chunk>[31]<header-block><blank-line>, @chunk[37];
    is-deeply ~$match<document><chunk>[31]<header-block><header>, @chunk[38];
    is-deeply ~$match<document><chunk>[32]<horizontal-rule>, @chunk[39];
    is-deeply ~$match<document><chunk>[33]<header-block><blank-line>, @chunk[40];
    is-deeply ~$match<document><chunk>[33]<header-block><header>, @chunk[41];
    is-deeply ~$match<document><chunk>[34]<paragraph>, @chunk[42];
    is-deeply ~$match<document><chunk>[35]<blank-line>, @chunk[43];
    is-deeply ~$match<document><chunk>[36]<header-block><horizontal-rule>, @chunk[44];
    is-deeply ~$match<document><chunk>[36]<header-block><header>, @chunk[45];
    is-deeply ~$match<document><chunk>[37]<header-block><blank-line>, @chunk[46];
    is-deeply ~$match<document><chunk>[37]<header-block><header>, @chunk[47];
    is-deeply ~$match<document><chunk>[38]<blank-line>, @chunk[48];
    is-deeply ~$match<document><chunk>[39]<header-block><horizontal-rule>, @chunk[49];
    is-deeply ~$match<document><chunk>[39]<header-block><header>, @chunk[50];
    is-deeply ~$match<document><chunk>[40]<horizontal-rule>, @chunk[51];
    is-deeply ~$match<document><chunk>[41]<paragraph>, @chunk[52];
    is-deeply ~$match<document><chunk>[42]<blank-line>, @chunk[53];
    is-deeply ~$match<document><chunk>[43]<horizontal-rule>, @chunk[54];
    is-deeply ~$match<document><chunk>[44]<paragraph>, @chunk[55];
    is-deeply ~$match<document><chunk>[45]<header-block><blank-line>, @chunk[56];
    is-deeply ~$match<document><chunk>[45]<header-block><header>, @chunk[57];
    is-deeply ~$match<document><chunk>[46]<list-block>, @chunk[58];
    is-deeply ~$match<document><chunk>[47]<code-block>, @chunk[59];
    is-deeply ~$match<document><chunk>[48]<comment-block>, @chunk[60];
    is-deeply ~$match<document><chunk>[49]<list-block>, @chunk[61];
    is-deeply ~$match<document><chunk>[50]<code-block>, @chunk[62];
    is-deeply ~$match<document><chunk>[51]<sectional-block>, @chunk[63];
    is-deeply ~$match<document><chunk>[52]<sectional-block>, @chunk[64];
    is-deeply ~$match<document><chunk>[53]<sectional-block>, @chunk[65];
    is-deeply ~$match<document><chunk>[54]<sectional-block>, @chunk[66];
    is-deeply ~$match<document><chunk>[55]<blank-line>, @chunk[67];
    is-deeply ~$match<document><chunk>[56]<header-block><horizontal-rule>, @chunk[68];
    is-deeply ~$match<document><chunk>[56]<header-block><header>, @chunk[69];
    is-deeply ~$match<document><chunk>[57]<list-block>, @chunk[70];
    is-deeply ~$match<document><chunk>[58]<blank-line>, @chunk[71];
    is-deeply ~$match<document><chunk>[59]<header-block><horizontal-rule>, @chunk[72];
    is-deeply ~$match<document><chunk>[59]<header-block><header>, @chunk[73];
    is-deeply ~$match<document><chunk>[60]<list-block>, @chunk[74];
    is-deeply ~$match<document><chunk>[61]<blank-line>, @chunk[75];
    is-deeply ~$match<document><chunk>[62]<paragraph>, @chunk[76];
    is-deeply ~$match<document><chunk>[63]<blank-line>, @chunk[77];
    is-deeply ~$match<document><chunk>[64]<paragraph>, @chunk[78];
    is-deeply ~$match<document><chunk>[65]<code-block>, @chunk[79];
    is-deeply ~$match<document><chunk>[66]<blank-line>, @chunk[80];
    is-deeply ~$match<document><chunk>[67]<paragraph>, @chunk[81];
    is-deeply ~$match<document><chunk>[68]<blank-line>, @chunk[82];
    is-deeply ~$match<document><chunk>[69]<blank-line>, @chunk[83];
    is-deeply ~$match<document><chunk>[70]<blank-line>, @chunk[84];
    is-deeply ~$match<document><chunk>[71]<reference-block>, @chunk[85];
    ok $match<document><chunk>[72].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/hello',
{
    my Str:D $document = 't/data/hello/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Hello World
        ===========
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Introduction
        ------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        A simple, single-file hello world program written in Perl6.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        The following will (over)write the contents of `bin/hello` with the
        `Import modules` and `Print a string` code blocks:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- /bin/hello
        § "Import modules"
        § "Print a string"
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        First, we import any modules needed:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Import modules
        use v6;
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Forgot the module. Code blocks can be extended by defining them again:
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --- Import modules +=
        use Acme::Insult::Lala;
        ---
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Then we print a string:
        EOF
        '',
        q:to/EOF/.trim-trailing;
        --- Print a string
        say "hello, you " ~ Acme::Insult::Lala.new.generate-insult;
        ---
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<header-block><blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[2]<header-block><header>, @chunk[4];
    is-deeply ~$match<document><chunk>[3]<blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<paragraph>, @chunk[6];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<paragraph>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[8]<sectional-block>, @chunk[10];
    is-deeply ~$match<document><chunk>[9]<header-block><blank-line>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<header-block><header>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<blank-line>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<sectional-block>, @chunk[14];
    is-deeply ~$match<document><chunk>[12]<header-block><blank-line>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<header-block><header>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<blank-line>, @chunk[17];
    is-deeply ~$match<document><chunk>[14]<sectional-block>, @chunk[18];
    is-deeply ~$match<document><chunk>[15]<header-block><blank-line>, @chunk[19];
    is-deeply ~$match<document><chunk>[15]<header-block><header>, @chunk[20];
    is-deeply ~$match<document><chunk>[16]<blank-line>, @chunk[21];
    is-deeply ~$match<document><chunk>[17]<sectional-block>, @chunk[22];
    ok $match<document><chunk>[18].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/novel',
{
    my Str:D $document = 't/data/novel/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn foldmethod=marker foldlevel=0: */',
        '',
        q:to/EOF/.trim-trailing,
        Novel
        =====
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § chapter-01/intro.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § chapter-02/intro.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        § chapter-03/intro.finn
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing;
        El Fin
        ------
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[3]<horizontal-rule>, @chunk[4];
    is-deeply ~$match<document><chunk>[4]<sectional-inline-block><blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[4]<sectional-inline-block><sectional-inline>, @chunk[6];
    is-deeply ~$match<document><chunk>[5]<blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<horizontal-rule>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<sectional-inline-block><blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<sectional-inline-block><sectional-inline>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<blank-line>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<horizontal-rule>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<sectional-inline-block><blank-line>, @chunk[13];
    is-deeply ~$match<document><chunk>[10]<sectional-inline-block><sectional-inline>, @chunk[14];
    is-deeply ~$match<document><chunk>[11]<blank-line>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<horizontal-rule>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<header-block><blank-line>, @chunk[17];
    is-deeply ~$match<document><chunk>[13]<header-block><header>, @chunk[18];
    ok $match<document><chunk>[14].isa(Any);

    # end @chunk tests }}}
}

subtest 'finn-examples/sample',
{
    my Str:D $document = 't/data/sample/Story';
    my Match:D $match = Finn::Parser::Grammar.parsefile($document);

    ok $match, 'Parses Finn source document';

    # @chunk {{{

    my Str:D @chunk =
        '/* vim: set filetype=finn: */',
        '',
        q:to/EOF/.trim-trailing,
        vim-finn
        ========
        EOF
        '',
        q:to/EOF/.trim-trailing,
        *vim-finn*[1] is _a syntax plugin for Finn_, a superset of Junegunn Choi's
        *vim-journal*[2] specifically designed for literate programming.
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Bullet lists [3]
        ----------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Example:
        EOF
        q:to/EOF/.trim-trailing,
        - In typography, a bullet (•) is a typographical symbol or glyph used to
          introduce items in a list.
          = It is likely that the name originated from the resemblance of the
            traditional circular bullet symbol (•) to a projectile bullet, which were
            spherical until the second half of the 19th century
            * The bullet symbol may take any of a variety of shapes, such as
                1. circular,
                2. square,
                3. diamond,
                4. arrow, etc.
            * And typical word processor software offer a wide selection of shapes and
              colours.
                * When writing by hand, bullets may be drawn in any style
                  o Historically, the index symbol was popular for similar uses.
                    x Lists made with bullets are called bulleted lists.
                      > The HTML element name for a bulleted list is "unordered list"
                        ~ Because the list items are not arranged in numerical order.
                          : (as they would be in a numbered list)
                        ! Bullets are most often used in technical writing, reference
                          works, notes and presentations
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        To-do list [4]
        --------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        As its name implies, the To-do list on an article's talk page shows the
        list of improvements suggested for the article.
        EOF
        '',
        q:to/EOF/.trim-trailing,
        [v] Task 1
          [ ] Task 1-1
            [v] Task 1-1-1
            [x] Task 1-1-2
              [*] Task 1-1-2-1
                [=] Task 1-1-2-1-1
                [=] Task 1-1-2-1-2
              [-] Task 1-1-2-2
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Software logs
        -------------
        EOF
        '',
        q:to/EOF/.trim-trailing,
        2015/04/01 12:00:00 DEBUG Info message
        2015/04/01 12:00:00 INFO Info message
        2015/04/01 12:00:00 WARN Warning message
        2015/04/01 12:00:00 ERROR Error message (FIXME)
        EOF
        '',
        '~' x 78,
        '',
        q:to/EOF/.trim-trailing,
        Code
        ----
        EOF
        '',
        q:to/EOF/.trim-trailing,
        --clojure
        (defn is-directory? [path]
          (.isDirectory (io/file (path-for path))))
        --
        EOF
        '',
        q:to/EOF/.trim-trailing,
        Blocks can be indented.
        EOF
        '',
        q:to/EOF/.trim-trailing,
          ```ruby
          class Foo
            def foobar
              puts :baz
            end
          end
          ```
        EOF
        '',
        '',
        q:to/EOF/.trim-trailing;
        ******************************************************************************

        [1]: https://github.com/atweiden/vim-finn
        [2]: https://github.com/junegunn/vim-journal
        [3]: http://en.wikipedia.org/wiki/Bullet_%28typography%29
        [4]: http://en.wikipedia.org/wiki/Wikipedia:To-do_list
        EOF

    # end @chunk }}}
    # @chunk tests {{{

    is-deeply ~$match<document><chunk>[0]<comment-block>, @chunk[0];
    is-deeply ~$match<document><chunk>[1]<header-block><blank-line>, @chunk[1];
    is-deeply ~$match<document><chunk>[1]<header-block><header>, @chunk[2];
    is-deeply ~$match<document><chunk>[2]<blank-line>, @chunk[3];
    is-deeply ~$match<document><chunk>[3]<paragraph>, @chunk[4];
    is-deeply ~$match<document><chunk>[4]<blank-line>, @chunk[5];
    is-deeply ~$match<document><chunk>[5]<horizontal-rule>, @chunk[6];
    is-deeply ~$match<document><chunk>[6]<header-block><blank-line>, @chunk[7];
    is-deeply ~$match<document><chunk>[6]<header-block><header>, @chunk[8];
    is-deeply ~$match<document><chunk>[7]<header-block><blank-line>, @chunk[9];
    is-deeply ~$match<document><chunk>[7]<header-block><header>, @chunk[10];
    is-deeply ~$match<document><chunk>[8]<list-block>, @chunk[11];
    is-deeply ~$match<document><chunk>[9]<blank-line>, @chunk[12];
    is-deeply ~$match<document><chunk>[10]<horizontal-rule>, @chunk[13];
    is-deeply ~$match<document><chunk>[11]<header-block><blank-line>, @chunk[14];
    is-deeply ~$match<document><chunk>[11]<header-block><header>, @chunk[15];
    is-deeply ~$match<document><chunk>[12]<blank-line>, @chunk[16];
    is-deeply ~$match<document><chunk>[13]<paragraph>, @chunk[17];
    is-deeply ~$match<document><chunk>[14]<blank-line>, @chunk[18];
    is-deeply ~$match<document><chunk>[15]<list-block>, @chunk[19];
    is-deeply ~$match<document><chunk>[16]<blank-line>, @chunk[20];
    is-deeply ~$match<document><chunk>[17]<horizontal-rule>, @chunk[21];
    is-deeply ~$match<document><chunk>[18]<header-block><blank-line>, @chunk[22];
    is-deeply ~$match<document><chunk>[18]<header-block><header>, @chunk[23];
    is-deeply ~$match<document><chunk>[19]<blank-line>, @chunk[24];
    is-deeply ~$match<document><chunk>[20]<paragraph>, @chunk[25];
    is-deeply ~$match<document><chunk>[21]<blank-line>, @chunk[26];
    is-deeply ~$match<document><chunk>[22]<horizontal-rule>, @chunk[27];
    is-deeply ~$match<document><chunk>[23]<header-block><blank-line>, @chunk[28];
    is-deeply ~$match<document><chunk>[23]<header-block><header>, @chunk[29];
    is-deeply ~$match<document><chunk>[24]<blank-line>, @chunk[30];
    is-deeply ~$match<document><chunk>[25]<code-block>, @chunk[31];
    is-deeply ~$match<document><chunk>[26]<blank-line>, @chunk[32];
    is-deeply ~$match<document><chunk>[27]<paragraph>, @chunk[33];
    is-deeply ~$match<document><chunk>[28]<blank-line>, @chunk[34];
    is-deeply ~$match<document><chunk>[29]<code-block>, @chunk[35];
    is-deeply ~$match<document><chunk>[30]<blank-line>, @chunk[36];
    is-deeply ~$match<document><chunk>[31]<blank-line>, @chunk[37];
    is-deeply ~$match<document><chunk>[32]<reference-block>, @chunk[38];
    ok $match<document><chunk>[33].isa(Any);

    # end @chunk tests }}}
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
