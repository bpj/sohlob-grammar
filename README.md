# sohlob-grammar

A project to write a coherent description of my Sohlob [conlang]() family.

Please note that this is a work of fiction!

Each chapter is a markdown file with a name like `010-some-title.md` in the [chapters](chapters) directory.

I start out by numbering the chapter *files* `0100,0200..`. This does by no means mean that there are going to be 9999 chapters, but rather that I want some free 'numberspace' between *files* so that I can split files or reorder/add chapters without having to `git mv` all the files.
I intend that when files get renamed (as opposed to split) a symlink with the old name will still be around (I use a little `find` magic in my makefile to make sure the symlink files don't get included when building the grammar with pandoc).

These are going to be rendered into LaTeX and thence PDF, and quite possibly HTML as well, using [pandoc](http://pandoc.org) (its Github repository is [here](https://github.com/jgm/pandoc)) and a bunch of filters and other scripts, some of which may be not yet written and/or live in other repositories, which I will include as subtrees as need arises.

Note that in spite of having an `.md` suffix, allowing the GitHub renderer to render them as best it can, the chapters are written in pandoc's Markdown 'dialect' which has more and partly different extensions from GitHub's.
In particular pandoc supports YAML metadata blocks and filters as well as inline LaTeX markup.

Note that the inline and block 'code' which occurs in the chapter texts isn't meant to be code examples at all, but are intended to be rendered into more or less ordinary text by pandoc filters. This is true even of those 'code' chunks which have no pandoc-style attributes; there is going to be a filter which knows how to have them rendered based on whether their content contains certain bespoke markup, including but not limited to:


*  `` `[...]` `` or `` `/.../` ``

    Phonetic/phonemic transcription (partly) in a dialect of [CXS]().
    
*  `` `$...$` ``

    Variable defined in YAML metadata blocks and filled in by a filter.

*  `` `_..._` ``

    An ASCII transcription to be rendered into Unicode Latin script characters and combining diacritics, dubbed ["BASCII"]().
    Most ASCII punctuation characters are used as '[sigils]()' or translate into combining diacritics, hopefully transparently, while literal punctuation characters are written prefixed by a doublequote, like `"/` for slash versus `/` for acute accent. The asterisk is the only punctuation character guaranteed to always be literal in "BASCII", for reasons which should be obvious to anyone interested in historical linguistics! Curly brackets are used for "markup within the markup", e.g. `{-...-}` for underlined. Superscript and subscript numbers are written like `^1` or `_2`
    May contain occasional non-ASCII characters, and in fact all Unicode punctuation and symbol characters (General Categories P and S), are reserved for future use as special characters as and when devices support them. BTW any character including doublequote itself can be prefixed with a doublequote to render it literally, though only ASCII characters and actually used special characters are supported in the keymap. Currently `€` is slated to become a sigil for Greek letters.
    
*  `` `^...^` ``

    Similar to "BASCII" but bespoke to Greek, dubbed ["GRASCII"]. Don't get me started on why I don't like [BetaCode]()! (They could start by swapping X and C: Ξενοφῶν -> `XENOFW=N` and Ἀχιλλεύς -> `ACILLEU/S`, which is similar to how those letters are rendered in normal Latin transcription.) "GRASCII" used to write most diacritics as prefixes and use precomposed accented characters but that is slated to change, except that `ha` etc. will map to the proper Greek vowels followed by a combining rough breathing.

*  `` `<...>` ``

    Graphemic transcription. May contain "BASCII".
    
*  `` `|...|` ``

    Small caps. May contain "BASCII".
    
*  `` `{_..._}` ``

    Sohlob alphabet script in [the strict ASCII transliteration]().
    
*  `` `{*...*}` ``

    If lowercase Kijeb syllabary script in [the strict ASCII transliteration]().

    If uppercase Old Cidilib syllabary script in [the strict ASCII transliteration]().
    
*  `` `...` ``

    Assumed to be "BASCII" unless otherwise marked.


The point of BXS, BASCII, GRASCII and similar is that I write some stuff on various handheld devices where entering Unicode (especially combining marks) properly is hard or impossible. When on a proper computer I have [Vim keymaps]() built on the same notations which I use to enter proper Unicode.

--------------------------------------------------------------------------------

Sohlob Grammar (c) by Benct Philip Jonsson

The text of Sohlob Grammar and other non-software content are licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>. 

--------------------------------------------------------------------------------

Software content is licensed under the MIT license.

--------------------------------------------------------------------------------
