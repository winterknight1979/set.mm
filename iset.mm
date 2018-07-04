$( iset.mm - Version of 2-Jul-2018

Created by Mario Carneiro, starting from the 21-Jan-2015 version of
set.mm

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
         Metamath source file for intuitionistic logic and set theory
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

                           ~~ PUBLIC DOMAIN ~~
This work is waived of all rights, including copyright, according to the CC0
Public Domain Dedication.  http://creativecommons.org/publicdomain/zero/1.0/

Maintainer and default contributor:

NM  Norman Megill - http://us.metamath.org/email.html

Contributor list:

DA  David Abernethy      DH  David Harvey           MO  Mel L. O'Cat
SA  Stefan Allan         JH  Jeff Hoffman           SO  Stefan O'Rear
JA  Juha Arpiainen       SJ  Szymon Jaroszewicz     JO  Jason Orendorff
JBN Jonathan Ben-Naim    WL  Wolf Lammen            JP  Josh Purinton
GB  Gregory Bush         GL  Gerard Lang            SR  Steve Rodriguez
MC  Mario Carneiro       RL  Raph Levien            ATS Andrew Salmon
PC  Paul Chapman         FL  Frederic Line          AS  Alan Sare
SF  Scott Fenton         RFL Roy F. Longton         ES  Eric Schmidt
JGH Jeffrey Hankins      JM  Jeff Madsen            DAW David A. Wheeler
AH  Anthony Hart         RM  Rodolfo Medina         GD  Georgy Dunaev

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                          Contents of this header
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

1. Recent label changes
2. Quick "How To"
3. Bibliography
4. Metamath syntax summary
5. Other notes
6. Acceptable shorter proofs

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                          1. Recent label changes
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

This is part of an ongoing project to improve naming consistency.  If you have
suggestions for better names, let me know.

If you are keeping proofs outside the master version of this file, you can
make global substitutions into your local version by processing the
ones WITHOUT "Notes" in _reverse_ order.  The ones WITH "Notes" may have to be
processed manually.

DONE:
Date      Old       New         Notes
23-May-18 sb8eu     sb8euh
23-May-18 sb8e      sb8eh
23-May-18 sb8       sb8h
10-May-18 sbf       sbh
9-May-18  sbied     sbiedh
6-May-18  alrimi    alrimih
6-May-18  cbvex     cbvexh
6-May-18  cbval     cbvalh
6-May-18  sbco2     sbco2h
6-May-18  sbie      sbieh
6-May-18  cbv3      cbv3h
17-Apr-18 con1bidc  con1biimdc
10-Feb-18 ax-6      hbn1
10-Feb-18 hbn1OLD   hbn1
10-Feb-18 a6e       ---         deleted; use sp, 19.9, and nfa1
10-Feb-18 ax-9o     ax9o
10-Feb-18 ax6o      ---         deleted; this was unused
10-Feb-18 ax-6o     ---         deleted; this was unused
10-Feb-18 ax6       ---         deleted; never was intuitionistic
10-Feb-18 modal-b   ---         deleted; never was intuitionistic
10-Feb-18 ax9       ---         deleted; never was intuitionistic
10-Feb-18 ax-i11e   ax11e
21-Dec-17 equid1    equid
28-Jan-15 strssd    [--same--]  moved from NM's mathbox to main set.mm
(older changes in set.mm than the above have already been applied to iset.mm;
newer changes in set.mm might be worth applying here)


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                           2. Quick "How To"
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

How to use this file under Windows 95/98/NT/2K/XP/Vista:

1. Download the program metamath.exe per the instructions on the
   Metamath home page (http://us.metamath.org) and put it in the same
   directory as this file (set.mm).
2. In Windows Explorer, double-click on metamath.exe.
3. Type "read set.mm" and press Enter.
4. Type "help" for a list of help topics, and "help demo" for some
   command examples.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                             3. Bibliography
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Bibliographical references are made by bracketing an identifer in a theorem's
comment, such as [RussellWhitehead].  These refer to HTML tags on the following
web pages:

  Logic and set theory - see http://us.metamath.org/mpegif/mmset.html#bib
  Hilbert space - see http://us.metamath.org/mpegif/mmhil.html#ref


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                      4. Metamath syntax summary
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

The HELP LANGUAGE command in the Metamath program will give you a quick
overview of Metamath.  Syntax summary:

          $c ... $. - Constant declaration
          $v ... $. - Variable declaration
          $d ... $. - Disjoint (distinct) variable restriction
  <label> $f ... $. - "Floating" hypothesis (i.e. variable type declaration)
  <label> $e ... $. - "Essential" hypothesis (i.e. a logical assumption for a
                      theorem or axiom)
  <label> $a ... $. - Axiom or definition or syntax construction
  <label> $p ... $= ... $. - Theorem and its proof
          ${ ... $} - Block for defining the scope of the above statements
                      (except $a, $p which are forever active)
$)        $( ... $)
$(                  - Comments (may not be nested); see HELP LANGUAGE
                      for markup features
          $[ ... $] - Include a file

The above two-character sequences beginning with "$" are the only primitives
built into the Metamath language.  The only "logic" Metamath uses in its proof
verification algorithm is the substitution of expressions for variables while
checking for distinct variable violations.  Everything else, including the
axioms for logic, is defined in this database file.

Here is some more detail about the syntax.  There are two kinds of user-defined
syntax elements, called math symbols (or just symbols) and labels.  A symbol
may contain any non-whitespace printable character except "$".  A label may
contain only alphanumeric characters and the characters "."  (period), "-"
(hyphen), and "_" (underscore).  Tokens and labels are case-sensitive.  All
labels (except in proofs) must be distinct.  A label may not have the same name
as a token (to simplify the coding of certain parsers and translators).

  $c <symbollist> $.
      <symbollist> is a (whitespace-separated) list of distinct symbols that
      haven't been used before.
  $v <symbollist> $.
      <symbollist> is a list of distinct symbols that haven't been used yet
      in the current scope (see ${ ... $} below).
  $d <symbollist> $.
      <symbollist> is a (whitespace-separated) list of distinct symbols
      previously declared with $v in current scope.  It means that
      substitutions into these symbols may not have variables in common.
  <label> $f <symbollist> $.
      <symbollist> is a list of 2 symbols, the first of which must be
      previously declared with $c in the current scope.
  <label> $e <symbollist> $.
      <symbollist> is a list of 2 or more symbols, the first of which must be
      previously declared with $c in the current scope.
  <label> $a <symbollist> $.
      <symbollist> is a list of 2 or more symbols, the first of which must be
      previously declared with $c in the current scope.
  <label> $p <symbollist> $= <proof> $.
      <symbollist> is a list of 2 or more symbols, the first of which must be
      previously declared with $c in the current scope.  <proof> is either a
      whitespace-delimited sequence of previous labels (created by
      SAVE PROOF <label> /NORMAL) or a compressed proof (created by
      SAVE PROOF <label> /COMPRESSED).  After using SAVE PROOF, use
      WRITE SOURCE to save the database file to disk.
  ${ ... $}
      Block for scoping the above statements (except $a, $p which are forever
      active).  Currently, $c may not occur inside of a block.
$)
  $( <any text> $)
$(    Comment.  Note: <any text> may not contain adjacent "$" and ")"
      characters.
  $[ <filename> $]
      Insert contents of <filename> at this point.  If <filename> is current
      file or has been already been inserted, it will not be inserted again.

Inside of comments, it is recommended that labels be preceded with a tilde (~)
and math symbol tokens be enclosed in grave accents (` `).  This way the LaTeX
and HTML rendition of comments will be accurate, and (future) tools to globally
change labels and math symbols will also change them in comments.  Note that ``
inside of grave accents is interpreted as a single ` .  A special comment
containing $ t defines LaTeX and HTML symbols.  See HELP LANGUAGE and
HELP HTML for other markup features in comments.

The proofs in this file are in "compressed" format for storage efficiency.  The
Metamath program reads the compressed format directly.  This format is
described in an Appendix of the Metamath book.  It is not intended to be read
by humans.  For viewing proofs you should use the various SHOW PROOF commands
described in the Metamath book (or the on-line HELP).

The Metamath program does not normally affect any content of this file (set.mm)
other than proofs, i.e. tokens between "$=" and "$.".  All other content is
user-created.  Proofs are created or modified with the PROVE command.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                          5. Other notes
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

1. It is recommended that you be familiar with chapters 2 and 4 of the
'Metamath' book to understand the Metamath language.  Chapters 2, 3 and 5
explain how to use the program.  Chapter 3 gives you an informal overview of
what this source file is all about.  Appendix A shows you the standard
mathematical symbols corresponding to some of the ASCII tokens in this file.

The ASCII tokens may seem cryptic at first, even if you are familiar with set
theory, but a review of the definition summary in Chapter 3 should quickly
enable you to see the correspondence to standard mathematical notation.  To
easily find the definition of a token, search for the first occurrences of the
token surrounded by spaces.  Some odd-looking ones include "-." for "not", and
"C_" for "is a subset of."  (HELP TEX tells you how to obtain a LaTeX output to
see the real mathematical symbols.)  Let me know if you have better suggestions
for naming ASCII tokens.

2. Logic and set theory provide a foundation for all of mathematics.  To learn
about them, you should study one or more of the references listed below.  The
textbooks provide a motivation for what we are doing, whereas Metamath lets you
see in detail all hidden and implicit steps.  Most standard theorems are
accompanied by citations.  Some closely followed texts include the following:

  Axioms of propositional calculus - [Margaris].
  Axioms of predicate calculus - [Megill] (System S3' in the article
      referenced).
  Theorems of propositional calculus - [WhiteheadRussell].
  Theorems of pure predicate calculus - [Margaris].
  Theorems of equality and substitution - [Monk2], [Tarski], [Megill].
  Axioms of set theory - [BellMachover].
  Development of set theory - [TakeutiZaring].  (The first part of [Quine]
      has a good explanation of the powerful device of "virtual" or
      class abstractions, which is essential to our development.)
  Construction of real and complex numbers - [Gleason]
  Theorems about real numbers - [Apostol]
  Intuitionistic logic and constructive mathematics - [Bauer] is an sampling
    of theorems and arguments which give a flavor of constructive mathematics.
    [Heyting] is a more comprehensive treatment of intuitionistic logic.

3. Convention:  All $a statements starting with "|-" have labels
starting with "ax-" (axioms) or "df-" (definitions).  "ax-" corresponds
to what is traditionally called an axiom.  "df-" introduces new symbols
or a new relationship among symbols that can be eliminated; they always
extend the definition of a wff or class.  Metamath blindly treats $a
statements as new given facts but does not try to justify them.  The
mmj2 program will justify the definitions as sound, except for 5 (df-bi,
df-cleq, df-clel, df-clab, df-sbc) that require a more complex metalogical
justification by hand.

4. Our method of definition, the axioms for predicate calculus, and the
development of substitution are somewhat different from those found in standard
texts.  The axioms were designed for direct derivation of standard results
without excessive use of metatheorems.  (See Theorem 9.7 of [Megill] for a
rigorous justification.)  Typically we are minimalist when introducing new
definitions; they are introduced only when a clear advantage becomes apparent
for reducing the number of symbols, shortening proofs, etc.  We generally avoid
the introduction of gratuitous definitions because each one requires associated
theorems and additional elimination steps in proofs.

5. Where possible, the notation attempts to conform to modern conventions, with
variations due to our choice of the axiom system or to make proofs shorter.
Listed below are some important conventions and how they correspond to textbook
language.  The notation is usually explained in more detail when first
introduced.

  Typically, Greek letters (ph = phi, ps = psi, ch = chi, etc.) are used for
      propositional (wff) variables; x,y,z,... for individual (i.e. set)
      variables; and A,B,C,... for class variables.
  "|-", meaning "It is provable that," is the first token of all assertions
      and hypotheses that aren't syntax constructions.  This is a standard
      convention in logic.  For us, it also prevents any ambiguity with
      statements that are syntax constructions, such as "wff -. ph".
  "$e |- ( ph -> A. x ph ) $." should be read "Assume variable x is
      (effectively) not free in wff phi."  Literally, this says "Assume it is
      provable that phi implies for all x phi."
  "|- ( -. A. x x = y -> ..." should be read "If x and y are distinct
      variables, then..."  This antecedent provides us with a technical
      device (called a "distinctor" in [Megill]) to avoid the need for the
      $d statement early in our development of predicate calculus, permitting
      unrestricted substitituions as conceptually simple as those in
      propositional calculus.  However, the $d eventually becomes a
      requirement, and after that this device is rarely used.
  "[ y / x ] ph" should be read "the wff that results when y is properly
      substituted for x in ph."
  "$d x y $." should be read "Assume x and y are distinct variables."
  "$d x ph $." should be read "Assume x does not occur in phi $."  Sometimes
      a theorem is proved with "$e |- ( ph -> A. x ph ) $." in place of
      "$d x ph $." when a more general result is desired; ~ ax-17 can be used
      to derive the $d version.  For an example of how to get from the $d
      version back to the $e version, see the proof of ~ euf from ~ df-eu .
  "$d x A $." should be read "Assume x is not a variable occurring in class A."
  "$d x A $.  $d x ps $.  $e |- ( x = A -> ( ph <-> ps ) ) $." is an idiom
      often used instead of explicit substitution, meaning "Assume psi results
      from the substitution of A for x in phi."
  "$e |- A e. _V $." should be read "Assume class A is a set (i.e. exists)."
      This is a convenient convention used by [Quine].
  "$d x y $.  $e |- y e. A -> A. x y e. A $." should be read "Assume x is
      (effectively) not a free variable in class A."
  "`' R" should be read "converse of (relation) R" and is the same as the more
      standard notation R^{-1}.
  "( f ` x )" should be read "the value of function f at x" and is the same as
      the more familiar f(x).
  The Deduction Theorem of standard logic is never used.  Instead, in set
      theory, we use other tricks to make a $e hypothesis become an antecedent.
      See the comment for theorem ~ dedth below.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
           6. Acceptable shorter proofs
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Shorter proofs are welcome, and any shorter proof I accept will be acknowledged
in the theorem's description.  However, in some cases a proof may be "shorter"
or not depending on how it is formatted.  This section provides general
guidelines.

Usually I will automatically accept shorter proofs that (1) shorten the set.mm
file (with compressed proofs), (2) reduce the size of the HTML file generated
with SHOW STATEMENT xx / HTML, (3) use only existing, unmodified theorems in
the database (the order of theorems may be changed, though), and (4) use no
additional axioms.

Usually I will also automatically accept a _new_ theorem that is used to
shorten multiple proofs, if the total size of set.mm (including the comment of
the new theorem, not including the acknowledgment) decreases as a result.

In borderline cases, I typically place more importance on the number of
compressed proof steps and less on the length of the label section (since the
names are in principal arbitrary).  If two proofs have the same number of
compressed proof steps, I will typically give preference to the one with the
smaller number of different labels, or if these numbers are the same, the proof
with the fewest number of characters that the proofs happen to have by chance
when label lengths are included.

A few theorems have a longer proof than necessary in order to avoid the use of
certain axioms, for pedagogical purposes, and for other reasons.  Usually this
is clear from the theorem's description.  For example, id1 shows a proof
directly from axioms.  Shorter proofs for such cases won't be accepted, of
course, unless the criteria described continues to be satisfied.

$)


$(
###############################################################################
            FIRST ORDER LOGIC WITH EQUALITY
###############################################################################
$)

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
                           Pre-logic
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

  $( Declare the primitive constant symbols for propositional calculus. $)
  $c ( $.  $( Left parenthesis $)
  $c ) $.  $( Right parenthesis $)
  $c -> $. $( Right arrow (read:  "implies") $)
  $c -. $. $( Right handle (read:  "not") $)
  $c wff $. $( Well-formed formula symbol (read:  "the following symbol
               sequence is a wff") $)
  $c |- $. $( Turnstile (read:  "the following symbol sequence is provable" or
              'a proof exists for") $)

  $( wff variable sequence:  ph ps ch th ta et ze si rh mu la ka $)
  $( Introduce some variable names we will use to represent well-formed
     formulas (wff's). $)
  $v ph $.  $( Greek phi $)
  $v ps $.  $( Greek psi $)
  $v ch $.  $( Greek chi $)
  $v th $.  $( Greek theta $)
  $v ta $.  $( Greek tau $)
  $v et $.  $( Greek eta $)
  $v ze $.  $( Greek zeta $)
  $v si $.  $( Greek sigma $)
  $v rh $.  $( Greek rho $)
  $v mu $.  $( Greek mu $)
  $v la $.  $( Greek lambda $)
  $v ka $.  $( Greek kappa $)

  $( Specify some variables that we will use to represent wff's.
     The fact that a variable represents a wff is relevant only to a theorem
     referring to that variable, so we may use $f hypotheses.  The symbol
     ` wff ` specifies that the variable that follows it represents a wff. $)
  $( Let variable ` ph ` be a wff. $)
  wph $f wff ph $.
  $( Let variable ` ps ` be a wff. $)
  wps $f wff ps $.
  $( Let variable ` ch ` be a wff. $)
  wch $f wff ch $.
  $( Let variable ` th ` be a wff. $)
  wth $f wff th $.
  $( Let variable ` ta ` be a wff. $)
  wta $f wff ta $.
  $( Let variable ` et ` be a wff. $)
  wet $f wff et $.
  $( Let variable ` ze ` be a wff. $)
  wze $f wff ze $.
  $( Let variable ` si ` be a wff. $)
  wsi $f wff si $.
  $( Let variable ` rh ` be a wff. $)
  wrh $f wff rh $.
  $( Let variable ` mu ` be a wff. $)
  wmu $f wff mu $.
  $( Let variable ` la ` be a wff. $)
  wla $f wff la $.
  $( Let variable ` ka ` be a wff. $)
  wka $f wff ka $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                 Inferences for assisting proof development
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    dummylink.1 $e |- ph $.
    dummylink.2 $e |- ps $.
    $( (_Note_:  This inference rule and the next one, ~ idi , will normally
       never appear in a completed proof.  It can be ignored if you are using
       this database to assist learning logic - please start with the statement
       ~ wn instead.)

       This is a technical inference to assist proof development.  It provides
       a temporary way to add an independent subproof to a proof under
       development, for later assignment to a normal proof step.

       The metamath program's Proof Assistant requires proofs to be developed
       backwards from the conclusion with no gaps, and it has no mechanism that
       lets the user to work on isolated subproofs.  This inference provides a
       workaround for this limitation.  It can be inserted at any point in a
       proof to allow an independent subproof to be developed on the side, for
       later use as part of the final proof.

       _Instructions_:  (1) Assign this inference to any unknown step in the
       proof.  Typically, the last unknown step is the most convenient, since
       'assign last' can be used.  This step will be replicated in hypothesis
       dummylink.1, from where the development of the main proof can continue.
       (2) Develop the independent subproof backwards from hypothesis
       dummylink.2.  If desired, use a 'let' command to pre-assign the
       conclusion of the independent subproof to dummylink.2.  (3) After the
       independent subproof is complete, use 'improve all' to assign it
       automatically to an unknown step in the main proof that matches it.  (4)
       After the entire proof is complete, use 'minimize *' to clean up
       (discard) all dummylink references automatically.

       This inference was originally designed to assist importing partially
       completed Proof Worksheets from the mmj2 Proof Assistant GUI, but it can
       also be useful on its own.  Interestingly, no axioms are required for
       its proof.  (Contributed by NM, 7-Feb-2006.) $)
    dummylink $p |- ph $=
      (  ) C $.
  $}

  ${
    idi.1 $e |- ph $.
    $( Inference form of ~ id .  This inference rule, which requires no axioms
       for its proof, is useful as a copy-paste mechanism during proof
       development in mmj2.  It is normally not referenced in the final version
       of a proof, since it is always redundant and can be removed using the
       'minimize *' command in the metamath program's Proof Assistant.
       (Contributed by Alan Sare, 31-Dec-2011.) $)
    idi $p |- ph $=
      (  ) B $.
  $}

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
                           Propositional calculus
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Recursively define primitive wffs for propositional calculus
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( If ` ph ` is a wff, so is ` -. ph ` or "not ` ph ` ."  Part of the
     recursive definition of a wff (well-formed formula).  Traditionally, Greek
     letters are used to represent wffs, and we follow this convention.  In
     propositional calculus, we define only wffs built up from other wffs, i.e.
     there is no starting or "atomic" wff.  Later, in predicate calculus, we
     will extend the basic wff definition by including atomic wffs ( ~ weq and
     ~ wel ). $)
  wn $a wff -. ph $.

  $( If ` ph ` and ` ps ` are wff's, so is ` ( ph -> ps ) ` or " ` ph ` implies
     ` ps ` ."  Part of the recursive definition of a wff.  The left-hand wff
     is called the antecedent, and the right-hand wff is called the
     consequent.  In the case of ` ( ph -> ( ps -> ch ) ) ` , the middle ` ps `
     may be informally called either an antecedent or part of the consequent
     depending on context. $)
  wi $a wff ( ph -> ps ) $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
             Propositional logic axioms for implication
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Axiom _Simp_.  Axiom A1 of [Margaris] p. 49.  One of the axioms of
     propositional calculus.  This axiom is called _Simp_ or "the principle of
     simplification" in _Principia Mathematica_ (Theorem *2.02 of
     [WhiteheadRussell] p. 100) because "it enables us to pass from the joint
     assertion of ` ph ` and ` ps ` to the assertion of ` ph ` simply."

     The theorems of propositional calculus are also called _tautologies_.
     Although classical propositional logic tautologies can be proved using
     truth tables, there is no similarly simple system for intuitionistic
     propositional logic, so proving tautologies from axioms is the preferred
     approach.  (Contributed by NM, 5-Aug-1993.) $)
  ax-1 $a |- ( ph -> ( ps -> ph ) ) $.

  $( Axiom _Frege_.  Axiom A2 of [Margaris] p. 49.  This axiom "distributes" an
     antecedent over two consequents.  This axiom was part of Frege's original
     system and is known as _Frege_ in the literature.  It is also proved as
     Theorem *2.77 of [WhiteheadRussell] p. 108.  The other direction of this
     axiom also turns out to be true, as demonstrated by ~ pm5.41 .
     (Contributed by NM, 5-Aug-1993.) $)
  ax-2 $a |- ( ( ph -> ( ps -> ch ) ) -> ( ( ph -> ps ) -> ( ph -> ch ) ) ) $.

  $(
     Postulate the modus ponens rule of inference.
  $)

  ${
    $( Minor premise for modus ponens. $)
    min $e |- ph $.
    $( Major premise for modus ponens. $)
    maj $e |- ( ph -> ps ) $.
    $( Rule of Modus Ponens.  The postulated inference rule of propositional
       calculus.  See e.g.  Rule 1 of [Hamilton] p. 73.  The rule says, "if
       ` ph ` is true, and ` ph ` implies ` ps ` , then ` ps ` must also be
       true."  This rule is sometimes called "detachment," since it detaches
       the minor premise from the major premise.

       Note:  In some web page displays such as the Statement List, the symbols
       "&" and "=>" informally indicate the relationship between the hypotheses
       and the assertion (conclusion), abbreviating the English words "and" and
       "implies."  They are not part of the formal language.  (Contributed by
       NM, 5-Aug-1993.) $)
    ax-mp $a |- ps $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Logical implication
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   The results in this section are based on implication only, and only use
   ~ ax-1 , ~ ax-2 , and ~ ax-mp .
   In an implication, the wff before the arrow is called the "antecedent" and
   the wff after the arrow is called the "consequent."

   We will use the following descriptive terms very loosely:  A "closed form"
   or "tautology" has no $e hypotheses.  An "inference" has one or more $e
   hypotheses.  A "deduction" is an inference in which the hypotheses and the
   conclusion share the same antecedent.
$)

  ${
    mp2b.1 $e |- ph $.
    mp2b.2 $e |- ( ph -> ps ) $.
    mp2b.3 $e |- ( ps -> ch ) $.
    $( A double modus ponens inference.  (Contributed by Mario Carneiro,
       24-Jan-2013.) $)
    mp2b $p |- ch $=
      ( ax-mp ) BCABDEGFG $.
  $}

  ${
    $( Premise for ~ a1i . $)
    a1i.1 $e |- ph $.
    $( Inference derived from axiom ~ ax-1 .  See ~ a1d for an explanation of
       our informal use of the terms "inference" and "deduction."  See also the
       comment in ~ syld .  (Contributed by NM, 5-Aug-1993.) $)
    a1i $p |- ( ps -> ph ) $=
      ( wi ax-1 ax-mp ) ABADCABEF $.
  $}

  ${
    $( Premise for ~ a2i . $)
    a2i.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Inference derived from axiom ~ ax-2 .  (Contributed by NM,
       5-Aug-1993.) $)
    a2i $p |- ( ( ph -> ps ) -> ( ph -> ch ) ) $=
      ( wi ax-2 ax-mp ) ABCEEABEACEEDABCFG $.
  $}

  ${
    imim2i.1 $e |- ( ph -> ps ) $.
    $( Inference adding common antecedents in an implication.  (Contributed by
       NM, 5-Aug-1993.) $)
    imim2i $p |- ( ( ch -> ph ) -> ( ch -> ps ) ) $=
      ( wi a1i a2i ) CABABECDFG $.
  $}

  ${
    mpd.1 $e |- ( ph -> ps ) $.
    mpd.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( A modus ponens deduction.  (Contributed by NM, 5-Aug-1993.) $)
    mpd $p |- ( ph -> ch ) $=
      ( wi a2i ax-mp ) ABFACFDABCEGH $.
  $}

  ${
    $( First of 2 premises for ~ syl . $)
    syl.1 $e |- ( ph -> ps ) $.
    $( Second of 2 premises for ~ syl . $)
    syl.2 $e |- ( ps -> ch ) $.
    $( An inference version of the transitive laws for implication ~ imim2 and
       ~ imim1 , which Russell and Whitehead call "the principle of the
       syllogism...because...the syllogism in Barbara is derived from them"
       (quote after Theorem *2.06 of [WhiteheadRussell] p. 101).  Some authors
       call this law a "hypothetical syllogism."  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by O'Cat, 20-Oct-2011.)  (Proof shortened
       by Wolf Lammen, 26-Jul-2012.) $)
    syl $p |- ( ph -> ch ) $=
      ( wi a1i mpd ) ABCDBCFAEGH $.
  $}

  ${
    mpi.1 $e |- ps $.
    mpi.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( A nested modus ponens inference.  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Stefan Allan, 20-Mar-2006.) $)
    mpi $p |- ( ph -> ch ) $=
      ( a1i mpd ) ABCBADFEG $.
  $}

  ${
    mp2.1 $e |- ph $.
    mp2.2 $e |- ps $.
    mp2.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( A double modus ponens inference.  (Contributed by NM, 5-Apr-1994.)
       (Proof shortened by Wolf Lammen, 23-Jul-2013.) $)
    mp2 $p |- ch $=
      ( mpi ax-mp ) ACDABCEFGH $.
  $}

  ${
    3syl.1 $e |- ( ph -> ps ) $.
    3syl.2 $e |- ( ps -> ch ) $.
    3syl.3 $e |- ( ch -> th ) $.
    $( Inference chaining two syllogisms.  (Contributed by NM, 5-Aug-1993.) $)
    3syl $p |- ( ph -> th ) $=
      ( syl ) ACDABCEFHGH $.
  $}

  $( Principle of identity.  Theorem *2.08 of [WhiteheadRussell] p. 101.  For
     another version of the proof directly from axioms, see ~ id1 .
     (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Stefan Allan,
     20-Mar-2006.) $)
  id $p |- ( ph -> ph ) $=
    ( wi ax-1 mpd ) AAABZAAACAECD $.

  $( Principle of identity.  Theorem *2.08 of [WhiteheadRussell] p. 101.  This
     version is proved directly from the axioms for demonstration purposes.
     This proof is a popular example in the literature and is identical, step
     for step, to the proofs of Theorem 1 of [Margaris] p. 51, Example 2.7(a)
     of [Hamilton] p. 31, Lemma 10.3 of [BellMachover] p. 36, and Lemma 1.8 of
     [Mendelson] p. 36.  It is also "Our first proof" in Hirst and Hirst's _A
     Primer for Logic and Proof_ p. 17 (PDF p. 23) at
     ~ http://www.mathsci.appstate.edu/~~jlh/primer/hirst.pdf .  For a shorter
     version of the proof that takes advantage of previously proved theorems,
     see ~ id .  (Contributed by NM, 5-Aug-1993.) $)
  id1 $p |- ( ph -> ph ) $=
    ( wi ax-1 ax-2 ax-mp ) AAABZBZFAACAFABBGFBAFCAFADEE $.

  $( Principle of identity with antecedent.  (Contributed by NM,
     26-Nov-1995.) $)
  idd $p |- ( ph -> ( ps -> ps ) ) $=
    ( wi id a1i ) BBCABDE $.

  ${
    a1d.1 $e |- ( ph -> ps ) $.
    $( Deduction introducing an embedded antecedent.  (The proof was revised by
       Stefan Allan, 20-Mar-2006.)

       _Naming convention_:  We often call a theorem a "deduction" and suffix
       its label with "d" whenever the hypotheses and conclusion are each
       prefixed with the same antecedent.  This allows us to use the theorem in
       places where (in traditional textbook formalizations) the standard
       Deduction Theorem would be used; here ` ph ` would be replaced with a
       conjunction ( ~ wa ) of the hypotheses of the would-be deduction.  By
       contrast, we tend to call the simpler version with no common antecedent
       an "inference" and suffix its label with "i"; compare theorem ~ a1i .
       Finally, a "theorem" would be the form with no hypotheses; in this case
       the "theorem" form would be the original axiom ~ ax-1 .  We usually show
       the theorem form without a suffix on its label (e.g. ~ pm2.43 vs.
       ~ pm2.43i vs. ~ pm2.43d ).  (Contributed by NM, 5-Aug-1993.)  (Revised
       by NM, 20-Mar-2006.) $)
    a1d $p |- ( ph -> ( ch -> ps ) ) $=
      ( wi ax-1 syl ) ABCBEDBCFG $.
  $}

  ${
    a2d.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( Deduction distributing an embedded antecedent.  (Contributed by NM,
       23-Jun-1994.) $)
    a2d $p |- ( ph -> ( ( ps -> ch ) -> ( ps -> th ) ) ) $=
      ( wi ax-2 syl ) ABCDFFBCFBDFFEBCDGH $.
  $}

  ${
    a1ii.1 $e |- ch $.
    $( Add two antecedents to a wff.  (Contributed by Jeff Hankins,
       4-Aug-2009.)  (Proof shortened by Wolf Lammen, 23-Jul-2013.) $)
    a1ii $p |- ( ph -> ( ps -> ch ) ) $=
      ( a1i a1d ) ACBCADEF $.
  $}

  ${
    sylcom.1 $e |- ( ph -> ( ps -> ch ) ) $.
    sylcom.2 $e |- ( ps -> ( ch -> th ) ) $.
    $( Syllogism inference with commutation of antecedents.  (Contributed by
       NM, 29-Aug-2004.)  (Proof shortened by O'Cat, 2-Feb-2006.)  (Proof
       shortened by Stefan Allan, 23-Feb-2006.) $)
    sylcom $p |- ( ph -> ( ps -> th ) ) $=
      ( wi a2i syl ) ABCGBDGEBCDFHI $.
  $}

  ${
    syl5com.1 $e |- ( ph -> ps ) $.
    syl5com.2 $e |- ( ch -> ( ps -> th ) ) $.
    $( Syllogism inference with commuted antecedents.  (Contributed by NM,
       24-May-2005.) $)
    syl5com $p |- ( ph -> ( ch -> th ) ) $=
      ( a1d sylcom ) ACBDABCEGFH $.
  $}

  ${
    $( Premise for ~ com12 .  See ~ pm2.04 for the theorem form. $)
    com12.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Inference that swaps (commutes) antecedents in an implication.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       4-Aug-2012.) $)
    com12 $p |- ( ps -> ( ph -> ch ) ) $=
      ( id syl5com ) BBACBEDF $.
  $}

  ${
    syl5.1 $e |- ( ph -> ps ) $.
    syl5.2 $e |- ( ch -> ( ps -> th ) ) $.
    $( A syllogism rule of inference.  The second premise is used to replace
       the second antecedent of the first premise.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Wolf Lammen, 25-May-2013.) $)
    syl5 $p |- ( ch -> ( ph -> th ) ) $=
      ( syl5com com12 ) ACDABCDEFGH $.
  $}

  ${
    syl6.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl6.2 $e |- ( ch -> th ) $.
    $( A syllogism rule of inference.  The second premise is used to replace
       the consequent of the first premise.  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Wolf Lammen, 30-Jul-2012.) $)
    syl6 $p |- ( ph -> ( ps -> th ) ) $=
      ( wi a1i sylcom ) ABCDECDGBFHI $.
  $}

  ${
    syl56.1 $e |- ( ph -> ps ) $.
    syl56.2 $e |- ( ch -> ( ps -> th ) ) $.
    syl56.3 $e |- ( th -> ta ) $.
    $( Combine ~ syl5 and ~ syl6 .  (Contributed by NM, 14-Nov-2013.) $)
    syl56 $p |- ( ch -> ( ph -> ta ) ) $=
      ( syl6 syl5 ) ABCEFCBDEGHIJ $.
  $}

  ${
    syl6com.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl6com.2 $e |- ( ch -> th ) $.
    $( Syllogism inference with commuted antecedents.  (Contributed by NM,
       25-May-2005.) $)
    syl6com $p |- ( ps -> ( ph -> th ) ) $=
      ( syl6 com12 ) ABDABCDEFGH $.
  $}

  ${
    mpcom.1 $e |- ( ps -> ph ) $.
    mpcom.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Modus ponens inference with commutation of antecedents.  (Contributed by
       NM, 17-Mar-1996.) $)
    mpcom $p |- ( ps -> ch ) $=
      ( com12 mpd ) BACDABCEFG $.
  $}

  ${
    syli.1 $e |- ( ps -> ( ph -> ch ) ) $.
    syli.2 $e |- ( ch -> ( ph -> th ) ) $.
    $( Syllogism inference with common nested antecedent.  (Contributed by NM,
       4-Nov-2004.) $)
    syli $p |- ( ps -> ( ph -> th ) ) $=
      ( com12 sylcom ) BACDECADFGH $.
  $}

  ${
    syl2im.1 $e |- ( ph -> ps ) $.
    syl2im.2 $e |- ( ch -> th ) $.
    syl2im.3 $e |- ( ps -> ( th -> ta ) ) $.
    $( Replace two antecedents.  Implication-only version of ~ syl2an .
       (Contributed by Wolf Lammen, 14-May-2013.) $)
    syl2im $p |- ( ph -> ( ch -> ta ) ) $=
      ( wi syl5 syl ) ABCEIFCDBEGHJK $.
  $}

  $( This theorem, called "Assertion," can be thought of as closed form of
     modus ponens ~ ax-mp .  Theorem *2.27 of [WhiteheadRussell] p. 104.
     (Contributed by NM, 5-Aug-1993.) $)
  pm2.27 $p |- ( ph -> ( ( ph -> ps ) -> ps ) ) $=
    ( wi id com12 ) ABCZABFDE $.

  ${
    mpdd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    mpdd.2 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( A nested modus ponens deduction.  (Contributed by NM, 12-Dec-2004.) $)
    mpdd $p |- ( ph -> ( ps -> th ) ) $=
      ( wi a2d mpd ) ABCGBDGEABCDFHI $.
  $}

  ${
    mpid.1 $e |- ( ph -> ch ) $.
    mpid.2 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( A nested modus ponens deduction.  (Contributed by NM, 14-Dec-2004.) $)
    mpid $p |- ( ph -> ( ps -> th ) ) $=
      ( a1d mpdd ) ABCDACBEGFH $.
  $}

  ${
    mpdi.1 $e |- ( ps -> ch ) $.
    mpdi.2 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( A nested modus ponens deduction.  (Contributed by NM, 16-Apr-2005.)
       (Proof shortened by O'Cat, 15-Jan-2008.) $)
    mpdi $p |- ( ph -> ( ps -> th ) ) $=
      ( wi a1i mpdd ) ABCDBCGAEHFI $.
  $}

  ${
    mpii.1 $e |- ch $.
    mpii.2 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( A doubly nested modus ponens inference.  (Contributed by NM,
       31-Dec-1993.)  (Proof shortened by Wolf Lammen, 31-Jul-2012.) $)
    mpii $p |- ( ph -> ( ps -> th ) ) $=
      ( a1i mpdi ) ABCDCBEGFH $.
  $}

  ${
    syld.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syld.2 $e |- ( ph -> ( ch -> th ) ) $.
    $( Syllogism deduction.

       Notice that ~ syld has the same form as ~ syl with ` ph ` added in front
       of each hypothesis and conclusion.  When all theorems referenced in a
       proof are converted in this way, we can replace ` ph ` with a hypothesis
       of the proof, allowing the hypothesis to be eliminated with ~ id and
       become an antecedent.  The Deduction Theorem for propositional calculus,
       e.g.  Theorem 3 in [Margaris] p. 56, tells us that this procedure is
       always possible.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by
       O'Cat, 19-Feb-2008.)  (Proof shortened by Wolf Lammen, 3-Aug-2012.) $)
    syld $p |- ( ph -> ( ps -> th ) ) $=
      ( wi a1d mpdd ) ABCDEACDGBFHI $.
  $}

  ${
    mp2d.1 $e |- ( ph -> ps ) $.
    mp2d.2 $e |- ( ph -> ch ) $.
    mp2d.3 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( A double modus ponens deduction.  (Contributed by NM, 23-May-2013.)
       (Proof shortened by Wolf Lammen, 23-Jul-2013.) $)
    mp2d $p |- ( ph -> th ) $=
      ( mpid mpd ) ABDEABCDFGHI $.
  $}

  ${
    a1dd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction introducing a nested embedded antecedent.  (Contributed by NM,
       17-Dec-2004.)  (Proof shortened by O'Cat, 15-Jan-2008.) $)
    a1dd $p |- ( ph -> ( ps -> ( th -> ch ) ) ) $=
      ( wi ax-1 syl6 ) ABCDCFECDGH $.
  $}

  ${
    pm2.43i.1 $e |- ( ph -> ( ph -> ps ) ) $.
    $( Inference absorbing redundant antecedent.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by O'Cat, 28-Nov-2008.) $)
    pm2.43i $p |- ( ph -> ps ) $=
      ( id mpd ) AABADCE $.
  $}

  ${
    pm2.43d.1 $e |- ( ph -> ( ps -> ( ps -> ch ) ) ) $.
    $( Deduction absorbing redundant antecedent.  (Contributed by NM,
       18-Aug-1993.)  (Proof shortened by O'Cat, 28-Nov-2008.) $)
    pm2.43d $p |- ( ph -> ( ps -> ch ) ) $=
      ( id mpdi ) ABBCBEDF $.
  $}

  ${
    pm2.43a.1 $e |- ( ps -> ( ph -> ( ps -> ch ) ) ) $.
    $( Inference absorbing redundant antecedent.  (Contributed by NM,
       7-Nov-1995.)  (Proof shortened by O'Cat, 28-Nov-2008.) $)
    pm2.43a $p |- ( ps -> ( ph -> ch ) ) $=
      ( id mpid ) BABCBEDF $.
  $}

  ${
    pm2.43b.1 $e |- ( ps -> ( ph -> ( ps -> ch ) ) ) $.
    $( Inference absorbing redundant antecedent.  (Contributed by NM,
       31-Oct-1995.) $)
    pm2.43b $p |- ( ph -> ( ps -> ch ) ) $=
      ( pm2.43a com12 ) BACABCDEF $.
  $}

  $( Absorption of redundant antecedent.  Also called the "Contraction" or
     "Hilbert" axiom.  Theorem *2.43 of [WhiteheadRussell] p. 106.
     (Contributed by NM, 5-Aug-1993.)  (Proof shortened by O'Cat,
     15-Aug-2004.) $)
  pm2.43 $p |- ( ( ph -> ( ph -> ps ) ) -> ( ph -> ps ) ) $=
    ( wi pm2.27 a2i ) AABCBABDE $.

  ${
    imim2d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction adding nested antecedents.  (Contributed by NM,
       5-Aug-1993.) $)
    imim2d $p |- ( ph -> ( ( th -> ps ) -> ( th -> ch ) ) ) $=
      ( wi a1d a2d ) ADBCABCFDEGH $.
  $}

  $( A closed form of syllogism (see ~ syl ).  Theorem *2.05 of
     [WhiteheadRussell] p. 100.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 6-Sep-2012.) $)
  imim2 $p |- ( ( ph -> ps ) -> ( ( ch -> ph ) -> ( ch -> ps ) ) ) $=
    ( wi id imim2d ) ABDZABCGEF $.

  ${
    embantd.1 $e |- ( ph -> ps ) $.
    embantd.2 $e |- ( ph -> ( ch -> th ) ) $.
    $( Deduction embedding an antecedent.  (Contributed by Wolf Lammen,
       4-Oct-2013.) $)
    embantd $p |- ( ph -> ( ( ps -> ch ) -> th ) ) $=
      ( wi imim2d mpid ) ABCGBDEACDBFHI $.
  $}

  ${
    3syld.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3syld.2 $e |- ( ph -> ( ch -> th ) ) $.
    3syld.3 $e |- ( ph -> ( th -> ta ) ) $.
    $( Triple syllogism deduction.  (Contributed by Jeff Hankins,
       4-Aug-2009.) $)
    3syld $p |- ( ph -> ( ps -> ta ) ) $=
      ( syld ) ABDEABCDFGIHI $.
  $}

  ${
    sylsyld.1 $e |- ( ph -> ps ) $.
    sylsyld.2 $e |- ( ph -> ( ch -> th ) ) $.
    sylsyld.3 $e |- ( ps -> ( th -> ta ) ) $.
    $( Virtual deduction rule.  (Contributed by Alan Sare, 20-Apr-2011.) $)
    sylsyld $p |- ( ph -> ( ch -> ta ) ) $=
      ( wi syl syld ) ACDEGABDEIFHJK $.
  $}

  ${
    imim12i.1 $e |- ( ph -> ps ) $.
    imim12i.2 $e |- ( ch -> th ) $.
    $( Inference joining two implications.  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by O'Cat, 29-Oct-2011.) $)
    imim12i $p |- ( ( ps -> ch ) -> ( ph -> th ) ) $=
      ( wi imim2i syl5 ) ABBCGDECDBFHI $.
  $}

  ${
    imim1i.1 $e |- ( ph -> ps ) $.
    $( Inference adding common consequents in an implication, thereby
       interchanging the original antecedent and consequent.  (Contributed by
       NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 4-Aug-2012.) $)
    imim1i $p |- ( ( ps -> ch ) -> ( ph -> ch ) ) $=
      ( id imim12i ) ABCCDCEF $.
  $}

  ${
    imim3i.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Inference adding three nested antecedents.  (Contributed by NM,
       19-Dec-2006.) $)
    imim3i $p |- ( ( th -> ph ) -> ( ( th -> ps ) -> ( th -> ch ) ) ) $=
      ( wi imim2i a2d ) DAFDBCABCFDEGH $.
  $}

  ${
    sylc.1 $e |- ( ph -> ps ) $.
    sylc.2 $e |- ( ph -> ch ) $.
    sylc.3 $e |- ( ps -> ( ch -> th ) ) $.
    $( A syllogism inference combined with contraction.  (Contributed by NM,
       4-May-1994.)  (Revised by NM, 13-Jul-2013.) $)
    sylc $p |- ( ph -> th ) $=
      ( syl2im pm2.43i ) ADABACDEFGHI $.
  $}

  ${
    syl3c.1 $e |- ( ph -> ps ) $.
    syl3c.2 $e |- ( ph -> ch ) $.
    syl3c.3 $e |- ( ph -> th ) $.
    syl3c.4 $e |- ( ps -> ( ch -> ( th -> ta ) ) ) $.
    $( A syllogism inference combined with contraction.  (Contributed by Alan
       Sare, 7-Jul-2011.) $)
    syl3c $p |- ( ph -> ta ) $=
      ( wi sylc mpd ) ADEHABCDEJFGIKL $.
  $}

  ${
    syl6mpi.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl6mpi.2 $e |- th $.
    syl6mpi.3 $e |- ( ch -> ( th -> ta ) ) $.
    $( ~ syl6 combined with ~ mpi .  (Contributed by Alan Sare, 8-Jul-2011.)
       (Proof shortened by Wolf Lammen, 13-Sep-2012.) $)
    syl6mpi $p |- ( ph -> ( ps -> ta ) ) $=
      ( mpi syl6 ) ABCEFCDEGHIJ $.
  $}

  ${
    mpsyl.1 $e |- ph $.
    mpsyl.2 $e |- ( ps -> ch ) $.
    mpsyl.3 $e |- ( ph -> ( ch -> th ) ) $.
    $( Modus ponens combined with a syllogism inference.  (Contributed by Alan
       Sare, 20-Apr-2011.) $)
    mpsyl $p |- ( ps -> th ) $=
      ( a1i sylc ) BACDABEHFGI $.
  $}

  ${
    syl6c.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl6c.2 $e |- ( ph -> ( ps -> th ) ) $.
    syl6c.3 $e |- ( ch -> ( th -> ta ) ) $.
    $( Inference combining ~ syl6 with contraction.  (Contributed by Alan Sare,
       2-May-2011.) $)
    syl6c $p |- ( ph -> ( ps -> ta ) ) $=
      ( wi syl6 mpdd ) ABDEGABCDEIFHJK $.
  $}

  ${
    syldd.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    syldd.2 $e |- ( ph -> ( ps -> ( th -> ta ) ) ) $.
    $( Nested syllogism deduction.  (Contributed by NM, 12-Dec-2004.)  (Proof
       shortened by Wolf Lammen, 11-May-2013.) $)
    syldd $p |- ( ph -> ( ps -> ( ch -> ta ) ) ) $=
      ( wi imim2 syl6c ) ABDEHCDHCEHGFDECIJ $.
  $}

  ${
    syl5d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl5d.2 $e |- ( ph -> ( th -> ( ch -> ta ) ) ) $.
    $( A nested syllogism deduction.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Josh Purinton, 29-Dec-2000.)  (Proof shortened by O'Cat,
       2-Feb-2006.) $)
    syl5d $p |- ( ph -> ( th -> ( ps -> ta ) ) ) $=
      ( wi a1d syldd ) ADBCEABCHDFIGJ $.
  $}

  ${
    syl7.1 $e |- ( ph -> ps ) $.
    syl7.2 $e |- ( ch -> ( th -> ( ps -> ta ) ) ) $.
    $( A syllogism rule of inference.  The second premise is used to replace
       the third antecedent of the first premise.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Wolf Lammen, 3-Aug-2012.) $)
    syl7 $p |- ( ch -> ( th -> ( ph -> ta ) ) ) $=
      ( wi a1i syl5d ) CABDEABHCFIGJ $.
  $}

  ${
    syl6d.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    syl6d.2 $e |- ( ph -> ( th -> ta ) ) $.
    $( A nested syllogism deduction.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Josh Purinton, 29-Dec-2000.)  (Proof shortened by O'Cat,
       2-Feb-2006.)  (Revised by NM, 3-Feb-2006.) $)
    syl6d $p |- ( ph -> ( ps -> ( ch -> ta ) ) ) $=
      ( wi a1d syldd ) ABCDEFADEHBGIJ $.
  $}

  ${
    syl8.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    syl8.2 $e |- ( th -> ta ) $.
    $( A syllogism rule of inference.  The second premise is used to replace
       the consequent of the first premise.  (Contributed by NM, 1-Aug-1994.)
       (Proof shortened by Wolf Lammen, 3-Aug-2012.) $)
    syl8 $p |- ( ph -> ( ps -> ( ch -> ta ) ) ) $=
      ( wi a1i syl6d ) ABCDEFDEHAGIJ $.
  $}

  ${
    syl9.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl9.2 $e |- ( th -> ( ch -> ta ) ) $.
    $( A nested syllogism inference with different antecedents.  (Contributed
       by NM, 5-Aug-1993.)  (Proof shortened by Josh Purinton, 29-Dec-2000.) $)
    syl9 $p |- ( ph -> ( th -> ( ps -> ta ) ) ) $=
      ( wi a1i syl5d ) ABCDEFDCEHHAGIJ $.
  $}

  ${
    syl9r.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl9r.2 $e |- ( th -> ( ch -> ta ) ) $.
    $( A nested syllogism inference with different antecedents.  (Contributed
       by NM, 5-Aug-1993.) $)
    syl9r $p |- ( th -> ( ph -> ( ps -> ta ) ) ) $=
      ( wi syl9 com12 ) ADBEHABCDEFGIJ $.
  $}

  ${
    imim12d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    imim12d.2 $e |- ( ph -> ( th -> ta ) ) $.
    $( Deduction combining antecedents and consequents.  (Contributed by NM,
       7-Aug-1994.)  (Proof shortened by O'Cat, 30-Oct-2011.) $)
    imim12d $p |- ( ph -> ( ( ch -> th ) -> ( ps -> ta ) ) ) $=
      ( wi imim2d syl5d ) ABCCDHEFADECGIJ $.
  $}

  ${
    imim1d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction adding nested consequents.  (Contributed by NM, 3-Apr-1994.)
       (Proof shortened by Wolf Lammen, 12-Sep-2012.) $)
    imim1d $p |- ( ph -> ( ( ch -> th ) -> ( ps -> th ) ) ) $=
      ( idd imim12d ) ABCDDEADFG $.
  $}

  $( A closed form of syllogism (see ~ syl ).  Theorem *2.06 of
     [WhiteheadRussell] p. 100.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 25-May-2013.) $)
  imim1 $p |- ( ( ph -> ps ) -> ( ( ps -> ch ) -> ( ph -> ch ) ) ) $=
    ( wi id imim1d ) ABDZABCGEF $.

  $( Theorem *2.83 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.83 $p |- ( ( ph -> ( ps -> ch ) ) -> ( ( ph -> ( ch -> th ) ) ->
                ( ph -> ( ps -> th ) ) ) ) $=
    ( wi imim1 imim3i ) BCECDEBDEABCDFG $.

  ${
    com3.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( Commutation of antecedents.  Swap 2nd and 3rd.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Wolf Lammen, 4-Aug-2012.) $)
    com23 $p |- ( ph -> ( ch -> ( ps -> th ) ) ) $=
      ( wi pm2.27 syl9 ) ABCDFCDECDGH $.

    $( Commutation of antecedents.  Rotate right.  (Contributed by NM,
       25-Apr-1994.) $)
    com3r $p |- ( ch -> ( ph -> ( ps -> th ) ) ) $=
      ( wi com23 com12 ) ACBDFABCDEGH $.

    $( Commutation of antecedents.  Swap 1st and 3rd.  (Contributed by NM,
       25-Apr-1994.)  (Proof shortened by Wolf Lammen, 28-Jul-2012.) $)
    com13 $p |- ( ch -> ( ps -> ( ph -> th ) ) ) $=
      ( com3r com23 ) CABDABCDEFG $.

    $( Commutation of antecedents.  Rotate left.  (Contributed by NM,
       25-Apr-1994.)  (Proof shortened by Wolf Lammen, 28-Jul-2012.) $)
    com3l $p |- ( ps -> ( ch -> ( ph -> th ) ) ) $=
      ( com3r ) CABDABCDEFF $.
  $}

  $( Swap antecedents.  Theorem *2.04 of [WhiteheadRussell] p. 100.
     (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
     12-Sep-2012.) $)
  pm2.04 $p |- ( ( ph -> ( ps -> ch ) ) -> ( ps -> ( ph -> ch ) ) ) $=
    ( wi id com23 ) ABCDDZABCGEF $.

  ${
    com4.1 $e |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $.
    $( Commutation of antecedents.  Swap 3rd and 4th.  (Contributed by NM,
       25-Apr-1994.) $)
    com34 $p |- ( ph -> ( ps -> ( th -> ( ch -> ta ) ) ) ) $=
      ( wi pm2.04 syl6 ) ABCDEGGDCEGGFCDEHI $.

    $( Commutation of antecedents.  Rotate left.  (Contributed by NM,
       25-Apr-1994.)  (Proof shortened by O'Cat, 15-Aug-2004.) $)
    com4l $p |- ( ps -> ( ch -> ( th -> ( ph -> ta ) ) ) ) $=
      ( wi com3l com34 ) BCADEABCDEGFHI $.

    $( Commutation of antecedents.  Rotate twice.  (Contributed by NM,
       25-Apr-1994.) $)
    com4t $p |- ( ch -> ( th -> ( ph -> ( ps -> ta ) ) ) ) $=
      ( com4l ) BCDAEABCDEFGG $.

    $( Commutation of antecedents.  Rotate right.  (Contributed by NM,
       25-Apr-1994.) $)
    com4r $p |- ( th -> ( ph -> ( ps -> ( ch -> ta ) ) ) ) $=
      ( com4t com4l ) CDABEABCDEFGH $.

    $( Commutation of antecedents.  Swap 2nd and 4th.  (Contributed by NM,
       25-Apr-1994.)  (Proof shortened by Wolf Lammen, 28-Jul-2012.) $)
    com24 $p |- ( ph -> ( th -> ( ch -> ( ps -> ta ) ) ) ) $=
      ( wi com4t com13 ) CDABEGABCDEFHI $.

    $( Commutation of antecedents.  Swap 1st and 4th.  (Contributed by NM,
       25-Apr-1994.)  (Proof shortened by Wolf Lammen, 28-Jul-2012.) $)
    com14 $p |- ( th -> ( ps -> ( ch -> ( ph -> ta ) ) ) ) $=
      ( wi com4l com3r ) BCDAEGABCDEFHI $.
  $}

  ${
    com5.1 $e |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $.
    $( Commutation of antecedents.  Swap 4th and 5th.  (Contributed by Jeff
       Hankins, 28-Jun-2009.) $)
    com45 $p |- ( ph -> ( ps -> ( ch -> ( ta -> ( th -> et ) ) ) ) ) $=
      ( wi pm2.04 syl8 ) ABCDEFHHEDFHHGDEFIJ $.

    $( Commutation of antecedents.  Swap 3rd and 5th.  (Contributed by Jeff
       Hankins, 28-Jun-2009.) $)
    com35 $p |- ( ph -> ( ps -> ( ta -> ( th -> ( ch -> et ) ) ) ) ) $=
      ( wi com34 com45 ) ABDECFHABDCEFABCDEFHGIJI $.

    $( Commutation of antecedents.  Swap 2nd and 5th.  (Contributed by Jeff
       Hankins, 28-Jun-2009.) $)
    com25 $p |- ( ph -> ( ta -> ( ch -> ( th -> ( ps -> et ) ) ) ) ) $=
      ( wi com24 com45 ) ADCEBFHADCBEFABCDEFHGIJI $.

    $( Commutation of antecedents.  Rotate left.  (Contributed by Jeff Hankins,
       28-Jun-2009.)  (Proof shortened by Wolf Lammen, 29-Jul-2012.) $)
    com5l $p |- ( ps -> ( ch -> ( th -> ( ta -> ( ph -> et ) ) ) ) ) $=
      ( wi com4l com45 ) BCDAEFABCDEFHGIJ $.

    $( Commutation of antecedents.  Swap 1st and 5th.  (Contributed by Jeff
       Hankins, 28-Jun-2009.)  (Proof shortened by Wolf Lammen,
       29-Jul-2012.) $)
    com15 $p |- ( ta -> ( ps -> ( ch -> ( th -> ( ph -> et ) ) ) ) ) $=
      ( wi com5l com4r ) BCDEAFHABCDEFGIJ $.

    $( Commutation of antecedents.  Rotate left twice.  (Contributed by Jeff
       Hankins, 28-Jun-2009.) $)
    com52l $p |- ( ch -> ( th -> ( ta -> ( ph -> ( ps -> et ) ) ) ) ) $=
      ( com5l ) BCDEAFABCDEFGHH $.

    $( Commutation of antecedents.  Rotate right twice.  (Contributed by Jeff
       Hankins, 28-Jun-2009.) $)
    com52r $p |- ( th -> ( ta -> ( ph -> ( ps -> ( ch -> et ) ) ) ) ) $=
      ( com52l com5l ) CDEABFABCDEFGHI $.

    $( Commutation of antecedents.  Rotate right.  (Contributed by Wolf Lammen,
       29-Jul-2012.) $)
    com5r $p |- ( ta -> ( ph -> ( ps -> ( ch -> ( th -> et ) ) ) ) ) $=
      ( com52l ) CDEABFABCDEFGHH $.
  $}

  $( Elimination of a nested antecedent as a kind of reversal of inference
     ~ ja .  (Contributed by Wolf Lammen, 9-May-2013.) $)
  jarr $p |- ( ( ( ph -> ps ) -> ch ) -> ( ps -> ch ) ) $=
    ( wi ax-1 imim1i ) BABDCBAEF $.

  ${
    pm2.86i.1 $e |- ( ( ph -> ps ) -> ( ph -> ch ) ) $.
    $( Inference based on ~ pm2.86 .  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Wolf Lammen, 3-Apr-2013.) $)
    pm2.86i $p |- ( ph -> ( ps -> ch ) ) $=
      ( wi ax-1 syl com12 ) BACBABEACEBAFDGH $.
  $}

  ${
    pm2.86d.1 $e |- ( ph -> ( ( ps -> ch ) -> ( ps -> th ) ) ) $.
    $( Deduction based on ~ pm2.86 .  (Contributed by NM, 29-Jun-1995.)  (Proof
       shortened by Wolf Lammen, 3-Apr-2013.) $)
    pm2.86d $p |- ( ph -> ( ps -> ( ch -> th ) ) ) $=
      ( wi ax-1 syl5 com23 ) ACBDCBCFABDFCBGEHI $.
  $}

  $( Converse of axiom ~ ax-2 .  Theorem *2.86 of [WhiteheadRussell] p. 108.
     (Contributed by NM, 25-Apr-1994.)  (Proof shortened by Wolf Lammen,
     3-Apr-2013.) $)
  pm2.86 $p |- ( ( ( ph -> ps ) -> ( ph -> ch ) ) ->
              ( ph -> ( ps -> ch ) ) ) $=
    ( wi id pm2.86d ) ABDACDDZABCGEF $.

  $( The Linearity Axiom of the infinite-valued sentential logic (L-infinity)
     of Lukasiewicz.  (Contributed by O'Cat, 12-Aug-2004.) $)
  loolin $p |- ( ( ( ph -> ps ) -> ( ps -> ph ) ) -> ( ps -> ph ) ) $=
    ( wi jarr pm2.43d ) ABCBACZCBAABFDE $.

  $( An alternate for the Linearity Axiom of the infinite-valued sentential
     logic (L-infinity) of Lukasiewicz, due to Barbara Wozniakowska, _Reports
     on Mathematical Logic_ 10, 129-137 (1978).  (Contributed by O'Cat,
     8-Aug-2004.) $)
  loowoz $p |- ( ( ( ph -> ps ) -> ( ph -> ch ) ) ->
                 ( ( ps -> ph ) -> ( ps -> ch ) ) ) $=
    ( wi jarr a2d ) ABDACDZDBACABGEF $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Logical conjunction and logical equivalence
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare connectives for conjunction ('and') and biconditional. $)
  $c /\ $. $( Wedge (read:  'and') $)
  $c <-> $. $( Double arrow (read:  'if and only if' or
               'is logically equivalent to') $)

  $( Extend wff definition to include conjunction ('and'). $)
  wa $a wff ( ph /\ ps ) $.

  $( Extend our wff definition to include the biconditional connective. $)
  wb $a wff ( ph <-> ps ) $.

  $( Left 'and' elimination.  Axiom 1 of 10 for intuitionistic logic.
     (Contributed by Mario Carneiro, 31-Jan-2015.) $)
  ax-ia1 $a |- ( ( ph /\ ps ) -> ph ) $.

  $( Right 'and' elimination.  Axiom 2 of 10 for intuitionistic logic.
     (Contributed by Mario Carneiro, 31-Jan-2015.) $)
  ax-ia2 $a |- ( ( ph /\ ps ) -> ps ) $.

  $( 'And' introduction.  Axiom 3 of 10 for intuitionistic logic.  (Contributed
     by Mario Carneiro, 31-Jan-2015.) $)
  ax-ia3 $a |- ( ph -> ( ps -> ( ph /\ ps ) ) ) $.

  $( Elimination of a conjunct.  Theorem *3.26 (Simp) of [WhiteheadRussell]
     p. 112.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 13-Nov-2012.) $)
  simpl $p |- ( ( ph /\ ps ) -> ph ) $=
    ( ax-ia1 ) ABC $.

  $( Elimination of a conjunct.  Theorem *3.27 (Simp) of [WhiteheadRussell]
     p. 112.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 13-Nov-2012.) $)
  simpr $p |- ( ( ph /\ ps ) -> ps ) $=
    ( ax-ia2 ) ABC $.

  ${
    simpli.1 $e |- ( ph /\ ps ) $.
    $( Inference eliminating a conjunct.  (Contributed by NM, 15-Jun-1994.) $)
    simpli $p |- ph $=
      ( wa simpl ax-mp ) ABDACABEF $.
  $}

  ${
    simpld.1 $e |- ( ph -> ( ps /\ ch ) ) $.
    $( Deduction eliminating a conjunct.  (Contributed by NM, 5-Aug-1993.) $)
    simpld $p |- ( ph -> ps ) $=
      ( wa simpl syl ) ABCEBDBCFG $.
  $}

  ${
    simpri.1 $e |- ( ph /\ ps ) $.
    $( Inference eliminating a conjunct.  (Contributed by NM, 15-Jun-1994.) $)
    simpri $p |- ps $=
      ( wa simpr ax-mp ) ABDBCABEF $.
  $}

  ${
    simprd.1 $e |- ( ph -> ( ps /\ ch ) ) $.
    $( Deduction eliminating a conjunct.  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Wolf Lammen, 3-Oct-2013.) $)
    simprd $p |- ( ph -> ch ) $=
      ( wa simpr syl ) ABCECDBCFG $.
  $}

  ${
    exp.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( Exportation inference.  (This theorem used to be labeled "exp" but was
       changed to "ex" so as not to conflict with the math token "exp", per the
       June 2006 Metamath spec change.)  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Eric Schmidt, 22-Dec-2006.) $)
    ex $p |- ( ph -> ( ps -> ch ) ) $=
      ( wa ax-ia3 syl6 ) ABABECABFDG $.

    $( Exportation inference with commuted antecedents.  (Contributed by NM,
       25-May-2005.) $)
    expcom $p |- ( ps -> ( ph -> ch ) ) $=
      ( ex com12 ) ABCABCDEF $.
  $}

  $( This is our first definition, which introduces and defines the
     biconditional connective ` <-> ` .  We define a wff of the form
     ` ( ph <-> ps ) ` as an abbreviation for
     ` ( ( ph -> ps ) /\ ( ps -> ph ) ) ` .

     Unlike most traditional developments, we have chosen not to have a
     separate symbol such as "Df." to mean "is defined as."  Instead, we will
     later use the biconditional connective for this purpose, as it allows us
     to use logic to manipulate definitions directly.  For an example of such a
     definition, see ~ df-3or .  This greatly simplifies many proofs since it
     eliminates the need for a separate mechanism for introducing and
     eliminating definitions.  Of course, we cannot use this mechanism to
     define the biconditional itself, since it hasn't been introduced yet.
     Instead, we use a more general form of definition, described as follows.

     In its most general form, a definition is simply an assertion that
     introduces a new symbol (or a new combination of existing symbols, as in
     ~ df-3an ) that is eliminable and does not strengthen the existing
     language.  The latter requirement means that the set of provable
     statements not containing the new symbol (or new combination) should
     remain exactly the same after the definition is introduced.  Our
     definition of the biconditional may look unusual compared to most
     definitions, but it strictly satisfies these requirements.

     The justification for our definition is that if we mechanically replace
     ` ( ph <-> ps ) ` (the definiendum i.e. the thing being defined) with
     ` ( ( ph -> ps ) /\ ( ps -> ph ) ) ` (the definiens i.e. the defining
     expression) in the definition, the definition becomes the previously
     proved theorem ~ biijust .  It is impossible to use ~ df-bi to prove any
     statement expressed in the original language that can't be proved from the
     original axioms, because if we simply replace each instance of ~ df-bi in
     the proof with the corresponding ~ biijust instance, we will end up with a
     proof from the original axioms.

     Note that from Metamath's point of view, a definition is just another
     axiom - i.e. an assertion we claim to be true - but from our high level
     point of view, we are are not strengthening the language.  To indicate
     this fact, we prefix definition labels with "df-" instead of "ax-".  (This
     prefixing is an informal convention that means nothing to the Metamath
     proof verifier; it is just for human readability.)

     ~ df-bi itself is a conjunction of two implications (to avoid using the
     biconditional in its own definition), but once we have the biconditional,
     we can prove ~ dfbi2 which uses the biconditional instead.

     Other definitions of the biconditional, such as ~ dfbi3dc , only hold for
     decidable propositions, not all propositions.  (Contributed by NM,
     5-Aug-1993.)  (Revised by Jim Kingdon, 24-Nov-2017.) $)
  df-bi $a |- ( ( ( ph <-> ps ) -> ( ( ph -> ps ) /\ ( ps -> ph ) ) )
        /\ ( ( ( ph -> ps ) /\ ( ps -> ph ) ) -> ( ph <-> ps ) ) ) $.

  $( Property of the biconditional connective.  (Contributed by NM,
     11-May-1999.)  (Revised by NM, 31-Jan-2015.) $)
  bi1 $p |- ( ( ph <-> ps ) -> ( ph -> ps ) ) $=
    ( wb wi wa df-bi simpli simpld ) ABCZABDZBADZIJKEZDLIDABFGH $.

  $( Property of the biconditional connective.  (Contributed by NM,
     11-May-1999.) $)
  bi3 $p |- ( ( ph -> ps ) -> ( ( ps -> ph ) -> ( ph <-> ps ) ) ) $=
    ( wi wb wa df-bi simpri ex ) ABCZBACZABDZKIJEZCLKCABFGH $.

  ${
    biimpi.1 $e |- ( ph <-> ps ) $.
    $( Infer an implication from a logical equivalence.  (Contributed by NM,
       5-Aug-1993.) $)
    biimpi $p |- ( ph -> ps ) $=
      ( wb wi bi1 ax-mp ) ABDABECABFG $.
  $}

  ${
    sylbi.1 $e |- ( ph <-> ps ) $.
    sylbi.2 $e |- ( ps -> ch ) $.
    $( A mixed syllogism inference from a biconditional and an implication.
       Useful for substituting an antecedent with a definition.  (Contributed
       by NM, 5-Aug-1993.) $)
    sylbi $p |- ( ph -> ch ) $=
      ( biimpi syl ) ABCABDFEG $.
  $}

  ${
    imp.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Importation inference.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Eric Schmidt, 22-Dec-2006.) $)
    imp $p |- ( ( ph /\ ps ) -> ch ) $=
      ( wa simpl simpr sylc ) ABEABCABFABGDH $.

    $( Importation inference with commuted antecedents.  (Contributed by NM,
       25-May-2005.) $)
    impcom $p |- ( ( ps /\ ph ) -> ch ) $=
      ( com12 imp ) BACABCDEF $.
  $}

  ${
    impbii.1 $e |- ( ph -> ps ) $.
    impbii.2 $e |- ( ps -> ph ) $.
    $( Infer an equivalence from an implication and its converse.  (Contributed
       by NM, 5-Aug-1993.) $)
    impbii $p |- ( ph <-> ps ) $=
      ( wi wb bi3 mp2 ) ABEBAEABFCDABGH $.
  $}

  ${
    impbidd.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    impbidd.2 $e |- ( ph -> ( ps -> ( th -> ch ) ) ) $.
    $( Deduce an equivalence from two implications.  (Contributed by Rodolfo
       Medina, 12-Oct-2010.) $)
    impbidd $p |- ( ph -> ( ps -> ( ch <-> th ) ) ) $=
      ( wi wb bi3 syl6c ) ABCDGDCGCDHEFCDIJ $.
  $}

  ${
    impbid21d.1 $e |- ( ps -> ( ch -> th ) ) $.
    impbid21d.2 $e |- ( ph -> ( th -> ch ) ) $.
    $( Deduce an equivalence from two implications.  (Contributed by Wolf
       Lammen, 12-May-2013.) $)
    impbid21d $p |- ( ph -> ( ps -> ( ch <-> th ) ) ) $=
      ( wi a1i a1d impbidd ) ABCDBCDGGAEHADCGBFIJ $.
  $}

  ${
    impbid.1 $e |- ( ph -> ( ps -> ch ) ) $.
    impbid.2 $e |- ( ph -> ( ch -> ps ) ) $.
    $( Deduce an equivalence from two implications.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Wolf Lammen, 3-Nov-2012.) $)
    impbid $p |- ( ph -> ( ps <-> ch ) ) $=
      ( wb impbid21d pm2.43i ) ABCFAABCDEGH $.
  $}

  $( Property of the biconditional connective.  (Contributed by NM,
     11-May-1999.)  (Proof shortened by Wolf Lammen, 11-Nov-2012.) $)
  bi2 $p |- ( ( ph <-> ps ) -> ( ps -> ph ) ) $=
    ( wb wi wa df-bi simpli simprd ) ABCZABDZBADZIJKEZDLIDABFGH $.

  $( Commutative law for equivalence.  (Contributed by Wolf Lammen,
     10-Nov-2012.) $)
  bicom1 $p |- ( ( ph <-> ps ) -> ( ps <-> ph ) ) $=
    ( wb bi2 bi1 impbid ) ABCBAABDABEF $.

  ${
    bicomi.1 $e |- ( ph <-> ps ) $.
    $( Inference from commutative law for logical equivalence.  (Contributed by
       NM, 5-Aug-1993.)  (Revised by NM, 16-Sep-2013.) $)
    bicomi $p |- ( ps <-> ph ) $=
      ( wb bicom1 ax-mp ) ABDBADCABEF $.
  $}

  ${
    biimpri.1 $e |- ( ph <-> ps ) $.
    $( Infer a converse implication from a logical equivalence.  (Contributed
       by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 16-Sep-2013.) $)
    biimpri $p |- ( ps -> ph ) $=
      ( bicomi biimpi ) BAABCDE $.
  $}

  ${
    sylbir.1 $e |- ( ps <-> ph ) $.
    sylbir.2 $e |- ( ps -> ch ) $.
    $( A mixed syllogism inference from a biconditional and an implication.
       (Contributed by NM, 5-Aug-1993.) $)
    sylbir $p |- ( ph -> ch ) $=
      ( biimpri syl ) ABCBADFEG $.
  $}

  $( Join antecedents with conjunction.  Theorem *3.2 of [WhiteheadRussell]
     p. 111.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 12-Nov-2012.) $)
  pm3.2 $p |- ( ph -> ( ps -> ( ph /\ ps ) ) ) $=
    ( wa id ex ) ABABCZFDE $.

  ${
    sylib.1 $e |- ( ph -> ps ) $.
    sylib.2 $e |- ( ps <-> ch ) $.
    $( A mixed syllogism inference from an implication and a biconditional.
       (Contributed by NM, 5-Aug-1993.) $)
    sylib $p |- ( ph -> ch ) $=
      ( biimpi syl ) ABCDBCEFG $.
  $}

  $( Commutative law for equivalence.  Theorem *4.21 of [WhiteheadRussell]
     p. 117.  (Contributed by NM, 5-Aug-1993.)  (Revised by NM,
     11-Nov-2012.) $)
  bicom $p |- ( ( ph <-> ps ) <-> ( ps <-> ph ) ) $=
    ( wb bicom1 impbii ) ABCBACABDBADE $.

  ${
    bicomd.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Commute two sides of a biconditional in a deduction.  (Contributed by
       NM, 5-Aug-1993.) $)
    bicomd $p |- ( ph -> ( ch <-> ps ) ) $=
      ( wb bicom sylib ) ABCECBEDBCFG $.
  $}

  ${
    impbid1.1 $e |- ( ph -> ( ps -> ch ) ) $.
    impbid1.2 $e |- ( ch -> ps ) $.
    $( Infer an equivalence from two implications.  (Contributed by NM,
       6-Mar-2007.) $)
    impbid1 $p |- ( ph -> ( ps <-> ch ) ) $=
      ( wi a1i impbid ) ABCDCBFAEGH $.
  $}

  ${
    impbid2.1 $e |- ( ps -> ch ) $.
    impbid2.2 $e |- ( ph -> ( ch -> ps ) ) $.
    $( Infer an equivalence from two implications.  (Contributed by NM,
       6-Mar-2007.)  (Proof shortened by Wolf Lammen, 27-Sep-2013.) $)
    impbid2 $p |- ( ph -> ( ps <-> ch ) ) $=
      ( impbid1 bicomd ) ACBACBEDFG $.
  $}

  ${
    biimpd.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduce an implication from a logical equivalence.  (Contributed by NM,
       5-Aug-1993.) $)
    biimpd $p |- ( ph -> ( ps -> ch ) ) $=
      ( wb wi bi1 syl ) ABCEBCFDBCGH $.
  $}

  ${
    mpbi.min $e |- ph $.
    mpbi.maj $e |- ( ph <-> ps ) $.
    $( An inference from a biconditional, related to modus ponens.
       (Contributed by NM, 5-Aug-1993.) $)
    mpbi $p |- ps $=
      ( biimpi ax-mp ) ABCABDEF $.
  $}

  ${
    mpbir.min $e |- ps $.
    mpbir.maj $e |- ( ph <-> ps ) $.
    $( An inference from a biconditional, related to modus ponens.
       (Contributed by NM, 5-Aug-1993.) $)
    mpbir $p |- ph $=
      ( biimpri ax-mp ) BACABDEF $.
  $}

  ${
    mpbid.min $e |- ( ph -> ps ) $.
    mpbid.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( A deduction from a biconditional, related to modus ponens.  (Contributed
       by NM, 5-Aug-1993.) $)
    mpbid $p |- ( ph -> ch ) $=
      ( biimpd mpd ) ABCDABCEFG $.
  $}

  ${
    mpbii.min $e |- ps $.
    mpbii.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( An inference from a nested biconditional, related to modus ponens.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       25-Oct-2012.) $)
    mpbii $p |- ( ph -> ch ) $=
      ( a1i mpbid ) ABCBADFEG $.
  $}

  ${
    sylibr.1 $e |- ( ph -> ps ) $.
    sylibr.2 $e |- ( ch <-> ps ) $.
    $( A mixed syllogism inference from an implication and a biconditional.
       Useful for substituting a consequent with a definition.  (Contributed by
       NM, 5-Aug-1993.) $)
    sylibr $p |- ( ph -> ch ) $=
      ( biimpri syl ) ABCDCBEFG $.
  $}

  ${
    sylibd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    sylibd.2 $e |- ( ph -> ( ch <-> th ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 3-Aug-1994.) $)
    sylibd $p |- ( ph -> ( ps -> th ) ) $=
      ( biimpd syld ) ABCDEACDFGH $.
  $}

  ${
    sylbid.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    sylbid.2 $e |- ( ph -> ( ch -> th ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 3-Aug-1994.) $)
    sylbid $p |- ( ph -> ( ps -> th ) ) $=
      ( biimpd syld ) ABCDABCEGFH $.
  $}

  ${
    mpbidi.min $e |- ( th -> ( ph -> ps ) ) $.
    mpbidi.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( A deduction from a biconditional, related to modus ponens.  (Contributed
       by NM, 9-Aug-1994.) $)
    mpbidi $p |- ( th -> ( ph -> ch ) ) $=
      ( biimpd sylcom ) DABCEABCFGH $.
  $}

  ${
    syl5bi.1 $e |- ( ph <-> ps ) $.
    syl5bi.2 $e |- ( ch -> ( ps -> th ) ) $.
    $( A mixed syllogism inference from a nested implication and a
       biconditional.  Useful for substituting an embedded antecedent with a
       definition.  (Contributed by NM, 5-Aug-1993.) $)
    syl5bi $p |- ( ch -> ( ph -> th ) ) $=
      ( biimpi syl5 ) ABCDABEGFH $.
  $}

  ${
    syl5bir.1 $e |- ( ps <-> ph ) $.
    syl5bir.2 $e |- ( ch -> ( ps -> th ) ) $.
    $( A mixed syllogism inference from a nested implication and a
       biconditional.  (Contributed by NM, 5-Aug-1993.) $)
    syl5bir $p |- ( ch -> ( ph -> th ) ) $=
      ( biimpri syl5 ) ABCDBAEGFH $.
  $}

  ${
    syl5ib.1 $e |- ( ph -> ps ) $.
    syl5ib.2 $e |- ( ch -> ( ps <-> th ) ) $.
    $( A mixed syllogism inference.  (Contributed by NM, 5-Aug-1993.) $)
    syl5ib $p |- ( ch -> ( ph -> th ) ) $=
      ( biimpd syl5 ) ABCDECBDFGH $.

    $( A mixed syllogism inference.  (Contributed by NM, 19-Jun-2007.) $)
    syl5ibcom $p |- ( ph -> ( ch -> th ) ) $=
      ( syl5ib com12 ) CADABCDEFGH $.
  $}

  ${
    syl5ibr.1 $e |- ( ph -> th ) $.
    syl5ibr.2 $e |- ( ch -> ( ps <-> th ) ) $.
    $( A mixed syllogism inference.  (Contributed by NM, 3-Apr-1994.)  (Revised
       by NM, 22-Sep-2013.) $)
    syl5ibr $p |- ( ch -> ( ph -> ps ) ) $=
      ( bicomd syl5ib ) ADCBECBDFGH $.

    $( A mixed syllogism inference.  (Contributed by NM, 20-Jun-2007.) $)
    syl5ibrcom $p |- ( ph -> ( ch -> ps ) ) $=
      ( syl5ibr com12 ) CABABCDEFGH $.
  $}

  ${
    biimprd.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduce a converse implication from a logical equivalence.  (Contributed
       by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 22-Sep-2013.) $)
    biimprd $p |- ( ph -> ( ch -> ps ) ) $=
      ( id syl5ibr ) CBACCEDF $.
  $}

  ${
    biimpcd.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduce a commuted implication from a logical equivalence.  (Contributed
       by NM, 3-May-1994.)  (Proof shortened by Wolf Lammen, 22-Sep-2013.) $)
    biimpcd $p |- ( ps -> ( ph -> ch ) ) $=
      ( id syl5ibcom ) BBACBEDF $.

    $( Deduce a converse commuted implication from a logical equivalence.
       (Contributed by NM, 3-May-1994.)  (Proof shortened by Wolf Lammen,
       20-Dec-2013.) $)
    biimprcd $p |- ( ch -> ( ph -> ps ) ) $=
      ( id syl5ibrcom ) CBACCEDF $.
  $}

  ${
    syl6ib.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl6ib.2 $e |- ( ch <-> th ) $.
    $( A mixed syllogism inference from a nested implication and a
       biconditional.  (Contributed by NM, 5-Aug-1993.) $)
    syl6ib $p |- ( ph -> ( ps -> th ) ) $=
      ( biimpi syl6 ) ABCDECDFGH $.
  $}

  ${
    syl6ibr.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl6ibr.2 $e |- ( th <-> ch ) $.
    $( A mixed syllogism inference from a nested implication and a
       biconditional.  Useful for substituting an embedded consequent with a
       definition.  (Contributed by NM, 5-Aug-1993.) $)
    syl6ibr $p |- ( ph -> ( ps -> th ) ) $=
      ( biimpri syl6 ) ABCDEDCFGH $.
  $}


  ${
    syl6bi.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    syl6bi.2 $e |- ( ch -> th ) $.
    $( A mixed syllogism inference.  (Contributed by NM, 2-Jan-1994.) $)
    syl6bi $p |- ( ph -> ( ps -> th ) ) $=
      ( biimpd syl6 ) ABCDABCEGFH $.
  $}

  ${
    syl6bir.1 $e |- ( ph -> ( ch <-> ps ) ) $.
    syl6bir.2 $e |- ( ch -> th ) $.
    $( A mixed syllogism inference.  (Contributed by NM, 18-May-1994.) $)
    syl6bir $p |- ( ph -> ( ps -> th ) ) $=
      ( biimprd syl6 ) ABCDACBEGFH $.
  $}

  ${
    syl7bi.1 $e |- ( ph <-> ps ) $.
    syl7bi.2 $e |- ( ch -> ( th -> ( ps -> ta ) ) ) $.
    $( A mixed syllogism inference from a doubly nested implication and a
       biconditional.  (Contributed by NM, 5-Aug-1993.) $)
    syl7bi $p |- ( ch -> ( th -> ( ph -> ta ) ) ) $=
      ( biimpi syl7 ) ABCDEABFHGI $.
  $}

  ${
    syl8ib.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    syl8ib.2 $e |- ( th <-> ta ) $.
    $( A syllogism rule of inference.  The second premise is used to replace
       the consequent of the first premise.  (Contributed by NM,
       1-Aug-1994.) $)
    syl8ib $p |- ( ph -> ( ps -> ( ch -> ta ) ) ) $=
      ( biimpi syl8 ) ABCDEFDEGHI $.
  $}

  ${
    mpbird.min $e |- ( ph -> ch ) $.
    mpbird.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( A deduction from a biconditional, related to modus ponens.  (Contributed
       by NM, 5-Aug-1993.) $)
    mpbird $p |- ( ph -> ps ) $=
      ( biimprd mpd ) ACBDABCEFG $.
  $}

  ${
    mpbiri.min $e |- ch $.
    mpbiri.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( An inference from a nested biconditional, related to modus ponens.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       25-Oct-2012.) $)
    mpbiri $p |- ( ph -> ps ) $=
      ( a1i mpbird ) ABCCADFEG $.
  $}

  ${
    sylibrd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    sylibrd.2 $e |- ( ph -> ( th <-> ch ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 3-Aug-1994.) $)
    sylibrd $p |- ( ph -> ( ps -> th ) ) $=
      ( biimprd syld ) ABCDEADCFGH $.
  $}

  ${
    sylbird.1 $e |- ( ph -> ( ch <-> ps ) ) $.
    sylbird.2 $e |- ( ph -> ( ch -> th ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 3-Aug-1994.) $)
    sylbird $p |- ( ph -> ( ps -> th ) ) $=
      ( biimprd syld ) ABCDACBEGFH $.
  $}

  $( Principle of identity for logical equivalence.  Theorem *4.2 of
     [WhiteheadRussell] p. 117.  (Contributed by NM, 5-Aug-1993.) $)
  biid $p |- ( ph <-> ph ) $=
    ( id impbii ) AAABZDC $.

  $( Principle of identity with antecedent.  (Contributed by NM,
     25-Nov-1995.) $)
  biidd $p |- ( ph -> ( ps <-> ps ) ) $=
    ( wb biid a1i ) BBCABDE $.

  $( Two propositions are equivalent if they are both true.  Closed form of
     ~ 2th .  Equivalent to a ~ bi1 -like version of the xor-connective.  This
     theorem stays true, no matter how you permute its operands.  This is
     evident from its sharper version
     ` ( ph <-> ( ps <-> ( ph <-> ps ) ) ) ` .  (Contributed by Wolf Lammen,
     12-May-2013.) $)
  pm5.1im $p |- ( ph -> ( ps -> ( ph <-> ps ) ) ) $=
    ( ax-1 impbid21d ) ABABBACABCD $.

  ${
    2th.1 $e |- ph $.
    2th.2 $e |- ps $.
    $( Two truths are equivalent.  (Contributed by NM, 18-Aug-1993.) $)
    2th $p |- ( ph <-> ps ) $=
      ( a1i impbii ) ABBADEABCEF $.
  $}

  ${
    2thd.1 $e |- ( ph -> ps ) $.
    2thd.2 $e |- ( ph -> ch ) $.
    $( Two truths are equivalent (deduction rule).  (Contributed by NM,
       3-Jun-2012.)  (Revised by NM, 29-Jan-2013.) $)
    2thd $p |- ( ph -> ( ps <-> ch ) ) $=
      ( wb pm5.1im sylc ) ABCBCFDEBCGH $.
  $}

  ${
    ibi.1 $e |- ( ph -> ( ph <-> ps ) ) $.
    $( Inference that converts a biconditional implied by one of its arguments,
       into an implication.  (Contributed by NM, 17-Oct-2003.) $)
    ibi $p |- ( ph -> ps ) $=
      ( biimpd pm2.43i ) ABAABCDE $.
  $}

  ${
    ibir.1 $e |- ( ph -> ( ps <-> ph ) ) $.
    $( Inference that converts a biconditional implied by one of its arguments,
       into an implication.  (Contributed by NM, 22-Jul-2004.) $)
    ibir $p |- ( ph -> ps ) $=
      ( bicomd ibi ) ABABACDE $.
  $}

  ${
    ibd.1 $e |- ( ph -> ( ps -> ( ps <-> ch ) ) ) $.
    $( Deduction that converts a biconditional implied by one of its arguments,
       into an implication.  (Contributed by NM, 26-Jun-2004.) $)
    ibd $p |- ( ph -> ( ps -> ch ) ) $=
      ( wb bi1 syli ) BABCECDBCFG $.
  $}

  $( Distribution of implication over biconditional.  Theorem *5.74 of
     [WhiteheadRussell] p. 126.  (Contributed by NM, 1-Aug-1994.)  (Proof
     shortened by Wolf Lammen, 11-Apr-2013.) $)
  pm5.74 $p |- ( ( ph -> ( ps <-> ch ) ) <->
               ( ( ph -> ps ) <-> ( ph -> ch ) ) ) $=
    ( wb wi bi1 imim3i bi2 impbid pm2.86d impbidd impbii ) ABCDZEZABEZACEZDZNOP
    MBCABCFGMCBABCHGIQABCQABCOPFJQACBOPHJKL $.

  ${
    pm5.74i.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Distribution of implication over biconditional (inference rule).
       (Contributed by NM, 1-Aug-1994.) $)
    pm5.74i $p |- ( ( ph -> ps ) <-> ( ph -> ch ) ) $=
      ( wb wi pm5.74 mpbi ) ABCEFABFACFEDABCGH $.
  $}

  ${
    pm5.74ri.1 $e |- ( ( ph -> ps ) <-> ( ph -> ch ) ) $.
    $( Distribution of implication over biconditional (reverse inference
       rule).  (Contributed by NM, 1-Aug-1994.) $)
    pm5.74ri $p |- ( ph -> ( ps <-> ch ) ) $=
      ( wb wi pm5.74 mpbir ) ABCEFABFACFEDABCGH $.
  $}

  ${
    pm5.74d.1 $e |- ( ph -> ( ps -> ( ch <-> th ) ) ) $.
    $( Distribution of implication over biconditional (deduction rule).
       (Contributed by NM, 21-Mar-1996.) $)
    pm5.74d $p |- ( ph -> ( ( ps -> ch ) <-> ( ps -> th ) ) ) $=
      ( wb wi pm5.74 sylib ) ABCDFGBCGBDGFEBCDHI $.
  $}

  ${
    pm5.74rd.1 $e |- ( ph -> ( ( ps -> ch ) <-> ( ps -> th ) ) ) $.
    $( Distribution of implication over biconditional (deduction rule).
       (Contributed by NM, 19-Mar-1997.) $)
    pm5.74rd $p |- ( ph -> ( ps -> ( ch <-> th ) ) ) $=
      ( wi wb pm5.74 sylibr ) ABCFBDFGBCDGFEBCDHI $.
  $}

  ${
    bitri.1 $e |- ( ph <-> ps ) $.
    bitri.2 $e |- ( ps <-> ch ) $.
    $( An inference from transitive law for logical equivalence.  (Contributed
       by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 13-Oct-2012.) $)
    bitri $p |- ( ph <-> ch ) $=
      ( biimpi sylib biimpri sylibr impbii ) ACABCABDFEGCBABCEHDIJ $.
  $}

  ${
    bitr2i.1 $e |- ( ph <-> ps ) $.
    bitr2i.2 $e |- ( ps <-> ch ) $.
    $( An inference from transitive law for logical equivalence.  (Contributed
       by NM, 5-Aug-1993.) $)
    bitr2i $p |- ( ch <-> ph ) $=
      ( bitri bicomi ) ACABCDEFG $.
  $}

  ${
    bitr3i.1 $e |- ( ps <-> ph ) $.
    bitr3i.2 $e |- ( ps <-> ch ) $.
    $( An inference from transitive law for logical equivalence.  (Contributed
       by NM, 5-Aug-1993.) $)
    bitr3i $p |- ( ph <-> ch ) $=
      ( bicomi bitri ) ABCBADFEG $.
  $}

  ${
    bitr4i.1 $e |- ( ph <-> ps ) $.
    bitr4i.2 $e |- ( ch <-> ps ) $.
    $( An inference from transitive law for logical equivalence.  (Contributed
       by NM, 5-Aug-1993.) $)
    bitr4i $p |- ( ph <-> ch ) $=
      ( bicomi bitri ) ABCDCBEFG $.
  $}

  ${
    bitrd.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    bitrd.2 $e |- ( ph -> ( ch <-> th ) ) $.
    $( Deduction form of ~ bitri .  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Wolf Lammen, 14-Apr-2013.) $)
    bitrd $p |- ( ph -> ( ps <-> th ) ) $=
      ( wi pm5.74i bitri pm5.74ri ) ABDABGACGADGABCEHACDFHIJ $.
  $}

  ${
    bitr2d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    bitr2d.2 $e |- ( ph -> ( ch <-> th ) ) $.
    $( Deduction form of ~ bitr2i .  (Contributed by NM, 9-Jun-2004.) $)
    bitr2d $p |- ( ph -> ( th <-> ps ) ) $=
      ( bitrd bicomd ) ABDABCDEFGH $.
  $}

  ${
    bitr3d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    bitr3d.2 $e |- ( ph -> ( ps <-> th ) ) $.
    $( Deduction form of ~ bitr3i .  (Contributed by NM, 5-Aug-1993.) $)
    bitr3d $p |- ( ph -> ( ch <-> th ) ) $=
      ( bicomd bitrd ) ACBDABCEGFH $.
  $}

  ${
    bitr4d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    bitr4d.2 $e |- ( ph -> ( th <-> ch ) ) $.
    $( Deduction form of ~ bitr4i .  (Contributed by NM, 5-Aug-1993.) $)
    bitr4d $p |- ( ph -> ( ps <-> th ) ) $=
      ( bicomd bitrd ) ABCDEADCFGH $.
  $}

  ${
    syl5bb.1 $e |- ( ph <-> ps ) $.
    syl5bb.2 $e |- ( ch -> ( ps <-> th ) ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       5-Aug-1993.) $)
    syl5bb $p |- ( ch -> ( ph <-> th ) ) $=
      ( wb a1i bitrd ) CABDABGCEHFI $.
  $}

  ${
    syl5rbb.1 $e |- ( ph <-> ps ) $.
    syl5rbb.2 $e |- ( ch -> ( ps <-> th ) ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       5-Aug-1993.) $)
    syl5rbb $p |- ( ch -> ( th <-> ph ) ) $=
      ( syl5bb bicomd ) CADABCDEFGH $.
  $}

  ${
    syl5bbr.1 $e |- ( ps <-> ph ) $.
    syl5bbr.2 $e |- ( ch -> ( ps <-> th ) ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       5-Aug-1993.) $)
    syl5bbr $p |- ( ch -> ( ph <-> th ) ) $=
      ( bicomi syl5bb ) ABCDBAEGFH $.
  $}

  ${
    syl5rbbr.1 $e |- ( ps <-> ph ) $.
    syl5rbbr.2 $e |- ( ch -> ( ps <-> th ) ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       25-Nov-1994.) $)
    syl5rbbr $p |- ( ch -> ( th <-> ph ) ) $=
      ( bicomi syl5rbb ) ABCDBAEGFH $.
  $}

  ${
    syl6bb.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    syl6bb.2 $e |- ( ch <-> th ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       5-Aug-1993.) $)
    syl6bb $p |- ( ph -> ( ps <-> th ) ) $=
      ( wb a1i bitrd ) ABCDECDGAFHI $.
  $}

  ${
    syl6rbb.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    syl6rbb.2 $e |- ( ch <-> th ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       5-Aug-1993.) $)
    syl6rbb $p |- ( ph -> ( th <-> ps ) ) $=
      ( syl6bb bicomd ) ABDABCDEFGH $.
  $}

  ${
    syl6bbr.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    syl6bbr.2 $e |- ( th <-> ch ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       5-Aug-1993.) $)
    syl6bbr $p |- ( ph -> ( ps <-> th ) ) $=
      ( bicomi syl6bb ) ABCDEDCFGH $.
  $}

  ${
    syl6rbbr.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    syl6rbbr.2 $e |- ( th <-> ch ) $.
    $( A syllogism inference from two biconditionals.  (Contributed by NM,
       25-Nov-1994.) $)
    syl6rbbr $p |- ( ph -> ( th <-> ps ) ) $=
      ( bicomi syl6rbb ) ABCDEDCFGH $.
  $}

  ${
    3imtr3.1 $e |- ( ph -> ps ) $.
    3imtr3.2 $e |- ( ph <-> ch ) $.
    3imtr3.3 $e |- ( ps <-> th ) $.
    $( A mixed syllogism inference, useful for removing a definition from both
       sides of an implication.  (Contributed by NM, 10-Aug-1994.) $)
    3imtr3i $p |- ( ch -> th ) $=
      ( sylbir sylib ) CBDCABFEHGI $.
  $}

  ${
    3imtr4.1 $e |- ( ph -> ps ) $.
    3imtr4.2 $e |- ( ch <-> ph ) $.
    3imtr4.3 $e |- ( th <-> ps ) $.
    $( A mixed syllogism inference, useful for applying a definition to both
       sides of an implication.  (Contributed by NM, 5-Aug-1993.) $)
    3imtr4i $p |- ( ch -> th ) $=
      ( sylbi sylibr ) CBDCABFEHGI $.
  $}

  ${
    3imtr3d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3imtr3d.2 $e |- ( ph -> ( ps <-> th ) ) $.
    3imtr3d.3 $e |- ( ph -> ( ch <-> ta ) ) $.
    $( More general version of ~ 3imtr3i .  Useful for converting conditional
       definitions in a formula.  (Contributed by NM, 8-Apr-1996.) $)
    3imtr3d $p |- ( ph -> ( th -> ta ) ) $=
      ( sylibd sylbird ) ADBEGABCEFHIJ $.
  $}

  ${
    3imtr4d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3imtr4d.2 $e |- ( ph -> ( th <-> ps ) ) $.
    3imtr4d.3 $e |- ( ph -> ( ta <-> ch ) ) $.
    $( More general version of ~ 3imtr4i .  Useful for converting conditional
       definitions in a formula.  (Contributed by NM, 26-Oct-1995.) $)
    3imtr4d $p |- ( ph -> ( th -> ta ) ) $=
      ( sylibrd sylbid ) ADBEGABCEFHIJ $.
  $}

  ${
    3imtr3g.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3imtr3g.2 $e |- ( ps <-> th ) $.
    3imtr3g.3 $e |- ( ch <-> ta ) $.
    $( More general version of ~ 3imtr3i .  Useful for converting definitions
       in a formula.  (Contributed by NM, 20-May-1996.)  (Proof shortened by
       Wolf Lammen, 20-Dec-2013.) $)
    3imtr3g $p |- ( ph -> ( th -> ta ) ) $=
      ( syl5bir syl6ib ) ADCEDBACGFIHJ $.
  $}

  ${
    3imtr4g.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3imtr4g.2 $e |- ( th <-> ps ) $.
    3imtr4g.3 $e |- ( ta <-> ch ) $.
    $( More general version of ~ 3imtr4i .  Useful for converting definitions
       in a formula.  (Contributed by NM, 20-May-1996.)  (Proof shortened by
       Wolf Lammen, 20-Dec-2013.) $)
    3imtr4g $p |- ( ph -> ( th -> ta ) ) $=
      ( syl5bi syl6ibr ) ADCEDBACGFIHJ $.
  $}

  ${
    3bitri.1 $e |- ( ph <-> ps ) $.
    3bitri.2 $e |- ( ps <-> ch ) $.
    3bitri.3 $e |- ( ch <-> th ) $.
    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 5-Aug-1993.) $)
    3bitri $p |- ( ph <-> th ) $=
      ( bitri ) ABDEBCDFGHH $.

    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 4-Aug-2006.) $)
    3bitrri $p |- ( th <-> ph ) $=
      ( bitr2i bitr3i ) DCAGABCEFHI $.
  $}

  ${
    3bitr2i.1 $e |- ( ph <-> ps ) $.
    3bitr2i.2 $e |- ( ch <-> ps ) $.
    3bitr2i.3 $e |- ( ch <-> th ) $.
    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 4-Aug-2006.) $)
    3bitr2i $p |- ( ph <-> th ) $=
      ( bitr4i bitri ) ACDABCEFHGI $.

    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 4-Aug-2006.) $)
    3bitr2ri $p |- ( th <-> ph ) $=
      ( bitr4i bitr2i ) ACDABCEFHGI $.
  $}

  ${
    3bitr3i.1 $e |- ( ph <-> ps ) $.
    3bitr3i.2 $e |- ( ph <-> ch ) $.
    3bitr3i.3 $e |- ( ps <-> th ) $.
    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 19-Aug-1993.) $)
    3bitr3i $p |- ( ch <-> th ) $=
      ( bitr3i bitri ) CBDCABFEHGI $.

    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 5-Aug-1993.) $)
    3bitr3ri $p |- ( th <-> ch ) $=
      ( bitr3i ) DBCGBACEFHH $.
  $}

  ${
    3bitr4i.1 $e |- ( ph <-> ps ) $.
    3bitr4i.2 $e |- ( ch <-> ph ) $.
    3bitr4i.3 $e |- ( th <-> ps ) $.
    $( A chained inference from transitive law for logical equivalence.  This
       inference is frequently used to apply a definition to both sides of a
       logical equivalence.  (Contributed by NM, 5-Aug-1993.) $)
    3bitr4i $p |- ( ch <-> th ) $=
      ( bitr4i bitri ) CADFABDEGHI $.

    $( A chained inference from transitive law for logical equivalence.
       (Contributed by NM, 2-Sep-1995.) $)
    3bitr4ri $p |- ( th <-> ch ) $=
      ( bitr4i bitr2i ) CADFABDEGHI $.
  $}

  ${
    3bitrd.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3bitrd.2 $e |- ( ph -> ( ch <-> th ) ) $.
    3bitrd.3 $e |- ( ph -> ( th <-> ta ) ) $.
    $( Deduction from transitivity of biconditional.  (Contributed by NM,
       13-Aug-1999.) $)
    3bitrd $p |- ( ph -> ( ps <-> ta ) ) $=
      ( bitrd ) ABDEABCDFGIHI $.

    $( Deduction from transitivity of biconditional.  (Contributed by NM,
       4-Aug-2006.) $)
    3bitrrd $p |- ( ph -> ( ta <-> ps ) ) $=
      ( bitr2d bitr3d ) ADEBHABCDFGIJ $.
  $}

  ${
    3bitr2d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3bitr2d.2 $e |- ( ph -> ( th <-> ch ) ) $.
    3bitr2d.3 $e |- ( ph -> ( th <-> ta ) ) $.
    $( Deduction from transitivity of biconditional.  (Contributed by NM,
       4-Aug-2006.) $)
    3bitr2d $p |- ( ph -> ( ps <-> ta ) ) $=
      ( bitr4d bitrd ) ABDEABCDFGIHJ $.

    $( Deduction from transitivity of biconditional.  (Contributed by NM,
       4-Aug-2006.) $)
    3bitr2rd $p |- ( ph -> ( ta <-> ps ) ) $=
      ( bitr4d bitr2d ) ABDEABCDFGIHJ $.
  $}

  ${
    3bitr3d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3bitr3d.2 $e |- ( ph -> ( ps <-> th ) ) $.
    3bitr3d.3 $e |- ( ph -> ( ch <-> ta ) ) $.
    $( Deduction from transitivity of biconditional.  Useful for converting
       conditional definitions in a formula.  (Contributed by NM,
       24-Apr-1996.) $)
    3bitr3d $p |- ( ph -> ( th <-> ta ) ) $=
      ( bitr3d bitrd ) ADCEABDCGFIHJ $.

    $( Deduction from transitivity of biconditional.  (Contributed by NM,
       4-Aug-2006.) $)
    3bitr3rd $p |- ( ph -> ( ta <-> th ) ) $=
      ( bitr3d ) ACEDHABCDFGII $.
  $}

  ${
    3bitr4d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3bitr4d.2 $e |- ( ph -> ( th <-> ps ) ) $.
    3bitr4d.3 $e |- ( ph -> ( ta <-> ch ) ) $.
    $( Deduction from transitivity of biconditional.  Useful for converting
       conditional definitions in a formula.  (Contributed by NM,
       18-Oct-1995.) $)
    3bitr4d $p |- ( ph -> ( th <-> ta ) ) $=
      ( bitr4d bitrd ) ADBEGABCEFHIJ $.

    $( Deduction from transitivity of biconditional.  (Contributed by NM,
       4-Aug-2006.) $)
    3bitr4rd $p |- ( ph -> ( ta <-> th ) ) $=
      ( bitr4d ) AEBDAECBHFIGI $.
  $}

  ${
    3bitr3g.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3bitr3g.2 $e |- ( ps <-> th ) $.
    3bitr3g.3 $e |- ( ch <-> ta ) $.
    $( More general version of ~ 3bitr3i .  Useful for converting definitions
       in a formula.  (Contributed by NM, 4-Jun-1995.) $)
    3bitr3g $p |- ( ph -> ( th <-> ta ) ) $=
      ( syl5bbr syl6bb ) ADCEDBACGFIHJ $.
  $}

  ${
    3bitr4g.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3bitr4g.2 $e |- ( th <-> ps ) $.
    3bitr4g.3 $e |- ( ta <-> ch ) $.
    $( More general version of ~ 3bitr4i .  Useful for converting definitions
       in a formula.  (Contributed by NM, 5-Aug-1993.) $)
    3bitr4g $p |- ( ph -> ( th <-> ta ) ) $=
      ( syl5bb syl6bbr ) ADCEDBACGFIHJ $.
  $}

  ${
    bi3ant.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Construct a bi-conditional in antecedent position.  (Contributed by Wolf
       Lammen, 14-May-2013.) $)
    bi3ant $p |- ( ( ( th -> ta ) -> ph ) -> ( ( ( ta -> th ) -> ps ) ->
                                                ( ( th <-> ta ) -> ch ) ) ) $=
      ( wi wb bi1 imim1i bi2 imim3i syl2im ) DEGZAGDEHZAGEDGZBGOBGOCGONADEIJOPB
      DEKJABCOFLM $.
  $}

  $( Express symmetries of theorems in terms of biconditionals.  (Contributed
     by Wolf Lammen, 14-May-2013.) $)
  bisym $p |- ( ( ( ph -> ps ) -> ( ch -> th ) ) -> ( ( ( ps -> ph )
      -> ( th -> ch ) ) -> ( ( ph <-> ps ) -> ( ch <-> th ) ) ) ) $=
    ( wi wb bi3 bi3ant ) CDEDCECDFABCDGH $.

  $( The next three rules are useful for building up wff's around a
     definition, in order to make use of the definition. $)

  ${
    bi.a $e |- ( ph <-> ps ) $.
    $( Introduce an antecedent to both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       6-Feb-2013.) $)
    imbi2i $p |- ( ( ch -> ph ) <-> ( ch -> ps ) ) $=
      ( wb a1i pm5.74i ) CABABECDFG $.
  $}

  ${
    bibi.a $e |- ( ph <-> ps ) $.
    $( Inference adding a biconditional to the left in an equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       7-May-2011.)  (Proof shortened by Wolf Lammen, 16-May-2013.) $)
    bibi2i $p |- ( ( ch <-> ph ) <-> ( ch <-> ps ) ) $=
      ( wb id syl6bb syl6bbr impbii ) CAEZCBEZJCABJFDGKCBAKFDHI $.

    $( Inference adding a biconditional to the right in an equivalence.
       (Contributed by NM, 5-Aug-1993.) $)
    bibi1i $p |- ( ( ph <-> ch ) <-> ( ps <-> ch ) ) $=
      ( wb bicom bibi2i 3bitri ) ACECAECBEBCEACFABCDGCBFH $.

    ${
      bibi12.2 $e |- ( ch <-> th ) $.
      $( The equivalence of two equivalences.  (Contributed by NM,
         5-Aug-1993.) $)
      bibi12i $p |- ( ( ph <-> ch ) <-> ( ps <-> th ) ) $=
        ( wb bibi2i bibi1i bitri ) ACGADGBDGCDAFHABDEIJ $.
    $}
  $}

  ${
    imbid.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduction adding an antecedent to both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.) $)
    imbi2d $p |- ( ph -> ( ( th -> ps ) <-> ( th -> ch ) ) ) $=
      ( wb a1d pm5.74d ) ADBCABCFDEGH $.

    $( Deduction adding a consequent to both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       17-Sep-2013.) $)
    imbi1d $p |- ( ph -> ( ( ps -> th ) <-> ( ch -> th ) ) ) $=
      ( wi biimprd imim1d biimpd impbid ) ABDFCDFACBDABCEGHABCDABCEIHJ $.

    $( Deduction adding a biconditional to the left in an equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       19-May-2013.) $)
    bibi2d $p |- ( ph -> ( ( th <-> ps ) <-> ( th <-> ch ) ) ) $=
      ( wb wi pm5.74i bibi2i pm5.74 3bitr4i pm5.74ri ) ADBFZDCFZADGZABGZFOACGZF
      AMGANGPQOABCEHIADBJADCJKL $.

    $( Deduction adding a biconditional to the right in an equivalence.
       (Contributed by NM, 5-Aug-1993.) $)
    bibi1d $p |- ( ph -> ( ( ps <-> th ) <-> ( ch <-> th ) ) ) $=
      ( wb bibi2d bicom 3bitr4g ) ADBFDCFBDFCDFABCDEGBDHCDHI $.
  $}

  ${
    imbi12d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    imbi12d.2 $e |- ( ph -> ( th <-> ta ) ) $.
    $( Deduction joining two equivalences to form equivalence of implications.
       (Contributed by NM, 5-Aug-1993.) $)
    imbi12d $p |- ( ph -> ( ( ps -> th ) <-> ( ch -> ta ) ) ) $=
      ( wi imbi1d imbi2d bitrd ) ABDHCDHCEHABCDFIADECGJK $.
    $( Deduction joining two equivalences to form equivalence of
       biconditionals.  (Contributed by NM, 5-Aug-1993.) $)
    bibi12d $p |- ( ph -> ( ( ps <-> th ) <-> ( ch <-> ta ) ) ) $=
      ( wb bibi1d bibi2d bitrd ) ABDHCDHCEHABCDFIADECGJK $.
  $}

  $( Theorem *4.84 of [WhiteheadRussell] p. 122.  (Contributed by NM,
     3-Jan-2005.) $)
  imbi1 $p |- ( ( ph <-> ps ) -> ( ( ph -> ch ) <-> ( ps -> ch ) ) ) $=
    ( wb id imbi1d ) ABDZABCGEF $.

  $( Theorem *4.85 of [WhiteheadRussell] p. 122.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 19-May-2013.) $)
  imbi2 $p |- ( ( ph <-> ps ) -> ( ( ch -> ph ) <-> ( ch -> ps ) ) ) $=
    ( wb id imbi2d ) ABDZABCGEF $.

  ${
    imbi1i.1 $e |- ( ph <-> ps ) $.
    $( Introduce a consequent to both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       17-Sep-2013.) $)
    imbi1i $p |- ( ( ph -> ch ) <-> ( ps -> ch ) ) $=
      ( wb wi imbi1 ax-mp ) ABEACFBCFEDABCGH $.
  $}

  ${
    imbi12i.1 $e |- ( ph <-> ps ) $.
    imbi12i.2 $e |- ( ch <-> th ) $.
    $( Join two logical equivalences to form equivalence of implications.
       (Contributed by NM, 5-Aug-1993.) $)
    imbi12i $p |- ( ( ph -> ch ) <-> ( ps -> th ) ) $=
      ( wi imbi2i imbi1i bitri ) ACGADGBDGCDAFHABDEIJ $.
  $}

  $( Theorem *4.86 of [WhiteheadRussell] p. 122.  (Contributed by NM,
     3-Jan-2005.) $)
  bibi1 $p |- ( ( ph <-> ps ) -> ( ( ph <-> ch ) <-> ( ps <-> ch ) ) ) $=
    ( wb id bibi1d ) ABDZABCGEF $.

  $( A wff is equivalent to itself with true antecedent.  (Contributed by NM,
     28-Jan-1996.) $)
  biimt $p |- ( ph -> ( ps <-> ( ph -> ps ) ) ) $=
    ( wi ax-1 pm2.27 impbid2 ) ABABCBADABEF $.

  $( Theorem *5.5 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.5 $p |- ( ph -> ( ( ph -> ps ) <-> ps ) ) $=
    ( wi biimt bicomd ) ABABCABDE $.

  ${
    a1bi.1 $e |- ph $.
    $( Inference rule introducing a theorem as an antecedent.  (Contributed by
       NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 11-Nov-2012.) $)
    a1bi $p |- ( ps <-> ( ph -> ps ) ) $=
      ( wi wb biimt ax-mp ) ABABDECABFG $.
  $}

  $( Theorem *5.501 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.)  (Revised by NM, 24-Jan-2013.) $)
  pm5.501 $p |- ( ph -> ( ps <-> ( ph <-> ps ) ) ) $=
    ( wb pm5.1im bi1 com12 impbid ) ABABCZABDHABABEFG $.

  $( Implication in terms of implication and biconditional.  (Contributed by
     NM, 31-Mar-1994.)  (Proof shortened by Wolf Lammen, 24-Jan-2013.) $)
  ibib $p |- ( ( ph -> ps ) <-> ( ph -> ( ph <-> ps ) ) ) $=
    ( wb pm5.501 pm5.74i ) ABABCABDE $.

  $( Implication in terms of implication and biconditional.  (Contributed by
     NM, 29-Apr-2005.)  (Proof shortened by Wolf Lammen, 21-Dec-2013.) $)
  ibibr $p |- ( ( ph -> ps ) <-> ( ph -> ( ps <-> ph ) ) ) $=
    ( wb pm5.501 bicom syl6bb pm5.74i ) ABBACZABABCHABDABEFG $.

  ${
    tbt.1 $e |- ph $.
    $( A wff is equivalent to its equivalence with truth.  (Contributed by NM,
       18-Aug-1993.)  (Proof shortened by Andrew Salmon, 13-May-2011.) $)
    tbt $p |- ( ps <-> ( ps <-> ph ) ) $=
      ( wb ibibr pm5.74ri ax-mp ) ABBADZDCABHABEFG $.
  $}

  $( Logical equivalence of commuted antecedents.  Part of Theorem *4.87 of
     [WhiteheadRussell] p. 122.  (Contributed by NM, 5-Aug-1993.) $)
  bi2.04 $p |- ( ( ph -> ( ps -> ch ) ) <-> ( ps -> ( ph -> ch ) ) ) $=
    ( wi pm2.04 impbii ) ABCDDBACDDABCEBACEF $.

  $( Antecedent absorption implication.  Theorem *5.4 of [WhiteheadRussell]
     p. 125.  (Contributed by NM, 5-Aug-1993.) $)
  pm5.4 $p |- ( ( ph -> ( ph -> ps ) ) <-> ( ph -> ps ) ) $=
    ( wi pm2.43 ax-1 impbii ) AABCZCGABDGAEF $.

  $( Distributive law for implication.  Compare Theorem *5.41 of
     [WhiteheadRussell] p. 125.  (Contributed by NM, 5-Aug-1993.) $)
  imdi $p |- ( ( ph -> ( ps -> ch ) ) <->
               ( ( ph -> ps ) -> ( ph -> ch ) ) ) $=
    ( wi ax-2 pm2.86 impbii ) ABCDDABDACDDABCEABCFG $.

  $( Theorem *5.41 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 12-Oct-2012.) $)
  pm5.41 $p |- ( ( ( ph -> ps ) -> ( ph -> ch ) ) <->
                ( ph -> ( ps -> ch ) ) ) $=
    ( wi imdi bicomi ) ABCDDABDACDDABCEF $.

  $( Simplify an implication between two implications when the antecedent of
     the first is a consequence of the antecedent of the second.  The reverse
     form is useful in producing the successor step in induction proofs.
     (Contributed by Paul Chapman, 22-Jun-2011.)  (Proof shortened by Wolf
     Lammen, 14-Sep-2013.) $)
  imim21b $p |- ( ( ps -> ph ) -> ( ( ( ph -> ch ) -> ( ps -> th ) ) <->
                                    ( ps -> ( ch -> th ) ) ) ) $=
    ( wi bi2.04 wb pm5.5 imbi1d imim2i pm5.74d syl5bb ) ACEZBDEEBMDEZEBAEZBCDEZ
    EMBDFOBNPANPGBAMCDACHIJKL $.

  ${
    imp3.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( Importation deduction.  (Contributed by NM, 31-Mar-1994.)  (Revised by
       NM, 24-Mar-2013.) $)
    imp3a $p |- ( ph -> ( ( ps /\ ch ) -> th ) ) $=
      ( wa wi com3l imp com12 ) BCFADBCADGABCDEHIJ $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp31 $p |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $=
      ( wa wi imp ) ABFCDABCDGEHH $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp32 $p |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $=
      ( wa imp3a imp ) ABCFDABCDEGH $.
  $}

  ${
    exp3a.1 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( Exportation deduction.  (Contributed by NM, 20-Aug-1993.)  (Revised by
       NM, 24-Mar-2013.) $)
    exp3a $p |- ( ph -> ( ps -> ( ch -> th ) ) ) $=
      ( wi wa com12 ex com3r ) BCADBCADFABCGDEHIJ $.

    $( A deduction version of exportation, followed by importation.
       (Contributed by NM, 6-Sep-2008.) $)
    expdimp $p |- ( ( ph /\ ps ) -> ( ch -> th ) ) $=
      ( wi exp3a imp ) ABCDFABCDEGH $.
  $}

  ${
    impancom.1 $e |- ( ( ph /\ ps ) -> ( ch -> th ) ) $.
    $( Mixed importation/commutation inference.  (Contributed by NM,
       22-Jun-2013.) $)
    impancom $p |- ( ( ph /\ ch ) -> ( ps -> th ) ) $=
      ( wi ex com23 imp ) ACBDFABCDABCDFEGHI $.
  $}

  $( Theorem *3.3 (Exp) of [WhiteheadRussell] p. 112.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 24-Mar-2013.) $)
  pm3.3 $p |- ( ( ( ph /\ ps ) -> ch ) -> ( ph -> ( ps -> ch ) ) ) $=
    ( wa wi id exp3a ) ABDCEZABCHFG $.

  $( Theorem *3.31 (Imp) of [WhiteheadRussell] p. 112.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 24-Mar-2013.) $)
  pm3.31 $p |- ( ( ph -> ( ps -> ch ) ) -> ( ( ph /\ ps ) -> ch ) ) $=
    ( wi id imp3a ) ABCDDZABCGEF $.

  $( Import-export theorem.  Part of Theorem *4.87 of [WhiteheadRussell]
     p. 122.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 24-Mar-2013.) $)
  impexp $p |- ( ( ( ph /\ ps ) -> ch ) <-> ( ph -> ( ps -> ch ) ) ) $=
    ( wa wi pm3.3 pm3.31 impbii ) ABDCEABCEEABCFABCGH $.

  $( Join antecedents with conjunction.  Theorem *3.21 of [WhiteheadRussell]
     p. 111.  (Contributed by NM, 5-Aug-1993.) $)
  pm3.21 $p |- ( ph -> ( ps -> ( ps /\ ph ) ) ) $=
    ( wa pm3.2 com12 ) BABACBADE $.

  $( Theorem *3.22 of [WhiteheadRussell] p. 111.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 13-Nov-2012.) $)
  pm3.22 $p |- ( ( ph /\ ps ) -> ( ps /\ ph ) ) $=
    ( wa pm3.21 imp ) ABBACABDE $.

  $( Commutative law for conjunction.  Theorem *4.3 of [WhiteheadRussell]
     p. 118.  (Contributed by NM, 25-Jun-1998.)  (Proof shortened by Wolf
     Lammen, 4-Nov-2012.) $)
  ancom $p |- ( ( ph /\ ps ) <-> ( ps /\ ph ) ) $=
    ( wa pm3.22 impbii ) ABCBACABDBADE $.

  ${
    ancomd.1 $e |- ( ph -> ( ps /\ ch ) ) $.
    $( Commutation of conjuncts in consequent.  (Contributed by Jeff Hankins,
       14-Aug-2009.) $)
    ancomd $p |- ( ph -> ( ch /\ ps ) ) $=
      ( wa ancom sylib ) ABCECBEDBCFG $.
  $}

  ${
    ancoms.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( Inference commuting conjunction in antecedent.  (Contributed by NM,
       21-Apr-1994.) $)
    ancoms $p |- ( ( ps /\ ph ) -> ch ) $=
      ( expcom imp ) BACABCDEF $.
  $}

  ${
    ancomsd.1 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( Deduction commuting conjunction in antecedent.  (Contributed by NM,
       12-Dec-2004.) $)
    ancomsd $p |- ( ph -> ( ( ch /\ ps ) -> th ) ) $=
      ( wa ancom syl5bi ) CBFBCFADCBGEH $.
  $}

  ${
    pm3.2i.1 $e |- ph $.
    pm3.2i.2 $e |- ps $.
    $( Infer conjunction of premises.  (Contributed by NM, 5-Aug-1993.) $)
    pm3.2i $p |- ( ph /\ ps ) $=
      ( wa pm3.2 mp2 ) ABABECDABFG $.
  $}

  $( Nested conjunction of antecedents.  (Contributed by NM, 5-Aug-1993.) $)
  pm3.43i $p |- ( ( ph -> ps ) ->
                ( ( ph -> ch ) -> ( ph -> ( ps /\ ch ) ) ) ) $=
    ( wa pm3.2 imim3i ) BCBCDABCEF $.

  ${
    simplbi.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Deduction eliminating a conjunct.  (Contributed by NM, 27-May-1998.) $)
    simplbi $p |- ( ph -> ps ) $=
      ( wa biimpi simpld ) ABCABCEDFG $.
  $}

  ${
    simprbi.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Deduction eliminating a conjunct.  (Contributed by NM, 27-May-1998.) $)
    simprbi $p |- ( ph -> ch ) $=
      ( wa biimpi simprd ) ABCABCEDFG $.
  $}

  ${
    adantr.1 $e |- ( ph -> ps ) $.
    $( Inference adding a conjunct to the right of an antecedent.  (Contributed
       by NM, 30-Aug-1993.) $)
    adantr $p |- ( ( ph /\ ch ) -> ps ) $=
      ( a1d imp ) ACBABCDEF $.
  $}

  ${
    adantl.1 $e |- ( ph -> ps ) $.
    $( Inference adding a conjunct to the left of an antecedent.  (Contributed
       by NM, 30-Aug-1993.)  (Proof shortened by Wolf Lammen, 23-Nov-2012.) $)
    adantl $p |- ( ( ch /\ ph ) -> ps ) $=
      ( adantr ancoms ) ACBABCDEF $.
  $}

  ${
    adantld.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction adding a conjunct to the left of an antecedent.  (Contributed
       by NM, 4-May-1994.)  (Proof shortened by Wolf Lammen, 20-Dec-2012.) $)
    adantld $p |- ( ph -> ( ( th /\ ps ) -> ch ) ) $=
      ( wa simpr syl5 ) DBFBACDBGEH $.
  $}

  ${
    adantrd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction adding a conjunct to the right of an antecedent.  (Contributed
       by NM, 4-May-1994.) $)
    adantrd $p |- ( ph -> ( ( ps /\ th ) -> ch ) ) $=
      ( wa simpl syl5 ) BDFBACBDGEH $.
  $}

  ${
    mpan9.1 $e |- ( ph -> ps ) $.
    mpan9.2 $e |- ( ch -> ( ps -> th ) ) $.
    $( Modus ponens conjoining dissimilar antecedents.  (Contributed by NM,
       1-Feb-2008.)  (Proof shortened by Andrew Salmon, 7-May-2011.) $)
    mpan9 $p |- ( ( ph /\ ch ) -> th ) $=
      ( syl5 impcom ) CADABCDEFGH $.
  $}

  ${
    syldan.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    syldan.2 $e |- ( ( ph /\ ch ) -> th ) $.
    $( A syllogism deduction with conjoined antecents.  (Contributed by NM,
       24-Feb-2005.)  (Proof shortened by Wolf Lammen, 6-Apr-2013.) $)
    syldan $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa expcom adantrd mpcom ) CABGDECADBACDFHIJ $.
  $}

  ${
    sylan.1 $e |- ( ph -> ps ) $.
    sylan.2 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference.  (Contributed by NM, 21-Apr-1994.)  (Proof
       shortened by Wolf Lammen, 22-Nov-2012.) $)
    sylan $p |- ( ( ph /\ ch ) -> th ) $=
      ( expcom mpan9 ) ABCDEBCDFGH $.
  $}

  ${
    sylanb.1 $e |- ( ph <-> ps ) $.
    sylanb.2 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference.  (Contributed by NM, 18-May-1994.) $)
    sylanb $p |- ( ( ph /\ ch ) -> th ) $=
      ( biimpi sylan ) ABCDABEGFH $.
  $}

  ${
    sylanbr.1 $e |- ( ps <-> ph ) $.
    sylanbr.2 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference.  (Contributed by NM, 18-May-1994.) $)
    sylanbr $p |- ( ( ph /\ ch ) -> th ) $=
      ( biimpri sylan ) ABCDBAEGFH $.
  $}

  ${
    sylan2.1 $e |- ( ph -> ch ) $.
    sylan2.2 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference.  (Contributed by NM, 21-Apr-1994.)  (Proof
       shortened by Wolf Lammen, 22-Nov-2012.) $)
    sylan2 $p |- ( ( ps /\ ph ) -> th ) $=
      ( adantl syldan ) BACDACBEGFH $.
  $}

  ${
    sylan2b.1 $e |- ( ph <-> ch ) $.
    sylan2b.2 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference.  (Contributed by NM, 21-Apr-1994.) $)
    sylan2b $p |- ( ( ps /\ ph ) -> th ) $=
      ( biimpi sylan2 ) ABCDACEGFH $.
  $}

  ${
    sylan2br.1 $e |- ( ch <-> ph ) $.
    sylan2br.2 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference.  (Contributed by NM, 21-Apr-1994.) $)
    sylan2br $p |- ( ( ps /\ ph ) -> th ) $=
      ( biimpri sylan2 ) ABCDCAEGFH $.
  $}

  ${
    syl2an.1 $e |- ( ph -> ps ) $.
    syl2an.2 $e |- ( ta -> ch ) $.
    syl2an.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A double syllogism inference.  (Contributed by NM, 31-Jan-1997.) $)
    syl2an $p |- ( ( ph /\ ta ) -> th ) $=
      ( sylan sylan2 ) EACDGABCDFHIJ $.

    $( A double syllogism inference.  (Contributed by NM, 17-Sep-2013.) $)
    syl2anr $p |- ( ( ta /\ ph ) -> th ) $=
      ( syl2an ancoms ) AEDABCDEFGHIJ $.
  $}

  ${
    syl2anb.1 $e |- ( ph <-> ps ) $.
    syl2anb.2 $e |- ( ta <-> ch ) $.
    syl2anb.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A double syllogism inference.  (Contributed by NM, 29-Jul-1999.) $)
    syl2anb $p |- ( ( ph /\ ta ) -> th ) $=
      ( sylanb sylan2b ) EACDGABCDFHIJ $.
  $}

  ${
    syl2anbr.1 $e |- ( ps <-> ph ) $.
    syl2anbr.2 $e |- ( ch <-> ta ) $.
    syl2anbr.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A double syllogism inference.  (Contributed by NM, 29-Jul-1999.) $)
    syl2anbr $p |- ( ( ph /\ ta ) -> th ) $=
      ( sylanbr sylan2br ) EACDGABCDFHIJ $.
  $}

  ${
    syland.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syland.2 $e |- ( ph -> ( ( ch /\ th ) -> ta ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 15-Dec-2004.) $)
    syland $p |- ( ph -> ( ( ps /\ th ) -> ta ) ) $=
      ( wi exp3a syld imp3a ) ABDEABCDEHFACDEGIJK $.
  $}

  ${
    sylan2d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    sylan2d.2 $e |- ( ph -> ( ( th /\ ch ) -> ta ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 15-Dec-2004.) $)
    sylan2d $p |- ( ph -> ( ( th /\ ps ) -> ta ) ) $=
      ( ancomsd syland ) ABDEABCDEFADCEGHIH $.
  $}

  ${
    syl2and.1 $e |- ( ph -> ( ps -> ch ) ) $.
    syl2and.2 $e |- ( ph -> ( th -> ta ) ) $.
    syl2and.3 $e |- ( ph -> ( ( ch /\ ta ) -> et ) ) $.
    $( A syllogism deduction.  (Contributed by NM, 15-Dec-2004.) $)
    syl2and $p |- ( ph -> ( ( ps /\ th ) -> et ) ) $=
      ( sylan2d syland ) ABCDFGADECFHIJK $.
  $}

  ${
    biimpa.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Inference from a logical equivalence.  (Contributed by NM,
       3-May-1994.) $)
    biimpa $p |- ( ( ph /\ ps ) -> ch ) $=
      ( biimpd imp ) ABCABCDEF $.

    $( Inference from a logical equivalence.  (Contributed by NM,
       3-May-1994.) $)
    biimpar $p |- ( ( ph /\ ch ) -> ps ) $=
      ( biimprd imp ) ACBABCDEF $.

    $( Inference from a logical equivalence.  (Contributed by NM,
       3-May-1994.) $)
    biimpac $p |- ( ( ps /\ ph ) -> ch ) $=
      ( biimpcd imp ) BACABCDEF $.

    $( Inference from a logical equivalence.  (Contributed by NM,
       3-May-1994.) $)
    biimparc $p |- ( ( ch /\ ph ) -> ps ) $=
      ( biimprcd imp ) CABABCDEF $.
  $}

  $( Introduction of antecedent as conjunct.  Theorem *4.73 of
     [WhiteheadRussell] p. 121.  (Contributed by NM, 30-Mar-1994.)  (Revised by
     NM, 24-Mar-2013.) $)
  iba $p |- ( ph -> ( ps <-> ( ps /\ ph ) ) ) $=
    ( wa pm3.21 simpl impbid1 ) ABBACABDBAEF $.

  $( Introduction of antecedent as conjunct.  (Contributed by NM, 5-Dec-1995.)
     (Revised by NM, 24-Mar-2013.) $)
  ibar $p |- ( ph -> ( ps <-> ( ph /\ ps ) ) ) $=
    ( wa pm3.2 simpr impbid1 ) ABABCABDABEF $.

  ${
    biantru.1 $e |- ph $.
    $( A wff is equivalent to its conjunction with truth.  (Contributed by NM,
       5-Aug-1993.) $)
    biantru $p |- ( ps <-> ( ps /\ ph ) ) $=
      ( wa wb iba ax-mp ) ABBADECABFG $.
  $}

  ${
    biantrur.1 $e |- ph $.
    $( A wff is equivalent to its conjunction with truth.  (Contributed by NM,
       3-Aug-1994.) $)
    biantrur $p |- ( ps <-> ( ph /\ ps ) ) $=
      ( wa wb ibar ax-mp ) ABABDECABFG $.
  $}

  ${
    biantrud.1 $e |- ( ph -> ps ) $.
    $( A wff is equivalent to its conjunction with truth.  (Contributed by NM,
       2-Aug-1994.)  (Proof shortened by Wolf Lammen, 23-Oct-2013.) $)
    biantrud $p |- ( ph -> ( ch <-> ( ch /\ ps ) ) ) $=
      ( wa wb iba syl ) ABCCBEFDBCGH $.

    $( A wff is equivalent to its conjunction with truth.  (Contributed by NM,
       1-May-1995.)  (Proof shortened by Andrew Salmon, 7-May-2011.) $)
    biantrurd $p |- ( ph -> ( ch <-> ( ps /\ ch ) ) ) $=
      ( wa wb ibar syl ) ABCBCEFDBCGH $.
  $}

  ${
    jca.1 $e |- ( ph -> ps ) $.
    jca.2 $e |- ( ph -> ch ) $.
    $( Deduce conjunction of the consequents of two implications ("join
       consequents with 'and'").  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Wolf Lammen, 25-Oct-2012.) $)
    jca $p |- ( ph -> ( ps /\ ch ) ) $=
      ( wa pm3.2 sylc ) ABCBCFDEBCGH $.
  $}

  ${
    jcad.1 $e |- ( ph -> ( ps -> ch ) ) $.
    jcad.2 $e |- ( ph -> ( ps -> th ) ) $.
    $( Deduction conjoining the consequents of two implications.  (Contributed
       by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 23-Jul-2013.) $)
    jcad $p |- ( ph -> ( ps -> ( ch /\ th ) ) ) $=
      ( wa pm3.2 syl6c ) ABCDCDGEFCDHI $.
  $}

  ${
    jca31.1 $e |- ( ph -> ps ) $.
    jca31.2 $e |- ( ph -> ch ) $.
    jca31.3 $e |- ( ph -> th ) $.
    $( Join three consequents.  (Contributed by Jeff Hankins, 1-Aug-2009.) $)
    jca31 $p |- ( ph -> ( ( ps /\ ch ) /\ th ) ) $=
      ( wa jca ) ABCHDABCEFIGI $.

    $( Join three consequents.  (Contributed by FL, 1-Aug-2009.) $)
    jca32 $p |- ( ph -> ( ps /\ ( ch /\ th ) ) ) $=
      ( wa jca ) ABCDHEACDFGII $.
  $}

  ${
    jcai.1 $e |- ( ph -> ps ) $.
    jcai.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction replacing implication with conjunction.  (Contributed by NM,
       5-Aug-1993.) $)
    jcai $p |- ( ph -> ( ps /\ ch ) ) $=
      ( mpd jca ) ABCDABCDEFG $.
  $}

  ${
    jctil.1 $e |- ( ph -> ps ) $.
    jctil.2 $e |- ch $.
    $( Inference conjoining a theorem to left of consequent in an implication.
       (Contributed by NM, 31-Dec-1993.) $)
    jctil $p |- ( ph -> ( ch /\ ps ) ) $=
      ( a1i jca ) ACBCAEFDG $.

    $( Inference conjoining a theorem to right of consequent in an
       implication.  (Contributed by NM, 31-Dec-1993.) $)
    jctir $p |- ( ph -> ( ps /\ ch ) ) $=
      ( a1i jca ) ABCDCAEFG $.
  $}

  ${
    jctl.1 $e |- ps $.
    $( Inference conjoining a theorem to the left of a consequent.
       (Contributed by NM, 31-Dec-1993.)  (Proof shortened by Wolf Lammen,
       24-Oct-2012.) $)
    jctl $p |- ( ph -> ( ps /\ ph ) ) $=
      ( id jctil ) AABADCE $.

    $( Inference conjoining a theorem to the right of a consequent.
       (Contributed by NM, 18-Aug-1993.)  (Proof shortened by Wolf Lammen,
       24-Oct-2012.) $)
    jctr $p |- ( ph -> ( ph /\ ps ) ) $=
      ( id jctir ) AABADCE $.
  $}

  ${
    jctild.1 $e |- ( ph -> ( ps -> ch ) ) $.
    jctild.2 $e |- ( ph -> th ) $.
    $( Deduction conjoining a theorem to left of consequent in an implication.
       (Contributed by NM, 21-Apr-2005.) $)
    jctild $p |- ( ph -> ( ps -> ( th /\ ch ) ) ) $=
      ( a1d jcad ) ABDCADBFGEH $.
  $}

  ${
    jctird.1 $e |- ( ph -> ( ps -> ch ) ) $.
    jctird.2 $e |- ( ph -> th ) $.
    $( Deduction conjoining a theorem to right of consequent in an
       implication.  (Contributed by NM, 21-Apr-2005.) $)
    jctird $p |- ( ph -> ( ps -> ( ch /\ th ) ) ) $=
      ( a1d jcad ) ABCDEADBFGH $.
  $}

  $( Conjoin antecedent to left of consequent.  (Contributed by NM,
     15-Aug-1994.) $)
  ancl $p |- ( ( ph -> ps ) -> ( ph -> ( ph /\ ps ) ) ) $=
    ( wa pm3.2 a2i ) ABABCABDE $.

  $( Conjoin antecedent to left of consequent.  Theorem *4.7 of
     [WhiteheadRussell] p. 120.  (Contributed by NM, 25-Jul-1999.)  (Proof
     shortened by Wolf Lammen, 24-Mar-2013.) $)
  anclb $p |- ( ( ph -> ps ) <-> ( ph -> ( ph /\ ps ) ) ) $=
    ( wa ibar pm5.74i ) ABABCABDE $.

  $( Theorem *5.42 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.42 $p |- ( ( ph -> ( ps -> ch ) ) <->
                ( ph -> ( ps -> ( ph /\ ch ) ) ) ) $=
    ( wi wa ibar imbi2d pm5.74i ) ABCDBACEZDACIBACFGH $.

  $( Conjoin antecedent to right of consequent.  (Contributed by NM,
     15-Aug-1994.) $)
  ancr $p |- ( ( ph -> ps ) -> ( ph -> ( ps /\ ph ) ) ) $=
    ( wa pm3.21 a2i ) ABBACABDE $.

  $( Conjoin antecedent to right of consequent.  (Contributed by NM,
     25-Jul-1999.)  (Proof shortened by Wolf Lammen, 24-Mar-2013.) $)
  ancrb $p |- ( ( ph -> ps ) <-> ( ph -> ( ps /\ ph ) ) ) $=
    ( wa iba pm5.74i ) ABBACABDE $.

  ${
    ancli.1 $e |- ( ph -> ps ) $.
    $( Deduction conjoining antecedent to left of consequent.  (Contributed by
       NM, 12-Aug-1993.) $)
    ancli $p |- ( ph -> ( ph /\ ps ) ) $=
      ( id jca ) AABADCE $.
  $}

  ${
    ancri.1 $e |- ( ph -> ps ) $.
    $( Deduction conjoining antecedent to right of consequent.  (Contributed by
       NM, 15-Aug-1994.) $)
    ancri $p |- ( ph -> ( ps /\ ph ) ) $=
      ( id jca ) ABACADE $.
  $}

  ${
    ancld.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction conjoining antecedent to left of consequent in nested
       implication.  (Contributed by NM, 15-Aug-1994.)  (Proof shortened by
       Wolf Lammen, 1-Nov-2012.) $)
    ancld $p |- ( ph -> ( ps -> ( ps /\ ch ) ) ) $=
      ( idd jcad ) ABBCABEDF $.
  $}

  ${
    ancrd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction conjoining antecedent to right of consequent in nested
       implication.  (Contributed by NM, 15-Aug-1994.)  (Proof shortened by
       Wolf Lammen, 1-Nov-2012.) $)
    ancrd $p |- ( ph -> ( ps -> ( ch /\ ps ) ) ) $=
      ( idd jcad ) ABCBDABEF $.
  $}

  $( Conjoin antecedent to left of consequent in nested implication.
     (Contributed by NM, 10-Aug-1994.)  (Proof shortened by Wolf Lammen,
     14-Jul-2013.) $)
  anc2l $p |- ( ( ph -> ( ps -> ch ) ) -> ( ph -> ( ps -> ( ph /\ ch ) ) ) ) $=
    ( wi wa pm5.42 biimpi ) ABCDDABACEDDABCFG $.

  $( Conjoin antecedent to right of consequent in nested implication.
     (Contributed by NM, 15-Aug-1994.) $)
  anc2r $p |- ( ( ph -> ( ps -> ch ) ) -> ( ph -> ( ps -> ( ch /\ ph ) ) ) ) $=
    ( wi wa pm3.21 imim2d a2i ) ABCDBCAEZDACIBACFGH $.

  ${
    anc2li.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction conjoining antecedent to left of consequent in nested
       implication.  (Contributed by NM, 10-Aug-1994.)  (Proof shortened by
       Wolf Lammen, 7-Dec-2012.) $)
    anc2li $p |- ( ph -> ( ps -> ( ph /\ ch ) ) ) $=
      ( id jctild ) ABCADAEF $.
  $}

  ${
    anc2ri.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction conjoining antecedent to right of consequent in nested
       implication.  (Contributed by NM, 15-Aug-1994.)  (Proof shortened by
       Wolf Lammen, 7-Dec-2012.) $)
    anc2ri $p |- ( ph -> ( ps -> ( ch /\ ph ) ) ) $=
      ( id jctird ) ABCADAEF $.
  $}

  $( Theorem *3.41 of [WhiteheadRussell] p. 113.  (Contributed by NM,
     3-Jan-2005.) $)
  pm3.41 $p |- ( ( ph -> ch ) -> ( ( ph /\ ps ) -> ch ) ) $=
    ( wa simpl imim1i ) ABDACABEF $.

  $( Theorem *3.42 of [WhiteheadRussell] p. 113.  (Contributed by NM,
     3-Jan-2005.) $)
  pm3.42 $p |- ( ( ps -> ch ) -> ( ( ph /\ ps ) -> ch ) ) $=
    ( wa simpr imim1i ) ABDBCABEF $.

  $( Conjunction implies implication.  Theorem *3.4 of [WhiteheadRussell]
     p. 113.  (Contributed by NM, 31-Jul-1995.) $)
  pm3.4 $p |- ( ( ph /\ ps ) -> ( ph -> ps ) ) $=
    ( wa simpr a1d ) ABCBAABDE $.

  $( Conjunction with implication.  Compare Theorem *4.45 of [WhiteheadRussell]
     p. 119.  (Contributed by NM, 17-May-1998.) $)
  pm4.45im $p |- ( ph <-> ( ph /\ ( ps -> ph ) ) ) $=
    ( wi wa ax-1 ancli simpl impbii ) AABACZDAIABEFAIGH $.

  ${
    anim12d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    anim12d.2 $e |- ( ph -> ( th -> ta ) ) $.
    $( Conjoin antecedents and consequents in a deduction.  (Contributed by NM,
       3-Apr-1994.)  (Proof shortened by Wolf Lammen, 18-Dec-2013.) $)
    anim12d $p |- ( ph -> ( ( ps /\ th ) -> ( ch /\ ta ) ) ) $=
      ( wa idd syl2and ) ABCDECEHZFGAKIJ $.
  $}

  ${
    anim1d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Add a conjunct to right of antecedent and consequent in a deduction.
       (Contributed by NM, 3-Apr-1994.) $)
    anim1d $p |- ( ph -> ( ( ps /\ th ) -> ( ch /\ th ) ) ) $=
      ( idd anim12d ) ABCDDEADFG $.

    $( Add a conjunct to left of antecedent and consequent in a deduction.
       (Contributed by NM, 5-Aug-1993.) $)
    anim2d $p |- ( ph -> ( ( th /\ ps ) -> ( th /\ ch ) ) ) $=
      ( idd anim12d ) ADDBCADFEG $.
  $}

  ${
    anim12i.1 $e |- ( ph -> ps ) $.
    anim12i.2 $e |- ( ch -> th ) $.
    $( Conjoin antecedents and consequents of two premises.  (Contributed by
       NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 14-Dec-2013.) $)
    anim12i $p |- ( ( ph /\ ch ) -> ( ps /\ th ) ) $=
      ( wa id syl2an ) ABDBDGZCEFJHI $.
  $}

  ${
    anim1i.1 $e |- ( ph -> ps ) $.
    $( Introduce conjunct to both sides of an implication.  (Contributed by NM,
       5-Aug-1993.) $)
    anim1i $p |- ( ( ph /\ ch ) -> ( ps /\ ch ) ) $=
      ( id anim12i ) ABCCDCEF $.

    $( Introduce conjunct to both sides of an implication.  (Contributed by NM,
       5-Aug-1993.) $)
    anim2i $p |- ( ( ch /\ ph ) -> ( ch /\ ps ) ) $=
      ( id anim12i ) CCABCEDF $.
  $}

  ${
    anim12ii.1 $e |- ( ph -> ( ps -> ch ) ) $.
    anim12ii.2 $e |- ( th -> ( ps -> ta ) ) $.
    $( Conjoin antecedents and consequents in a deduction.  (Contributed by NM,
       11-Nov-2007.)  (Proof shortened by Wolf Lammen, 19-Jul-2013.) $)
    anim12ii $p |- ( ( ph /\ th ) -> ( ps -> ( ch /\ ta ) ) ) $=
      ( wa wi adantr adantl jcad ) ADHBCEABCIDFJDBEIAGKL $.
  $}

  $( Theorem *3.47 of [WhiteheadRussell] p. 113.  It was proved by Leibniz, and
     it evidently pleased him enough to call it 'praeclarum theorema' (splendid
     theorem).  (Contributed by NM, 12-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 7-Apr-2013.) $)
  prth $p |- ( ( ( ph -> ps ) /\ ( ch -> th ) ) ->
              ( ( ph /\ ch ) -> ( ps /\ th ) ) ) $=
    ( wi wa simpl simpr anim12d ) ABEZCDEZFABCDJKGJKHI $.

  $( Theorem *3.33 (Syll) of [WhiteheadRussell] p. 112.  (Contributed by NM,
     3-Jan-2005.) $)
  pm3.33 $p |- ( ( ( ph -> ps ) /\ ( ps -> ch ) ) -> ( ph -> ch ) ) $=
    ( wi imim1 imp ) ABDBCDACDABCEF $.

  $( Theorem *3.34 (Syll) of [WhiteheadRussell] p. 112.  (Contributed by NM,
     3-Jan-2005.) $)
  pm3.34 $p |- ( ( ( ps -> ch ) /\ ( ph -> ps ) ) -> ( ph -> ch ) ) $=
    ( wi imim2 imp ) BCDABDACDBCAEF $.

  $( Conjunctive detachment.  Theorem *3.35 of [WhiteheadRussell] p. 112.
     (Contributed by NM, 14-Dec-2002.) $)
  pm3.35 $p |- ( ( ph /\ ( ph -> ps ) ) -> ps ) $=
    ( wi pm2.27 imp ) AABCBABDE $.

  $( Theorem *5.31 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.31 $p |- ( ( ch /\ ( ph -> ps ) ) -> ( ph -> ( ps /\ ch ) ) ) $=
    ( wi wa pm3.21 imim2d imp ) CABDABCEZDCBIACBFGH $.

  ${
    imp4.1 $e |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $.
    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp4a $p |- ( ph -> ( ps -> ( ( ch /\ th ) -> ta ) ) ) $=
      ( wi wa impexp syl6ibr ) ABCDEGGCDHEGFCDEIJ $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp4b $p |- ( ( ph /\ ps ) -> ( ( ch /\ th ) -> ta ) ) $=
      ( wa wi imp4a imp ) ABCDGEHABCDEFIJ $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp4c $p |- ( ph -> ( ( ( ps /\ ch ) /\ th ) -> ta ) ) $=
      ( wa wi imp3a ) ABCGDEABCDEHFII $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp4d $p |- ( ph -> ( ( ps /\ ( ch /\ th ) ) -> ta ) ) $=
      ( wa imp4a imp3a ) ABCDGEABCDEFHI $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp41 $p |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th ) -> ta ) $=
      ( wa wi imp imp31 ) ABGCDEABCDEHHFIJ $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp42 $p |- ( ( ( ph /\ ( ps /\ ch ) ) /\ th ) -> ta ) $=
      ( wa wi imp32 imp ) ABCGGDEABCDEHFIJ $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp43 $p |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) -> ta ) $=
      ( wa imp4b imp ) ABGCDGEABCDEFHI $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp44 $p |- ( ( ph /\ ( ( ps /\ ch ) /\ th ) ) -> ta ) $=
      ( wa imp4c imp ) ABCGDGEABCDEFHI $.

    $( An importation inference.  (Contributed by NM, 26-Apr-1994.) $)
    imp45 $p |- ( ( ph /\ ( ps /\ ( ch /\ th ) ) ) -> ta ) $=
      ( wa imp4d imp ) ABCDGGEABCDEFHI $.

  $}

  ${
    imp5.1 $e |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $.
    $( An importation inference.  (Contributed by Jeff Hankins, 7-Jul-2009.) $)
    imp5a $p |- ( ph -> ( ps -> ( ch -> ( ( th /\ ta ) -> et ) ) ) ) $=
      ( wi wa pm3.31 syl8 ) ABCDEFHHDEIFHGDEFJK $.

    $( An importation inference.  (Contributed by Jeff Hankins, 7-Jul-2009.) $)
    imp5d $p |- ( ( ( ph /\ ps ) /\ ch ) -> ( ( th /\ ta ) -> et ) ) $=
      ( wa wi imp31 imp3a ) ABHCHDEFABCDEFIIGJK $.

    $( An importation inference.  (Contributed by Jeff Hankins, 7-Jul-2009.) $)
    imp5g $p |- ( ( ph /\ ps ) -> ( ( ( ch /\ th ) /\ ta ) -> et ) ) $=
      ( wa wi imp imp4c ) ABHCDEFABCDEFIIIGJK $.

    $( An importation inference.  (Contributed by Jeff Hankins, 7-Jul-2009.) $)
    imp55 $p |- ( ( ( ph /\ ( ps /\ ( ch /\ th ) ) ) /\ ta ) -> et ) $=
      ( wa wi imp4a imp42 ) ABCDHEFABCDEFIGJK $.

    $( An importation inference.  (Contributed by Jeff Hankins, 7-Jul-2009.) $)
    imp511 $p |- ( ( ph /\ ( ( ps /\ ( ch /\ th ) ) /\ ta ) ) -> et ) $=
      ( wa wi imp4a imp44 ) ABCDHEFABCDEFIGJK $.
  $}

  ${
    expimpd.1 $e |- ( ( ph /\ ps ) -> ( ch -> th ) ) $.
    $( Exportation followed by a deduction version of importation.
       (Contributed by NM, 6-Sep-2008.) $)
    expimpd $p |- ( ph -> ( ( ps /\ ch ) -> th ) ) $=
      ( wi ex imp3a ) ABCDABCDFEGH $.
  $}

  ${
    exp31.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp31 $p |- ( ph -> ( ps -> ( ch -> th ) ) ) $=
      ( wi wa ex ) ABCDFABGCDEHH $.
  $}

  ${
    exp32.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp32 $p |- ( ph -> ( ps -> ( ch -> th ) ) ) $=
      ( wa ex exp3a ) ABCDABCFDEGH $.
  $}

  ${
    exp4a.1 $e |- ( ph -> ( ps -> ( ( ch /\ th ) -> ta ) ) ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp4a $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wa wi impexp syl6ib ) ABCDGEHCDEHHFCDEIJ $.
  $}

  ${
    exp4b.1 $e |- ( ( ph /\ ps ) -> ( ( ch /\ th ) -> ta ) ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.)  (Proof
       shortened by Wolf Lammen, 23-Nov-2012.) $)
    exp4b $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wa wi ex exp4a ) ABCDEABCDGEHFIJ $.
  $}

  ${
    exp4c.1 $e |- ( ph -> ( ( ( ps /\ ch ) /\ th ) -> ta ) ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp4c $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wi wa exp3a ) ABCDEGABCHDEFII $.
  $}

  ${
    exp4d.1 $e |- ( ph -> ( ( ps /\ ( ch /\ th ) ) -> ta ) ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp4d $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wa exp3a exp4a ) ABCDEABCDGEFHI $.
  $}

  ${
    exp41.1 $e |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th ) -> ta ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp41 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wi wa ex exp31 ) ABCDEGABHCHDEFIJ $.
  $}

  ${
    exp42.1 $e |- ( ( ( ph /\ ( ps /\ ch ) ) /\ th ) -> ta ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp42 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wi wa exp31 exp3a ) ABCDEGABCHDEFIJ $.
  $}

  ${
    exp43.1 $e |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) -> ta ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp43 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wa ex exp4b ) ABCDEABGCDGEFHI $.
  $}

  ${
    exp44.1 $e |- ( ( ph /\ ( ( ps /\ ch ) /\ th ) ) -> ta ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp44 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wi wa exp32 exp3a ) ABCDEGABCHDEFIJ $.
  $}

  ${
    exp45.1 $e |- ( ( ph /\ ( ps /\ ( ch /\ th ) ) ) -> ta ) $.
    $( An exportation inference.  (Contributed by NM, 26-Apr-1994.) $)
    exp45 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wa exp32 exp4a ) ABCDEABCDGEFHI $.
  $}

  ${
    expr.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( Export a wff from a right conjunct.  (Contributed by Jeff Hankins,
       30-Aug-2009.) $)
    expr $p |- ( ( ph /\ ps ) -> ( ch -> th ) ) $=
      ( wi exp32 imp ) ABCDFABCDEGH $.
  $}

  ${
    exp5c.1 $e |- ( ph -> ( ( ps /\ ch ) -> ( ( th /\ ta ) -> et ) ) ) $.
    $( An exportation inference.  (Contributed by Jeff Hankins, 7-Jul-2009.) $)
    exp5c $p |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $=
      ( wi wa exp4a exp3a ) ABCDEFHHABCIDEFGJK $.
  $}

  ${
    exp53.1 $e |- ( ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) /\ ta ) -> et ) $.
    $( An exportation inference.  (Contributed by Jeff Hankins,
       30-Aug-2009.) $)
    exp53 $p |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $=
      ( wi wa ex exp43 ) ABCDEFHABICDIIEFGJK $.
  $}

  ${
    expl.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( Export a wff from a left conjunct.  (Contributed by Jeff Hankins,
       28-Aug-2009.) $)
    expl $p |- ( ph -> ( ( ps /\ ch ) -> th ) ) $=
      ( exp31 imp3a ) ABCDABCDEFG $.
  $}

  ${
    impr.1 $e |- ( ( ph /\ ps ) -> ( ch -> th ) ) $.
    $( Import a wff into a right conjunct.  (Contributed by Jeff Hankins,
       30-Aug-2009.) $)
    impr $p |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $=
      ( wi ex imp32 ) ABCDABCDFEGH $.
  $}

  ${
    impl.1 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( Export a wff from a left conjunct.  (Contributed by Mario Carneiro,
       9-Jul-2014.) $)
    impl $p |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $=
      ( exp3a imp31 ) ABCDABCDEFG $.
  $}

  ${
    impac.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Importation with conjunction in consequent.  (Contributed by NM,
       9-Aug-1994.) $)
    impac $p |- ( ( ph /\ ps ) -> ( ch /\ ps ) ) $=
      ( wa ancrd imp ) ABCBEABCDFG $.
  $}

  ${
    exbiri.1 $e |- ( ( ph /\ ps ) -> ( ch <-> th ) ) $.
    $( Inference form of ~ exbir .  (Contributed by Alan Sare, 31-Dec-2011.)
       (Proof shortened by Wolf Lammen, 27-Jan-2013.) $)
    exbiri $p |- ( ph -> ( ps -> ( th -> ch ) ) ) $=
      ( wa biimpar exp31 ) ABDCABFCDEGH $.
  $}

  ${
    pm3.26bda.1 $e |- ( ph -> ( ps <-> ( ch /\ th ) ) ) $.
    $( Deduction eliminating a conjunct.  (Contributed by NM, 22-Oct-2007.) $)
    simprbda $p |- ( ( ph /\ ps ) -> ch ) $=
      ( wa biimpa simpld ) ABFCDABCDFEGH $.

    $( Deduction eliminating a conjunct.  (Contributed by NM, 22-Oct-2007.) $)
    simplbda $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa biimpa simprd ) ABFCDABCDFEGH $.
  $}

  ${
    pm3.26bi2.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Deduction eliminating a conjunct.  (Contributed by Alan Sare,
       31-Dec-2011.) $)
    simplbi2 $p |- ( ps -> ( ch -> ph ) ) $=
      ( wa biimpri ex ) BCAABCEDFG $.
  $}

  $( A theorem similar to the standard definition of the biconditional.
     Definition of [Margaris] p. 49.  (Contributed by NM, 5-Aug-1993.)
     (Revised by NM, 31-Jan-2015.) $)
  dfbi2 $p |- ( ( ph <-> ps ) <-> ( ( ph -> ps ) /\ ( ps -> ph ) ) ) $=
    ( wb wi wa df-bi simpli simpri impbii ) ABCZABDBADEZJKDZKJDZABFZGLMNHI $.

  $( Implication in terms of biconditional and conjunction.  Theorem *4.71 of
     [WhiteheadRussell] p. 120.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 2-Dec-2012.) $)
  pm4.71 $p |- ( ( ph -> ps ) <-> ( ph <-> ( ph /\ ps ) ) ) $=
    ( wa wi wb simpl biantru anclb dfbi2 3bitr4i ) AABCZDZLKADZCABDAKEMLABFGABH
    AKIJ $.

  $( Implication in terms of biconditional and conjunction.  Theorem *4.71 of
     [WhiteheadRussell] p. 120 (with conjunct reversed).  (Contributed by NM,
     25-Jul-1999.) $)
  pm4.71r $p |- ( ( ph -> ps ) <-> ( ph <-> ( ps /\ ph ) ) ) $=
    ( wi wa wb pm4.71 ancom bibi2i bitri ) ABCAABDZEABADZEABFJKAABGHI $.

  ${
    pm4.71i.1 $e |- ( ph -> ps ) $.
    $( Inference converting an implication to a biconditional with
       conjunction.  Inference from Theorem *4.71 of [WhiteheadRussell]
       p. 120.  (Contributed by NM, 4-Jan-2004.) $)
    pm4.71i $p |- ( ph <-> ( ph /\ ps ) ) $=
      ( wi wa wb pm4.71 mpbi ) ABDAABEFCABGH $.
  $}

  ${
    pm4.71ri.1 $e |- ( ph -> ps ) $.
    $( Inference converting an implication to a biconditional with
       conjunction.  Inference from Theorem *4.71 of [WhiteheadRussell] p. 120
       (with conjunct reversed).  (Contributed by NM, 1-Dec-2003.) $)
    pm4.71ri $p |- ( ph <-> ( ps /\ ph ) ) $=
      ( wi wa wb pm4.71r mpbi ) ABDABAEFCABGH $.
  $}

  ${
    pm4.71rd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction converting an implication to a biconditional with
       conjunction.  Deduction from Theorem *4.71 of [WhiteheadRussell]
       p. 120.  (Contributed by NM, 10-Feb-2005.) $)
    pm4.71rd $p |- ( ph -> ( ps <-> ( ch /\ ps ) ) ) $=
      ( wi wa wb pm4.71r sylib ) ABCEBCBFGDBCHI $.
  $}

  $( Theorem *4.24 of [WhiteheadRussell] p. 117.  (Contributed by NM,
     3-Jan-2005.)  (Revised by NM, 14-Mar-2014.) $)
  pm4.24 $p |- ( ph <-> ( ph /\ ph ) ) $=
    ( id pm4.71i ) AAABC $.

  $( Idempotent law for conjunction.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 14-Mar-2014.) $)
  anidm $p |- ( ( ph /\ ph ) <-> ph ) $=
    ( wa pm4.24 bicomi ) AAABACD $.

  $( Obsolete proof of ~ anidm as of 14-Mar-2014.  (Contributed by NM,
     5-Aug-1993.)  (Revised by NM, 6-Nov-2012.) $)
  anidmOLD $p |- ( ( ph /\ ph ) <-> ph ) $=
    ( wa simpl id ancli impbii ) AABAAACAAADEF $.

  $( Obsolete proof of ~ pm4.24 as of 14-Mar-2014.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.24OLD $p |- ( ph <-> ( ph /\ ph ) ) $=
    ( wa anidm bicomi ) AABAACD $.

  ${
    anidms.1 $e |- ( ( ph /\ ph ) -> ps ) $.
    $( Inference from idempotent law for conjunction.  (Contributed by NM,
       15-Jun-1994.) $)
    anidms $p |- ( ph -> ps ) $=
      ( ex pm2.43i ) ABAABCDE $.
  $}

  $( Conjunction idempotence with antecedent.  (Contributed by Roy F. Longton,
     8-Aug-2005.) $)
  anidmdbi $p |- ( ( ph -> ( ps /\ ps ) ) <-> ( ph -> ps ) ) $=
    ( wa anidm imbi2i ) BBCBABDE $.

  ${
    anasss.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( Associative law for conjunction applied to antecedent (eliminates
       syllogism).  (Contributed by NM, 15-Nov-2002.) $)
    anasss $p |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $=
      ( exp31 imp32 ) ABCDABCDEFG $.
  $}

  ${
    anassrs.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( Associative law for conjunction applied to antecedent (eliminates
       syllogism).  (Contributed by NM, 15-Nov-2002.) $)
    anassrs $p |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $=
      ( exp32 imp31 ) ABCDABCDEFG $.
  $}

  $( Associative law for conjunction.  Theorem *4.32 of [WhiteheadRussell]
     p. 118.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 24-Nov-2012.) $)
  anass $p |- ( ( ( ph /\ ps ) /\ ch ) <-> ( ph /\ ( ps /\ ch ) ) ) $=
    ( wa id anassrs anasss impbii ) ABDCDZABCDDZABCJJEFABCIIEGH $.

  ${
    sylanl1.1 $e |- ( ph -> ps ) $.
    sylanl1.2 $e |- ( ( ( ps /\ ch ) /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 10-Mar-2005.) $)
    sylanl1 $p |- ( ( ( ph /\ ch ) /\ th ) -> ta ) $=
      ( wa anim1i sylan ) ACHBCHDEABCFIGJ $.
  $}

  ${
    sylanl2.1 $e |- ( ph -> ch ) $.
    sylanl2.2 $e |- ( ( ( ps /\ ch ) /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 1-Jan-2005.) $)
    sylanl2 $p |- ( ( ( ps /\ ph ) /\ th ) -> ta ) $=
      ( wa anim2i sylan ) BAHBCHDEACBFIGJ $.
  $}

  ${
    sylanr1.1 $e |- ( ph -> ch ) $.
    sylanr1.2 $e |- ( ( ps /\ ( ch /\ th ) ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 9-Apr-2005.) $)
    sylanr1 $p |- ( ( ps /\ ( ph /\ th ) ) -> ta ) $=
      ( wa anim1i sylan2 ) ADHBCDHEACDFIGJ $.
  $}

  ${
    sylanr2.1 $e |- ( ph -> th ) $.
    sylanr2.2 $e |- ( ( ps /\ ( ch /\ th ) ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 9-Apr-2005.) $)
    sylanr2 $p |- ( ( ps /\ ( ch /\ ph ) ) -> ta ) $=
      ( wa anim2i sylan2 ) CAHBCDHEADCFIGJ $.
  $}

  ${
    sylani.1 $e |- ( ph -> ch ) $.
    sylani.2 $e |- ( ps -> ( ( ch /\ th ) -> ta ) ) $.
    $( A syllogism inference.  (Contributed by NM, 2-May-1996.) $)
    sylani $p |- ( ps -> ( ( ph /\ th ) -> ta ) ) $=
      ( wi a1i syland ) BACDEACHBFIGJ $.
  $}

  ${
    sylan2i.1 $e |- ( ph -> th ) $.
    sylan2i.2 $e |- ( ps -> ( ( ch /\ th ) -> ta ) ) $.
    $( A syllogism inference.  (Contributed by NM, 1-Aug-1994.) $)
    sylan2i $p |- ( ps -> ( ( ch /\ ph ) -> ta ) ) $=
      ( wi a1i sylan2d ) BADCEADHBFIGJ $.
  $}

  ${
    syl2ani.1 $e |- ( ph -> ch ) $.
    syl2ani.2 $e |- ( et -> th ) $.
    syl2ani.3 $e |- ( ps -> ( ( ch /\ th ) -> ta ) ) $.
    $( A syllogism inference.  (Contributed by NM, 3-Aug-1999.) $)
    syl2ani $p |- ( ps -> ( ( ph /\ et ) -> ta ) ) $=
      ( sylan2i sylani ) ABCFEGFBCDEHIJK $.
  $}

  ${
    sylan9.1 $e |- ( ph -> ( ps -> ch ) ) $.
    sylan9.2 $e |- ( th -> ( ch -> ta ) ) $.
    $( Nested syllogism inference conjoining dissimilar antecedents.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       7-May-2011.) $)
    sylan9 $p |- ( ( ph /\ th ) -> ( ps -> ta ) ) $=
      ( wi syl9 imp ) ADBEHABCDEFGIJ $.
  $}

  ${
    sylan9r.1 $e |- ( ph -> ( ps -> ch ) ) $.
    sylan9r.2 $e |- ( th -> ( ch -> ta ) ) $.
    $( Nested syllogism inference conjoining dissimilar antecedents.
       (Contributed by NM, 5-Aug-1993.) $)
    sylan9r $p |- ( ( th /\ ph ) -> ( ps -> ta ) ) $=
      ( wi syl9r imp ) DABEHABCDEFGIJ $.
  $}

  ${
    syl2anc.1 $e |- ( ph -> ps ) $.
    syl2anc.2 $e |- ( ph -> ch ) $.
    syl2anc.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( Syllogism inference combined with contraction.  (Contributed by NM,
       16-Mar-2012.) $)
    syl2anc $p |- ( ph -> th ) $=
      ( ex sylc ) ABCDEFBCDGHI $.
  $}

  ${
    sylancl.1 $e |- ( ph -> ps ) $.
    sylancl.2 $e |- ch $.
    sylancl.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( Syllogism inference combined with modus ponens.  (Contributed by Jeff
       Madsen, 2-Sep-2009.) $)
    sylancl $p |- ( ph -> th ) $=
      ( a1i syl2anc ) ABCDECAFHGI $.
  $}

  ${
    sylancr.1 $e |- ps $.
    sylancr.2 $e |- ( ph -> ch ) $.
    sylancr.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( Syllogism inference combined with modus ponens.  (Contributed by Jeff
       Madsen, 2-Sep-2009.) $)
    sylancr $p |- ( ph -> th ) $=
      ( a1i syl2anc ) ABCDBAEHFGI $.
  $}

  ${
    sylanbrc.1 $e |- ( ph -> ps ) $.
    sylanbrc.2 $e |- ( ph -> ch ) $.
    sylanbrc.3 $e |- ( th <-> ( ps /\ ch ) ) $.
    $( Syllogism inference.  (Contributed by Jeff Madsen, 2-Sep-2009.) $)
    sylanbrc $p |- ( ph -> th ) $=
      ( wa jca sylibr ) ABCHDABCEFIGJ $.
  $}

  ${
    sylancb.1 $e |- ( ph <-> ps ) $.
    sylancb.2 $e |- ( ph <-> ch ) $.
    sylancb.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference combined with contraction.  (Contributed by NM,
       3-Sep-2004.) $)
    sylancb $p |- ( ph -> th ) $=
      ( syl2anb anidms ) ADABCDAEFGHI $.
  $}

  ${
    sylancbr.1 $e |- ( ps <-> ph ) $.
    sylancbr.2 $e |- ( ch <-> ph ) $.
    sylancbr.3 $e |- ( ( ps /\ ch ) -> th ) $.
    $( A syllogism inference combined with contraction.  (Contributed by NM,
       3-Sep-2004.) $)
    sylancbr $p |- ( ph -> th ) $=
      ( syl2anbr anidms ) ADABCDAEFGHI $.
  $}

  ${
    sylancom.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    sylancom.2 $e |- ( ( ch /\ ps ) -> th ) $.
    $( Syllogism inference with commutation of antecents.  (Contributed by NM,
       2-Jul-2008.) $)
    sylancom $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa simpr syl2anc ) ABGCBDEABHFI $.
  $}

  ${
    mpdan.1 $e |- ( ph -> ps ) $.
    mpdan.2 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 23-May-1999.)
       (Proof shortened by Wolf Lammen, 22-Nov-2012.) $)
    mpdan $p |- ( ph -> ch ) $=
      ( id syl2anc ) AABCAFDEG $.
  $}

  ${
    mpancom.1 $e |- ( ps -> ph ) $.
    mpancom.2 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( An inference based on modus ponens with commutation of antecedents.
       (Contributed by NM, 28-Oct-2003.)  (Proof shortened by Wolf Lammen,
       7-Apr-2013.) $)
    mpancom $p |- ( ps -> ch ) $=
      ( id syl2anc ) BABCDBFEG $.
  $}

  ${
    mpan.1 $e |- ph $.
    mpan.2 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 30-Aug-1993.)
       (Proof shortened by Wolf Lammen, 7-Apr-2013.) $)
    mpan $p |- ( ps -> ch ) $=
      ( a1i mpancom ) ABCABDFEG $.
  $}

  ${
    mpan2.1 $e |- ps $.
    mpan2.2 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 16-Sep-1993.)
       (Proof shortened by Wolf Lammen, 19-Nov-2012.) $)
    mpan2 $p |- ( ph -> ch ) $=
      ( a1i mpdan ) ABCBADFEG $.
  $}

  ${
    mp2an.1 $e |- ph $.
    mp2an.2 $e |- ps $.
    mp2an.3 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       13-Apr-1995.) $)
    mp2an $p |- ch $=
      ( mpan ax-mp ) BCEABCDFGH $.
  $}

  ${
    mp4an.1 $e |- ph $.
    mp4an.2 $e |- ps $.
    mp4an.3 $e |- ch $.
    mp4an.4 $e |- th $.
    mp4an.5 $e |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by Jeff Madsen,
       15-Jun-2011.) $)
    mp4an $p |- ta $=
      ( wa pm3.2i mp2an ) ABKCDKEABFGLCDHILJM $.
  $}

  ${
    mpan2d.1 $e |- ( ph -> ch ) $.
    mpan2d.2 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( A deduction based on modus ponens.  (Contributed by NM, 12-Dec-2004.) $)
    mpan2d $p |- ( ph -> ( ps -> th ) ) $=
      ( exp3a mpid ) ABCDEABCDFGH $.
  $}

  ${
    mpand.1 $e |- ( ph -> ps ) $.
    mpand.2 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( A deduction based on modus ponens.  (Contributed by NM, 12-Dec-2004.)
       (Proof shortened by Wolf Lammen, 7-Apr-2013.) $)
    mpand $p |- ( ph -> ( ch -> th ) ) $=
      ( ancomsd mpan2d ) ACBDEABCDFGH $.
  $}

  ${
    mpani.1 $e |- ps $.
    mpani.2 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 10-Apr-1994.)
       (Proof shortened by Wolf Lammen, 19-Nov-2012.) $)
    mpani $p |- ( ph -> ( ch -> th ) ) $=
      ( a1i mpand ) ABCDBAEGFH $.
  $}

  ${
    mpan2i.1 $e |- ch $.
    mpan2i.2 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 10-Apr-1994.)
       (Proof shortened by Wolf Lammen, 19-Nov-2012.) $)
    mpan2i $p |- ( ph -> ( ps -> th ) ) $=
      ( a1i mpan2d ) ABCDCAEGFH $.
  $}

  ${
    mp2ani.1 $e |- ps $.
    mp2ani.2 $e |- ch $.
    mp2ani.3 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       12-Dec-2004.) $)
    mp2ani $p |- ( ph -> th ) $=
      ( mpani mpi ) ACDFABCDEGHI $.
  $}

  ${
    mp2and.1 $e |- ( ph -> ps ) $.
    mp2and.2 $e |- ( ph -> ch ) $.
    mp2and.3 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( A deduction based on modus ponens.  (Contributed by NM, 12-Dec-2004.) $)
    mp2and $p |- ( ph -> th ) $=
      ( mpand mpd ) ACDFABCDEGHI $.
  $}

  ${
    mpanl1.1 $e |- ph $.
    mpanl1.2 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 16-Aug-1994.)
       (Proof shortened by Wolf Lammen, 7-Apr-2013.) $)
    mpanl1 $p |- ( ( ps /\ ch ) -> th ) $=
      ( wa jctl sylan ) BABGCDBAEHFI $.
  $}

  ${
    mpanl2.1 $e |- ps $.
    mpanl2.2 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 16-Aug-1994.)
       (Proof shortened by Andrew Salmon, 7-May-2011.) $)
    mpanl2 $p |- ( ( ph /\ ch ) -> th ) $=
      ( wa jctr sylan ) AABGCDABEHFI $.
  $}

  ${
    mpanl12.1 $e |- ph $.
    mpanl12.2 $e |- ps $.
    mpanl12.3 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       13-Jul-2005.) $)
    mpanl12 $p |- ( ch -> th ) $=
      ( mpanl1 mpan ) BCDFABCDEGHI $.
  $}

  ${
    mpanr1.1 $e |- ps $.
    mpanr1.2 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 3-May-1994.)
       (Proof shortened by Andrew Salmon, 7-May-2011.) $)
    mpanr1 $p |- ( ( ph /\ ch ) -> th ) $=
      ( anassrs mpanl2 ) ABCDEABCDFGH $.
  $}

  ${
    mpanr2.1 $e |- ch $.
    mpanr2.2 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 3-May-1994.)
       (Proof shortened by Andrew Salmon, 7-May-2011.)  (Proof shortened by
       Wolf Lammen, 7-Apr-2013.) $)
    mpanr2 $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa jctr sylan2 ) BABCGDBCEHFI $.

    $( Obsolete proof of ~ mpanr2 as of 7-Apr-2013.  (Contributed by NM,
       3-May-1994.)  (Revised by NM, 12-May-2011.) $)
    mpanr2OLD $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa expr mpi ) ABGCDEABCDFHI $.
  $}

  ${
    mpanr12.1 $e |- ps $.
    mpanr12.2 $e |- ch $.
    mpanr12.3 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       24-Jul-2009.) $)
    mpanr12 $p |- ( ph -> th ) $=
      ( mpanr1 mpan2 ) ACDFABCDEGHI $.
  $}

  ${
    mpanlr1.1 $e |- ps $.
    mpanlr1.2 $e |- ( ( ( ph /\ ( ps /\ ch ) ) /\ th ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 30-Dec-2004.)
       (Proof shortened by Wolf Lammen, 7-Apr-2013.) $)
    mpanlr1 $p |- ( ( ( ph /\ ch ) /\ th ) -> ta ) $=
      ( wa jctl sylanl2 ) CABCHDECBFIGJ $.
  $}

  ${
    pm5.74da.1 $e |- ( ( ph /\ ps ) -> ( ch <-> th ) ) $.
    $( Distribution of implication over biconditional (deduction rule).
       (Contributed by NM, 4-May-2007.) $)
    pm5.74da $p |- ( ph -> ( ( ps -> ch ) <-> ( ps -> th ) ) ) $=
      ( wb ex pm5.74d ) ABCDABCDFEGH $.
  $}

  $( Distribution of implication with conjunction.  (Contributed by NM,
     31-May-1999.)  (Proof shortened by Wolf Lammen, 6-Dec-2012.) $)
  imdistan $p |- ( ( ph -> ( ps -> ch ) ) <->
                ( ( ph /\ ps ) -> ( ph /\ ch ) ) ) $=
    ( wi wa pm5.42 impexp bitr4i ) ABCDDABACEZDDABEIDABCFABIGH $.

  ${
    imdistani.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Distribution of implication with conjunction.  (Contributed by NM,
       1-Aug-1994.) $)
    imdistani $p |- ( ( ph /\ ps ) -> ( ph /\ ch ) ) $=
      ( wa anc2li imp ) ABACEABCDFG $.
  $}

  ${
    imdistanri.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Distribution of implication with conjunction.  (Contributed by NM,
       8-Jan-2002.) $)
    imdistanri $p |- ( ( ps /\ ph ) -> ( ch /\ ph ) ) $=
      ( com12 impac ) BACABCDEF $.
  $}

  ${
    imdistand.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( Distribution of implication with conjunction (deduction rule).
       (Contributed by NM, 27-Aug-2004.) $)
    imdistand $p |- ( ph -> ( ( ps /\ ch ) -> ( ps /\ th ) ) ) $=
      ( wi wa imdistan sylib ) ABCDFFBCGBDGFEBCDHI $.
  $}

  ${
    imdistanda.1 $e |- ( ( ph /\ ps ) -> ( ch -> th ) ) $.
    $( Distribution of implication with conjunction (deduction version with
       conjoined antecedent).  (Contributed by Jeff Madsen, 19-Jun-2011.) $)
    imdistanda $p |- ( ph -> ( ( ps /\ ch ) -> ( ps /\ th ) ) ) $=
      ( wi ex imdistand ) ABCDABCDFEGH $.
  $}

  ${
    pm5.32d.1 $e |- ( ph -> ( ps -> ( ch <-> th ) ) ) $.
    $( Distribution of implication over biconditional (deduction rule).
       (Contributed by NM, 29-Oct-1996.)  (Revised by NM, 31-Jan-2015.) $)
    pm5.32d $p |- ( ph -> ( ( ps /\ ch ) <-> ( ps /\ th ) ) ) $=
      ( wa wb wi bi1 syl6 imdistand bi2 impbid ) ABCFBDFABCDABCDGZCDHECDIJKABDC
      ABNDCHECDLJKM $.

    $( Distribution of implication over biconditional (deduction rule).
       (Contributed by NM, 25-Dec-2004.) $)
    pm5.32rd $p |- ( ph -> ( ( ch /\ ps ) <-> ( th /\ ps ) ) ) $=
      ( wa pm5.32d ancom 3bitr4g ) ABCFBDFCBFDBFABCDEGCBHDBHI $.
  $}

  ${
    pm5.32da.1 $e |- ( ( ph /\ ps ) -> ( ch <-> th ) ) $.
    $( Distribution of implication over biconditional (deduction rule).
       (Contributed by NM, 9-Dec-2006.) $)
    pm5.32da $p |- ( ph -> ( ( ps /\ ch ) <-> ( ps /\ th ) ) ) $=
      ( wb ex pm5.32d ) ABCDABCDFEGH $.
  $}

  $( Distribution of implication over biconditional.  Theorem *5.32 of
     [WhiteheadRussell] p. 125.  (Contributed by NM, 1-Aug-1994.)  (Revised by
     NM, 31-Jan-2015.) $)
  pm5.32 $p |- ( ( ph -> ( ps <-> ch ) ) <->
               ( ( ph /\ ps ) <-> ( ph /\ ch ) ) ) $=
    ( wb wi wa id pm5.32d ibar bibi12d biimprcd impbii ) ABCDZEZABFZACFZDZNABCN
    GHAMQABOCPABIACIJKL $.

  ${
    pm5.32i.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Distribution of implication over biconditional (inference rule).
       (Contributed by NM, 1-Aug-1994.) $)
    pm5.32i $p |- ( ( ph /\ ps ) <-> ( ph /\ ch ) ) $=
      ( wb wi wa pm5.32 mpbi ) ABCEFABGACGEDABCHI $.

    $( Distribution of implication over biconditional (inference rule).
       (Contributed by NM, 12-Mar-1995.) $)
    pm5.32ri $p |- ( ( ps /\ ph ) <-> ( ch /\ ph ) ) $=
      ( wa pm5.32i ancom 3bitr4i ) ABEACEBAECAEABCDFBAGCAGH $.
  $}

  ${
    biadan2.1 $e |- ( ph -> ps ) $.
    biadan2.2 $e |- ( ps -> ( ph <-> ch ) ) $.
    $( Add a conjunction to an equivalence.  (Contributed by Jeff Madsen,
       20-Jun-2011.) $)
    biadan2 $p |- ( ph <-> ( ps /\ ch ) ) $=
      ( wa pm4.71ri pm5.32i bitri ) ABAFBCFABDGBACEHI $.
  $}

  ${
    bi.aa $e |- ( ph <-> ps ) $.
    $( Introduce a left conjunct to both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       16-Nov-2013.) $)
    anbi2i $p |- ( ( ch /\ ph ) <-> ( ch /\ ps ) ) $=
      ( wb a1i pm5.32i ) CABABECDFG $.

    $( Introduce a right conjunct to both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       16-Nov-2013.) $)
    anbi1i $p |- ( ( ph /\ ch ) <-> ( ps /\ ch ) ) $=
      ( wb a1i pm5.32ri ) CABABECDFG $.

    $( Variant of ~ anbi2i with commutation.  (Contributed by Jonathan
       Ben-Naim, 3-Jun-2011.)  (Proof shortened by Andrew Salmon,
       14-Jun-2011.) $)
    anbi2ci $p |- ( ( ph /\ ch ) <-> ( ch /\ ps ) ) $=
      ( wa anbi1i ancom bitri ) ACEBCECBEABCDFBCGH $.
  $}

  ${
    anbi12.1 $e |- ( ph <-> ps ) $.
    anbi12.2 $e |- ( ch <-> th ) $.
    $( Conjoin both sides of two equivalences.  (Contributed by NM,
       5-Aug-1993.) $)
    anbi12i $p |- ( ( ph /\ ch ) <-> ( ps /\ th ) ) $=
      ( wa anbi1i anbi2i bitri ) ACGBCGBDGABCEHCDBFIJ $.
  $}

  ${
    sylan9bb.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    sylan9bb.2 $e |- ( th -> ( ch <-> ta ) ) $.
    $( Nested syllogism inference conjoining dissimilar antecedents.
       (Contributed by NM, 4-Mar-1995.) $)
    sylan9bb $p |- ( ( ph /\ th ) -> ( ps <-> ta ) ) $=
      ( wa wb adantr adantl bitrd ) ADHBCEABCIDFJDCEIAGKL $.
  $}

  ${
    sylan9bbr.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    sylan9bbr.2 $e |- ( th -> ( ch <-> ta ) ) $.
    $( Nested syllogism inference conjoining dissimilar antecedents.
       (Contributed by NM, 4-Mar-1995.) $)
    sylan9bbr $p |- ( ( th /\ ph ) -> ( ps <-> ta ) ) $=
      ( wb sylan9bb ancoms ) ADBEHABCDEFGIJ $.
  $}

  ${
    anbid.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduction adding a left conjunct to both sides of a logical
       equivalence.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
       Lammen, 16-Nov-2013.) $)
    anbi2d $p |- ( ph -> ( ( th /\ ps ) <-> ( th /\ ch ) ) ) $=
      ( wb a1d pm5.32d ) ADBCABCFDEGH $.

    $( Deduction adding a right conjunct to both sides of a logical
       equivalence.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
       Lammen, 16-Nov-2013.) $)
    anbi1d $p |- ( ph -> ( ( ps /\ th ) <-> ( ch /\ th ) ) ) $=
      ( wb a1d pm5.32rd ) ADBCABCFDEGH $.
  $}

  $( Introduce a right conjunct to both sides of a logical equivalence.
     Theorem *4.36 of [WhiteheadRussell] p. 118.  (Contributed by NM,
     3-Jan-2005.) $)
  anbi1 $p |- ( ( ph <-> ps ) -> ( ( ph /\ ch ) <-> ( ps /\ ch ) ) ) $=
    ( wb id anbi1d ) ABDZABCGEF $.

  $( Introduce a left conjunct to both sides of a logical equivalence.
     (Contributed by NM, 16-Nov-2013.) $)
  anbi2 $p |- ( ( ph <-> ps ) -> ( ( ch /\ ph ) <-> ( ch /\ ps ) ) ) $=
    ( wb id anbi2d ) ABDZABCGEF $.

  $( Theorem *4.22 of [WhiteheadRussell] p. 117.  (Contributed by NM,
     3-Jan-2005.) $)
  bitr $p |- ( ( ( ph <-> ps ) /\ ( ps <-> ch ) ) -> ( ph <-> ch ) ) $=
    ( wb bibi1 biimpar ) ABDACDBCDABCEF $.

  ${
    anbi12d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    anbi12d.2 $e |- ( ph -> ( th <-> ta ) ) $.
    $( Deduction joining two equivalences to form equivalence of conjunctions.
       (Contributed by NM, 5-Aug-1993.) $)
    anbi12d $p |- ( ph -> ( ( ps /\ th ) <-> ( ch /\ ta ) ) ) $=
      ( wa anbi1d anbi2d bitrd ) ABDHCDHCEHABCDFIADECGJK $.
  $}

  $( Modus ponens mixed with several conjunctions.  (Contributed by Jim
     Kingdon, 7-Jan-2018.) $)
  mpan10 $p |- ( ( ( ( ph -> ps ) /\ ch ) /\ ph ) -> ( ps /\ ch ) ) $=
    ( wi wa ancom anbi2i anass 3bitr4i id imp anim1i sylbi ) ABDZCEAEZNAEZCEZBC
    ENCAEZENACEZEOQRSNCAFGNCAHNACHIPBCNABNJKLM $.

  $( Theorem *5.3 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Andrew Salmon, 7-May-2011.) $)
  pm5.3 $p |- ( ( ( ph /\ ps ) -> ch ) <->
               ( ( ph /\ ps ) -> ( ph /\ ch ) ) ) $=
    ( wa wi impexp imdistan bitri ) ABDZCEABCEEIACDEABCFABCGH $.

  ${
    adant2.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       4-May-1994.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    adantll $p |- ( ( ( th /\ ph ) /\ ps ) -> ch ) $=
      ( wa simpr sylan ) DAFABCDAGEH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       4-May-1994.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    adantlr $p |- ( ( ( ph /\ th ) /\ ps ) -> ch ) $=
      ( wa simpl sylan ) ADFABCADGEH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       4-May-1994.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    adantrl $p |- ( ( ph /\ ( th /\ ps ) ) -> ch ) $=
      ( wa simpr sylan2 ) DBFABCDBGEH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       4-May-1994.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    adantrr $p |- ( ( ph /\ ( ps /\ th ) ) -> ch ) $=
      ( wa simpl sylan2 ) BDFABCBDGEH $.
  $}

  ${
    adantl2.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 2-Dec-2012.) $)
    adantlll $p |- ( ( ( ( ta /\ ph ) /\ ps ) /\ ch ) -> th ) $=
      ( wa simpr sylanl1 ) EAGABCDEAHFI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantllr $p |- ( ( ( ( ph /\ ta ) /\ ps ) /\ ch ) -> th ) $=
      ( wa simpl sylanl1 ) AEGABCDAEHFI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantlrl $p |- ( ( ( ph /\ ( ta /\ ps ) ) /\ ch ) -> th ) $=
      ( wa simpr sylanl2 ) EBGABCDEBHFI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantlrr $p |- ( ( ( ph /\ ( ps /\ ta ) ) /\ ch ) -> th ) $=
      ( wa simpl sylanl2 ) BEGABCDBEHFI $.
  $}

  ${
    adantr2.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantrll $p |- ( ( ph /\ ( ( ta /\ ps ) /\ ch ) ) -> th ) $=
      ( wa simpr sylanr1 ) EBGABCDEBHFI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantrlr $p |- ( ( ph /\ ( ( ps /\ ta ) /\ ch ) ) -> th ) $=
      ( wa simpl sylanr1 ) BEGABCDBEHFI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantrrl $p |- ( ( ph /\ ( ps /\ ( ta /\ ch ) ) ) -> th ) $=
      ( wa simpr sylanr2 ) ECGABCDECHFI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       26-Dec-2004.)  (Proof shortened by Wolf Lammen, 4-Dec-2012.) $)
    adantrrr $p |- ( ( ph /\ ( ps /\ ( ch /\ ta ) ) ) -> th ) $=
      ( wa simpl sylanr2 ) CEGABCDCEHFI $.
  $}

  ${
    ad2ant.1 $e |- ( ph -> ps ) $.
    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       19-Oct-1999.)  (Proof shortened by Wolf Lammen, 20-Nov-2012.) $)
    ad2antrr $p |- ( ( ( ph /\ ch ) /\ th ) -> ps ) $=
      ( adantr adantlr ) ADBCABDEFG $.

    $( Deduction adding 3 conjuncts to antecedent.  (Contributed by NM,
       28-Jul-2012.) $)
    ad3antrrr $p |- ( ( ( ( ph /\ ch ) /\ th ) /\ ta ) -> ps ) $=
      ( wa adantr ad2antrr ) ACGBDEABCFHI $.

    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       19-Oct-1999.)  (Proof shortened by Wolf Lammen, 20-Nov-2012.) $)
    ad2antlr $p |- ( ( ( ch /\ ph ) /\ th ) -> ps ) $=
      ( adantr adantll ) ADBCABDEFG $.

    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       19-Oct-1999.) $)
    ad2antrl $p |- ( ( ch /\ ( ph /\ th ) ) -> ps ) $=
      ( wa adantr adantl ) ADFBCABDEGH $.

    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       19-Oct-1999.) $)
    ad2antll $p |- ( ( ch /\ ( th /\ ph ) ) -> ps ) $=
      ( wa adantl ) DAFBCABDEGG $.
  $}

  ${
    ad2ant2.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( Deduction adding two conjuncts to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    ad2ant2l $p |- ( ( ( th /\ ph ) /\ ( ta /\ ps ) ) -> ch ) $=
      ( wa adantrl adantll ) AEBGCDABCEFHI $.

    $( Deduction adding two conjuncts to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    ad2ant2r $p |- ( ( ( ph /\ th ) /\ ( ps /\ ta ) ) -> ch ) $=
      ( wa adantrr adantlr ) ABEGCDABCEFHI $.

    $( Deduction adding two conjuncts to antecedent.  (Contributed by NM,
       23-Nov-2007.) $)
    ad2ant2lr $p |- ( ( ( th /\ ph ) /\ ( ps /\ ta ) ) -> ch ) $=
      ( wa adantrr adantll ) ABEGCDABCEFHI $.

    $( Deduction adding two conjuncts to antecedent.  (Contributed by NM,
       24-Nov-2007.) $)
    ad2ant2rl $p |- ( ( ( ph /\ th ) /\ ( ta /\ ps ) ) -> ch ) $=
      ( wa adantrl adantlr ) AEBGCDABCEFHI $.
  $}

  $( Simplification of a conjunction.  (Contributed by NM, 18-Mar-2007.) $)
  simpll $p |- ( ( ( ph /\ ps ) /\ ch ) -> ph ) $=
    ( id ad2antrr ) AABCADE $.

  $( Simplification of a conjunction.  (Contributed by NM, 20-Mar-2007.) $)
  simplr $p |- ( ( ( ph /\ ps ) /\ ch ) -> ps ) $=
    ( id ad2antlr ) BBACBDE $.

  $( Simplification of a conjunction.  (Contributed by NM, 21-Mar-2007.) $)
  simprl $p |- ( ( ph /\ ( ps /\ ch ) ) -> ps ) $=
    ( id ad2antrl ) BBACBDE $.

  $( Simplification of a conjunction.  (Contributed by NM, 21-Mar-2007.) $)
  simprr $p |- ( ( ph /\ ( ps /\ ch ) ) -> ch ) $=
    ( id ad2antll ) CCABCDE $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simplll $p |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th ) -> ph ) $=
    ( wa simpl ad2antrr ) ABEACDABFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simpllr $p |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th ) -> ps ) $=
    ( wa simpr ad2antrr ) ABEBCDABFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simplrl $p |- ( ( ( ph /\ ( ps /\ ch ) ) /\ th ) -> ps ) $=
    ( wa simpl ad2antlr ) BCEBADBCFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simplrr $p |- ( ( ( ph /\ ( ps /\ ch ) ) /\ th ) -> ch ) $=
    ( wa simpr ad2antlr ) BCECADBCFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simprll $p |- ( ( ph /\ ( ( ps /\ ch ) /\ th ) ) -> ps ) $=
    ( wa simpl ad2antrl ) BCEBADBCFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simprlr $p |- ( ( ph /\ ( ( ps /\ ch ) /\ th ) ) -> ch ) $=
    ( wa simpr ad2antrl ) BCECADBCFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simprrl $p |- ( ( ph /\ ( ps /\ ( ch /\ th ) ) ) -> ch ) $=
    ( wa simpl ad2antll ) CDECABCDFG $.

  $( Simplification of a conjunction.  (Contributed by Jeff Hankins,
     28-Jul-2009.) $)
  simprrr $p |- ( ( ph /\ ( ps /\ ( ch /\ th ) ) ) -> th ) $=
    ( wa simpr ad2antll ) CDEDABCDFG $.

  $( Theorem *4.87 of [WhiteheadRussell] p. 122.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Eric Schmidt, 26-Oct-2006.) $)
  pm4.87 $p |- ( ( ( ( ( ph /\ ps ) -> ch ) <-> ( ph -> ( ps -> ch ) ) ) /\
                ( ( ph -> ( ps -> ch ) ) <-> ( ps -> ( ph -> ch ) ) ) ) /\
                ( ( ps -> ( ph -> ch ) ) <-> ( ( ps /\ ph ) -> ch ) ) ) $=
    ( wa wi wb impexp bi2.04 pm3.2i bicomi ) ABDCEABCEEZFZKBACEEZFZDMBADCEZFLNA
    BCGABCHIOMBACGJI $.

  $( Introduce one conjunct as an antecedent to the other.  "abai" stands for
     "and, biconditional, and, implication".  (Contributed by NM,
     12-Aug-1993.)  (Proof shortened by Wolf Lammen, 7-Dec-2012.) $)
  abai $p |- ( ( ph /\ ps ) <-> ( ph /\ ( ph -> ps ) ) ) $=
    ( wi biimt pm5.32i ) ABABCABDE $.

  $( Swap two conjuncts.  Note that the first digit (1) in the label refers to
     the outer conjunct position, and the next digit (2) to the inner conjunct
     position.  (Contributed by NM, 12-Mar-1995.) $)
  an12 $p |- ( ( ph /\ ( ps /\ ch ) ) <-> ( ps /\ ( ph /\ ch ) ) ) $=
    ( wa ancom anbi1i anass 3bitr3i ) ABDZCDBADZCDABCDDBACDDIJCABEFABCGBACGH $.

  $( A rearrangement of conjuncts.  (Contributed by NM, 12-Mar-1995.)  (Proof
     shortened by Wolf Lammen, 25-Dec-2012.) $)
  an32 $p |- ( ( ( ph /\ ps ) /\ ch ) <-> ( ( ph /\ ch ) /\ ps ) ) $=
    ( wa anass an12 ancom 3bitri ) ABDCDABCDDBACDZDIBDABCEABCFBIGH $.

  $( A rearrangement of conjuncts.  (Contributed by NM, 24-Jun-2012.)  (Proof
     shortened by Wolf Lammen, 31-Dec-2012.) $)
  an13 $p |- ( ( ph /\ ( ps /\ ch ) ) <-> ( ch /\ ( ps /\ ph ) ) ) $=
    ( wa an12 anass ancom 3bitr2i ) ABCDDBACDDBADZCDCIDABCEBACFICGH $.

  $( A rearrangement of conjuncts.  (Contributed by NM, 24-Jun-2012.)  (Proof
     shortened by Wolf Lammen, 31-Dec-2012.) $)
  an31 $p |- ( ( ( ph /\ ps ) /\ ch ) <-> ( ( ch /\ ps ) /\ ph ) ) $=
    ( wa an13 anass 3bitr4i ) ABCDDCBADDABDCDCBDADABCEABCFCBAFG $.

  ${
    an12s.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( Swap two conjuncts in antecedent.  The label suffix "s" means that
       ~ an12 is combined with ~ syl (or a variant).  (Contributed by NM,
       13-Mar-1996.) $)
    an12s $p |- ( ( ps /\ ( ph /\ ch ) ) -> th ) $=
      ( wa an12 sylbi ) BACFFABCFFDBACGEH $.

    $( Inference commuting a nested conjunction in antecedent.  (Contributed by
       NM, 24-May-2006.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    ancom2s $p |- ( ( ph /\ ( ch /\ ps ) ) -> th ) $=
      ( wa pm3.22 sylan2 ) CBFABCFDCBGEH $.

    $( Swap two conjuncts in antecedent.  (Contributed by NM, 31-May-2006.) $)
    an13s $p |- ( ( ch /\ ( ps /\ ph ) ) -> th ) $=
      ( exp32 com13 imp32 ) CBADABCDABCDEFGH $.
  $}

  ${
    an32s.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( Swap two conjuncts in antecedent.  (Contributed by NM, 13-Mar-1996.) $)
    an32s $p |- ( ( ( ph /\ ch ) /\ ps ) -> th ) $=
      ( wa an32 sylbi ) ACFBFABFCFDACBGEH $.

    $( Inference commuting a nested conjunction in antecedent.  (Contributed by
       NM, 24-May-2006.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    ancom1s $p |- ( ( ( ps /\ ph ) /\ ch ) -> th ) $=
      ( wa pm3.22 sylan ) BAFABFCDBAGEH $.

    $( Swap two conjuncts in antecedent.  (Contributed by NM, 31-May-2006.) $)
    an31s $p |- ( ( ( ch /\ ps ) /\ ph ) -> th ) $=
      ( exp31 com13 imp31 ) CBADABCDABCDEFGH $.
  $}

  $( Absorption into embedded conjunct.  (Contributed by NM, 4-Sep-1995.)
     (Proof shortened by Wolf Lammen, 16-Nov-2013.) $)
  anabs1 $p |- ( ( ( ph /\ ps ) /\ ph ) <-> ( ph /\ ps ) ) $=
    ( wa simpl pm4.71i bicomi ) ABCZGACGAABDEF $.

  $( Absorption into embedded conjunct.  (Contributed by NM, 20-Jul-1996.)
     (Proof shortened by Wolf Lammen, 9-Dec-2012.) $)
  anabs5 $p |- ( ( ph /\ ( ph /\ ps ) ) <-> ( ph /\ ps ) ) $=
    ( wa ibar bicomd pm5.32i ) AABCZBABGABDEF $.

  $( Absorption into embedded conjunct.  (Contributed by NM, 20-Jul-1996.)
     (Proof shortened by Wolf Lammen, 17-Nov-2013.) $)
  anabs7 $p |- ( ( ps /\ ( ph /\ ps ) ) <-> ( ph /\ ps ) ) $=
    ( wa simpr pm4.71ri bicomi ) ABCZBGCGBABDEF $.

  ${
    anabsan.1 $e |- ( ( ( ph /\ ph ) /\ ps ) -> ch ) $.
    $( Absorption of antecedent with conjunction.  (Contributed by NM,
       24-Mar-1996.)  (Revised by NM, 18-Nov-2013.) $)
    anabsan $p |- ( ( ph /\ ps ) -> ch ) $=
      ( wa pm4.24 sylanb ) AAAEBCAFDG $.
  $}

  ${
    anabss1.1 $e |- ( ( ( ph /\ ps ) /\ ph ) -> ch ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       20-Jul-1996.)  (Proof shortened by Wolf Lammen, 31-Dec-2012.) $)
    anabss1 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( an32s anabsan ) ABCABACDEF $.
  $}

  ${
    anabss4.1 $e |- ( ( ( ps /\ ph ) /\ ps ) -> ch ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       20-Jul-1996.) $)
    anabss4 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( anabss1 ancoms ) BACBACDEF $.
  $}

  ${
    anabss5.1 $e |- ( ( ph /\ ( ph /\ ps ) ) -> ch ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       10-May-1994.)  (Proof shortened by Wolf Lammen, 1-Jan-2013.) $)
    anabss5 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( anassrs anabsan ) ABCAABCDEF $.
  $}

  ${
    anabsi5.1 $e |- ( ph -> ( ( ph /\ ps ) -> ch ) ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       11-Jun-1995.)  (Proof shortened by Wolf Lammen, 18-Nov-2013.) $)
    anabsi5 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( wa imp anabss5 ) ABCAABECDFG $.
  $}

  ${
    anabsi6.1 $e |- ( ph -> ( ( ps /\ ph ) -> ch ) ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       14-Aug-2000.) $)
    anabsi6 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( ancomsd anabsi5 ) ABCABACDEF $.
  $}

  ${
    anabsi7.1 $e |- ( ps -> ( ( ph /\ ps ) -> ch ) ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       20-Jul-1996.)  (Proof shortened by Wolf Lammen, 18-Nov-2013.) $)
    anabsi7 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( anabsi6 ancoms ) BACBACDEF $.
  $}

  ${
    anabsi8.1 $e |- ( ps -> ( ( ps /\ ph ) -> ch ) ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       26-Sep-1999.) $)
    anabsi8 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( anabsi5 ancoms ) BACBACDEF $.
  $}

  ${
    anabss7.1 $e |- ( ( ps /\ ( ph /\ ps ) ) -> ch ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       20-Jul-1996.)  (Proof shortened by Wolf Lammen, 19-Nov-2013.) $)
    anabss7 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( anassrs anabss4 ) ABCBABCDEF $.
  $}

  ${
    anabsan2.1 $e |- ( ( ph /\ ( ps /\ ps ) ) -> ch ) $.
    $( Absorption of antecedent with conjunction.  (Contributed by NM,
       10-May-2004.)  (Revised by NM, 1-Jan-2013.) $)
    anabsan2 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( an12s anabss7 ) ABCABBCDEF $.
  $}

  ${
    anabss3.1 $e |- ( ( ( ph /\ ps ) /\ ps ) -> ch ) $.
    $( Absorption of antecedent into conjunction.  (Contributed by NM,
       20-Jul-1996.)  (Proof shortened by Wolf Lammen, 1-Jan-2013.) $)
    anabss3 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( anasss anabsan2 ) ABCABBCDEF $.
  $}

  $( Rearrangement of 4 conjuncts.  (Contributed by NM, 10-Jul-1994.) $)
  an4 $p |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) <->
              ( ( ph /\ ch ) /\ ( ps /\ th ) ) ) $=
    ( wa an12 anbi2i anass 3bitr4i ) ABCDEZEZEACBDEZEZEABEJEACELEKMABCDFGABJHAC
    LHI $.

  $( Rearrangement of 4 conjuncts.  (Contributed by NM, 7-Feb-1996.) $)
  an42 $p |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) <->
                 ( ( ph /\ ch ) /\ ( th /\ ps ) ) ) $=
    ( wa an4 ancom anbi2i bitri ) ABECDEEACEZBDEZEJDBEZEABCDFKLJBDGHI $.

  ${
    an4s.1 $e |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) -> ta ) $.
    $( Inference rearranging 4 conjuncts in antecedent.  (Contributed by NM,
       10-Aug-1995.) $)
    an4s $p |- ( ( ( ph /\ ch ) /\ ( ps /\ th ) ) -> ta ) $=
      ( wa an4 sylbi ) ACGBDGGABGCDGGEACBDHFI $.
  $}

  ${
    an41r3s.1 $e |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) -> ta ) $.
    $( Inference rearranging 4 conjuncts in antecedent.  (Contributed by NM,
       10-Aug-1995.) $)
    an42s $p |- ( ( ( ph /\ ch ) /\ ( th /\ ps ) ) -> ta ) $=
      ( wa an4s ancom2s ) ACGBDEABCDEFHI $.
  $}

  $( Distribution of conjunction over conjunction.  (Contributed by NM,
     14-Aug-1995.) $)
  anandi $p |- ( ( ph /\ ( ps /\ ch ) ) <->
               ( ( ph /\ ps ) /\ ( ph /\ ch ) ) ) $=
    ( wa anidm anbi1i an4 bitr3i ) ABCDZDAADZIDABDACDDJAIAEFAABCGH $.

  $( Distribution of conjunction over conjunction.  (Contributed by NM,
     24-Aug-1995.) $)
  anandir $p |- ( ( ( ph /\ ps ) /\ ch ) <->
               ( ( ph /\ ch ) /\ ( ps /\ ch ) ) ) $=
    ( wa anidm anbi2i an4 bitr3i ) ABDZCDICCDZDACDBCDDJCICEFABCCGH $.

  ${
    anandis.1 $e |- ( ( ( ph /\ ps ) /\ ( ph /\ ch ) ) -> ta ) $.
    $( Inference that undistributes conjunction in the antecedent.
       (Contributed by NM, 7-Jun-2004.) $)
    anandis $p |- ( ( ph /\ ( ps /\ ch ) ) -> ta ) $=
      ( wa an4s anabsan ) ABCFDABACDEGH $.
  $}

  ${
    anandirs.1 $e |- ( ( ( ph /\ ch ) /\ ( ps /\ ch ) ) -> ta ) $.
    $( Inference that undistributes conjunction in the antecedent.
       (Contributed by NM, 7-Jun-2004.) $)
    anandirs $p |- ( ( ( ph /\ ps ) /\ ch ) -> ta ) $=
      ( wa an4s anabsan2 ) ABFCDACBCDEGH $.
  $}

  ${
    impbida.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    impbida.2 $e |- ( ( ph /\ ch ) -> ps ) $.
    $( Deduce an equivalence from two implications.  (Contributed by NM,
       17-Feb-2007.) $)
    impbida $p |- ( ph -> ( ps <-> ch ) ) $=
      ( ex impbid ) ABCABCDFACBEFG $.
  $}

  $( Theorem *3.45 (Fact) of [WhiteheadRussell] p. 113.  (Contributed by NM,
     3-Jan-2005.) $)
  pm3.45 $p |- ( ( ph -> ps ) -> ( ( ph /\ ch ) -> ( ps /\ ch ) ) ) $=
    ( wi id anim1d ) ABDZABCGEF $.

  ${
    im2an9.1 $e |- ( ph -> ( ps -> ch ) ) $.
    im2an9.2 $e |- ( th -> ( ta -> et ) ) $.
    $( Deduction joining nested implications to form implication of
       conjunctions.  (Contributed by NM, 29-Feb-1996.) $)
    im2anan9 $p |- ( ( ph /\ th ) -> ( ( ps /\ ta ) -> ( ch /\ et ) ) ) $=
      ( wa wi adantr adantl anim12d ) ADIBCEFABCJDGKDEFJAHLM $.

    $( Deduction joining nested implications to form implication of
       conjunctions.  (Contributed by NM, 29-Feb-1996.) $)
    im2anan9r $p |- ( ( th /\ ph ) -> ( ( ps /\ ta ) -> ( ch /\ et ) ) ) $=
      ( wa wi im2anan9 ancoms ) ADBEICFIJABCDEFGHKL $.
  $}

  ${
    anim12dan.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    anim12dan.2 $e |- ( ( ph /\ th ) -> ta ) $.
    $( Conjoin antecedents and consequents in a deduction.  (Contributed by
       Mario Carneiro, 12-May-2014.) $)
    anim12dan $p |- ( ( ph /\ ( ps /\ th ) ) -> ( ch /\ ta ) ) $=
      ( wa ex anim12d imp ) ABDHCEHABCDEABCFIADEGIJK $.
  $}

  $( Two propositions are equivalent if they are both true.  Theorem *5.1 of
     [WhiteheadRussell] p. 123.  (Contributed by NM, 21-May-1994.) $)
  pm5.1 $p |- ( ( ph /\ ps ) -> ( ph <-> ps ) ) $=
    ( wb pm5.501 biimpa ) ABABCABDE $.

  $( Theorem *3.43 (Comp) of [WhiteheadRussell] p. 113.  (Contributed by NM,
     3-Jan-2005.)  (Revised by NM, 27-Nov-2013.) $)
  pm3.43 $p |- ( ( ( ph -> ps ) /\ ( ph -> ch ) ) ->
                ( ph -> ( ps /\ ch ) ) ) $=
    ( wi wa pm3.43i imp ) ABDACDABCEDABCFG $.

  $( Distributive law for implication over conjunction.  Compare Theorem *4.76
     of [WhiteheadRussell] p. 121.  (Contributed by NM, 3-Apr-1994.)  (Proof
     shortened by Wolf Lammen, 27-Nov-2013.) $)
  jcab $p |- ( ( ph -> ( ps /\ ch ) ) <->
                ( ( ph -> ps ) /\ ( ph -> ch ) ) ) $=
    ( wa wi simpl imim2i simpr jca pm3.43 impbii ) ABCDZEZABEZACEZDMNOLBABCFGLC
    ABCHGIABCJK $.

  $( Obsolete proof of ~ pm3.43 as of 27-Nov-2013 (Contributed by NM,
     3-Jan-2005.) $)
  pm3.43OLD $p |- ( ( ( ph -> ps ) /\ ( ph -> ch ) ) ->
                ( ph -> ( ps /\ ch ) ) ) $=
    ( wa wi jcab biimpri ) ABCDEABEACEDABCFG $.

  $( Theorem *4.76 of [WhiteheadRussell] p. 121.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.76 $p |- ( ( ( ph -> ps ) /\ ( ph -> ch ) ) <->
                ( ph -> ( ps /\ ch ) ) ) $=
    ( wa wi jcab bicomi ) ABCDEABEACEDABCFG $.

  $( Theorem *4.38 of [WhiteheadRussell] p. 118.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.38 $p |- ( ( ( ph <-> ch ) /\ ( ps <-> th ) ) ->
                ( ( ph /\ ps ) <-> ( ch /\ th ) ) ) $=
    ( wb wa simpl simpr anbi12d ) ACEZBDEZFACBDJKGJKHI $.

  ${
    bi2an9.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    bi2an9.2 $e |- ( th -> ( ta <-> et ) ) $.
    $( Deduction joining two equivalences to form equivalence of conjunctions.
       (Contributed by NM, 31-Jul-1995.) $)
    bi2anan9 $p |- ( ( ph /\ th ) -> ( ( ps /\ ta ) <-> ( ch /\ et ) ) ) $=
      ( wa anbi1d anbi2d sylan9bb ) ABEICEIDCFIABCEGJDEFCHKL $.

    $( Deduction joining two equivalences to form equivalence of conjunctions.
       (Contributed by NM, 19-Feb-1996.) $)
    bi2anan9r $p |- ( ( th /\ ph ) -> ( ( ps /\ ta ) <-> ( ch /\ et ) ) ) $=
      ( wa wb bi2anan9 ancoms ) ADBEICFIJABCDEFGHKL $.

    $( Deduction joining two biconditionals with different antecedents.
       (Contributed by NM, 12-May-2004.) $)
    bi2bian9 $p |- ( ( ph /\ th ) -> ( ( ps <-> ta ) <-> ( ch <-> et ) ) ) $=
      ( wa wb adantr adantl bibi12d ) ADIBCEFABCJDGKDEFJAHLM $.
  $}

  $( Theorem *5.33 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.33 $p |- ( ( ph /\ ( ps -> ch ) ) <->
                ( ph /\ ( ( ph /\ ps ) -> ch ) ) ) $=
    ( wi wa ibar imbi1d pm5.32i ) ABCDABEZCDABICABFGH $.

  $( Theorem *5.36 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.36 $p |- ( ( ph /\ ( ph <-> ps ) ) <-> ( ps /\ ( ph <-> ps ) ) ) $=
    ( wb id pm5.32ri ) ABCZABFDE $.

  ${
    bianabs.1 $e |- ( ph -> ( ps <-> ( ph /\ ch ) ) ) $.
    $( Absorb a hypothesis into the second member of a biconditional.
       (Contributed by FL, 15-Feb-2007.) $)
    bianabs $p |- ( ph -> ( ps <-> ch ) ) $=
      ( wa ibar bitr4d ) ABACECDACFG $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Logical negation (intuitionistic)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( 'Not' introduction.  Axiom 4 of 10 for intuitionistic logic.  (Contributed
     by Mario Carneiro, 31-Jan-2015.) $)
  ax-in1 $a |- ( ( ph -> -. ph ) -> -. ph ) $.

  $( 'Not' elimination.  Axiom 5 of 10 for intuitionistic logic.  (Contributed
     by Mario Carneiro, 31-Jan-2015.) $)
  ax-in2 $a |- ( -. ph -> ( ph -> ps ) ) $.

  $( Reductio ad absurdum.  Theorem *2.01 of [WhiteheadRussell] p. 100.  This
     is valid intuitionistically (in the terminology of [Bauer] p. 482 it is a
     proof of negation not a proof by contradiction); compare with ~ pm2.18
     which is not.  (Contributed by Mario Carneiro, 12-May-2015.) $)
  pm2.01 $p |- ( ( ph -> -. ph ) -> -. ph ) $=
    ( ax-in1 ) AB $.

  $( From a wff and its negation, anything is true.  Theorem *2.21 of
     [WhiteheadRussell] p. 104.  Also called the Duns Scotus law.  (Contributed
     by Mario Carneiro, 12-May-2015.) $)
  pm2.21 $p |- ( -. ph -> ( ph -> ps ) ) $=
    ( ax-in2 ) ABC $.

  ${
    pm2.01d.1 $e |- ( ph -> ( ps -> -. ps ) ) $.
    $( Deduction based on reductio ad absurdum.  (Contributed by NM,
       18-Aug-1993.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
    pm2.01d $p |- ( ph -> -. ps ) $=
      ( wn wi pm2.01 syl ) ABBDZEHCBFG $.
  $}

  ${
    pm2.21d.1 $e |- ( ph -> -. ps ) $.
    $( A contradiction implies anything.  Deduction from ~ pm2.21 .
       (Contributed by NM, 10-Feb-1996.) $)
    pm2.21d $p |- ( ph -> ( ps -> ch ) ) $=
      ( wn wi pm2.21 syl ) ABEBCFDBCGH $.
  $}

  ${
    pm2.21dd.1 $e |- ( ph -> ps ) $.
    pm2.21dd.2 $e |- ( ph -> -. ps ) $.
    $( A contradiction implies anything.  Deduction from ~ pm2.21 .
       (Contributed by Mario Carneiro, 9-Feb-2017.) $)
    pm2.21dd $p |- ( ph -> ch ) $=
      ( pm2.21d mpd ) ABCDABCEFG $.
  $}

  $( Theorem *2.24 of [WhiteheadRussell] p. 104.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.24 $p |- ( ph -> ( -. ph -> ps ) ) $=
    ( wn pm2.21 com12 ) ACABABDE $.

  ${
    pm2.24d.1 $e |- ( ph -> ps ) $.
    $( Deduction version of ~ pm2.24 .  (Contributed by NM, 30-Jan-2006.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    pm2.24d $p |- ( ph -> ( -. ps -> ch ) ) $=
      ( wn wi pm2.24 syl ) ABBECFDBCGH $.
  $}

  ${
    pm2.24i.1 $e |- ph $.
    $( Inference version of ~ pm2.24 .  (Contributed by NM, 20-Aug-2001.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    pm2.24i $p |- ( -. ph -> ps ) $=
      ( wn pm2.21 mpi ) ADABCABEF $.
  $}

  ${
    con2d.1 $e |- ( ph -> ( ps -> -. ch ) ) $.
    $( A contraposition deduction.  (Contributed by NM, 19-Aug-1993.)  (Revised
       by NM, 12-Feb-2013.) $)
    con2d $p |- ( ph -> ( ch -> -. ps ) ) $=
      ( wn wi ax-in2 syl6 com23 pm2.01 ) ACBBEZFKABCKABCECKFDCKGHIBJH $.
  $}

  ${
    mt2d.1 $e |- ( ph -> ch ) $.
    mt2d.2 $e |- ( ph -> ( ps -> -. ch ) ) $.
    $( Modus tollens deduction.  (Contributed by NM, 4-Jul-1994.) $)
    mt2d $p |- ( ph -> -. ps ) $=
      ( wn con2d mpd ) ACBFDABCEGH $.
  $}

  ${
    nsyl3.1 $e |- ( ph -> -. ps ) $.
    nsyl3.2 $e |- ( ch -> ps ) $.
    $( A negated syllogism inference.  (Contributed by NM, 1-Dec-1995.)
       (Revised by NM, 13-Jun-2013.) $)
    nsyl3 $p |- ( ch -> -. ph ) $=
      ( wn wi a1i mt2d ) CABEABFGCDHI $.
  $}

  ${
    con2i.a $e |- ( ph -> -. ps ) $.
    $( A contraposition inference.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by O'Cat, 28-Nov-2008.)  (Proof shortened by Wolf Lammen,
       13-Jun-2013.) $)
    con2i $p |- ( ps -> -. ph ) $=
      ( id nsyl3 ) ABBCBDE $.
  $}

  ${
    nsyl.1 $e |- ( ph -> -. ps ) $.
    nsyl.2 $e |- ( ch -> ps ) $.
    $( A negated syllogism inference.  (Contributed by NM, 31-Dec-1993.)
       (Proof shortened by Wolf Lammen, 2-Mar-2013.) $)
    nsyl $p |- ( ph -> -. ch ) $=
      ( nsyl3 con2i ) CAABCDEFG $.
  $}

  $( Adding double negation.  Theorem *2.12 of [WhiteheadRussell] p. 101.  This
     one holds intuitionistically, but its converse, ~ notnot2 , does not.
     (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
     2-Mar-2013.) $)
  notnot1 $p |- ( ph -> -. -. ph ) $=
    ( wn id con2i ) ABZAECD $.

  ${
    con3d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( A contraposition deduction.  (Contributed by NM, 5-Aug-1993.)  (Revised
       by NM, 31-Jan-2015.) $)
    con3d $p |- ( ph -> ( -. ch -> -. ps ) ) $=
      ( wn notnot1 syl6 con2d ) ABCEZABCIEDCFGH $.
  $}

  ${
    con3i.a $e |- ( ph -> ps ) $.
    $( A contraposition inference.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Wolf Lammen, 20-Jun-2013.) $)
    con3i $p |- ( -. ps -> -. ph ) $=
      ( wn id nsyl ) BDZBAGECF $.
  $}

  ${
    con3rr3.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Rotate through consequent right.  (Contributed by Wolf Lammen,
       3-Nov-2013.) $)
    con3rr3 $p |- ( -. ch -> ( ph -> -. ps ) ) $=
      ( wn con3d com12 ) ACEBEABCDFG $.
  $}

  ${
    con3and.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Variant of ~ con3d with importation.  (Contributed by Jonathan Ben-Naim,
       3-Jun-2011.) $)
    con3and $p |- ( ( ph /\ -. ch ) -> -. ps ) $=
      ( wn con3d imp ) ACEBEABCDFG $.
  $}

  $( In classical logic, this is just a restatement of ~ pm3.2 .  In
     intuitionistic logic, it still holds, but is weaker than pm3.2.
     (Contributed by Mario Carneiro, 12-May-2015.) $)
  pm3.2im $p |- ( ph -> ( ps -> -. ( ph -> -. ps ) ) ) $=
    ( wn wi pm2.27 con2d ) AABCZDBAGEF $.

  ${
    expi.1 $e |- ( -. ( ph -> -. ps ) -> ch ) $.
    $( An exportation inference.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by O'Cat, 28-Nov-2008.) $)
    expi $p |- ( ph -> ( ps -> ch ) ) $=
      ( wn wi pm3.2im syl6 ) ABABEFECABGDH $.
  $}

  ${
    pm2.65i.1 $e |- ( ph -> ps ) $.
    pm2.65i.2 $e |- ( ph -> -. ps ) $.
    $( Inference rule for proof by contradiction.  (Contributed by NM,
       18-May-1994.)  (Proof shortened by Wolf Lammen, 11-Sep-2013.) $)
    pm2.65i $p |- -. ph $=
      ( wn wi nsyl3 pm2.01 ax-mp ) AAEZFJABADCGAHI $.
  $}

  ${
    mt2.1 $e |- ps $.
    mt2.2 $e |- ( ph -> -. ps ) $.
    $( A rule similar to modus tollens.  (Contributed by NM, 19-Aug-1993.)
       (Proof shortened by Wolf Lammen, 10-Sep-2013.) $)
    mt2 $p |- -. ph $=
      ( a1i pm2.65i ) ABBACEDF $.
  $}

  $( Theorem used to justify definition of intuitionistic biconditional
     ~ df-bi .  (Contributed by NM, 24-Nov-2017.) $)
  biijust $p  |- ( ( ( ( ph -> ps ) /\ ( ps -> ph ) )
        -> ( ( ph -> ps ) /\ ( ps -> ph ) ) )
    /\ ( ( ( ph -> ps ) /\ ( ps -> ph ) )
           -> ( ( ph -> ps ) /\ ( ps -> ph ) ) ) ) $=
    ( wi wa id pm3.2i ) ABCBACDZGCZHGEZIF $.

  $( Contraposition.  Theorem *2.16 of [WhiteheadRussell] p. 103.  (Contributed
     by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 13-Feb-2013.) $)
  con3 $p |- ( ( ph -> ps ) -> ( -. ps -> -. ph ) ) $=
    ( wi id con3d ) ABCZABFDE $.

  $( Contraposition.  Theorem *2.03 of [WhiteheadRussell] p. 100.  (Contributed
     by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 12-Feb-2013.) $)
  con2 $p |- ( ( ph -> -. ps ) -> ( ps -> -. ph ) ) $=
    ( wn wi id con2d ) ABCDZABGEF $.

  ${
    mt2i.1 $e |- ch $.
    mt2i.2 $e |- ( ph -> ( ps -> -. ch ) ) $.
    $( Modus tollens inference.  (Contributed by NM, 26-Mar-1995.)  (Proof
       shortened by Wolf Lammen, 15-Sep-2012.) $)
    mt2i $p |- ( ph -> -. ps ) $=
      ( a1i mt2d ) ABCCADFEG $.
  $}

  ${
    negbi.1 $e |- ph $.
    $( Infer double negation.  (Contributed by NM, 27-Feb-2008.) $)
    notnoti $p |- -. -. ph $=
      ( wn notnot1 ax-mp ) AACCBADE $.
  $}

  ${
    pm2.21i.1 $e |- -. ph $.
    $( A contradiction implies anything.  Inference from ~ pm2.21 .
       (Contributed by NM, 16-Sep-1993.)  (Revised by Mario Carneiro,
       31-Jan-2015.) $)
    pm2.21i $p |- ( ph -> ps ) $=
      ( wn wi pm2.21 ax-mp ) ADABECABFG $.
  $}

  ${
    pm2.24ii.1 $e |- ph $.
    pm2.24ii.2 $e |- -. ph $.
    $( A contradiction implies anything.  Inference from ~ pm2.24 .
       (Contributed by NM, 27-Feb-2008.) $)
    pm2.24ii $p |- ps $=
      ( pm2.21i ax-mp ) ABCABDEF $.
  $}

  ${
    nsyld.1 $e |- ( ph -> ( ps -> -. ch ) ) $.
    nsyld.2 $e |- ( ph -> ( ta -> ch ) ) $.
    $( A negated syllogism deduction.  (Contributed by NM, 9-Apr-2005.) $)
    nsyld $p |- ( ph -> ( ps -> -. ta ) ) $=
      ( wn con3d syld ) ABCGDGEADCFHI $.
  $}

  ${
    nsyli.1 $e |- ( ph -> ( ps -> ch ) ) $.
    nsyli.2 $e |- ( th -> -. ch ) $.
    $( A negated syllogism inference.  (Contributed by NM, 3-May-1994.) $)
    nsyli $p |- ( ph -> ( th -> -. ps ) ) $=
      ( wn con3d syl5 ) DCGABGFABCEHI $.
  $}

  $( Theorem 8 of [Margaris] p. 60.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Josh Purinton, 29-Dec-2000.) $)
  mth8 $p |- ( ph -> ( -. ps -> -. ( ph -> ps ) ) ) $=
    ( wi pm2.27 con3d ) AABCBABDE $.

  ${
    jc.1 $e |- ( ph -> ps ) $.
    jc.2 $e |- ( ph -> ch ) $.
    $( Inference joining the consequents of two premises.  (Contributed by NM,
       5-Aug-1993.) $)
    jc $p |- ( ph -> -. ( ps -> -. ch ) ) $=
      ( wn wi pm3.2im sylc ) ABCBCFGFDEBCHI $.
  $}

  $( Theorem *2.51 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.51 $p |- ( -. ( ph -> ps ) -> ( ph -> -. ps ) ) $=
    ( wi wn ax-1 con3i a1d ) ABCZDBDABHBAEFG $.

  $( Theorem *2.52 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
  pm2.52 $p |- ( -. ( ph -> ps ) -> ( -. ph -> -. ps ) ) $=
    ( wn wi pm2.21 pm2.24d com12 ) ACZABDZCBCZHIJABEFG $.

  $( Exportation theorem expressed with primitive connectives.  (Contributed by
     NM, 5-Aug-1993.) $)
  expt $p |- ( ( -. ( ph -> -. ps ) -> ch ) -> ( ph -> ( ps -> ch ) ) ) $=
    ( wn wi pm3.2im imim1d com12 ) AABDEDZCEBCEABICABFGH $.

  $( Elimination of a nested antecedent.  Although it is a kind of reversal of
     inference ~ ja it holds intuitionistically, while ~ ja does not.
     (Contributed by Wolf Lammen, 10-May-2013.) $)
  jarl $p |- ( ( ( ph -> ps ) -> ch ) -> ( -. ph -> ch ) ) $=
    ( wn wi pm2.21 imim1i ) ADABECABFG $.

  $( Theorem *2.65 of [WhiteheadRussell] p. 107.  Proof by contradiction.
     Proofs, such as this one, which assume a proposition, here ` ph ` , derive
     a contradiction, and therefore conclude ` -. ph ` , are valid
     intuitionistically (and can be called "proof of negation", for example by
     [Bauer] p. 482).  By contrast, proofs which assume ` -. ph ` , derive a
     contradiction, and conclude ` ph ` , such as ~ condandc , are only valid
     for decidable propositions.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 8-Mar-2013.) $)
  pm2.65 $p |- ( ( ph -> ps ) -> ( ( ph -> -. ps ) -> -. ph ) ) $=
    ( wi wn pm2.27 con2d a2i ) ABCAABDZCZABIDAIBAHEFGF $.

  ${
    pm2.65d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    pm2.65d.2 $e |- ( ph -> ( ps -> -. ch ) ) $.
    $( Deduction rule for proof by contradiction.  (Contributed by NM,
       26-Jun-1994.)  (Proof shortened by Wolf Lammen, 26-May-2013.) $)
    pm2.65d $p |- ( ph -> -. ps ) $=
      ( nsyld pm2.01d ) ABABCBEDFG $.
  $}

  ${
    pm2.65da.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    pm2.65da.2 $e |- ( ( ph /\ ps ) -> -. ch ) $.
    $( Deduction rule for proof by contradiction.  (Contributed by NM,
       12-Jun-2014.) $)
    pm2.65da $p |- ( ph -> -. ps ) $=
      ( ex wn pm2.65d ) ABCABCDFABCGEFH $.
  $}

  ${
    mto.1 $e |- -. ps $.
    mto.2 $e |- ( ph -> ps ) $.
    $( The rule of modus tollens.  (Contributed by NM, 19-Aug-1993.)  (Proof
       shortened by Wolf Lammen, 11-Sep-2013.) $)
    mto $p |- -. ph $=
      ( wn a1i pm2.65i ) ABDBEACFG $.
  $}

  ${
    mtod.1 $e |- ( ph -> -. ch ) $.
    mtod.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Modus tollens deduction.  (Contributed by NM, 3-Apr-1994.)  (Proof
       shortened by Wolf Lammen, 11-Sep-2013.) $)
    mtod $p |- ( ph -> -. ps ) $=
      ( wn a1d pm2.65d ) ABCEACFBDGH $.
  $}

  ${
    mtoi.1 $e |- -. ch $.
    mtoi.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Modus tollens inference.  (Contributed by NM, 5-Jul-1994.)  (Proof
       shortened by Wolf Lammen, 15-Sep-2012.) $)
    mtoi $p |- ( ph -> -. ps ) $=
      ( wn a1i mtod ) ABCCFADGEH $.
  $}

  ${
    mtand.1 $e |- ( ph -> -. ch ) $.
    mtand.2 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( A modus tollens deduction.  (Contributed by Jeff Hankins,
       19-Aug-2009.) $)
    mtand $p |- ( ph -> -. ps ) $=
      ( ex mtod ) ABCDABCEFG $.
  $}

  ${
    notbid.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduction negating both sides of a logical equivalence.  (Contributed by
       NM, 21-May-1994.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
    notbid $p |- ( ph -> ( -. ps <-> -. ch ) ) $=
      ( wn biimprd con3d biimpd impbid ) ABECEACBABCDFGABCABCDHGI $.
  $}

  $( Contraposition.  Bidirectional version of ~ con2 .  (Contributed by NM,
     5-Aug-1993.) $)
  con2b $p |- ( ( ph -> -. ps ) <-> ( ps -> -. ph ) ) $=
    ( wn wi con2 impbii ) ABCDBACDABEBAEF $.

  ${
    notbii.1 $e |- ( ph <-> ps ) $.
    $( Negate both sides of a logical equivalence.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
    notbii $p |- ( -. ph <-> -. ps ) $=
      ( wb wn id notbid ax-mp ) ABDZAEBEDCIABIFGH $.
  $}

  ${
    mtbi.1 $e |- -. ph $.
    mtbi.2 $e |- ( ph <-> ps ) $.
    $( An inference from a biconditional, related to modus tollens.
       (Contributed by NM, 15-Nov-1994.)  (Proof shortened by Wolf Lammen,
       25-Oct-2012.) $)
    mtbi $p |- -. ps $=
      ( biimpri mto ) BACABDEF $.
  $}

  ${
    mtbir.1 $e |- -. ps $.
    mtbir.2 $e |- ( ph <-> ps ) $.
    $( An inference from a biconditional, related to modus tollens.
       (Contributed by NM, 15-Nov-1994.)  (Proof shortened by Wolf Lammen,
       14-Oct-2012.) $)
    mtbir $p |- -. ph $=
      ( bicomi mtbi ) BACABDEF $.
  $}

  ${
    mtbid.min $e |- ( ph -> -. ps ) $.
    mtbid.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( A deduction from a biconditional, similar to modus tollens.
       (Contributed by NM, 26-Nov-1995.) $)
    mtbid $p |- ( ph -> -. ch ) $=
      ( biimprd mtod ) ACBDABCEFG $.
  $}

  ${
    mtbird.min $e |- ( ph -> -. ch ) $.
    mtbird.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( A deduction from a biconditional, similar to modus tollens.
       (Contributed by NM, 10-May-1994.) $)
    mtbird $p |- ( ph -> -. ps ) $=
      ( biimpd mtod ) ABCDABCEFG $.
  $}

  ${
    mtbii.min $e |- -. ps $.
    mtbii.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( An inference from a biconditional, similar to modus tollens.
       (Contributed by NM, 27-Nov-1995.) $)
    mtbii $p |- ( ph -> -. ch ) $=
      ( biimprd mtoi ) ACBDABCEFG $.
  $}

  ${
    mtbiri.min $e |- -. ch $.
    mtbiri.maj $e |- ( ph -> ( ps <-> ch ) ) $.
    $( An inference from a biconditional, similar to modus tollens.
       (Contributed by NM, 24-Aug-1995.) $)
    mtbiri $p |- ( ph -> -. ps ) $=
      ( biimpd mtoi ) ABCDABCEFG $.
  $}

  ${
    sylnib.1 $e |- ( ph -> -. ps ) $.
    sylnib.2 $e |- ( ps <-> ch ) $.
    $( A mixed syllogism inference from an implication and a biconditional.
       (Contributed by Wolf Lammen, 16-Dec-2013.) $)
    sylnib $p |- ( ph -> -. ch ) $=
      ( wb a1i mtbid ) ABCDBCFAEGH $.
  $}

  ${
    sylnibr.1 $e |- ( ph -> -. ps ) $.
    sylnibr.2 $e |- ( ch <-> ps ) $.
    $( A mixed syllogism inference from an implication and a biconditional.
       Useful for substituting an consequent with a definition.  (Contributed
       by Wolf Lammen, 16-Dec-2013.) $)
    sylnibr $p |- ( ph -> -. ch ) $=
      ( bicomi sylnib ) ABCDCBEFG $.
  $}

  ${
    sylnbi.1 $e |- ( ph <-> ps ) $.
    sylnbi.2 $e |- ( -. ps -> ch ) $.
    $( A mixed syllogism inference from a biconditional and an implication.
       Useful for substituting an antecedent with a definition.  (Contributed
       by Wolf Lammen, 16-Dec-2013.) $)
    sylnbi $p |- ( -. ph -> ch ) $=
      ( wn notbii sylbi ) AFBFCABDGEH $.
  $}

  ${
    sylnbir.1 $e |- ( ps <-> ph ) $.
    sylnbir.2 $e |- ( -. ps -> ch ) $.
    $( A mixed syllogism inference from a biconditional and an implication.
       (Contributed by Wolf Lammen, 16-Dec-2013.) $)
    sylnbir $p |- ( -. ph -> ch ) $=
      ( bicomi sylnbi ) ABCBADFEG $.
  $}

  ${
    xchnxbi.1 $e |- ( -. ph <-> ps ) $.
    xchnxbi.2 $e |- ( ph <-> ch ) $.
    $( Replacement of a subexpression by an equivalent one.  (Contributed by
       Wolf Lammen, 27-Sep-2014.) $)
    xchnxbi $p |- ( -. ch <-> ps ) $=
      ( wn notbii bitr3i ) CFAFBACEGDH $.
  $}

  ${
    xchnxbir.1 $e |- ( -. ph <-> ps ) $.
    xchnxbir.2 $e |- ( ch <-> ph ) $.
    $( Replacement of a subexpression by an equivalent one.  (Contributed by
       Wolf Lammen, 27-Sep-2014.) $)
    xchnxbir $p |- ( -. ch <-> ps ) $=
      ( bicomi xchnxbi ) ABCDCAEFG $.
  $}

  ${
    xchbinx.1 $e |- ( ph <-> -. ps ) $.
    xchbinx.2 $e |- ( ps <-> ch ) $.
    $( Replacement of a subexpression by an equivalent one.  (Contributed by
       Wolf Lammen, 27-Sep-2014.) $)
    xchbinx $p |- ( ph <-> -. ch ) $=
      ( wn notbii bitri ) ABFCFDBCEGH $.
  $}

  ${
    xchbinxr.1 $e |- ( ph <-> -. ps ) $.
    xchbinxr.2 $e |- ( ch <-> ps ) $.
    $( Replacement of a subexpression by an equivalent one.  (Contributed by
       Wolf Lammen, 27-Sep-2014.) $)
    xchbinxr $p |- ( ph <-> -. ch ) $=
      ( bicomi xchbinx ) ABCDCBEFG $.
  $}

  ${
    mt2bi.1 $e |- ph $.
    $( A false consequent falsifies an antecedent.  (Contributed by NM,
       19-Aug-1993.)  (Proof shortened by Wolf Lammen, 12-Nov-2012.) $)
    mt2bi $p |- ( -. ps <-> ( ps -> -. ph ) ) $=
      ( wn wi a1bi con2b bitri ) BDZAIEBADEAICFABGH $.
  $}

  $( Modus-tollens-like theorem.  (Contributed by NM, 7-Apr-2001.)  (Revised by
     Mario Carneiro, 31-Jan-2015.) $)
  mtt $p |- ( -. ph -> ( -. ps <-> ( ps -> ph ) ) ) $=
    ( wn wi pm2.21 con3 com12 impbid2 ) ACZBCZBADZBAEKIJBAFGH $.

  $( Two propositions are equivalent if they are both false.  Theorem *5.21 of
     [WhiteheadRussell] p. 124.  (Contributed by NM, 21-May-1994.)  (Revised by
     Mario Carneiro, 31-Jan-2015.) $)
  pm5.21 $p |- ( ( -. ph /\ -. ps ) -> ( ph <-> ps ) ) $=
    ( wn wa simpl pm2.21d simpr impbid ) ACZBCZDZABKABIJEFKBAIJGFH $.

  $( Two propositions are equivalent if they are both false.  Closed form of
     ~ 2false .  Equivalent to a ~ bi2 -like version of the xor-connective.
     (Contributed by Wolf Lammen, 13-May-2013.)  (Revised by Mario Carneiro,
     31-Jan-2015.) $)
  pm5.21im $p |- ( -. ph -> ( -. ps -> ( ph <-> ps ) ) ) $=
    ( wn wb pm5.21 ex ) ACBCABDABEF $.

  $( The negation of a wff is equivalent to the wff's equivalence to
     falsehood.  (Contributed by Juha Arpiainen, 19-Jan-2006.)  (Revised by
     Mario Carneiro, 31-Jan-2015.) $)
  nbn2 $p |- ( -. ph -> ( -. ps <-> ( ph <-> ps ) ) ) $=
    ( wn wb pm5.21im wi bi2 mtt syl5ibr impbid ) ACZBCZABDZABEMLKBAFABGABHIJ $.

  $( Transfer negation via an equivalence.  (Contributed by NM, 3-Oct-2007.)
     (Proof shortened by Wolf Lammen, 28-Jan-2013.) $)
  bibif $p |- ( -. ps -> ( ( ph <-> ps ) <-> -. ph ) ) $=
    ( wn wb nbn2 bicom syl6rbb ) BCACBADABDBAEBAFG $.

  ${
    nbn.1 $e |- -. ph $.
    $( The negation of a wff is equivalent to the wff's equivalence to
       falsehood.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
       Lammen, 3-Oct-2013.) $)
    nbn $p |- ( -. ps <-> ( ps <-> ph ) ) $=
      ( wb wn bibif ax-mp bicomi ) BADZBEZAEIJDCBAFGH $.
  $}

  ${
    nbn3.1 $e |- ph $.
    $( Transfer falsehood via equivalence.  (Contributed by NM,
       11-Sep-2006.) $)
    nbn3 $p |- ( -. ps <-> ( ps <-> -. ph ) ) $=
      ( wn notnoti nbn ) ADBACEF $.
  $}

  ${
    2false.1 $e |- -. ph $.
    2false.2 $e |- -. ps $.
    $( Two falsehoods are equivalent.  (Contributed by NM, 4-Apr-2005.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    2false $p |- ( ph <-> ps ) $=
      ( pm2.21i impbii ) ABABCEBADEF $.
  $}

  ${
    2falsed.1 $e |- ( ph -> -. ps ) $.
    2falsed.2 $e |- ( ph -> -. ch ) $.
    $( Two falsehoods are equivalent (deduction rule).  (Contributed by NM,
       11-Oct-2013.) $)
    2falsed $p |- ( ph -> ( ps <-> ch ) ) $=
      ( pm2.21d impbid ) ABCABCDFACBEFG $.
  $}

  ${
    pm5.21ni.1 $e |- ( ph -> ps ) $.
    pm5.21ni.2 $e |- ( ch -> ps ) $.
    $( Two propositions implying a false one are equivalent.  (Contributed by
       NM, 16-Feb-1996.)  (Proof shortened by Wolf Lammen, 19-May-2013.) $)
    pm5.21ni $p |- ( -. ps -> ( ph <-> ch ) ) $=
      ( wn con3i 2falsed ) BFACABDGCBEGH $.

    pm5.21nii.3 $e |- ( ps -> ( ph <-> ch ) ) $.
    $( Eliminate an antecedent implied by each side of a biconditional.
       (Contributed by NM, 21-May-1999.)  (Revised by Mario Carneiro,
       31-Jan-2015.) $)
    pm5.21nii $p |- ( ph <-> ch ) $=
      ( wb syl ibi ibir impbii ) ACACABACGZDFHICACBLEFHJK $.
  $}

  ${
    pm5.21ndd.1 $e |- ( ph -> ( ch -> ps ) ) $.
    pm5.21ndd.2 $e |- ( ph -> ( th -> ps ) ) $.
    pm5.21ndd.3 $e |- ( ph -> ( ps -> ( ch <-> th ) ) ) $.
    $( Eliminate an antecedent implied by each side of a biconditional,
       deduction version.  (Contributed by Paul Chapman, 21-Nov-2012.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    pm5.21ndd $p |- ( ph -> ( ch <-> th ) ) $=
      ( wb syld ibd bicom1 syl6 impbid ) ACDACDACBCDHZEGIJADCADNDCHADBNFGICDKLJ
      M $.
  $}

  $( Theorem *5.19 of [WhiteheadRussell] p. 124.  (Contributed by NM,
     3-Jan-2005.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
  pm5.19 $p |- -. ( ph <-> -. ph ) $=
    ( wn wb bi1 pm2.01d id mpbird pm2.65i ) AABZCZAJAIJAAIDEZJFGKH $.

  $( Theorem *4.8 of [WhiteheadRussell] p. 122.  This one is valid in
     intuitionistic logic, whereas ~ pm4.81 is not.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.8 $p |- ( ( ph -> -. ph ) <-> -. ph ) $=
    ( wn wi pm2.01 ax-1 impbii ) AABZCGADGAEF $.

  $( Express implication in terms of conjunction.  (Contributed by NM,
     9-Apr-1994.)  (Revised by Mario Carneiro, 1-Feb-2015.) $)
  imnan $p |- ( ( ph -> -. ps ) <-> -. ( ph /\ ps ) ) $=
    ( wn wi wa pm3.2im imp con2i pm3.2 con3rr3 impbii ) ABCDZABEZCMLABLCABFGHAB
    MABIJK $.

  $( Theorem to move a conjunct in and out of a negation.  (Contributed by NM,
     9-Nov-2003.) $)
  nan $p |- ( ( ph -> -. ( ps /\ ch ) ) <-> ( ( ph /\ ps ) -> -. ch ) ) $=
    ( wa wn wi impexp imnan imbi2i bitr2i ) ABDCEZFABKFZFABCDEZFABKGLMABCHIJ $.

  $( Law of noncontradiction.  Theorem *3.24 of [WhiteheadRussell] p. 111 (who
     call it the "law of contradiction").  (Contributed by NM, 16-Sep-1993.)
     (Revised by Mario Carneiro, 2-Feb-2015.) $)
  pm3.24 $p |- -. ( ph /\ -. ph ) $=
    ( wn wi wa notnot1 imnan mpbi ) AABZBCAHDBAEAHFG $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Logical disjunction
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare the connective for disjunction ('or'). $)
  $c \/ $. $( Vee (read:  'or') $)

  $( Extend wff definition to include disjunction ('or'). $)
  wo $a wff ( ph \/ ps ) $.

  $( Definition of 'or'.  Axiom 6 of 10 for intuitionistic logic.  (Contributed
     by Mario Carneiro, 31-Jan-2015.) $)
  ax-io $a |- ( ( ( ph \/ ch ) -> ps ) <->
    ( ( ph -> ps ) /\ ( ch -> ps ) ) ) $.

  $( Disjunction of antecedents.  Compare Theorem *4.77 of [WhiteheadRussell]
     p. 121.  (Contributed by NM, 30-May-1994.)  (Revised by Mario Carneiro,
     31-Jan-2015.) $)
  jaob $p |- ( ( ( ph \/ ch ) -> ps ) <-> ( ( ph -> ps ) /\ ( ch -> ps ) ) ) $=
    ( ax-io ) ABCD $.

  $( Introduction of a disjunct.  Axiom *1.3 of [WhiteheadRussell] p. 96.
     (Contributed by NM, 30-Aug-1993.)  (Revised by NM, 31-Jan-2015.) $)
  olc $p |- ( ph -> ( ps \/ ph ) ) $=
    ( wo wi wa id jaob mpbi simpri ) BBACZDZAJDZJJDKLEJFBJAGHI $.

  $( Introduction of a disjunct.  Theorem *2.2 of [WhiteheadRussell] p. 104.
     (Contributed by NM, 30-Aug-1993.)  (Revised by NM, 31-Jan-2015.) $)
  orc $p |- ( ph -> ( ph \/ ps ) ) $=
    ( wo wi wa id jaob mpbi simpli ) AABCZDZBJDZJJDKLEJFAJBGHI $.

  $( Slight generalization of Theorem *2.67 of [WhiteheadRussell] p. 107.
     (Contributed by NM, 3-Jan-2005.)  (Revised by NM, 9-Dec-2012.) $)
  pm2.67-2 $p |- ( ( ( ph \/ ch ) -> ps ) -> ( ph -> ps ) ) $=
    ( wo orc imim1i ) AACDBACEF $.

  $( Theorem *3.44 of [WhiteheadRussell] p. 113.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 3-Oct-2013.) $)
  pm3.44 $p |- ( ( ( ps -> ph ) /\ ( ch -> ph ) ) ->
                ( ( ps \/ ch ) -> ph ) ) $=
    ( wo wi wa jaob biimpri ) BCDAEBAECAEFBACGH $.

  ${
    jaoi.1 $e |- ( ph -> ps ) $.
    jaoi.2 $e |- ( ch -> ps ) $.
    $( Inference disjoining the antecedents of two implications.  (Contributed
       by NM, 5-Apr-1994.)  (Revised by NM, 31-Jan-2015.) $)
    jaoi $p |- ( ( ph \/ ch ) -> ps ) $=
      ( wi wo pm3.44 mp2an ) ABFCBFACGBFDEBACHI $.
  $}

  ${
    jaod.1 $e |- ( ph -> ( ps -> ch ) ) $.
    jaod.2 $e |- ( ph -> ( th -> ch ) ) $.
    $( Deduction disjoining the antecedents of two implications.  (Contributed
       by NM, 18-Aug-1994.)  (Revised by NM, 4-Apr-2013.) $)
    jaod $p |- ( ph -> ( ( ps \/ th ) -> ch ) ) $=
      ( wo wi com12 jaoi ) BDGACBACHDABCEIADCFIJI $.
  $}

  ${
    jaao.1 $e |- ( ph -> ( ps -> ch ) ) $.
    jaao.2 $e |- ( th -> ( ta -> ch ) ) $.
    $( Inference conjoining and disjoining the antecedents of two
       implications.  (Contributed by NM, 30-Sep-1999.) $)
    jaao $p |- ( ( ph /\ th ) -> ( ( ps \/ ta ) -> ch ) ) $=
      ( wa wi adantr adantl jaod ) ADHBCEABCIDFJDECIAGKL $.

    $( Inference disjoining and conjoining the antecedents of two
       implications.  (Contributed by Stefan Allan, 1-Nov-2008.) $)
    jaoa $p |- ( ( ph \/ th ) -> ( ( ps /\ ta ) -> ch ) ) $=
      ( wa wi adantrd adantld jaoi ) ABEHCIDABCEFJDECBGKL $.
  $}

  $( Theorem *2.53 of [WhiteheadRussell] p. 107.  This holds
     intuitionistically, although its converse, ~ pm2.54 , does not.
     (Contributed by NM, 3-Jan-2005.)  (Revised by NM, 31-Jan-2015.) $)
  pm2.53 $p |- ( ( ph \/ ps ) -> ( -. ph -> ps ) ) $=
    ( wn wi pm2.24 ax-1 jaoi ) AACZBDBABEBHFG $.

  ${
    ori.1 $e |- ( ph \/ ps ) $.
    $( Infer implication from disjunction.  (Contributed by NM, 11-Jun-1994.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    ori $p |- ( -. ph -> ps ) $=
      ( wo wn wi pm2.53 ax-mp ) ABDAEBFCABGH $.
  $}

  ${
    ord.1 $e |- ( ph -> ( ps \/ ch ) ) $.
    $( Deduce implication from disjunction.  (Contributed by NM, 18-May-1994.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    ord $p |- ( ph -> ( -. ps -> ch ) ) $=
      ( wo wn wi pm2.53 syl ) ABCEBFCGDBCHI $.
  $}

  $( Elimination of disjunction by denial of a disjunct.  Theorem *2.55 of
     [WhiteheadRussell] p. 107.  (Contributed by NM, 12-Aug-1994.)  (Proof
     shortened by Wolf Lammen, 21-Jul-2012.) $)
  orel1 $p |- ( -. ph -> ( ( ph \/ ps ) -> ps ) ) $=
    ( wo wn pm2.53 com12 ) ABCADBABEF $.

  $( Elimination of disjunction by denial of a disjunct.  Theorem *2.56 of
     [WhiteheadRussell] p. 107.  (Contributed by NM, 12-Aug-1994.)  (Proof
     shortened by Wolf Lammen, 5-Apr-2013.) $)
  orel2 $p |- ( -. ph -> ( ( ps \/ ph ) -> ps ) ) $=
    ( wn idd pm2.21 jaod ) ACZBBAGBDABEF $.

  $( Axiom *1.4 of [WhiteheadRussell] p. 96.  (Contributed by NM, 3-Jan-2005.)
     (Revised by NM, 15-Nov-2012.) $)
  pm1.4 $p |- ( ( ph \/ ps ) -> ( ps \/ ph ) ) $=
    ( wo olc orc jaoi ) ABACBABDBAEF $.

  $( Commutative law for disjunction.  Theorem *4.31 of [WhiteheadRussell]
     p. 118.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 15-Nov-2012.) $)
  orcom $p |- ( ( ph \/ ps ) <-> ( ps \/ ph ) ) $=
    ( wo pm1.4 impbii ) ABCBACABDBADE $.

  ${
    orcomd.1 $e |- ( ph -> ( ps \/ ch ) ) $.
    $( Commutation of disjuncts in consequent.  (Contributed by NM,
       2-Dec-2010.) $)
    orcomd $p |- ( ph -> ( ch \/ ps ) ) $=
      ( wo orcom sylib ) ABCECBEDBCFG $.
  $}

  ${
    orcoms.1 $e |- ( ( ph \/ ps ) -> ch ) $.
    $( Commutation of disjuncts in antecedent.  (Contributed by NM,
       2-Dec-2012.) $)
    orcoms $p |- ( ( ps \/ ph ) -> ch ) $=
      ( wo pm1.4 syl ) BAEABECBAFDG $.
  $}

  ${
    orci.1 $e |- ph $.
    $( Deduction introducing a disjunct.  (Contributed by NM, 19-Jan-2008.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    orci $p |- ( ph \/ ps ) $=
      ( wo orc ax-mp ) AABDCABEF $.

    $( Deduction introducing a disjunct.  (Contributed by NM, 19-Jan-2008.)
       (Revised by Mario Carneiro, 31-Jan-2015.) $)
    olci $p |- ( ps \/ ph ) $=
      ( wo olc ax-mp ) ABADCABEF $.
  $}

  ${
    orcd.1 $e |- ( ph -> ps ) $.
    $( Deduction introducing a disjunct.  (Contributed by NM, 20-Sep-2007.) $)
    orcd $p |- ( ph -> ( ps \/ ch ) ) $=
      ( wo orc syl ) ABBCEDBCFG $.

    $( Deduction introducing a disjunct.  (Contributed by NM, 11-Apr-2008.)
       (Proof shortened by Wolf Lammen, 3-Oct-2013.) $)
    olcd $p |- ( ph -> ( ch \/ ps ) ) $=
      ( orcd orcomd ) ABCABCDEF $.
  $}

  ${
    orcs.1 $e |- ( ( ph \/ ps ) -> ch ) $.
    $( Deduction eliminating disjunct. _Notational convention_:  We sometimes
       suffix with "s" the label of an inference that manipulates an
       antecedent, leaving the consequent unchanged.  The "s" means that the
       inference eliminates the need for a syllogism ( ~ syl ) -type inference
       in a proof.  (Contributed by NM, 21-Jun-1994.) $)
    orcs $p |- ( ph -> ch ) $=
      ( wo orc syl ) AABECABFDG $.
  $}

  ${
    olcs.1 $e |- ( ( ph \/ ps ) -> ch ) $.
    $( Deduction eliminating disjunct.  (Contributed by NM, 21-Jun-1994.)
       (Proof shortened by Wolf Lammen, 3-Oct-2013.) $)
    olcs $p |- ( ps -> ch ) $=
      ( orcoms orcs ) BACABCDEF $.
  $}

  $( Theorem *2.07 of [WhiteheadRussell] p. 101.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.07 $p |- ( ph -> ( ph \/ ph ) ) $=
    ( olc ) AAB $.

  $( Theorem *2.45 of [WhiteheadRussell] p. 106.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.45 $p |- ( -. ( ph \/ ps ) -> -. ph ) $=
    ( wo orc con3i ) AABCABDE $.

  $( Theorem *2.46 of [WhiteheadRussell] p. 106.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.46 $p |- ( -. ( ph \/ ps ) -> -. ps ) $=
    ( wo olc con3i ) BABCBADE $.

  $( Theorem *2.47 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.47 $p |- ( -. ( ph \/ ps ) -> ( -. ph \/ ps ) ) $=
    ( wo wn pm2.45 orcd ) ABCDADBABEF $.

  $( Theorem *2.48 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.48 $p |- ( -. ( ph \/ ps ) -> ( ph \/ -. ps ) ) $=
    ( wo wn pm2.46 olcd ) ABCDBDAABEF $.

  $( Theorem *2.49 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.49 $p |- ( -. ( ph \/ ps ) -> ( -. ph \/ -. ps ) ) $=
    ( wo wn pm2.46 olcd ) ABCDBDADABEF $.

  $( Theorem *2.67 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.)  (Revised by NM, 9-Dec-2012.) $)
  pm2.67 $p |- ( ( ( ph \/ ps ) -> ps ) -> ( ph -> ps ) ) $=
    ( pm2.67-2 ) ABBC $.

  $( A wff is equivalent to its disjunction with falsehood.  Theorem *4.74 of
     [WhiteheadRussell] p. 121.  (Contributed by NM, 23-Mar-1995.)  (Proof
     shortened by Wolf Lammen, 18-Nov-2012.) $)
  biorf $p |- ( -. ph -> ( ps <-> ( ph \/ ps ) ) ) $=
    ( wn wo olc orel1 impbid2 ) ACBABDBAEABFG $.

  $( A wff is equivalent to its negated disjunction with falsehood.
     (Contributed by NM, 9-Jul-2012.) $)
  biortn $p |- ( ph -> ( ps <-> ( -. ph \/ ps ) ) ) $=
    ( wn wo wb notnot1 biorf syl ) AACZCBIBDEAFIBGH $.

  ${
    biorfi.1 $e |- -. ph $.
    $( A wff is equivalent to its disjunction with falsehood.  (Contributed by
       NM, 23-Mar-1995.) $)
    biorfi $p |- ( ps <-> ( ps \/ ph ) ) $=
      ( wn wo wb orc orel2 impbid2 ax-mp ) ADZBBAEZFCKBLBAGABHIJ $.
  $}

  $( Theorem *2.621 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.)  (Revised by NM, 13-Dec-2013.) $)
  pm2.621 $p |- ( ( ph -> ps ) -> ( ( ph \/ ps ) -> ps ) ) $=
    ( wi id idd jaod ) ABCZABBGDGBEF $.

  $( Theorem *2.62 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 13-Dec-2013.) $)
  pm2.62 $p |- ( ( ph \/ ps ) -> ( ( ph -> ps ) -> ps ) ) $=
    ( wi wo pm2.621 com12 ) ABCABDBABEF $.

  ${
    imorri.1 $e |- ( -. ph \/ ps ) $.
    $( Infer implication from disjunction.  (Contributed by Jonathan Ben-Naim,
       3-Jun-2011.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
    imorri $p |- ( ph -> ps ) $=
      ( wn wo wi pm2.21 ax-1 jaoi ax-mp ) ADZBEABFZCKLBABGBAHIJ $.
  $}

  $( Negated disjunction in terms of conjunction.  This version of DeMorgan's
     law holds for all propositions (not just decidable ones), unlike ~ oran ,
     ~ anordc , or ~ ianordc .  Compare Theorem *4.56 of [WhiteheadRussell]
     p. 120.  (Contributed by NM, 5-Aug-1993.)  (Revised by Mario Carneiro,
     31-Jan-2015.) $)
  ioran $p |- ( -. ( ph \/ ps ) <-> ( -. ph /\ -. ps ) ) $=
    ( wo wn wa pm2.45 pm2.46 jca simpl con2i simpr jaoi impbii ) ABCZDZADZBDZEZ
    OPQABFABGHNRARDBRAPQIJRBPQKJLJM $.

  $( Theorem *3.14 of [WhiteheadRussell] p. 111.  (Contributed by NM,
     3-Jan-2005.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
  pm3.14 $p |- ( ( -. ph \/ -. ps ) -> -. ( ph /\ ps ) ) $=
    ( wn wa simpl con3i simpr jaoi ) ACABDZCBCIAABEFIBABGFH $.

  $( Theorem *3.1 of [WhiteheadRussell] p. 111.  (Contributed by NM,
     3-Jan-2005.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
  pm3.1 $p |- ( ( ph /\ ps ) -> -. ( -. ph \/ -. ps ) ) $=
    ( wn wo wa pm3.14 con2i ) ACBCDABEABFG $.

  $( Disjunction of antecedents.  Compare Theorem *3.44 of [WhiteheadRussell]
     p. 113.  (Contributed by NM, 5-Apr-1994.)  (Proof shortened by Wolf
     Lammen, 4-Apr-2013.) $)
  jao $p |- ( ( ph -> ps ) -> ( ( ch -> ps ) -> ( ( ph \/ ch ) -> ps ) ) ) $=
    ( wi wo pm3.44 ex ) ABDCBDACEBDBACFG $.

  $( Axiom *1.2 (Taut) of [WhiteheadRussell] p. 96.  (Contributed by NM,
     3-Jan-2005.)  (Revised by NM, 10-Mar-2013.) $)
  pm1.2 $p |- ( ( ph \/ ph ) -> ph ) $=
    ( id jaoi ) AAAABZDC $.

  $( Idempotent law for disjunction.  Theorem *4.25 of [WhiteheadRussell]
     p. 117.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew
     Salmon, 16-Apr-2011.)  (Proof shortened by Wolf Lammen, 10-Mar-2013.) $)
  oridm $p |- ( ( ph \/ ph ) <-> ph ) $=
    ( wo pm1.2 pm2.07 impbii ) AABAACADE $.

  $( Theorem *4.25 of [WhiteheadRussell] p. 117.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.25 $p |- ( ph <-> ( ph \/ ph ) ) $=
    ( wo oridm bicomi ) AABAACD $.

  ${
    orim12i.1 $e |- ( ph -> ps ) $.
    orim12i.2 $e |- ( ch -> th ) $.
    $( Disjoin antecedents and consequents of two premises.  (Contributed by
       NM, 6-Jun-1994.)  (Proof shortened by Wolf Lammen, 25-Jul-2012.) $)
    orim12i $p |- ( ( ph \/ ch ) -> ( ps \/ th ) ) $=
      ( wo orcd olcd jaoi ) ABDGCABDEHCDBFIJ $.
  $}

  ${
    orim1i.1 $e |- ( ph -> ps ) $.
    $( Introduce disjunct to both sides of an implication.  (Contributed by NM,
       6-Jun-1994.) $)
    orim1i $p |- ( ( ph \/ ch ) -> ( ps \/ ch ) ) $=
      ( id orim12i ) ABCCDCEF $.

    $( Introduce disjunct to both sides of an implication.  (Contributed by NM,
       6-Jun-1994.) $)
    orim2i $p |- ( ( ch \/ ph ) -> ( ch \/ ps ) ) $=
      ( id orim12i ) CCABCEDF $.
  $}

  ${
    orbi2i.1 $e |- ( ph <-> ps ) $.
    $( Inference adding a left disjunct to both sides of a logical
       equivalence.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
       Lammen, 12-Dec-2012.) $)
    orbi2i $p |- ( ( ch \/ ph ) <-> ( ch \/ ps ) ) $=
      ( wo biimpi orim2i biimpri impbii ) CAECBEABCABDFGBACABDHGI $.

    $( Inference adding a right disjunct to both sides of a logical
       equivalence.  (Contributed by NM, 5-Aug-1993.) $)
    orbi1i $p |- ( ( ph \/ ch ) <-> ( ps \/ ch ) ) $=
      ( wo orcom orbi2i 3bitri ) ACECAECBEBCEACFABCDGCBFH $.
  $}

  ${
    orbi12i.1 $e |- ( ph <-> ps ) $.
    orbi12i.2 $e |- ( ch <-> th ) $.
    $( Infer the disjunction of two equivalences.  (Contributed by NM,
       5-Aug-1993.) $)
    orbi12i $p |- ( ( ph \/ ch ) <-> ( ps \/ th ) ) $=
      ( wo orbi2i orbi1i bitri ) ACGADGBDGCDAFHABDEIJ $.
  $}

  $( Axiom *1.5 (Assoc) of [WhiteheadRussell] p. 96.  (Contributed by NM,
     3-Jan-2005.) $)
  pm1.5 $p |- ( ( ph \/ ( ps \/ ch ) ) -> ( ps \/ ( ph \/ ch ) ) ) $=
    ( wo orc olcd olc orim2i jaoi ) ABACDZDBCDAJBACEFCJBCAGHI $.

  $( Swap two disjuncts.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by
     Wolf Lammen, 14-Nov-2012.) $)
  or12 $p |- ( ( ph \/ ( ps \/ ch ) ) <-> ( ps \/ ( ph \/ ch ) ) ) $=
    ( wo pm1.5 impbii ) ABCDDBACDDABCEBACEF $.

  $( Associative law for disjunction.  Theorem *4.33 of [WhiteheadRussell]
     p. 118.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew
     Salmon, 26-Jun-2011.) $)
  orass $p |- ( ( ( ph \/ ps ) \/ ch ) <-> ( ph \/ ( ps \/ ch ) ) ) $=
    ( wo orcom or12 orbi2i 3bitri ) ABDZCDCIDACBDZDABCDZDICECABFJKACBEGH $.

  $( Theorem *2.31 of [WhiteheadRussell] p. 104.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.31 $p |- ( ( ph \/ ( ps \/ ch ) ) -> ( ( ph \/ ps ) \/ ch ) ) $=
    ( wo orass biimpri ) ABDCDABCDDABCEF $.

  $( Theorem *2.32 of [WhiteheadRussell] p. 105.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.32 $p |- ( ( ( ph \/ ps ) \/ ch ) -> ( ph \/ ( ps \/ ch ) ) ) $=
    ( wo orass biimpi ) ABDCDABCDDABCEF $.

  $( A rearrangement of disjuncts.  (Contributed by NM, 18-Oct-1995.)  (Proof
     shortened by Andrew Salmon, 26-Jun-2011.) $)
  or32 $p |- ( ( ( ph \/ ps ) \/ ch ) <-> ( ( ph \/ ch ) \/ ps ) ) $=
    ( wo orass or12 orcom 3bitri ) ABDCDABCDDBACDZDIBDABCEABCFBIGH $.

  $( Rearrangement of 4 disjuncts.  (Contributed by NM, 12-Aug-1994.) $)
  or4 $p |- ( ( ( ph \/ ps ) \/ ( ch \/ th ) ) <->
                ( ( ph \/ ch ) \/ ( ps \/ th ) ) ) $=
    ( wo or12 orbi2i orass 3bitr4i ) ABCDEZEZEACBDEZEZEABEJEACELEKMABCDFGABJHAC
    LHI $.

  $( Rearrangement of 4 disjuncts.  (Contributed by NM, 10-Jan-2005.) $)
  or42 $p |- ( ( ( ph \/ ps ) \/ ( ch \/ th ) ) <->
                 ( ( ph \/ ch ) \/ ( th \/ ps ) ) ) $=
    ( wo or4 orcom orbi2i bitri ) ABECDEEACEZBDEZEJDBEZEABCDFKLJBDGHI $.

  $( Distribution of disjunction over disjunction.  (Contributed by NM,
     25-Feb-1995.) $)
  orordi $p |- ( ( ph \/ ( ps \/ ch ) ) <->
               ( ( ph \/ ps ) \/ ( ph \/ ch ) ) ) $=
    ( wo oridm orbi1i or4 bitr3i ) ABCDZDAADZIDABDACDDJAIAEFAABCGH $.

  $( Distribution of disjunction over disjunction.  (Contributed by NM,
     25-Feb-1995.) $)
  orordir $p |- ( ( ( ph \/ ps ) \/ ch ) <->
               ( ( ph \/ ch ) \/ ( ps \/ ch ) ) ) $=
    ( wo oridm orbi2i or4 bitr3i ) ABDZCDICCDZDACDBCDDJCICEFABCCGH $.

  $( Theorem *2.3 of [WhiteheadRussell] p. 104.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.3 $p |- ( ( ph \/ ( ps \/ ch ) ) -> ( ph \/ ( ch \/ ps ) ) ) $=
    ( wo pm1.4 orim2i ) BCDCBDABCEF $.

  $( Theorem *2.41 of [WhiteheadRussell] p. 106.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.41 $p |- ( ( ps \/ ( ph \/ ps ) ) -> ( ph \/ ps ) ) $=
    ( wo olc id jaoi ) BABCZGBADGEF $.

  $( Theorem *2.42 of [WhiteheadRussell] p. 106.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.42 $p |- ( ( -. ph \/ ( ph -> ps ) ) -> ( ph -> ps ) ) $=
    ( wn wi pm2.21 id jaoi ) ACABDZHABEHFG $.

  $( Theorem *2.4 of [WhiteheadRussell] p. 106.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.4 $p |- ( ( ph \/ ( ph \/ ps ) ) -> ( ph \/ ps ) ) $=
    ( wo orc id jaoi ) AABCZGABDGEF $.

  $( Theorem *4.44 of [WhiteheadRussell] p. 119.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.44 $p |- ( ph <-> ( ph \/ ( ph /\ ps ) ) ) $=
    ( wa wo orc id simpl jaoi impbii ) AAABCZDAJEAAJAFABGHI $.

  ${
    mtord.1 $e |- ( ph -> -. ch ) $.
    mtord.2 $e |- ( ph -> -. th ) $.
    mtord.3 $e |- ( ph -> ( ps -> ( ch \/ th ) ) ) $.
    $( A modus tollens deduction involving disjunction.  (Contributed by Jeff
       Hankins, 15-Jul-2009.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
    mtord $p |- ( ph -> -. ps ) $=
      ( wo wn pm2.21d jaod syld pm2.01d ) ABABCDHBIZGACNDACNEJADNFJKLM $.
  $}

  $( Theorem *4.45 of [WhiteheadRussell] p. 119.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.45 $p |- ( ph <-> ( ph /\ ( ph \/ ps ) ) ) $=
    ( wo orc pm4.71i ) AABCABDE $.

  $( Theorem *3.48 of [WhiteheadRussell] p. 114.  (Contributed by NM,
     28-Jan-1997.)  (Revised by NM, 1-Dec-2012.) $)
  pm3.48 $p |- ( ( ( ph -> ps ) /\ ( ch -> th ) ) ->
               ( ( ph \/ ch ) -> ( ps \/ th ) ) ) $=
    ( wi wo orc imim2i olc jaao ) ABEABDFZCDECBKABDGHDKCDBIHJ $.

  ${
    orim12d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    orim12d.2 $e |- ( ph -> ( th -> ta ) ) $.
    $( Disjoin antecedents and consequents in a deduction.  (Contributed by NM,
       10-May-1994.) $)
    orim12d $p |- ( ph -> ( ( ps \/ th ) -> ( ch \/ ta ) ) ) $=
      ( wi wo pm3.48 syl2anc ) ABCHDEHBDICEIHFGBCDEJK $.
  $}

  ${
    orim1d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Disjoin antecedents and consequents in a deduction.  (Contributed by NM,
       23-Apr-1995.) $)
    orim1d $p |- ( ph -> ( ( ps \/ th ) -> ( ch \/ th ) ) ) $=
      ( idd orim12d ) ABCDDEADFG $.

    $( Disjoin antecedents and consequents in a deduction.  (Contributed by NM,
       23-Apr-1995.) $)
    orim2d $p |- ( ph -> ( ( th \/ ps ) -> ( th \/ ch ) ) ) $=
      ( idd orim12d ) ADDBCADFEG $.
  $}

  $( Axiom *1.6 (Sum) of [WhiteheadRussell] p. 97.  (Contributed by NM,
     3-Jan-2005.) $)
  orim2 $p |- ( ( ps -> ch ) -> ( ( ph \/ ps ) -> ( ph \/ ch ) ) ) $=
    ( wi id orim2d ) BCDZBCAGEF $.

  ${
    orbid.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduction adding a left disjunct to both sides of a logical
       equivalence.  (Contributed by NM, 5-Aug-1993.)  (Revised by Mario
       Carneiro, 31-Jan-2015.) $)
    orbi2d $p |- ( ph -> ( ( th \/ ps ) <-> ( th \/ ch ) ) ) $=
      ( wo biimpd orim2d biimprd impbid ) ADBFDCFABCDABCEGHACBDABCEIHJ $.

    $( Deduction adding a right disjunct to both sides of a logical
       equivalence.  (Contributed by NM, 5-Aug-1993.) $)
    orbi1d $p |- ( ph -> ( ( ps \/ th ) <-> ( ch \/ th ) ) ) $=
      ( wo orbi2d orcom 3bitr4g ) ADBFDCFBDFCDFABCDEGBDHCDHI $.
  $}

  $( Theorem *4.37 of [WhiteheadRussell] p. 118.  (Contributed by NM,
     3-Jan-2005.) $)
  orbi1 $p |- ( ( ph <-> ps ) -> ( ( ph \/ ch ) <-> ( ps \/ ch ) ) ) $=
    ( wb id orbi1d ) ABDZABCGEF $.

  ${
    orbi12d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    orbi12d.2 $e |- ( ph -> ( th <-> ta ) ) $.
    $( Deduction joining two equivalences to form equivalence of disjunctions.
       (Contributed by NM, 5-Aug-1993.) $)
    orbi12d $p |- ( ph -> ( ( ps \/ th ) <-> ( ch \/ ta ) ) ) $=
      ( wo orbi1d orbi2d bitrd ) ABDHCDHCEHABCDFIADECGJK $.
  $}

  $( Theorem *5.61 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 30-Jun-2013.) $)
  pm5.61 $p |- ( ( ( ph \/ ps ) /\ -. ps ) <-> ( ph /\ -. ps ) ) $=
    ( wn wo biorf orcom syl6rbb pm5.32ri ) BCZABDZAIABADJBAEBAFGH $.

  ${
    jaoian.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    jaoian.2 $e |- ( ( th /\ ps ) -> ch ) $.
    $( Inference disjoining the antecedents of two implications.  (Contributed
       by NM, 23-Oct-2005.) $)
    jaoian $p |- ( ( ( ph \/ th ) /\ ps ) -> ch ) $=
      ( wo wi ex jaoi imp ) ADGBCABCHDABCEIDBCFIJK $.
  $}

  ${
    jaodan.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    jaodan.2 $e |- ( ( ph /\ th ) -> ch ) $.
    $( Deduction disjoining the antecedents of two implications.  (Contributed
       by NM, 14-Oct-2005.) $)
    jaodan $p |- ( ( ph /\ ( ps \/ th ) ) -> ch ) $=
      ( wo ex jaod imp ) ABDGCABCDABCEHADCFHIJ $.
  $}

  $( Theorem *4.77 of [WhiteheadRussell] p. 121.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.77 $p |- ( ( ( ps -> ph ) /\ ( ch -> ph ) ) <->
                ( ( ps \/ ch ) -> ph ) ) $=
    ( wo wi wa jaob bicomi ) BCDAEBAECAEFBACGH $.

  $( Theorem *2.63 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.63 $p |- ( ( ph \/ ps ) -> ( ( -. ph \/ ps ) -> ps ) ) $=
    ( wo wn pm2.53 idd jaod ) ABCZADBBABEHBFG $.

  $( Theorem *2.64 of [WhiteheadRussell] p. 107.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.64 $p |- ( ( ph \/ ps ) -> ( ( ph \/ -. ps ) -> ph ) ) $=
    ( wn wo wi ax-1 orel2 jaoi com12 ) ABCZDABDZAAKAEJAKFBAGHI $.

  $( Theorem *5.53 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.53 $p |- ( ( ( ( ph \/ ps ) \/ ch ) -> th ) <->
                ( ( ( ph -> th ) /\ ( ps -> th ) ) /\ ( ch -> th ) ) ) $=
    ( wo wi wa jaob anbi1i bitri ) ABEZCEDFKDFZCDFZGADFBDFGZMGKDCHLNMADBHIJ $.

  $( Theorem *2.38 of [WhiteheadRussell] p. 105.  (Contributed by NM,
     6-Mar-2008.) $)
  pm2.38 $p |- ( ( ps -> ch ) -> ( ( ps \/ ph ) -> ( ch \/ ph ) ) ) $=
    ( wi id orim1d ) BCDZBCAGEF $.

  $( Theorem *2.36 of [WhiteheadRussell] p. 105.  (Contributed by NM,
     6-Mar-2008.) $)
  pm2.36 $p |- ( ( ps -> ch ) -> ( ( ph \/ ps ) -> ( ch \/ ph ) ) ) $=
    ( wo wi pm1.4 pm2.38 syl5 ) ABDBADBCECADABFABCGH $.

  $( Theorem *2.37 of [WhiteheadRussell] p. 105.  (Contributed by NM,
     6-Mar-2008.) $)
  pm2.37 $p |- ( ( ps -> ch ) -> ( ( ps \/ ph ) -> ( ph \/ ch ) ) ) $=
    ( wi wo pm2.38 pm1.4 syl6 ) BCDBAECAEACEABCFCAGH $.

  $( Theorem *2.73 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.73 $p |- ( ( ph -> ps ) -> ( ( ( ph \/ ps ) \/ ch ) ->
                ( ps \/ ch ) ) ) $=
    ( wi wo pm2.621 orim1d ) ABDABEBCABFG $.

  $( Theorem *2.74 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Mario Carneiro, 31-Jan-2015.) $)
  pm2.74 $p |- ( ( ps -> ph ) -> ( ( ( ph \/ ps ) \/ ch ) ->
                ( ph \/ ch ) ) ) $=
    ( wi wo idd id jaod orim1d ) BADZABEACJAABJAFJGHI $.

  $( Theorem *2.76 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
  pm2.76 $p |- ( ( ph \/ ( ps -> ch ) ) ->
                ( ( ph \/ ps ) -> ( ph \/ ch ) ) ) $=
    ( wo wi orc a1d orim2 jaoi ) AABDZACDZEBCEAKJACFGABCHI $.

  $( Theorem *2.75 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 4-Jan-2013.) $)
  pm2.75 $p |- ( ( ph \/ ps ) ->
                ( ( ph \/ ( ps -> ch ) ) -> ( ph \/ ch ) ) ) $=
    ( wi wo pm2.76 com12 ) ABCDEABEACEABCFG $.

  $( Theorem *2.8 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Mario Carneiro, 31-Jan-2015.) $)
  pm2.8 $p |- ( ( ph \/ ps ) -> ( ( -. ps \/ ch ) -> ( ph \/ ch ) ) ) $=
    ( wo wn pm1.4 ord orim1d ) ABDZBEACIBAABFGH $.

  $( Theorem *2.81 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.81 $p |- ( ( ps -> ( ch -> th ) ) -> ( ( ph \/ ps ) ->
                ( ( ph \/ ch ) -> ( ph \/ th ) ) ) ) $=
    ( wi wo orim2 pm2.76 syl6 ) BCDEZEABFAJFACFADFEABJGACDHI $.

  $( Theorem *2.82 of [WhiteheadRussell] p. 108.  (Contributed by NM,
     3-Jan-2005.) $)
  pm2.82 $p |- ( ( ( ph \/ ps ) \/ ch ) -> ( ( ( ph \/ -. ch ) \/ th ) ->
                ( ( ph \/ ps ) \/ th ) ) ) $=
    ( wo wn wi ax-1 pm2.24 orim2d jaoi orim1d ) ABEZCEACFZEZMDMOMGCMOHCNBACBIJK
    L $.

  ${
    pm3.2ni.1 $e |- -. ph $.
    pm3.2ni.2 $e |- -. ps $.
    $( Infer negated disjunction of negated premises.  (Contributed by NM,
       4-Apr-1995.) $)
    pm3.2ni $p |- -. ( ph \/ ps ) $=
      ( wo id pm2.21i jaoi mto ) ABEACAABAFBADGHI $.
  $}

  $( Absorption of redundant internal disjunct.  Compare Theorem *4.45 of
     [WhiteheadRussell] p. 119.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 28-Feb-2014.) $)
  orabs $p |- ( ph <-> ( ( ph \/ ps ) /\ ph ) ) $=
    ( wo orc pm4.71ri ) AABCABDE $.

  $( Obsolete proof of ~ orabs as of 28-Feb-2014.  (Contributed by NM,
     5-Aug-1993.) $)
  orabsOLD $p |- ( ph <-> ( ( ph \/ ps ) /\ ph ) ) $=
    ( wo wa orc ancri simpr impbii ) AABCZADAIABEFIAGH $.

  $( Absorb a disjunct into a conjunct.  (Contributed by Roy F. Longton,
     23-Jun-2005.)  (Proof shortened by Wolf Lammen, 10-Nov-2013.) $)
  oranabs $p |- ( ( ( ph \/ -. ps ) /\ ps ) <-> ( ph /\ ps ) ) $=
    ( wn wo biortn orcom syl6rbb pm5.32ri ) BABCZDZABAIADJBAEIAFGH $.

  $( Distributive law for disjunction.  Theorem *4.41 of [WhiteheadRussell]
     p. 119.  (Contributed by NM, 5-Aug-1993.)  (Revised by Mario Carneiro,
     31-Jan-2015.) $)
  ordi $p |- ( ( ph \/ ( ps /\ ch ) ) <-> ( ( ph \/ ps ) /\ ( ph \/ ch ) ) ) $=
    ( wa wo simpl orim2i simpr jca orc adantl adantr olc jaoian jaodan impbii )
    ABCDZEZABEZACEZDRSTQBABCFGQCABCHGISARCARSAQJZKACRBARCUALQAMNOP $.

  $( Distributive law for disjunction.  (Contributed by NM, 12-Aug-1994.) $)
  ordir $p |- ( ( ( ph /\ ps ) \/ ch ) <->
              ( ( ph \/ ch ) /\ ( ps \/ ch ) ) ) $=
    ( wa wo ordi orcom anbi12i 3bitr4i ) CABDZECAEZCBEZDJCEACEZBCEZDCABFJCGMKNL
    ACGBCGHI $.

  $( Distributive law for conjunction.  Theorem *4.4 of [WhiteheadRussell]
     p. 118.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 5-Jan-2013.) $)
  andi $p |- ( ( ph /\ ( ps \/ ch ) ) <-> ( ( ph /\ ps ) \/ ( ph /\ ch ) ) ) $=
    ( wo wa orc olc jaodan anim2i jaoi impbii ) ABCDZEZABEZACEZDZABPCNOFONGHNMO
    BLABCFICLACBGIJK $.

  $( Distributive law for conjunction.  (Contributed by NM, 12-Aug-1994.) $)
  andir $p |- ( ( ( ph \/ ps ) /\ ch ) <->
              ( ( ph /\ ch ) \/ ( ps /\ ch ) ) ) $=
    ( wo wa andi ancom orbi12i 3bitr4i ) CABDZECAEZCBEZDJCEACEZBCEZDCABFJCGMKNL
    ACGBCGHI $.

  $( Double distributive law for disjunction.  (Contributed by NM,
     12-Aug-1994.) $)
  orddi $p |- ( ( ( ph /\ ps ) \/ ( ch /\ th ) ) <->
              ( ( ( ph \/ ch ) /\ ( ph \/ th ) ) /\
              ( ( ps \/ ch ) /\ ( ps \/ th ) ) ) ) $=
    ( wa wo ordir ordi anbi12i bitri ) ABECDEZFAKFZBKFZEACFADFEZBCFBDFEZEABKGLN
    MOACDHBCDHIJ $.

  $( Double distributive law for conjunction.  (Contributed by NM,
     12-Aug-1994.) $)
  anddi $p |- ( ( ( ph \/ ps ) /\ ( ch \/ th ) ) <->
              ( ( ( ph /\ ch ) \/ ( ph /\ th ) ) \/
              ( ( ps /\ ch ) \/ ( ps /\ th ) ) ) ) $=
    ( wo wa andir andi orbi12i bitri ) ABECDEZFAKFZBKFZEACFADFEZBCFBDFEZEABKGLN
    MOACDHBCDHIJ $.

  $( Prove formula-building rules for the biconditional connective. $)

  $( Theorem *4.39 of [WhiteheadRussell] p. 118.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.39 $p |- ( ( ( ph <-> ch ) /\ ( ps <-> th ) ) ->
                ( ( ph \/ ps ) <-> ( ch \/ th ) ) ) $=
    ( wb wa simpl simpr orbi12d ) ACEZBDEZFACBDJKGJKHI $.

  $( Implication in terms of biconditional and disjunction.  Theorem *4.72 of
     [WhiteheadRussell] p. 121.  (Contributed by NM, 30-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 30-Jan-2013.) $)
  pm4.72 $p |- ( ( ph -> ps ) <-> ( ps <-> ( ph \/ ps ) ) ) $=
    ( wi wo wb olc pm2.621 impbid2 orc bi2 syl5 impbii ) ABCZBABDZEZMBNBAFABGHA
    NOBABIBNJKL $.

  $( Theorem *5.16 of [WhiteheadRussell] p. 124.  (Contributed by NM,
     3-Jan-2005.)  (Revised by Mario Carneiro, 31-Jan-2015.) $)
  pm5.16 $p |- -. ( ( ph <-> ps ) /\ ( ph <-> -. ps ) ) $=
    ( wb wn wa pm5.19 simpl simpr bitr3d mto ) ABCZABDZCZEZBLCBFNABLKMGKMHIJ $.

  $( A wff is disjoined with truth is true.  (Contributed by NM,
     23-May-1999.) $)
  biort $p |- ( ph -> ( ph <-> ( ph \/ ps ) ) ) $=
    ( wo orc ax-1 impbid2 ) AAABCZABDAGEF $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Decidable propositions
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)
  $( Declare connective for decidability. $)
  $c DECID $.

  $( Extend wff definition to include decidability. $)
  wdc $a wff DECID ph $.

  $( Propositions which are known to be true or false are called decidable.
     The (classical) Law of the Excluded Middle corresponds to the principle
     that all propositions are decidable, but even given intuitionistic logic,
     particular kinds of propositions may be decidable (for example, the
     proposition that two natural numbers are equal will be decidable under
     most sets of axioms).

     Our notation for decidability is a connective ` DECID ` which we place
     before the formula in question.  For example, ` DECID x = y ` corresponds
     to "x = y is decidable".  (Contributed by Jim Kingdon, 11-Mar-2018.) $)
  df-dc $a |- ( DECID ph <-> ( ph \/ -. ph ) ) $.

  $( Law of excluded middle, for a decidable proposition.  The law of the
     excluded middle is also called the principle of _tertium non datur_.
     Theorem *2.11 of [WhiteheadRussell] p. 101.  It says that something is
     either true or not true; there are no in-between values of truth.  The key
     way in which intuitionistic logic differs from classical logic is that
     intuitionistic logic says that excluded middle only holds for some
     propositions, and classical logic says that it holds for all
     propositions.  (Contributed by Jim Kingdon, 12-May-2018.) $)
  exmiddc $p |- ( DECID ph -> ( ph \/ -. ph ) ) $=
    ( wdc wn wo df-dc biimpi ) ABAACDAEF $.

  $( Commuted law of the excluded middle for a decidable proposition.  Based on
     theorem *2.1 of [WhiteheadRussell] p. 101.  (Contributed by Jim Kingdon,
     25-Mar-2018.) $)
  pm2.1dc $p |- ( DECID ph -> ( -. ph \/ ph ) ) $=
    ( wdc wn wo df-dc orcom bitri biimpi ) ABZACZADZIAJDKAEAJFGH $.

  $( A decidable proposition is decidable when negated.  (Contributed by Jim
     Kingdon, 25-Mar-2018.) $)
  dcn $p |- ( DECID ph -> DECID -. ph ) $=
    ( wn wo wdc notnot1 orim2i orcoms df-dc 3imtr4i ) AABZCJJBZCZADJDJALAKJAEFG
    AHJHI $.

  ${
    dcbii.1 $e |- ( ph <-> ps ) $.
    $( The equivalent of a decidable proposition is decidable.  (Contributed by
       Jim Kingdon, 28-Mar-2018.) $)
    dcbii $p |- ( DECID ph <-> DECID ps ) $=
      ( wn wo wdc notbii orbi12i df-dc 3bitr4i ) AADZEBBDZEAFBF
      ABKLCABCGHAIBIJ $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Theorems of decidable propositions
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   Many theorems of logic hold in intuitionistic logic just as they do in
   classical (non-inuitionistic) logic, for all propositions. Other theorems
   only hold for decidable propositions, such as the law of the excluded
   middle ( ~ df-dc ), double negation elimination ( ~ notnotdc ), or
   contraposition ( ~ condc ). Our goal is to prove all well-known
   or important classical theorems, but with suitable decidability
   conditions so that the proofs follow from intuitionistic axioms.
   This section is focused on such proofs, given decidability conditions.
$)

  $( Contraposition of a decidable proposition.  (Contributed by Jim Kingdon,
     13-Mar-2018.) $)
  condc $p |- ( DECID ph -> ( ( -. ph -> -. ps ) -> ( ps -> ph ) ) ) $=
    ( wdc wn wo wi df-dc ax-1 a1d pm2.27 ax-in2 syl6 jaoi sylbi ) ACA
    ADZEOBDZFZBAFZFZAGASOARQABHIOQPROPJBAKLMN $.

  $( Proof by contradiction for a decidable proposition.  Based on Theorem
     *2.18 of [WhiteheadRussell] p. 103 (also called the Law of Clavius).
     Intuitionistically it requires a decidability assumption, but compare with
     ~ pm2.01 which does not.  (Contributed by Jim Kingdon, 24-Mar-2018.) $)
  pm2.18dc $p |- ( DECID ph -> ( ( -. ph -> ph ) -> ph ) ) $=
    ( wdc wn wi pm2.21 a2i condc syl5 pm2.43d ) ABZACZADZALKLCZDJLADKAMAMEFALGH
    I $.

  $( Double negation elimination for a decidable proposition.  (Contributed by
     Jim Kingdon, 11-Mar-2018.) $)
  notnot2dc $p |- ( DECID ph -> ( -. -. ph -> ph ) ) $=
    ( wdc wn wo wi df-dc orcom bitri pm2.53 sylbi ) ABZACZADZLCAEKALD
    MAFALGHLAIJ $.

  $( Contraposition for a decidable proposition.  Based on theorem *2.15 of
     [WhiteheadRussell] p. 102.  (Contributed by Jim Kingdon, 29-Mar-2018.) $)
  con1dc $p |- ( DECID ph -> ( ( -. ph -> ps ) -> ( -. ps -> ph ) ) ) $=
    ( wn wi wdc notnot1 imim2i condc syl5 ) ACZBDJBCZCZDAEKADBLJBFGAK
    HI $.

  ${
    con4biddc.1 $e |- ( ph -> ( DECID ps -> ( DECID ch ->
        ( -. ps <-> -. ch ) ) ) ) $.
    $( A contraposition deduction.  (Contributed by Jim Kingdon,
       18-May-2018.) $)
    con4biddc $p |- ( ph -> ( DECID ps -> ( DECID ch -> ( ps <-> ch ) ) ) ) $=
      ( wdc wb wa wi wn bi2 syl8 condc a2i imp31 bi1 imim2d
      syl6 sylcom impbid exp31 ) ABEZCEZBCFAUAGUBGBCAUAUBBCHZAUAUBCIZBI
      ZHZHUBUCHAUAUBUEUDFZUFDUEUDJKUBUFUCCBLMQNAUAUBCBHZAUAUBUEUDHZHUBU
      HHAUAUBUGUIDUEUDOKUAUIUHUBBCLPRNST $.
  $}

  ${
    impidc.1 $e |- ( DECID ch -> ( ph -> ( ps -> ch ) ) ) $.
    $( An importation inference for a decidable consequent.  (Contributed by
       Jim Kingdon, 30-Apr-2018.) $)
    impidc $p |- ( DECID ch -> ( -. ( ph -> -. ps ) -> ch ) ) $=
      ( wdc wn wi wa imp con3d ex com23 con1dc mpd ) CEZCFZABF
      ZGZGRFCGOAPQOAPQGOAHBCOABCGDIJKLCRMN $.
  $}

  $( Simplification given a decidable proposition.  Similar to Theorem *3.27
     (Simp) of [WhiteheadRussell] p. 112.  (Contributed by Jim Kingdon,
     30-Apr-2018.) $)
  simprimdc $p |- ( DECID ps -> ( -. ( ph -> -. ps ) -> ps ) ) $=
    ( wi wdc idd a1i impidc ) ABBABBCCBDABEFG $.

  $( Simplification for a decidable proposition.  Similar to Theorem *3.26
     (Simp) of [WhiteheadRussell] p. 112.  (Contributed by Jim Kingdon,
     29-Mar-2018.) $)
  simplimdc $p |- ( DECID ph -> ( -. ( ph -> ps ) -> ph ) ) $=
    ( wdc wn wi pm2.21 con1dc mpi ) ACADABEZEIDAEABFAIGH $.

  ${
    pm2.61ddc.1 $e |- ( ph -> ( ps -> ch ) ) $.
    pm2.61ddc.2 $e |- ( ph -> ( -. ps -> ch ) ) $.
    $( Deduction eliminating a decidable antecedent.  (Contributed by Jim
       Kingdon, 4-May-2018.) $)
    pm2.61ddc $p |- ( DECID ps -> ( ph -> ch ) ) $=
      ( wdc wn wo wi df-dc com12 jaoi sylbi ) BFBBGZHACIZBJBONABCDKANCE
      KLM $.
  $}

  $( Case elimination for a decidable proposition.  Based on theorem *2.6 of
     [WhiteheadRussell] p. 107.  (Contributed by Jim Kingdon, 25-Mar-2018.) $)
  pm2.6dc $p |- ( DECID ph -> ( ( -. ph -> ps ) -> ( ( ph -> ps ) -> ps ) ) ) $=
    ( wdc wn wi wo wa pm2.1dc pm3.44 syl5com exp3a ) ACZADZBEZABEZBLMAFNOGBAHBM
    AIJK $.

  ${
    jadc.1 $e |- ( DECID ph -> ( -. ph -> ch ) ) $.
    jadc.2 $e |- ( ps -> ch ) $.
    $( Inference forming an implication from the antecedents of two premises,
       where a decidable antecedent is negated.  (Contributed by Jim Kingdon,
       25-Mar-2018.) $)
    jadc $p |- ( DECID ph -> ( ( ph -> ps ) -> ch ) ) $=
      ( wi wdc imim2i wn pm2.6dc mpd syl5 ) ABFACFZAGZCBCAEHNAICFMCFDACJKL $.
  $}

  ${
    jaddc.1 $e |- ( ph -> ( DECID ps -> ( -. ps -> th ) ) ) $.
    jaddc.2 $e |- ( ph -> ( ch -> th ) ) $.
    $( Deduction forming an implication from the antecedents of two premises,
       where a decidable antecedent is negated.  (Contributed by Jim Kingdon,
       26-Mar-2018.) $)
    jaddc $p |- ( ph -> ( DECID ps -> ( ( ps -> ch ) -> th ) ) ) $=
      ( wi wdc imim2d wn pm2.6dc sylcom syl5d ) ABCGBDGZBHZDACDBFIAOBJDGNDGEBDK
      LM $.
  $}

  $( Case elimination for a decidable proposition.  Based on theorem *2.61 of
     [WhiteheadRussell] p. 107.  (Contributed by Jim Kingdon, 29-Mar-2018.) $)
  pm2.61dc $p |- ( DECID ph ->
                   ( ( ph -> ps ) -> ( ( -. ph -> ps ) -> ps ) ) ) $=
    ( wdc wn wi pm2.6dc com23 ) ACADBEABEBABFG $.

  $( Negating an implication for a decidable antecedent.  Based on theorem *2.5
     of [WhiteheadRussell] p. 107.  (Contributed by Jim Kingdon,
     29-Mar-2018.) $)
  pm2.5dc $p |- ( DECID ph -> ( -. ( ph -> ps ) -> ( -. ph -> ps ) ) ) $=
    ( wdc wi wn wa simplimdc imp pm2.24d ex ) ACZABDEZAEBDKLFABKLAABG
    HIJ $.

  $( Theorem *2.521 of [WhiteheadRussell] p. 107, but with an additional
     decidability condition.  (Contributed by Jim Kingdon, 5-May-2018.) $)
  pm2.521dc $p |- ( DECID ph -> ( -. ( ph -> ps ) -> ( ps -> ph ) ) ) $=
    ( wi wn wdc pm2.52 condc syl5 ) ABCDADBDCAEBACABFABGH $.

  $( Contraposition.  Theorem *4.1 of [WhiteheadRussell] p. 116, but for a
     decidable proposition.  (Contributed by Jim Kingdon, 24-Apr-2018.) $)
  con34bdc $p |- ( DECID ps -> ( ( ph -> ps ) <-> ( -. ps -> -. ph ) ) ) $=
    ( wdc wi wn con3 condc impbid2 ) BCABDBEAEDABFBAGH $.

  $( Double negation equivalence for a decidable proposition.  Like theorem
     *4.13 of [WhiteheadRussell] p. 117, but with a decidability antecendent.
     (Contributed by Jim Kingdon, 13-Mar-2018.) $)
  notnotdc $p |- ( DECID ph -> ( ph <-> -. -. ph ) ) $=
    ( wdc wn notnot1 notnot2dc impbid2 ) ABAACCADAEF $.

  $( Contraposition.  (Contributed by Jim Kingdon, 4-Apr-2018.) $)
  con1biimdc $p |- ( DECID ph -> ( ( -. ph <-> ps ) -> ( -. ps <-> ph ) ) ) $=
    ( wdc wn wb wi bi1 con1dc syl5 bi2 con2d a1i impbidd ) ACZADZBEZBDZAPOBFNQA
    FOBGABHIPAQFFNPBAOBJKLM $.

  $( Contraposition.  (Contributed by Jim Kingdon, 17-Apr-2018.) $)
  con1bidc $p |- ( DECID ph -> ( DECID ps ->
      ( ( -. ph <-> ps ) <-> ( -. ps <-> ph ) ) ) ) $=
    ( wdc wn wb wa wi con1biimdc adantr adantl impbid ex ) ACZBCZADBE
    ZBDAEZEMNFOPMOPGNABHINPOGMBAHJKL $.

  $( Contraposition.  (Contributed by Jim Kingdon, 17-Apr-2018.) $)
  con2bidc $p |- ( DECID ph -> ( DECID ps ->
      ( ( ph <-> -. ps ) <-> ( ps <-> -. ph ) ) ) ) $=
    ( wdc wn wb wa con1bidc imp bicom 3bitr3g bicomd ex ) ACZBCZABDZEZBADZEZEMN
    FZRPSQBEZOAEZRPMNTUAEABGHQBIOAIJKL $.

  ${
    con1biddc.1 $e |- ( ph -> ( DECID ps -> ( -. ps <-> ch ) ) ) $.
    $( A contraposition deduction.  (Contributed by Jim Kingdon,
       4-Apr-2018.) $)
    con1biddc $p |- ( ph -> ( DECID ps -> ( -. ch <-> ps ) ) ) $=
      ( wdc wn wb con1biimdc sylcom ) ABEBFCGCFBGDBCHI $.
  $}

  ${
    con1biidc.1 $e |- ( DECID ph -> ( -. ph <-> ps ) ) $.
    $( A contraposition inference.  (Contributed by Jim Kingdon,
       15-Mar-2018.) $)
    con1biidc $p |- ( DECID ph -> ( -. ps <-> ph ) ) $=
      ( wdc wn notnotdc notbid bitrd bicomd ) ADZABEZJAAEZE
      KAFJLBCGHI $.
  $}

  $( Contraposition.  Bidirectional version of ~ con1dc .  (Contributed by NM,
     5-Aug-1993.) $)
  con1bdc $p |- ( DECID ph -> ( DECID ps ->
                  ( ( -. ph -> ps ) <-> ( -. ps -> ph ) ) ) ) $=
    ( wdc wn wi wb wa con1dc adantr adantl impbid ex ) ACZBCZADBEZBDA
    EZFMNGOPMOPENABHINPOEMBAHJKL $.

  ${
    con2biidc.1 $e |- ( DECID ps -> ( ph <-> -. ps ) ) $.
    $( A contraposition inference.  (Contributed by Jim Kingdon,
       15-Mar-2018.) $)
    con2biidc $p |- ( DECID ps -> ( ps <-> -. ph ) ) $=
      ( wdc wn bicomd con1biidc ) BDZAEBBAHABECFGF $.
  $}

  ${
    con2biddc.1 $e |- ( ph -> ( DECID ch -> ( ps <-> -. ch ) ) ) $.
    $( A contraposition deduction.  (Contributed by Jim Kingdon,
       11-Apr-2018.) $)
    con2biddc $p |- ( ph -> ( DECID ch -> ( ch <-> -. ps ) ) ) $=
      ( wdc wn wb bicom syl6ib con1biddc ) ACEZBFZCGCLGACBA
      KBCFZGMBGDBMHIJLCHI $.
  $}

  ${
    condandc.1 $e |- ( ( ph /\ -. ps ) -> ch ) $.
    condandc.2 $e |- ( ( ph /\ -. ps ) -> -. ch ) $.
    $( Proof by contradiction.  This only holds for decidable propositions, as
       it is part of the family of theorems which assume ` -. ps ` , derive a
       contradiction, and therefore conclude ` ps ` .  By contrast, assuming
       ` ps ` , deriving a contradiction, and therefore concluding ` -. ps ` ,
       as in ~ pm2.65 , is valid for all propositions.  (Contributed by Jim
       Kingdon, 13-May-2018.) $)
    condandc $p |- ( DECID ps -> ( ph -> ps ) ) $=
      ( wn wdc pm2.65da notnot2dc syl5 ) ABFZFBGBAKCDEHBIJ $.
  $}

  ${
    bijadc.1 $e |- ( ph -> ( ps -> ch ) ) $.
    bijadc.2 $e |- ( -. ph -> ( -. ps -> ch ) ) $.
    $( Combine antecedents into a single bi-conditional.  This inference is
       reminiscent of ~ jadc .  (Contributed by Jim Kingdon, 4-May-2018.) $)
    bijadc $p |- ( DECID ps -> ( ( ph <-> ps ) -> ch ) ) $=
    ( wb bi2 syli wn bi1 con3d pm2.61ddc ) ABFZBCBMACABGDHBIMAICMABAB
    JKEHL $.
  $}

  $( Relationship between an equivalence and an equivalence with some negation,
     for decidable propositions.  Based on theorem *5.18 of [WhiteheadRussell]
     p. 124.  Given decidability, we can consider ` -. ( ph <-> -. ps ) ` to
     represent "negated exclusive-or".  (Contributed by Jim Kingdon,
     4-Apr-2018.) $)
  pm5.18dc $p |- ( DECID ph -> ( DECID ps ->
        ( ( ph <-> ps ) <-> -. ( ph <-> -. ps ) ) ) ) $=
    ( wdc wn wo wb wi df-dc wa pm5.501 a1d con1biddc adantr bitr2d ex
    imp dcn nbn2 syl5 jaoi sylbi ) ACAADZEBCZABFZABDZFZDZFZGZAHAUIUBA
    UCUHAUCIUGBUDAUCUGBFABUFAUEUFFUCAUEJKLPABUDFUCABJMNOUBUCUHUBUCIUG
    UEUDUBUCUGUEFZUCUECZUBUJBQUBUEUFUBUEDUFFUKAUERKLSPUBUEUDFUCABRMNO
    TUA $.

  $( Definition of 'and' in terms of negation and implication, for decidable
     propositions.  The forward direction holds for all propositions, and can
     (basically) be found at ~ pm3.2im .  (Contributed by Jim Kingdon,
     30-Apr-2018.) $)
  dfandc $p |- ( DECID ph -> ( DECID ps ->
      ( ( ph /\ ps ) <-> -. ( ph -> -. ps ) ) ) ) $=
    ( wdc wa wn pm3.2im imp simplimdc adantr simprimdc adantl impbid2
    wi wb jca ex ) ACZBCZABDZABEZMEZNQRDZSUAABUAABFGUBUASUBUADABUBUAA
    QUAAMRATHIGUBUABRUABMQABJKGOPLP $.

  $( A decidable proposition or its triple negation is true.  Theorem *2.13 of
     [WhiteheadRussell] p. 101 with decidability condition added.  (Contributed
     by Jim Kingdon, 13-May-2018.) $)
  pm2.13dc $p |- ( DECID ph -> ( ph \/ -. -. -. ph ) ) $=
    ( wdc wn wo df-dc notnot2dc con3d orim2d syl5bi pm2.43i ) ABZAACZ
    CZCZDZKALDKOAEKLNAKMAAFGHIJ $.

  $( Theorem *4.63 of [WhiteheadRussell] p. 120, for decidable propositions.
     (Contributed by Jim Kingdon, 1-May-2018.) $)
  pm4.63dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( ph -> -. ps ) <-> ( ph /\ ps ) ) ) ) $=
    ( wdc wn wi wa wb dfandc imp bicomd ex ) ACZBCZABDEDZABFZGLMFONLM
    ONGABHIJK $.

  $( Theorem *4.67 of [WhiteheadRussell] p. 120, for decidable propositions.
     (Contributed by Jim Kingdon, 1-May-2018.) $)
  pm4.67dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( -. ph -> -. ps ) <-> ( -. ph /\ ps ) ) ) ) $=
    ( wdc wn wi wa wb dcn pm4.63dc syl ) ACADZCBCKBDEDKBFGEAHKBIJ $.

  $( Express conjunction in terms of implication.  The biconditionalized
     version of this theorem, ~ annim , is not valid intuitionistically.
     (Contributed by Jim Kingdon, 24-Dec-2017.) $)
  annimim $p |- ( ( ph /\ -. ps ) -> -. ( ph -> ps ) ) $=
    ( wn wi pm2.27 con3 syl imp ) ABCZABDZCZAJBDIKDABEJBFGH $.

  $( An implication between two decidable propositions is decidable.
     (Contributed by Jim Kingdon, 28-Mar-2018.) $)
  dcim $p |- ( DECID ph -> ( DECID ps -> DECID ( ph -> ps ) ) ) $=
    ( wn wo wi df-dc wa anbi2i andi bitri pm3.4 annimim orim12i sylbi
    wdc sylibr ex ax-in2 a1d orc syl6 jaoi ) AOAACZDBOZABEZOZEZAFAUGU
    CAUDUFAUDGZUEUECZDZUFUHABGZABCZGZDZUJUHABULDZGUNUDUOABFHABULIJUKU
    EUMUIABKABLMNUEFZPQUCUDUEUFUCUEUDABRSUEUJUFUEUITUPPUAUBN $.

  $( Express implication in terms of conjunction.  The converse only holds
     given a decidability condition; see ~ imandc .  (Contributed by Jim
     Kingdon, 24-Dec-2017.) $)
  imanim $p |- ( ( ph -> ps ) -> -. ( ph /\ -. ps ) ) $=
    ( wn wa wi annimim con2i ) ABCDABEABFG $.

  $( Express implication in terms of conjunction.  Theorem 3.4(27) of [Stoll]
     p. 176, with an added decidability condition.  The forward direction,
     ~ imanim , holds for all propositions, not just decidable ones.
     (Contributed by Jim Kingdon, 25-Apr-2018.) $)
  imandc $p |- ( DECID ps -> ( ( ph -> ps ) <-> -. ( ph /\ -. ps ) ) ) $=
    ( wdc wi wn wa notnotdc imbi2d imnan syl6bb ) BCZABDABEZEZDALFEKB
    MABGHALIJ $.

  $( Theorem *4.14 of [WhiteheadRussell] p. 117, given a decidability
     condition.  (Contributed by Jim Kingdon, 24-Apr-2018.) $)
  pm4.14dc $p |- ( DECID ch ->
      ( ( ( ph /\ ps ) -> ch ) <-> ( ( ph /\ -. ch ) -> -. ps ) ) ) $=
    ( wdc wi wn wa con34bdc imbi2d impexp 3bitr4g ) CDZABCEZEACFZBFZE
    ZEABGCEANGOELMPABCHIABCJANOJK $.

  $( Theorem *3.37 (Transp) of [WhiteheadRussell] p. 112, given a decidability
     condition.  (Contributed by Jim Kingdon, 24-Apr-2018.) $)
  pm3.37dc $p |- ( DECID ch ->
      ( ( ( ph /\ ps ) -> ch ) -> ( ( ph /\ -. ch ) -> -. ps ) ) ) $=
    ( wdc wa wi wn pm4.14dc biimpd ) CDABECFACGEBGFABCHI $.

  $( Theorem *4.15 of [WhiteheadRussell] p. 117.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 18-Nov-2012.) $)
  pm4.15 $p |- ( ( ( ph /\ ps ) -> -. ch ) <-> ( ( ps /\ ch ) -> -. ph ) ) $=
    ( wa wn wi con2b nan bitr2i ) BCDZAEFAJEFABDCEFJAGABCHI $.

  $( Deriving disjunction from implication for a decidable proposition.  Based
     on theorem *2.54 of [WhiteheadRussell] p. 107.  The converse, ~ pm2.53 ,
     holds whether the proposition is decidable or not.  (Contributed by Jim
     Kingdon, 26-Mar-2018.) $)
  pm2.54dc $p |- ( DECID ph -> ( ( -. ph -> ps ) -> ( ph \/ ps ) ) ) $=
    ( wdc wn wi wo dcn notnot2dc orc syl6 a1d olc a1i jaddc mpd ) ACZ
    ADZCZQBEABFZEAGPQBSPQDZSERPTASAHABIJKBSEPBALMNO $.

  $( Definition of 'or' in terms of negation and implication for a decidable
     proposition.  Based on definition of [Margaris] p. 49.  (Contributed by
     Jim Kingdon, 26-Mar-2018.) $)
  dfordc $p |- ( DECID ph -> ( ( ph \/ ps ) <-> ( -. ph -> ps ) ) ) $=
    ( wdc wo wn wi pm2.53 pm2.54dc impbid2 ) ACABDAEBFABGABHI $.

  $( Elimination of disjunction based on a disjunction, for a decidable
     proposition.  Based on theorem *2.25 of [WhiteheadRussell] p. 104.
     (Contributed by NM, 3-Jan-2005.) $)
  pm2.25dc $p |- ( DECID ph -> ( ph \/ ( ( ph \/ ps ) -> ps ) ) ) $=
    ( wdc wn wo wi df-dc orel1 orim2i sylbi ) ACAADZEAABEBFZEAGKLAABHIJ $.

  $( Concluding disjunction from implication for a decidable proposition.
     Based on theorem *2.68 of [WhiteheadRussell] p. 108.  Converse of ~ pm2.62
     and one half of ~ dfor2dc .  (Contributed by Jim Kingdon, 27-Mar-2018.) $)
  pm2.68dc $p |- ( DECID ph -> ( ( ( ph -> ps ) -> ps ) -> ( ph \/ ps ) ) ) $=
    ( wi wn wdc wo jarl pm2.54dc syl5 ) ABCBCADBCAEABFABBGABHI $.

  $( Logical 'or' expressed in terms of implication only, for a decidable
     proposition.  Based on theorem *5.25 of [WhiteheadRussell] p. 124.
     (Contributed by Jim Kingdon, 27-Mar-2018.) $)
  dfor2dc $p |- ( DECID ph -> ( ( ph \/ ps ) <-> ( ( ph -> ps ) -> ps ) ) ) $=
    ( wdc wo wi pm2.62 pm2.68dc impbid2 ) ACABDABEBEABFABGH $.

  $( Simplify an implication between implications, for a decidable
     proposition.  (Contributed by Jim Kingdon, 18-Mar-2018.) $)
  imimorbdc $p |- ( DECID ps -> ( ( ( ps -> ch ) -> ( ph -> ch ) ) <->
                  ( ph -> ( ps \/ ch ) ) ) ) $=
    ( wdc wo wi dfor2dc imbi2d bi2.04 syl6rbbr ) BDZABCEZFABCFZCFZFMA
    CFFKLNABCGHMACIJ $.

  $( Implication in terms of disjunction for a decidable proposition.  Based on
     theorem *4.6 of [WhiteheadRussell] p. 120.  (Contributed by Jim Kingdon,
     20-Apr-2018.) $)
  imordc $p |- ( DECID ph -> ( ( ph -> ps ) <-> ( -. ph \/ ps ) ) ) $=
    ( wdc wi wn wo notnotdc imbi1d wb dcn dfordc syl bitr4d ) ACZABDA
    EZEZBDZOBFZNAPBAGHNOCRQIAJOBKLM $.

  $( Implication in terms of disjunction.  Like Theorem *4.62 of
     [WhiteheadRussell] p. 120, but for a decidable antecedent.  (Contributed
     by Jim Kingdon, 21-Apr-2018.) $)
  pm4.62dc $p |- ( DECID ph -> ( ( ph -> -. ps ) <-> ( -. ph \/ -. ps ) ) ) $=
    ( wn imordc ) ABCD $.

  $( Negated conjunction in terms of disjunction (DeMorgan's law).  Theorem
     *4.51 of [WhiteheadRussell] p. 120, but where one proposition is
     decidable.  The reverse direction, ~ pm3.14 , holds for all propositions,
     but the equivalence only holds where one proposition is decidable.
     (Contributed by Jim Kingdon, 21-Apr-2018.) $)
  ianordc $p |- ( DECID ph -> ( -. ( ph /\ ps ) <-> ( -. ph \/ -. ps ) ) ) $=
    ( wa wn wi wdc wo imnan pm4.62dc syl5bbr ) ABCDABDZEAFADKGABHABIJ $.

  $( Absorption of disjunction into equivalence.  (Contributed by NM,
     6-Aug-1995.)  (Proof shortened by Wolf Lammen, 3-Nov-2013.) $)
  oibabs $p |- ( ( ( ph \/ ps ) -> ( ph <-> ps ) ) <-> ( ph <-> ps ) ) $=
    ( wo wb wi pm2.67-2 ibd olc imim1i ibibr sylibr impbid ax-1 impbii ) ABCZAB
    DZEZPQABQABAPBFGQBPEBAEBOPBAHIBAJKLPOMN $.

  $( Theorem *4.64 of [WhiteheadRussell] p. 120, given a decidability
     condition.  The reverse direction, ~ pm2.53 , holds for all propositions.
     (Contributed by Jim Kingdon, 2-May-2018.) $)
  pm4.64dc $p |- ( DECID ph -> ( ( -. ph -> ps ) <-> ( ph \/ ps ) ) ) $=
    ( wdc wo wn wi dfordc bicomd ) ACABDAEBFABGH $.

  $( Theorem *4.66 of [WhiteheadRussell] p. 120, given a decidability
     condition.  (Contributed by Jim Kingdon, 2-May-2018.) $)
  pm4.66dc $p |- ( DECID ph -> ( ( -. ph -> -. ps ) <-> ( ph \/ -. ps ) ) ) $=
    ( wn pm4.64dc ) ABCD $.

  $( Theorem *4.54 of [WhiteheadRussell] p. 120, for decidable propositions.
     One form of DeMorgan's law.  (Contributed by Jim Kingdon, 2-May-2018.) $)
  pm4.54dc $p |- ( DECID ph -> ( DECID ps ->
      ( ( -. ph /\ ps ) <-> -. ( ph \/ -. ps ) ) ) ) $=
    ( wdc wn wa wo wb dcn dfandc syl imp pm4.66dc adantr notbid bitrd
    wi ex ) ACZBCZADZBEZABDZFZDZGRSEZUATUBPZDZUDRSUAUGGZRTCSUHPAHTBIJ
    KUEUFUCRUFUCGSABLMNOQ $.

  $( Theorem *4.56 of [WhiteheadRussell] p. 120.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.56 $p |- ( ( -. ph /\ -. ps ) <-> -. ( ph \/ ps ) ) $=
    ( wo wn wa ioran bicomi ) ABCDADBDEABFG $.

  $( Implication distributes over disjunction.  We do not have an
     intuitionistic proof of the converse, but both directions hold classically
     as can be seen at ~ pm4.78 .  (Contributed by Jim Kingdon,
     15-Jan-2018.) $)
  pm4.78i $p |- ( ( ( ph -> ps ) \/ ( ph -> ch ) ) ->
       ( ph -> ( ps \/ ch ) ) ) $=
    ( wi wo orc imim2i olc jaoi ) ABDABCEZDACDBJABCFGCJACBHGI $.

  $( Equivalence between a disjunction of two implications, and a conjunction
     and an implication.  Based on theorem *4.79 of [WhiteheadRussell] p. 121
     but with additional decidability antecedents.  (Contributed by Jim
     Kingdon, 28-Mar-2018.) $)
  pm4.79dc $p |- ( DECID ph -> ( DECID ps ->
                 ( ( ( ps -> ph ) \/ ( ch -> ph ) ) <->
                   ( ( ps /\ ch ) -> ph ) ) ) ) $=
    ( wdc wi wo wa wb id jaoa simplimdc pm3.3 syl9 dcim pm2.54dc syl6 syl5d imp
    wn impbid2 expcom ) BDZADZBAEZCAEZFZBCGAEZHUBUCGUFUGUDBAUECUDIUEIJUBUCUGUFE
    UBUGUDSZUEEZUCUFUBUHBUGUEBAKBCALMUBUCUDDUIUFEBANUDUEOPQRTUA $.

  $( Two ways of stating exclusive-or which are equivalent for a decidable
     proposition.  Based on theorem *5.17 of [WhiteheadRussell] p. 124.
     (Contributed by Jim Kingdon, 16-Apr-2018.) $)
  pm5.17dc $p |- ( DECID ps ->
      ( ( ( ph \/ ps ) /\ -. ( ph /\ ps ) ) <-> ( ph <-> -. ps ) ) ) $=
    ( wn wb wdc wo wa bicom wi dfbi2 orcom dfordc syl5rbb a1i anbi12d
    imnan syl5bb ) ABCZDRADZBEZABFZABGCZGZARHSRAIZARIZGTUCRAJTUDUAUEU
    BUABAFTUDABKBALMUEUBDTABPNOQM $.

  $( Reverse distribution of disjunction over implication, given decidability.
     Based on theorem *2.85 of [WhiteheadRussell] p. 108.  (Contributed by Jim
     Kingdon, 1-Apr-2018.) $)
  pm2.85dc $p |- ( DECID ph -> ( ( ( ph \/ ps ) -> ( ph \/ ch ) ) ->
                ( ph \/ ( ps -> ch ) ) ) ) $=
    ( wdc wn wo df-dc orc a1d olc imim1i orel1 syl9r syl6 jaoi sylbi
    wi ) ADAAEZFABFZACFZQZABCQZFZQZAGAUDRAUCUAAUBHIRUAUBUCUABTRCBSTBA
    JKACLMUBAJNOP $.

  $( Disjunction distributes over implication.  The forward direction,
     ~ pm2.76 , is valid intuitionistically.  The reverse direction holds if
     ` ph ` is decidable, as can be seen at ~ pm2.85dc .  (Contributed by Jim
     Kingdon, 1-Apr-2018.) $)
  orimdidc $p |- ( DECID ph -> ( ( ph \/ ( ps -> ch ) ) <->
                ( ( ph \/ ps ) -> ( ph \/ ch ) ) ) ) $=
    ( wdc wi wo pm2.76 pm2.85dc impbid2 ) ADABCEFABFACFEABCGABCHI $.

  $( Decidable proposition version of theorem *2.26 of [WhiteheadRussell]
     p. 104.  (Contributed by Jim Kingdon, 20-Apr-2018.) $)
  pm2.26dc $p |- ( DECID ph -> ( -. ph \/ ( ( ph -> ps ) -> ps ) ) ) $=
    ( wdc wi wn wo pm2.27 imordc mpbii ) ACAABDBDZDAEJFABGAJHI $.

  $( A decidable proposition or its negation implies a second proposition.
     Based on theorem *5.11 of [WhiteheadRussell] p. 123.  (Contributed by Jim
     Kingdon, 29-Mar-2018.) $)
  pm5.11dc $p |- ( DECID ph -> ( DECID ps ->
                   ( ( ph -> ps ) \/ ( -. ph -> ps ) ) ) ) $=
    ( wdc wi wn wo dcim pm2.5dc pm2.54dc syl5com syld ) ACZBCABDZCZMA
    EBDZFZABGLMEODNPABHMOIJK $.

  $( Excluded middle with antecedents for a decidable consequent.  Based on
     theorem *5.12 of [WhiteheadRussell] p. 123.  (Contributed by Jim Kingdon,
     30-Mar-2018.) $)
  pm5.12dc $p |- ( DECID ps -> ( ( ph -> ps ) \/ ( ph -> -. ps ) ) ) $=
    ( wdc wn wo wi df-dc ax-1 orim12i sylbi ) BCBBDZEABFZAKFZEBGBLKMB
    AHKAHIJ $.

  $( A decidable proposition is implied by or implies other propositions.
     Based on theorem *5.14 of [WhiteheadRussell] p. 123.  (Contributed by Jim
     Kingdon, 30-Mar-2018.) $)
  pm5.14dc $p |- ( DECID ps -> ( ( ph -> ps ) \/ ( ps -> ch ) ) ) $=
    ( wdc wn wo wi df-dc ax-1 ax-in2 orim12i sylbi ) BDBBEZFABGZBCGZF
    BHBNMOBAIBCJKL $.

  $( An implication holds in at least one direction, where one proposition is
     decidable.  Based on theorem *5.13 of [WhiteheadRussell] p. 123.
     (Contributed by Jim Kingdon, 30-Mar-2018.) $)
  pm5.13dc $p |- ( DECID ps -> ( ( ph -> ps ) \/ ( ps -> ph ) ) ) $=
    ( pm5.14dc ) ABAC $.

  $( A disjunction is equivalent to one of its disjuncts, given a decidable
     disjunct.  Based on theorem *5.55 of [WhiteheadRussell] p. 125.
     (Contributed by Jim Kingdon, 30-Mar-2018.) $)
  pm5.55dc $p |- ( DECID ph ->
        ( ( ( ph \/ ps ) <-> ph ) \/ ( ( ph \/ ps ) <-> ps ) ) ) $=
    ( wdc wn wo wb df-dc biort bicomd biorf orim12i sylbi ) ACAADZEAB
    EZAFZNBFZEAGAOMPAANABHIMBNABJIKL $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Miscellaneous theorems of propositional calculus
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    pm5.21nd.1 $e |- ( ( ph /\ ps ) -> th ) $.
    pm5.21nd.2 $e |- ( ( ph /\ ch ) -> th ) $.
    pm5.21nd.3 $e |- ( th -> ( ps <-> ch ) ) $.
    $( Eliminate an antecedent implied by each side of a biconditional.
       (Contributed by NM, 20-Nov-2005.)  (Proof shortened by Wolf Lammen,
       4-Nov-2013.) $)
    pm5.21nd $p |- ( ph -> ( ps <-> ch ) ) $=
      ( ex wb wi a1i pm5.21ndd ) ADBCABDEHACDFHDBCIJAGKL $.
  $}

  $( Theorem *5.35 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.35 $p |- ( ( ( ph -> ps ) /\ ( ph -> ch ) ) ->
                ( ph -> ( ps <-> ch ) ) ) $=
    ( wi wa pm5.1 pm5.74rd ) ABDZACDZEABCHIFG $.

  $( A conjunction is equivalent to one of its conjuncts, given a decidable
     conjunct.  Based on theorem *5.54 of [WhiteheadRussell] p. 125.
     (Contributed by Jim Kingdon, 30-Mar-2018.) $)
  pm5.54dc $p |- ( DECID ph ->
                   ( ( ( ph /\ ps ) <-> ph ) \/ ( ( ph /\ ps ) <-> ps ) ) ) $=
    ( wdc wa wb wn wo df-dc ax-ia2 ax-ia3 impbid2 ax-ia1 ax-in2 orim12i orcomd
    sylbi ) ACZABDZBEZRAEZQAAFZGSTGAHASUATARBABIABJKUARAABLARMKNPO $.

  ${
    baib.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Move conjunction outside of biconditional.  (Contributed by NM,
       13-May-1999.) $)
    baib $p |- ( ps -> ( ph <-> ch ) ) $=
      ( wa ibar syl6rbbr ) BCBCEABCFDG $.
  $}

  ${
    baibr.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Move conjunction outside of biconditional.  (Contributed by NM,
       11-Jul-1994.) $)
    baibr $p |- ( ps -> ( ch <-> ph ) ) $=
      ( baib bicomd ) BACABCDEF $.
  $}

  $( Theorem *5.44 of [WhiteheadRussell] p. 125.  (Contributed by NM,
     3-Jan-2005.) $)
  pm5.44 $p |- ( ( ph -> ps ) -> ( ( ph -> ch ) <->
                ( ph -> ( ps /\ ch ) ) ) ) $=
    ( wa wi jcab baibr ) ABCDEABEACEABCFG $.

  $( Conjunction in antecedent versus disjunction in consequent, for a
     decidable proposition.  Based on theorem *5.6 of [WhiteheadRussell]
     p. 125.  (Contributed by Jim Kingdon, 2-Apr-2018.) $)
  pm5.6dc $p |- ( DECID ps ->
        ( ( ( ph /\ -. ps ) -> ch ) <-> ( ph -> ( ps \/ ch ) ) ) ) $=
    ( wdc wo wi wn wa dfordc imbi2d impexp syl6rbbr ) BDZABCEZFABGZCF
    ZFAOHCFMNPABCIJAOCKL $.

  ${
    orcanai.1 $e |- ( ph -> ( ps \/ ch ) ) $.
    $( Change disjunction in consequent to conjunction in antecedent.
       (Contributed by NM, 8-Jun-1994.) $)
    orcanai $p |- ( ( ph /\ -. ps ) -> ch ) $=
      ( wn ord imp ) ABECABCDFG $.
  $}


  ${
    intnan.1 $e |- -. ph $.
    $( Introduction of conjunct inside of a contradiction.  (Contributed by NM,
       16-Sep-1993.) $)
    intnan $p |- -. ( ps /\ ph ) $=
      ( wa simpr mto ) BADACBAEF $.

    $( Introduction of conjunct inside of a contradiction.  (Contributed by NM,
       3-Apr-1995.) $)
    intnanr $p |- -. ( ph /\ ps ) $=
      ( wa simpl mto ) ABDACABEF $.
  $}

  ${
    intnand.1 $e |- ( ph -> -. ps ) $.
    $( Introduction of conjunct inside of a contradiction.  (Contributed by NM,
       10-Jul-2005.) $)
    intnand $p |- ( ph -> -. ( ch /\ ps ) ) $=
      ( wa simpr nsyl ) ABCBEDCBFG $.

    $( Introduction of conjunct inside of a contradiction.  (Contributed by NM,
       10-Jul-2005.) $)
    intnanrd $p |- ( ph -> -. ( ps /\ ch ) ) $=
      ( wa simpl nsyl ) ABBCEDBCFG $.
  $}

  $( A conjunction of two decidable propositions is decidable.  (Contributed by
     Jim Kingdon, 12-Apr-2018.) $)
  dcan $p |- ( DECID ph -> ( DECID ps -> DECID ( ph /\ ps ) ) ) $=
    ( wdc wa wn wo ax-ia1 intnanrd orim2i ax-ia2 intnand olcd jaoi anbi12i andi
    df-dc andir orbi1i 3bitri 3imtr4i ex ) ACZBCZABDZCZUDAEZBDZFZAUFFZBEZDZFZUD
    UDEZFZUBUCDZUEUHUNUKUGUMUDUGABUFBGHIUKUMUDUKBAUIUJJKLMUOUIBUJFZDUIBDZUKFULU
    BUIUCUPAPBPNUIBUJOUQUHUKAUFBQRSUDPTUA $.

  $( A disjunction of two decidable propositions is decidable.  (Contributed by
     Jim Kingdon, 21-Apr-2018.) $)
  dcor $p |- ( DECID ph -> ( DECID ps -> DECID ( ph \/ ps ) ) ) $=
    ( wdc wn wo wi df-dc orc orcd sylibr a1d wa olc adantl ioran biimpri jaodan
    olcd sylan2b ex jaoi sylbi ) ACAADZEBCZABEZCZFZAGAUGUCAUFUDAUEUEDZEZUFAUEUH
    ABHIUEGZJKUCUDUFUDUCBBDZEUFBGUCBUFUKUCBLZUIUFULUEUHBUEUCBAMNIUJJUCUKLZUIUFU
    MUHUEUHUMABOPRUJJQSTUAUB $.

  $( An equivalence of two decidable propositions is decidable.  (Contributed
     by Jim Kingdon, 12-Apr-2018.) $)
  dcbi $p |- ( DECID ph -> ( DECID ps -> DECID ( ph <-> ps ) ) ) $=
    ( wdc wi wa wb dcim com12 dcan syl6c dfbi2 dcbii syl6ibr ) ACZBCZ
    ABDZBADZEZCZABFZCNOPCQCZSABGONUABAGHPQIJTRABKLM $.

  $( Express conjunction in terms of implication.  The forward direction,
     ~ annimim , is valid for all propositions, but as an equivalence, it
     requires a decidability condition.  (Contributed by Jim Kingdon,
     25-Apr-2018.) $)
  annimdc $p |- ( DECID ph -> ( DECID ps ->
      ( ( ph /\ -. ps ) <-> -. ( ph -> ps ) ) ) ) $=
    ( wdc wn wa wi imandc adantl dcim imp dcn dcan syl5 con2bidc sylc
    wb mpbid ex ) ACZBCZABDZEZABFZDPZSTEZUCUBDPZUDTUFSABGHUEUCCZUBCZU
    FUDPSTUGABIJSTUHTUACSUHBKAUALMJUCUBNOQR $.

  $( Theorem *4.55 of [WhiteheadRussell] p. 120, for decidable propositions.
     (Contributed by Jim Kingdon, 2-May-2018.) $)
  pm4.55dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( -. ph /\ ps ) <-> ( ph \/ -. ps ) ) ) ) $=
    ( wdc wn wa wo wb pm4.54dc imp dcn anim2i dcor syl wi dcan con2bidc biimprd
    jca mpd bicomd ex ) ACZBCZADZBEZDZABDZFZGUBUCEZUHUFUIUEUHDGZUHUFGZUBUCUJABH
    IUIUKUJUIUHCZUECZEUKUJGZUIULUMUIUBUGCZEULUCUOUBBJKUBUOULAUGLIMUBUCUMUBUDCUC
    UMNAJUDBOMIRULUMUNUHUEPIMQSTUA $.

  ${
    mpbiran.1 $e |- ps $.
    mpbiran.2 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Detach truth from conjunction in biconditional.  (Contributed by NM,
       27-Feb-1996.)  (Revised by NM, 9-Jan-2015.) $)
    mpbiran $p |- ( ph <-> ch ) $=
      ( wa biantrur bitr4i ) ABCFCEBCDGH $.
  $}

  ${
    mpbiran2.1 $e |- ch $.
    mpbiran2.2 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Detach truth from conjunction in biconditional.  (Contributed by NM,
       22-Feb-1996.)  (Revised by NM, 9-Jan-2015.) $)
    mpbiran2 $p |- ( ph <-> ps ) $=
      ( wa biantru bitr4i ) ABCFBECBDGH $.
  $}

  ${
    mpbir2an.1 $e |- ps $.
    mpbir2an.2 $e |- ch $.
    mpbiran2an.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( Detach a conjunction of truths in a biconditional.  (Contributed by NM,
       10-May-2005.)  (Revised by NM, 9-Jan-2015.) $)
    mpbir2an $p |- ph $=
      ( mpbiran mpbir ) ACEABCDFGH $.
  $}

  ${
    mpbi2and.1 $e |- ( ph -> ps ) $.
    mpbi2and.2 $e |- ( ph -> ch ) $.
    mpbi2and.3 $e |- ( ph -> ( ( ps /\ ch ) <-> th ) ) $.
    $( Detach a conjunction of truths in a biconditional.  (Contributed by NM,
       6-Nov-2011.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    mpbi2and $p |- ( ph -> th ) $=
      ( wa jca mpbid ) ABCHDABCEFIGJ $.
  $}

  ${
    mpbir2and.1 $e |- ( ph -> ch ) $.
    mpbir2and.2 $e |- ( ph -> th ) $.
    mpbir2and.3 $e |- ( ph -> ( ps <-> ( ch /\ th ) ) ) $.
    $( Detach a conjunction of truths in a biconditional.  (Contributed by NM,
       6-Nov-2011.)  (Proof shortened by Wolf Lammen, 24-Nov-2012.) $)
    mpbir2and $p |- ( ph -> ps ) $=
      ( wa jca mpbird ) ABCDHACDEFIGJ $.
  $}

  ${
    mpbiranOLD.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    ${
      mpbiranOLD.2 $e |- ps $.
      $( Obsolete version of ~ mpbiran as of 9-Jan-2015.  (Contributed by NM,
         27-Feb-1996.) $)
      mpbiranOLD $p |- ( ph <-> ch ) $=
        ( mpbiran ) ABCEDF $.
    $}

    ${
      mpbiran2OLD.2 $e |- ch $.
      $( Obsolete version of ~ mpbiran2 as of 9-Jan-2015.  (Contributed by NM,
         22-Feb-1996.) $)
      mpbiran2OLD $p |- ( ph <-> ps ) $=
        ( mpbiran2 ) ABCEDF $.
    $}

    ${
      mpbir2anOLD.2 $e |- ps $.
      mpbir2anOLD.3 $e |- ch $.
      $( Obsolete version of ~ mpbir2an as of 9-Jan-2015.  (Contributed by NM,
         10-May-2005.) $)
      mpbir2anOLD $p |- ph $=
        ( mpbir2an ) ABCEFDG $.
    $}
  $}

  ${
    mpbi2andOLD.1 $e |- ( ph -> ( ( ps /\ ch ) <-> th ) ) $.
    mpbi2andOLD.2 $e |- ( ph -> ps ) $.
    mpbi2andOLD.3 $e |- ( ph -> ch ) $.
    $( Obsolete version of ~ mpbi2and as of 9-Jan-2015.  (Contributed by NM,
       6-Nov-2011.)  (Revised by NM, 24-Nov-2012.) $)
    mpbi2andOLD $p |- ( ph -> th ) $=
      ( mpbi2and ) ABCDFGEH $.
  $}

  ${
    mpbir2andOLD.1 $e |- ( ph -> ( ps <-> ( ch /\ th ) ) ) $.
    mpbir2andOLD.2 $e |- ( ph -> ch ) $.
    mpbir2andOLD.3 $e |- ( ph -> th ) $.
    $( Obsolete version of ~ mpbir2and as of 9-Jan-2015.  (Contributed by NM,
       6-Nov-2011.)  (Revised by NM, 24-Nov-2012.) $)
    mpbir2andOLD $p |- ( ph -> ps ) $=
      ( mpbir2and ) ABCDFGEH $.
  $}

  $( Theorem *5.62 of [WhiteheadRussell] p. 125, for a decidable proposition.
     (Contributed by Jim Kingdon, 12-May-2018.) $)
  pm5.62dc $p |- ( DECID ps ->
      ( ( ( ph /\ ps ) \/ -. ps ) <-> ( ph \/ -. ps ) ) ) $=
    ( wdc wn wo wa df-dc ordir simplbi simplbi2 com12 impbid2 sylbi
    wb ) BCBBDZEZABFOEZAOEZNBGPQRQRPABOHZIRPQQRPSJKLM $.

  $( Theorem *5.63 of [WhiteheadRussell] p. 125, for a decidable proposition.
     (Contributed by Jim Kingdon, 12-May-2018.) $)
  pm5.63dc $p |- ( DECID ph ->
      ( ( ph \/ ps ) <-> ( ph \/ ( -. ph /\ ps ) ) ) ) $=
    ( wdc wo wn wa wi df-dc ordi simplbi2 sylbi simprbi impbid1 ) ACZ
    ABDZAAEZBFDZNAPDZOQGAHQROAPBIZJKQROSLM $.

  ${
    bianfi.1 $e |- -. ph $.
    $( A wff conjoined with falsehood is false.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Wolf Lammen, 26-Nov-2012.) $)
    bianfi $p |- ( ph <-> ( ps /\ ph ) ) $=
      ( wa intnan 2false ) ABADCABCEF $.
  $}

  ${
    bianfd.1 $e |- ( ph -> -. ps ) $.
    $( A wff conjoined with falsehood is false.  (Contributed by NM,
       27-Mar-1995.)  (Proof shortened by Wolf Lammen, 5-Nov-2013.) $)
    bianfd $p |- ( ph -> ( ps <-> ( ps /\ ch ) ) ) $=
      ( wa intnanrd 2falsed ) ABBCEDABCDFG $.
  $}

  $( Theorem *4.43 of [WhiteheadRussell] p. 119.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 26-Nov-2012.) $)
  pm4.43 $p |- ( ph <-> ( ( ph \/ ps ) /\ ( ph \/ -. ps ) ) ) $=
    ( wn wa wo pm3.24 biorfi ordi bitri ) AABBCZDZEABEAJEDKABFGABJHI $.

  $( Theorem *4.82 of [WhiteheadRussell] p. 122.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.82 $p |- ( ( ( ph -> ps ) /\ ( ph -> -. ps ) ) <-> -. ph ) $=
    ( wi wn wa pm2.65 imp pm2.21 jca impbii ) ABCZABDZCZEADZKMNABFGNKMABHALHIJ
    $.

  $( Theorem *4.83 of [WhiteheadRussell] p. 122, for decidable propositions.
     As with other case elimination theorems, like ~ pm2.61dc , it only holds
     for decidable propositions.  (Contributed by Jim Kingdon, 12-May-2018.) $)
  pm4.83dc $p |- ( DECID ph ->
      ( ( ( ph -> ps ) /\ ( -. ph -> ps ) ) <-> ps ) ) $=
    ( wdc wi wn wa wo df-dc pm3.44 com12 sylbi ax-1 jca impbid1 ) ACZABDZAEZBDZ
    FZBOAQGZSBDAHSTBBAQIJKBPRBALBQLMN $.

  $( A transitive law of equivalence.  Compare Theorem *4.22 of
     [WhiteheadRussell] p. 117.  (Contributed by NM, 18-Aug-1993.) $)
  biantr $p |- ( ( ( ph <-> ps ) /\ ( ch <-> ps ) ) -> ( ph <-> ch ) ) $=
    ( wb id bibi2d biimparc ) CBDZACDABDHCBAHEFG $.

  $( Disjunction distributes over the biconditional, for a decidable
     proposition.  Based on an axiom of system DS in Vladimir Lifschitz, "On
     calculational proofs" (1998),
     ~ http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.25.3384 .
     (Contributed by Jim Kingdon, 2-Apr-2018.) $)
  orbididc $p |- ( DECID ph -> ( ( ph \/ ( ps <-> ch ) ) <->
                ( ( ph \/ ps ) <-> ( ph \/ ch ) ) ) ) $=
    ( wdc wi wo wa orimdidc anbi12d dfbi2 orbi2i ordi bitri 3bitr4g
    wb ) ADZABCEZFZACBEZFZGZABFZACFZEZUCUBEZGABCOZFZUBUCOPRUDTUEABCHA
    CBHIUGAQSGZFUAUFUHABCJKAQSLMUBUCJN $.

  $( Disjunction distributes over the biconditional, for a decidable
     proposition.  Based on theorem *5.7 of [WhiteheadRussell] p. 125.  This
     theorem is similar to ~ orbididc .  (Contributed by Jim Kingdon,
     2-Apr-2018.) $)
  pm5.7dc $p |- ( DECID ch -> ( ( ( ph \/ ch ) <-> ( ps \/ ch ) ) <->
               ( ch \/ ( ph <-> ps ) ) ) ) $=
    ( wdc wb wo orbididc orcom bibi12i syl6rbb ) CDCABEFCAFZCBFZEACFZ
    BCFZECABGKMLNCAHCBHIJ $.

  $( Dijkstra-Scholten's Golden Rule for calculational proofs.  (Contributed by
     NM, 10-Jan-2005.) $)
  bigolden $p |- ( ( ( ph /\ ps ) <-> ph ) <-> ( ps <-> ( ph \/ ps ) ) ) $=
    ( wi wa wb wo pm4.71 pm4.72 bicom 3bitr3ri ) ABCAABDZEBABFEKAEABGABHAKIJ $.

  $( Conjunction in terms of disjunction (DeMorgan's law).  Theorem *4.5 of
     [WhiteheadRussell] p. 120, but where the propositions are decidable.  The
     forward direction, ~ pm3.1 , holds for all propositions, but the
     equivalence only holds given decidability.  (Contributed by Jim Kingdon,
     21-Apr-2018.) $)
  anordc $p |- ( DECID ph -> ( DECID ps ->
      ( ( ph /\ ps ) <-> -. ( -. ph \/ -. ps ) ) ) ) $=
    ( wdc wa wn wo wb dcan ianordc bicomd a1d con2biddc syld ) ACZBCA
    BDZCZOAEBEFZEGABHNQONQOEZGPNRQABIJKLM $.

  $( Theorem *3.11 of [WhiteheadRussell] p. 111, but for decidable
     propositions.  The converse, ~ pm3.1 , holds for all propositions, not
     just decidable ones.  (Contributed by Jim Kingdon, 22-Apr-2018.) $)
  pm3.11dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( -. ph \/ -. ps ) -> ( ph /\ ps ) ) ) ) $=
    ( wdc wn wo wa wi wb anordc imp biimprd ex ) ACZBCZADBDEDZABFZGMN
    FPOMNPOHABIJKL $.

  $( Theorem *3.12 of [WhiteheadRussell] p. 111, but for decidable
     propositions.  (Contributed by Jim Kingdon, 22-Apr-2018.) $)
  pm3.12dc $p |- ( DECID ph -> ( DECID ps ->
      ( ( -. ph \/ -. ps ) \/ ( ph /\ ps ) ) ) ) $=
    ( wdc wn wo wa wi pm3.11dc imp dcn dcor syl2im dfordc syl6 mpbird
    wb ex ) ACZBCZADZBDZEZABFZEZRSFUDUBDUCGZRSUEABHIRSUDUEPZRSUBCZUFR
    TCSUACUGAJBJTUAKLUBUCMNIOQ $.

  $( Theorem *3.13 of [WhiteheadRussell] p. 111, but for decidable
     propositions.  The converse, ~ pm3.14 , holds for all propositions.
     (Contributed by Jim Kingdon, 22-Apr-2018.) $)
  pm3.13dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( ph /\ ps ) -> ( -. ph \/ -. ps ) ) ) ) $=
    ( wdc wn wo wa wi dcn dcor syl2im pm3.11dc con1dc syl6c ) ACZBCZADZBDZEZCZR
    DABFZGTDRGNPCOQCSAHBHPQIJABKRTLM $.

  $( DN_1 for decidable propositions.  Without the decidability conditions,
     DN_1 can serve as a single axiom for Boolean algebra.  See
     ~ http://www-unix.mcs.anl.gov/~~mccune/papers/basax/v12.pdf .
     (Contributed by Jim Kingdon, 22-Apr-2018.) $)
  dn1dc $p |- ( ( DECID ph /\ ( DECID ps /\ ( DECID ch /\ DECID th ) ) ) ->
      ( -. ( -. ( -. ( ph \/ ps ) \/ ch ) \/
            -. ( ph \/ -. ( -. ch \/ -. ( ch \/ th ) ) ) ) <-> ch ) ) $=
    ( wo wn wa wdc wi pm2.45 imnan mpbi biorfi wb dcor imp anordc sylc dcn syl
    orcom ordir 3bitri pm4.45 simprrl ad2antll syl5bb orbi2d anbi2d syl6 syldan
    adantrr bitrd syl5rbb ) CABEZFZCEZACEZGZAHZBHZCHZDHZGZGZGZUQFACFZCDEZFZEZFZ
    EZFEFZCCUPAGZEVNCEUSVNCUPAFIVNFABJUPAKLMCVNUAUPACUBUCVFUSUQVLGZVMVFURVLUQVF
    CVKACCVHGZVFVKCDUDVFVBVHHZVPVKNUTVAVBVCUEZVDVQUTVAVBVCVQCDOPUFZCVHQRUGUHUIV
    FUQHZVLHZVOVMNVFUPHZVBVTUTVAWBVDUTVAWBUTVAUOHWBABOUOSUJPULVRUPCORUTVEVKHZWA
    VFVJHZWCVFVGHZVIHZWDVFVBWEVRCSTVFVQWFVSVHSTVGVIORVJSTUTWCWAAVKOPUKUQVLQRUMU
    N $.

  $( Decidable proposition version of theorem *5.71 of [WhiteheadRussell]
     p. 125.  (Contributed by Roy F. Longton, 23-Jun-2005.)  (Modified for
     decidability by Jim Kingdon, 19-Apr-2018.) $)
  pm5.71dc $p |- ( DECID ps ->
      ( ( ps -> -. ch ) -> ( ( ( ph \/ ps ) /\ ch ) <-> ( ph /\ ch ) ) ) ) $=
    ( wn wo wa wb wi wdc orel2 orc impbid1 anbi1d a1i pm2.21 pm5.32rd
    jadc ) BCDZABEZCFACFGZBDZTHBIUASACUASABAJABKLMNRCSACSAGOPQ $.

  $( Theorem *5.75 of [WhiteheadRussell] p. 126.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Andrew Salmon, 7-May-2011.)  (Proof
     shortened by Wolf Lammen, 23-Dec-2012.) $)
  pm5.75 $p |- ( ( ( ch -> -. ps ) /\ ( ph <-> ( ps \/ ch ) ) ) ->
                ( ( ph /\ -. ps ) <-> ch ) ) $=
    ( wo wb wn wa wi anbi1 anbi1i pm5.61 syl6bb pm4.71 biimpi bicomd sylan9bbr
    orcom bitri ) ABCDZEZABFZGZCUAGZCUAHZCTUBSUAGZUCASUAIUECBDZUAGUCSUFUABCQJCB
    KRLUDCUCUDCUCECUAMNOP $.

  $( Removal of conjunct from one side of an equivalence.  (Contributed by NM,
     5-Aug-1993.) $)
  bimsc1 $p |- ( ( ( ph -> ps ) /\ ( ch <-> ( ps /\ ph ) ) )
               -> ( ch <-> ph ) ) $=
    ( wi wa wb simpr ancr impbid2 bibi2d biimpa ) ABDZCBAEZFCAFLMACLMABAGABHIJK
    $.

  ${
    ccase.1 $e |- ( ( ph /\ ps ) -> ta ) $.
    ccase.2 $e |- ( ( ch /\ ps ) -> ta ) $.
    ccase.3 $e |- ( ( ph /\ th ) -> ta ) $.
    ccase.4 $e |- ( ( ch /\ th ) -> ta ) $.
    $( Inference for combining cases.  (Contributed by NM, 29-Jul-1999.)
       (Proof shortened by Wolf Lammen, 6-Jan-2013.) $)
    ccase $p |- ( ( ( ph \/ ch ) /\ ( ps \/ th ) ) -> ta ) $=
      ( wo jaoian jaodan ) ACJBEDABECFGKADECHIKL $.
  $}

  ${
    ccased.1 $e |- ( ph -> ( ( ps /\ ch ) -> et ) ) $.
    ccased.2 $e |- ( ph -> ( ( th /\ ch ) -> et ) ) $.
    ccased.3 $e |- ( ph -> ( ( ps /\ ta ) -> et ) ) $.
    ccased.4 $e |- ( ph -> ( ( th /\ ta ) -> et ) ) $.
    $( Deduction for combining cases.  (Contributed by NM, 9-May-2004.) $)
    ccased $p |- ( ph -> ( ( ( ps \/ th ) /\ ( ch \/ ta ) ) -> et ) ) $=
      ( wo wa wi com12 ccase ) BDKCEKLAFBCDEAFMABCLFGNADCLFHNABELFINADELFJNON
      $.
  $}

  ${
    ccase2.1 $e |- ( ( ph /\ ps ) -> ta ) $.
    ccase2.2 $e |- ( ch -> ta ) $.
    ccase2.3 $e |- ( th -> ta ) $.
    $( Inference for combining cases.  (Contributed by NM, 29-Jul-1999.) $)
    ccase2 $p |- ( ( ( ph \/ ch ) /\ ( ps \/ th ) ) -> ta ) $=
      ( adantr adantl ccase ) ABCDEFCEBGIDEAHJDECHJK $.
  $}

  ${
    niabn.1 $e |- ph $.
    $( Miscellaneous inference relating falsehoods.  (Contributed by NM,
       31-Mar-1994.) $)
    niabn $p |- ( -. ps -> ( ( ch /\ ps ) <-> -. ph ) ) $=
      ( wa wn simpr pm2.24i pm5.21ni ) CBEBAFCBGABDHI $.
  $}

  ${
    ninba.1 $e |- ph $.
    $( Miscellaneous inference relating falsehoods.  (Contributed by NM,
       31-Mar-1994.) $)
    ninba $p |- ( -. ps -> ( -. ph <-> ( ch /\ ps ) ) ) $=
      ( wn wa niabn bicomd ) BECBFAEABCDGH $.
  $}

  ${
    prlem1.1 $e |- ( ph -> ( et <-> ch ) ) $.
    prlem1.2 $e |- ( ps -> -. th ) $.
    $( A specialized lemma for set theory (to derive the Axiom of Pairing).
       (Contributed by NM, 18-Oct-1995.)  (Proof shortened by Andrew Salmon,
       13-May-2011.)  (Proof shortened by Wolf Lammen, 5-Jan-2013.) $)
    prlem1 $p |- ( ph -> ( ps ->
                  ( ( ( ps /\ ch ) \/ ( th /\ ta ) ) -> et ) ) ) $=
      ( wa wo wi biimprd adantld pm2.21d adantrd jaao ex ) ABBCIZDEIZJFKARFBSAC
      FBAFCGLMBDFEBDFHNOPQ $.
  $}

  $( A specialized lemma for set theory (to derive the Axiom of Pairing).
     (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
     13-May-2011.)  (Proof shortened by Wolf Lammen, 9-Dec-2012.) $)
  prlem2 $p |- ( ( ( ph /\ ps ) \/ ( ch /\ th ) ) <->
              ( ( ph \/ ch ) /\ ( ( ph /\ ps ) \/ ( ch /\ th ) ) ) ) $=
    ( wa wo simpl orim12i pm4.71ri ) ABEZCDEZFACFJAKCABGCDGHI $.

  ${
    oplem1.1 $e |- ( ph -> ( ps \/ ch ) ) $.
    oplem1.2 $e |- ( ph -> ( th \/ ta ) ) $.
    oplem1.3 $e |- ( ps <-> th ) $.
    oplem1.4 $e |- ( ch -> ( th <-> ta ) ) $.
    $( A specialized lemma for set theory (ordered pair theorem).  (Contributed
       by NM, 18-Oct-1995.)  (Proof shortened by Wolf Lammen, 8-Dec-2012.)
       (Proof shortened by Mario Carneiro, 2-Feb-2015.) $)
    oplem1 $p |- ( ph -> ps ) $=
      ( wo idd wi ax-1 biimprcd jaoi syl syl6ibr jaod mpd ) ABCJBFABBCABKACDBAD
      EJCDLZGDTEDCMCDEINOPHQRS $.
  $}

  $( Lemma used in construction of real numbers.  (Contributed by NM,
     4-Sep-1995.)  (Proof shortened by Andrew Salmon, 26-Jun-2011.) $)
  rnlem $p |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) ) <->
  ( ( ( ph /\ ch ) /\ ( ps /\ th ) ) /\ ( ( ph /\ th ) /\ ( ps /\ ch ) ) ) ) $=
    ( wa an4 biimpi an42 biimpri jca adantl impbii ) ABECDEEZACEBDEEZADEBCEEZEM
    NOMNABCDFGOMADBCHZIJOMNOMPGKL $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Abbreviated conjunction and disjunction of three wff's
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Extend wff definition to include 3-way disjunction ('or'). $)
  w3o $a wff ( ph \/ ps \/ ch ) $.
  $( Extend wff definition to include 3-way conjunction ('and'). $)
  w3a $a wff ( ph /\ ps /\ ch ) $.

  $( These abbreviations help eliminate parentheses to aid readability. $)

  $( Define disjunction ('or') of 3 wff's.  Definition *2.33 of
     [WhiteheadRussell] p. 105.  This abbreviation reduces the number of
     parentheses and emphasizes that the order of bracketing is not important
     by virtue of the associative law ~ orass .  (Contributed by NM,
     8-Apr-1994.) $)
  df-3or $a |- ( ( ph \/ ps \/ ch ) <-> ( ( ph \/ ps ) \/ ch ) ) $.

  $( Define conjunction ('and') of 3 wff.s.  Definition *4.34 of
     [WhiteheadRussell] p. 118.  This abbreviation reduces the number of
     parentheses and emphasizes that the order of bracketing is not important
     by virtue of the associative law ~ anass .  (Contributed by NM,
     8-Apr-1994.) $)
  df-3an $a |- ( ( ph /\ ps /\ ch ) <-> ( ( ph /\ ps ) /\ ch ) ) $.

  $( Associative law for triple disjunction.  (Contributed by NM,
     8-Apr-1994.) $)
  3orass $p |- ( ( ph \/ ps \/ ch ) <-> ( ph \/ ( ps \/ ch ) ) ) $=
    ( w3o wo df-3or orass bitri ) ABCDABECEABCEEABCFABCGH $.

  $( Associative law for triple conjunction.  (Contributed by NM,
     8-Apr-1994.) $)
  3anass $p |- ( ( ph /\ ps /\ ch ) <-> ( ph /\ ( ps /\ ch ) ) ) $=
    ( w3a wa df-3an anass bitri ) ABCDABECEABCEEABCFABCGH $.

  $( Rotation law for triple conjunction.  (Contributed by NM, 8-Apr-1994.) $)
  3anrot $p |- ( ( ph /\ ps /\ ch ) <-> ( ps /\ ch /\ ph ) ) $=
    ( wa w3a ancom 3anass df-3an 3bitr4i ) ABCDZDJADABCEBCAEAJFABCGBCAHI $.

  $( Rotation law for triple disjunction.  (Contributed by NM, 4-Apr-1995.) $)
  3orrot $p |- ( ( ph \/ ps \/ ch ) <-> ( ps \/ ch \/ ph ) ) $=
    ( wo w3o orcom 3orass df-3or 3bitr4i ) ABCDZDJADABCEBCAEAJFABCGBCAHI $.

  $( Commutation law for triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  3ancoma $p |- ( ( ph /\ ps /\ ch ) <-> ( ps /\ ph /\ ch ) ) $=
    ( wa w3a ancom anbi1i df-3an 3bitr4i ) ABDZCDBADZCDABCEBACEJKCABFGABCHBACHI
    $.

  $( Commutation law for triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  3ancomb $p |- ( ( ph /\ ps /\ ch ) <-> ( ph /\ ch /\ ps ) ) $=
    ( w3a 3ancoma 3anrot bitri ) ABCDBACDACBDABCEBACFG $.

  $( Commutation law for triple disjunction.  (Contributed by Scott Fenton,
     20-Apr-2011.) $)
  3orcomb $p |- ( ( ph \/ ps \/ ch ) <-> ( ph \/ ch \/ ps ) ) $=
    ( wo w3o orcom orbi2i 3orass 3bitr4i ) ABCDZDACBDZDABCEACBEJKABCFGABCHACBHI
    $.

  $( Reversal law for triple conjunction.  (Contributed by NM, 21-Apr-1994.) $)
  3anrev $p |- ( ( ph /\ ps /\ ch ) <-> ( ch /\ ps /\ ph ) ) $=
    ( w3a 3ancoma 3anrot bitr4i ) ABCDBACDCBADABCECBAFG $.

  $( Negated triple disjunction as triple conjunction.  (Contributed by Scott
     Fenton, 19-Apr-2011.) $)
  3ioran $p |- ( -. ( ph \/ ps \/ ch ) <-> ( -. ph /\ -. ps /\ -. ch ) ) $=
    ( wo wn wa w3o w3a ioran anbi1i df-3or xchnxbir df-3an 3bitr4i ) ABDZEZCEZF
    ZAEZBEZFZQFABCGZESTQHPUAQABIJOCDRUBOCIABCKLSTQMN $.

  $( Simplification of triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  3simpa $p |- ( ( ph /\ ps /\ ch ) -> ( ph /\ ps ) ) $=
    ( w3a wa df-3an simplbi ) ABCDABECABCFG $.

  $( Simplification of triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  3simpb $p |- ( ( ph /\ ps /\ ch ) -> ( ph /\ ch ) ) $=
    ( w3a wa 3ancomb 3simpa sylbi ) ABCDACBDACEABCFACBGH $.

  $( Simplification of triple conjunction.  (Contributed by NM, 21-Apr-1994.)
     (Proof shortened by Andrew Salmon, 13-May-2011.) $)
  3simpc $p |- ( ( ph /\ ps /\ ch ) -> ( ps /\ ch ) ) $=
    ( w3a wa 3anrot 3simpa sylbi ) ABCDBCADBCEABCFBCAGH $.

  $( Simplification of triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  simp1 $p |- ( ( ph /\ ps /\ ch ) -> ph ) $=
    ( w3a 3simpa simpld ) ABCDABABCEF $.

  $( Simplification of triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  simp2 $p |- ( ( ph /\ ps /\ ch ) -> ps ) $=
    ( w3a 3simpa simprd ) ABCDABABCEF $.

  $( Simplification of triple conjunction.  (Contributed by NM,
     21-Apr-1994.) $)
  simp3 $p |- ( ( ph /\ ps /\ ch ) -> ch ) $=
    ( w3a 3simpc simprd ) ABCDBCABCEF $.

  $( Simplification rule.  (Contributed by Jeff Hankins, 17-Nov-2009.) $)
  simpl1 $p |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ph ) $=
    ( w3a simp1 adantr ) ABCEADABCFG $.

  $( Simplification rule.  (Contributed by Jeff Hankins, 17-Nov-2009.) $)
  simpl2 $p |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ps ) $=
    ( w3a simp2 adantr ) ABCEBDABCFG $.

  $( Simplification rule.  (Contributed by Jeff Hankins, 17-Nov-2009.) $)
  simpl3 $p |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ch ) $=
    ( w3a simp3 adantr ) ABCECDABCFG $.

  $( Simplification rule.  (Contributed by Jeff Hankins, 17-Nov-2009.) $)
  simpr1 $p |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ps ) $=
    ( w3a simp1 adantl ) BCDEBABCDFG $.

  $( Simplification rule.  (Contributed by Jeff Hankins, 17-Nov-2009.) $)
  simpr2 $p |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ch ) $=
    ( w3a simp2 adantl ) BCDECABCDFG $.

  $( Simplification rule.  (Contributed by Jeff Hankins, 17-Nov-2009.) $)
  simpr3 $p |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> th ) $=
    ( w3a simp3 adantl ) BCDEDABCDFG $.

  ${
    3simp1i.1 $e |- ( ph /\ ps /\ ch ) $.
    $( Infer a conjunct from a triple conjunction.  (Contributed by NM,
       19-Apr-2005.) $)
    simp1i $p |- ph $=
      ( w3a simp1 ax-mp ) ABCEADABCFG $.

    $( Infer a conjunct from a triple conjunction.  (Contributed by NM,
       19-Apr-2005.) $)
    simp2i $p |- ps $=
      ( w3a simp2 ax-mp ) ABCEBDABCFG $.

    $( Infer a conjunct from a triple conjunction.  (Contributed by NM,
       19-Apr-2005.) $)
    simp3i $p |- ch $=
      ( w3a simp3 ax-mp ) ABCECDABCFG $.
  $}

  ${
    3simp1d.1 $e |- ( ph -> ( ps /\ ch /\ th ) ) $.
    $( Deduce a conjunct from a triple conjunction.  (Contributed by NM,
       4-Sep-2005.) $)
    simp1d $p |- ( ph -> ps ) $=
      ( w3a simp1 syl ) ABCDFBEBCDGH $.

    $( Deduce a conjunct from a triple conjunction.  (Contributed by NM,
       4-Sep-2005.) $)
    simp2d $p |- ( ph -> ch ) $=
      ( w3a simp2 syl ) ABCDFCEBCDGH $.

    $( Deduce a conjunct from a triple conjunction.  (Contributed by NM,
       4-Sep-2005.) $)
    simp3d $p |- ( ph -> th ) $=
      ( w3a simp3 syl ) ABCDFDEBCDGH $.
  $}

  ${
    3simp1bi.1 $e |- ( ph <-> ( ps /\ ch /\ th ) ) $.
    $( Deduce a conjunct from a triple conjunction.  (Contributed by Jonathan
       Ben-Naim, 3-Jun-2011.) $)
    simp1bi $p |- ( ph -> ps ) $=
      ( w3a biimpi simp1d ) ABCDABCDFEGH $.

    $( Deduce a conjunct from a triple conjunction.  (Contributed by Jonathan
       Ben-Naim, 3-Jun-2011.) $)
    simp2bi $p |- ( ph -> ch ) $=
      ( w3a biimpi simp2d ) ABCDABCDFEGH $.

    $( Deduce a conjunct from a triple conjunction.  (Contributed by Jonathan
       Ben-Naim, 3-Jun-2011.) $)
    simp3bi $p |- ( ph -> th ) $=
      ( w3a biimpi simp3d ) ABCDABCDFEGH $.
  $}

  ${
    3adant.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       16-Jul-1995.) $)
    3adant1 $p |- ( ( th /\ ph /\ ps ) -> ch ) $=
      ( w3a wa 3simpc syl ) DABFABGCDABHEI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       16-Jul-1995.) $)
    3adant2 $p |- ( ( ph /\ th /\ ps ) -> ch ) $=
      ( w3a wa 3simpb syl ) ADBFABGCADBHEI $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       16-Jul-1995.) $)
    3adant3 $p |- ( ( ph /\ ps /\ th ) -> ch ) $=
      ( w3a wa 3simpa syl ) ABDFABGCABDHEI $.
  $}

  ${
    3ad2ant.1 $e |- ( ph -> ch ) $.
    $( Deduction adding conjuncts to an antecedent.  (Contributed by NM,
       21-Apr-2005.) $)
    3ad2ant1 $p |- ( ( ph /\ ps /\ th ) -> ch ) $=
      ( adantr 3adant2 ) ADCBACDEFG $.

    $( Deduction adding conjuncts to an antecedent.  (Contributed by NM,
       21-Apr-2005.) $)
    3ad2ant2 $p |- ( ( ps /\ ph /\ th ) -> ch ) $=
      ( adantr 3adant1 ) ADCBACDEFG $.

    $( Deduction adding conjuncts to an antecedent.  (Contributed by NM,
       21-Apr-2005.) $)
    3ad2ant3 $p |- ( ( ps /\ th /\ ph ) -> ch ) $=
      ( adantl 3adant1 ) DACBACDEFG $.
  $}

  $( Simplification of triple conjunction.  (Contributed by NM, 9-Nov-2011.) $)
  simp1l $p |- ( ( ( ph /\ ps ) /\ ch /\ th ) -> ph ) $=
    ( wa simpl 3ad2ant1 ) ABECADABFG $.

  $( Simplification of triple conjunction.  (Contributed by NM, 9-Nov-2011.) $)
  simp1r $p |- ( ( ( ph /\ ps ) /\ ch /\ th ) -> ps ) $=
    ( wa simpr 3ad2ant1 ) ABECBDABFG $.

  $( Simplification of triple conjunction.  (Contributed by NM, 9-Nov-2011.) $)
  simp2l $p |- ( ( ph /\ ( ps /\ ch ) /\ th ) -> ps ) $=
    ( wa simpl 3ad2ant2 ) BCEABDBCFG $.

  $( Simplification of triple conjunction.  (Contributed by NM, 9-Nov-2011.) $)
  simp2r $p |- ( ( ph /\ ( ps /\ ch ) /\ th ) -> ch ) $=
    ( wa simpr 3ad2ant2 ) BCEACDBCFG $.

  $( Simplification of triple conjunction.  (Contributed by NM, 9-Nov-2011.) $)
  simp3l $p |- ( ( ph /\ ps /\ ( ch /\ th ) ) -> ch ) $=
    ( wa simpl 3ad2ant3 ) CDEACBCDFG $.

  $( Simplification of triple conjunction.  (Contributed by NM, 9-Nov-2011.) $)
  simp3r $p |- ( ( ph /\ ps /\ ( ch /\ th ) ) -> th ) $=
    ( wa simpr 3ad2ant3 ) CDEADBCDFG $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp11 $p |- ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) -> ph ) $=
    ( w3a simp1 3ad2ant1 ) ABCFDAEABCGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp12 $p |- ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) -> ps ) $=
    ( w3a simp2 3ad2ant1 ) ABCFDBEABCGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp13 $p |- ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) -> ch ) $=
    ( w3a simp3 3ad2ant1 ) ABCFDCEABCGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp21 $p |- ( ( ph /\ ( ps /\ ch /\ th ) /\ ta ) -> ps ) $=
    ( w3a simp1 3ad2ant2 ) BCDFABEBCDGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp22 $p |- ( ( ph /\ ( ps /\ ch /\ th ) /\ ta ) -> ch ) $=
    ( w3a simp2 3ad2ant2 ) BCDFACEBCDGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp23 $p |- ( ( ph /\ ( ps /\ ch /\ th ) /\ ta ) -> th ) $=
    ( w3a simp3 3ad2ant2 ) BCDFADEBCDGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp31 $p |- ( ( ph /\ ps /\ ( ch /\ th /\ ta ) ) -> ch ) $=
    ( w3a simp1 3ad2ant3 ) CDEFACBCDEGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp32 $p |- ( ( ph /\ ps /\ ( ch /\ th /\ ta ) ) -> th ) $=
    ( w3a simp2 3ad2ant3 ) CDEFADBCDEGH $.

  $( Simplification of doubly triple conjunction.  (Contributed by NM,
     17-Nov-2011.) $)
  simp33 $p |- ( ( ph /\ ps /\ ( ch /\ th /\ ta ) ) -> ta ) $=
    ( w3a simp3 3ad2ant3 ) CDEFAEBCDEGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpll1 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th ) /\ ta ) -> ph ) $=
    ( w3a wa simpl1 adantr ) ABCFDGAEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpll2 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th ) /\ ta ) -> ps ) $=
    ( w3a wa simpl2 adantr ) ABCFDGBEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpll3 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th ) /\ ta ) -> ch ) $=
    ( w3a wa simpl3 adantr ) ABCFDGCEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simplr1 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) ) /\ ta ) -> ph ) $=
    ( w3a wa simpr1 adantr ) DABCFGAEDABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simplr2 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) ) /\ ta ) -> ps ) $=
    ( w3a wa simpr2 adantr ) DABCFGBEDABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simplr3 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) ) /\ ta ) -> ch ) $=
    ( w3a wa simpr3 adantr ) DABCFGCEDABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simprl1 $p |- ( ( ta /\ ( ( ph /\ ps /\ ch ) /\ th ) ) -> ph ) $=
    ( w3a wa simpl1 adantl ) ABCFDGAEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simprl2 $p |- ( ( ta /\ ( ( ph /\ ps /\ ch ) /\ th ) ) -> ps ) $=
    ( w3a wa simpl2 adantl ) ABCFDGBEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simprl3 $p |- ( ( ta /\ ( ( ph /\ ps /\ ch ) /\ th ) ) -> ch ) $=
    ( w3a wa simpl3 adantl ) ABCFDGCEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simprr1 $p |- ( ( ta /\ ( th /\ ( ph /\ ps /\ ch ) ) ) -> ph ) $=
    ( w3a wa simpr1 adantl ) DABCFGAEDABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simprr2 $p |- ( ( ta /\ ( th /\ ( ph /\ ps /\ ch ) ) ) -> ps ) $=
    ( w3a wa simpr2 adantl ) DABCFGBEDABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simprr3 $p |- ( ( ta /\ ( th /\ ( ph /\ ps /\ ch ) ) ) -> ch ) $=
    ( w3a wa simpr3 adantl ) DABCFGCEDABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl1l $p |- ( ( ( ( ph /\ ps ) /\ ch /\ th ) /\ ta ) -> ph ) $=
    ( wa w3a simp1l adantr ) ABFCDGAEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl1r $p |- ( ( ( ( ph /\ ps ) /\ ch /\ th ) /\ ta ) -> ps ) $=
    ( wa w3a simp1r adantr ) ABFCDGBEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl2l $p |- ( ( ( ch /\ ( ph /\ ps ) /\ th ) /\ ta ) -> ph ) $=
    ( wa w3a simp2l adantr ) CABFDGAECABDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl2r $p |- ( ( ( ch /\ ( ph /\ ps ) /\ th ) /\ ta ) -> ps ) $=
    ( wa w3a simp2r adantr ) CABFDGBECABDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl3l $p |- ( ( ( ch /\ th /\ ( ph /\ ps ) ) /\ ta ) -> ph ) $=
    ( wa w3a simp3l adantr ) CDABFGAECDABHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl3r $p |- ( ( ( ch /\ th /\ ( ph /\ ps ) ) /\ ta ) -> ps ) $=
    ( wa w3a simp3r adantr ) CDABFGBECDABHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr1l $p |- ( ( ta /\ ( ( ph /\ ps ) /\ ch /\ th ) ) -> ph ) $=
    ( wa w3a simp1l adantl ) ABFCDGAEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr1r $p |- ( ( ta /\ ( ( ph /\ ps ) /\ ch /\ th ) ) -> ps ) $=
    ( wa w3a simp1r adantl ) ABFCDGBEABCDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr2l $p |- ( ( ta /\ ( ch /\ ( ph /\ ps ) /\ th ) ) -> ph ) $=
    ( wa w3a simp2l adantl ) CABFDGAECABDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr2r $p |- ( ( ta /\ ( ch /\ ( ph /\ ps ) /\ th ) ) -> ps ) $=
    ( wa w3a simp2r adantl ) CABFDGBECABDHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr3l $p |- ( ( ta /\ ( ch /\ th /\ ( ph /\ ps ) ) ) -> ph ) $=
    ( wa w3a simp3l adantl ) CDABFGAECDABHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr3r $p |- ( ( ta /\ ( ch /\ th /\ ( ph /\ ps ) ) ) -> ps ) $=
    ( wa w3a simp3r adantl ) CDABFGBECDABHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1ll $p |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th /\ ta ) -> ph ) $=
    ( wa simpll 3ad2ant1 ) ABFCFDAEABCGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1lr $p |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th /\ ta ) -> ps ) $=
    ( wa simplr 3ad2ant1 ) ABFCFDBEABCGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1rl $p |- ( ( ( ch /\ ( ph /\ ps ) ) /\ th /\ ta ) -> ph ) $=
    ( wa simprl 3ad2ant1 ) CABFFDAECABGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1rr $p |- ( ( ( ch /\ ( ph /\ ps ) ) /\ th /\ ta ) -> ps ) $=
    ( wa simprr 3ad2ant1 ) CABFFDBECABGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2ll $p |- ( ( th /\ ( ( ph /\ ps ) /\ ch ) /\ ta ) -> ph ) $=
    ( wa simpll 3ad2ant2 ) ABFCFDAEABCGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2lr $p |- ( ( th /\ ( ( ph /\ ps ) /\ ch ) /\ ta ) -> ps ) $=
    ( wa simplr 3ad2ant2 ) ABFCFDBEABCGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2rl $p |- ( ( th /\ ( ch /\ ( ph /\ ps ) ) /\ ta ) -> ph ) $=
    ( wa simprl 3ad2ant2 ) CABFFDAECABGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2rr $p |- ( ( th /\ ( ch /\ ( ph /\ ps ) ) /\ ta ) -> ps ) $=
    ( wa simprr 3ad2ant2 ) CABFFDBECABGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3ll $p |- ( ( th /\ ta /\ ( ( ph /\ ps ) /\ ch ) ) -> ph ) $=
    ( wa simpll 3ad2ant3 ) ABFCFDAEABCGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3lr $p |- ( ( th /\ ta /\ ( ( ph /\ ps ) /\ ch ) ) -> ps ) $=
    ( wa simplr 3ad2ant3 ) ABFCFDBEABCGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3rl $p |- ( ( th /\ ta /\ ( ch /\ ( ph /\ ps ) ) ) -> ph ) $=
    ( wa simprl 3ad2ant3 ) CABFFDAECABGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3rr $p |- ( ( th /\ ta /\ ( ch /\ ( ph /\ ps ) ) ) -> ps ) $=
    ( wa simprr 3ad2ant3 ) CABFFDBECABGH $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl11 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ et ) -> ph ) $=
    ( w3a simp11 adantr ) ABCGDEGAFABCDEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl12 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ et ) -> ps ) $=
    ( w3a simp12 adantr ) ABCGDEGBFABCDEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl13 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ et ) -> ch ) $=
    ( w3a simp13 adantr ) ABCGDEGCFABCDEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl21 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ et ) -> ph ) $=
    ( w3a simp21 adantr ) DABCGEGAFDABCEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl22 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ et ) -> ps ) $=
    ( w3a simp22 adantr ) DABCGEGBFDABCEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl23 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ et ) -> ch ) $=
    ( w3a simp23 adantr ) DABCGEGCFDABCEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl31 $p |- ( ( ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ et ) -> ph ) $=
    ( w3a simp31 adantr ) DEABCGGAFDEABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl32 $p |- ( ( ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ et ) -> ps ) $=
    ( w3a simp32 adantr ) DEABCGGBFDEABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpl33 $p |- ( ( ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ et ) -> ch ) $=
    ( w3a simp33 adantr ) DEABCGGCFDEABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr11 $p |- ( ( et /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) ) -> ph ) $=
    ( w3a simp11 adantl ) ABCGDEGAFABCDEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr12 $p |- ( ( et /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) ) -> ps ) $=
    ( w3a simp12 adantl ) ABCGDEGBFABCDEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr13 $p |- ( ( et /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) ) -> ch ) $=
    ( w3a simp13 adantl ) ABCGDEGCFABCDEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr21 $p |- ( ( et /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) ) -> ph ) $=
    ( w3a simp21 adantl ) DABCGEGAFDABCEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr22 $p |- ( ( et /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) ) -> ps ) $=
    ( w3a simp22 adantl ) DABCGEGBFDABCEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr23 $p |- ( ( et /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) ) -> ch ) $=
    ( w3a simp23 adantl ) DABCGEGCFDABCEHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr31 $p |- ( ( et /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) ) -> ph ) $=
    ( w3a simp31 adantl ) DEABCGGAFDEABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr32 $p |- ( ( et /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) ) -> ps ) $=
    ( w3a simp32 adantl ) DEABCGGBFDEABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simpr33 $p |- ( ( et /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) ) -> ch ) $=
    ( w3a simp33 adantl ) DEABCGGCFDEABCHI $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1l1 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th ) /\ ta /\ et ) -> ph ) $=
    ( w3a wa simpl1 3ad2ant1 ) ABCGDHEAFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1l2 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th ) /\ ta /\ et ) -> ps ) $=
    ( w3a wa simpl2 3ad2ant1 ) ABCGDHEBFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1l3 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th ) /\ ta /\ et ) -> ch ) $=
    ( w3a wa simpl3 3ad2ant1 ) ABCGDHECFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1r1 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) ) /\ ta /\ et ) -> ph ) $=
    ( w3a wa simpr1 3ad2ant1 ) DABCGHEAFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1r2 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) ) /\ ta /\ et ) -> ps ) $=
    ( w3a wa simpr2 3ad2ant1 ) DABCGHEBFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp1r3 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) ) /\ ta /\ et ) -> ch ) $=
    ( w3a wa simpr3 3ad2ant1 ) DABCGHECFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2l1 $p |- ( ( ta /\ ( ( ph /\ ps /\ ch ) /\ th ) /\ et ) -> ph ) $=
    ( w3a wa simpl1 3ad2ant2 ) ABCGDHEAFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2l2 $p |- ( ( ta /\ ( ( ph /\ ps /\ ch ) /\ th ) /\ et ) -> ps ) $=
    ( w3a wa simpl2 3ad2ant2 ) ABCGDHEBFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2l3 $p |- ( ( ta /\ ( ( ph /\ ps /\ ch ) /\ th ) /\ et ) -> ch ) $=
    ( w3a wa simpl3 3ad2ant2 ) ABCGDHECFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2r1 $p |- ( ( ta /\ ( th /\ ( ph /\ ps /\ ch ) ) /\ et ) -> ph ) $=
    ( w3a wa simpr1 3ad2ant2 ) DABCGHEAFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2r2 $p |- ( ( ta /\ ( th /\ ( ph /\ ps /\ ch ) ) /\ et ) -> ps ) $=
    ( w3a wa simpr2 3ad2ant2 ) DABCGHEBFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp2r3 $p |- ( ( ta /\ ( th /\ ( ph /\ ps /\ ch ) ) /\ et ) -> ch ) $=
    ( w3a wa simpr3 3ad2ant2 ) DABCGHECFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3l1 $p |- ( ( ta /\ et /\ ( ( ph /\ ps /\ ch ) /\ th ) ) -> ph ) $=
    ( w3a wa simpl1 3ad2ant3 ) ABCGDHEAFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3l2 $p |- ( ( ta /\ et /\ ( ( ph /\ ps /\ ch ) /\ th ) ) -> ps ) $=
    ( w3a wa simpl2 3ad2ant3 ) ABCGDHEBFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3l3 $p |- ( ( ta /\ et /\ ( ( ph /\ ps /\ ch ) /\ th ) ) -> ch ) $=
    ( w3a wa simpl3 3ad2ant3 ) ABCGDHECFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3r1 $p |- ( ( ta /\ et /\ ( th /\ ( ph /\ ps /\ ch ) ) ) -> ph ) $=
    ( w3a wa simpr1 3ad2ant3 ) DABCGHEAFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3r2 $p |- ( ( ta /\ et /\ ( th /\ ( ph /\ ps /\ ch ) ) ) -> ps ) $=
    ( w3a wa simpr2 3ad2ant3 ) DABCGHEBFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp3r3 $p |- ( ( ta /\ et /\ ( th /\ ( ph /\ ps /\ ch ) ) ) -> ch ) $=
    ( w3a wa simpr3 3ad2ant3 ) DABCGHECFDABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp11l $p |- ( ( ( ( ph /\ ps ) /\ ch /\ th ) /\ ta /\ et ) -> ph ) $=
    ( wa w3a simp1l 3ad2ant1 ) ABGCDHEAFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp11r $p |- ( ( ( ( ph /\ ps ) /\ ch /\ th ) /\ ta /\ et ) -> ps ) $=
    ( wa w3a simp1r 3ad2ant1 ) ABGCDHEBFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp12l $p |- ( ( ( ch /\ ( ph /\ ps ) /\ th ) /\ ta /\ et ) -> ph ) $=
    ( wa w3a simp2l 3ad2ant1 ) CABGDHEAFCABDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp12r $p |- ( ( ( ch /\ ( ph /\ ps ) /\ th ) /\ ta /\ et ) -> ps ) $=
    ( wa w3a simp2r 3ad2ant1 ) CABGDHEBFCABDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp13l $p |- ( ( ( ch /\ th /\ ( ph /\ ps ) ) /\ ta /\ et ) -> ph ) $=
    ( wa w3a simp3l 3ad2ant1 ) CDABGHEAFCDABIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp13r $p |- ( ( ( ch /\ th /\ ( ph /\ ps ) ) /\ ta /\ et ) -> ps ) $=
    ( wa w3a simp3r 3ad2ant1 ) CDABGHEBFCDABIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp21l $p |- ( ( ta /\ ( ( ph /\ ps ) /\ ch /\ th ) /\ et ) -> ph ) $=
    ( wa w3a simp1l 3ad2ant2 ) ABGCDHEAFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp21r $p |- ( ( ta /\ ( ( ph /\ ps ) /\ ch /\ th ) /\ et ) -> ps ) $=
    ( wa w3a simp1r 3ad2ant2 ) ABGCDHEBFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp22l $p |- ( ( ta /\ ( ch /\ ( ph /\ ps ) /\ th ) /\ et ) -> ph ) $=
    ( wa w3a simp2l 3ad2ant2 ) CABGDHEAFCABDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp22r $p |- ( ( ta /\ ( ch /\ ( ph /\ ps ) /\ th ) /\ et ) -> ps ) $=
    ( wa w3a simp2r 3ad2ant2 ) CABGDHEBFCABDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp23l $p |- ( ( ta /\ ( ch /\ th /\ ( ph /\ ps ) ) /\ et ) -> ph ) $=
    ( wa w3a simp3l 3ad2ant2 ) CDABGHEAFCDABIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp23r $p |- ( ( ta /\ ( ch /\ th /\ ( ph /\ ps ) ) /\ et ) -> ps ) $=
    ( wa w3a simp3r 3ad2ant2 ) CDABGHEBFCDABIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp31l $p |- ( ( ta /\ et /\ ( ( ph /\ ps ) /\ ch /\ th ) ) -> ph ) $=
    ( wa w3a simp1l 3ad2ant3 ) ABGCDHEAFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp31r $p |- ( ( ta /\ et /\ ( ( ph /\ ps ) /\ ch /\ th ) ) -> ps ) $=
    ( wa w3a simp1r 3ad2ant3 ) ABGCDHEBFABCDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp32l $p |- ( ( ta /\ et /\ ( ch /\ ( ph /\ ps ) /\ th ) ) -> ph ) $=
    ( wa w3a simp2l 3ad2ant3 ) CABGDHEAFCABDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp32r $p |- ( ( ta /\ et /\ ( ch /\ ( ph /\ ps ) /\ th ) ) -> ps ) $=
    ( wa w3a simp2r 3ad2ant3 ) CABGDHEBFCABDIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp33l $p |- ( ( ta /\ et /\ ( ch /\ th /\ ( ph /\ ps ) ) ) -> ph ) $=
    ( wa w3a simp3l 3ad2ant3 ) CDABGHEAFCDABIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp33r $p |- ( ( ta /\ et /\ ( ch /\ th /\ ( ph /\ ps ) ) ) -> ps ) $=
    ( wa w3a simp3r 3ad2ant3 ) CDABGHEBFCDABIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp111 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ et /\ ze ) -> ph ) $=
    ( w3a simp11 3ad2ant1 ) ABCHDEHFAGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp112 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ et /\ ze ) -> ps ) $=
    ( w3a simp12 3ad2ant1 ) ABCHDEHFBGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp113 $p |- ( ( ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ et /\ ze ) -> ch ) $=
    ( w3a simp13 3ad2ant1 ) ABCHDEHFCGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp121 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ et /\ ze ) -> ph ) $=
    ( w3a simp21 3ad2ant1 ) DABCHEHFAGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp122 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ et /\ ze ) -> ps ) $=
    ( w3a simp22 3ad2ant1 ) DABCHEHFBGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp123 $p |- ( ( ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ et /\ ze ) -> ch ) $=
    ( w3a simp23 3ad2ant1 ) DABCHEHFCGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp131 $p |- ( ( ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ et /\ ze ) -> ph ) $=
    ( w3a simp31 3ad2ant1 ) DEABCHHFAGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp132 $p |- ( ( ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ et /\ ze ) -> ps ) $=
    ( w3a simp32 3ad2ant1 ) DEABCHHFBGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp133 $p |- ( ( ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ et /\ ze ) -> ch ) $=
    ( w3a simp33 3ad2ant1 ) DEABCHHFCGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp211 $p |- ( ( et /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ ze ) -> ph ) $=
    ( w3a simp11 3ad2ant2 ) ABCHDEHFAGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp212 $p |- ( ( et /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ ze ) -> ps ) $=
    ( w3a simp12 3ad2ant2 ) ABCHDEHFBGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp213 $p |- ( ( et /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) /\ ze ) -> ch ) $=
    ( w3a simp13 3ad2ant2 ) ABCHDEHFCGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp221 $p |- ( ( et /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ ze ) -> ph ) $=
    ( w3a simp21 3ad2ant2 ) DABCHEHFAGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp222 $p |- ( ( et /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ ze ) -> ps ) $=
    ( w3a simp22 3ad2ant2 ) DABCHEHFBGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp223 $p |- ( ( et /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) /\ ze ) -> ch ) $=
    ( w3a simp23 3ad2ant2 ) DABCHEHFCGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp231 $p |- ( ( et /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ ze ) -> ph ) $=
    ( w3a simp31 3ad2ant2 ) DEABCHHFAGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp232 $p |- ( ( et /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ ze ) -> ps ) $=
    ( w3a simp32 3ad2ant2 ) DEABCHHFBGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp233 $p |- ( ( et /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) /\ ze ) -> ch ) $=
    ( w3a simp33 3ad2ant2 ) DEABCHHFCGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp311 $p |- ( ( et /\ ze /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) ) -> ph ) $=
    ( w3a simp11 3ad2ant3 ) ABCHDEHFAGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp312 $p |- ( ( et /\ ze /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) ) -> ps ) $=
    ( w3a simp12 3ad2ant3 ) ABCHDEHFBGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp313 $p |- ( ( et /\ ze /\ ( ( ph /\ ps /\ ch ) /\ th /\ ta ) ) -> ch ) $=
    ( w3a simp13 3ad2ant3 ) ABCHDEHFCGABCDEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp321 $p |- ( ( et /\ ze /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) ) -> ph ) $=
    ( w3a simp21 3ad2ant3 ) DABCHEHFAGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp322 $p |- ( ( et /\ ze /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) ) -> ps ) $=
    ( w3a simp22 3ad2ant3 ) DABCHEHFBGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp323 $p |- ( ( et /\ ze /\ ( th /\ ( ph /\ ps /\ ch ) /\ ta ) ) -> ch ) $=
    ( w3a simp23 3ad2ant3 ) DABCHEHFCGDABCEIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp331 $p |- ( ( et /\ ze /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) ) -> ph ) $=
    ( w3a simp31 3ad2ant3 ) DEABCHHFAGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp332 $p |- ( ( et /\ ze /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) ) -> ps ) $=
    ( w3a simp32 3ad2ant3 ) DEABCHHFBGDEABCIJ $.

  $( Simplification of conjunction.  (Contributed by NM, 9-Mar-2012.) $)
  simp333 $p |- ( ( et /\ ze /\ ( th /\ ta /\ ( ph /\ ps /\ ch ) ) ) -> ch ) $=
    ( w3a simp33 3ad2ant3 ) DEABCHHFCGDEABCIJ $.

  ${
    3adantl.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       24-Feb-2005.) $)
    3adantl1 $p |- ( ( ( ta /\ ph /\ ps ) /\ ch ) -> th ) $=
      ( w3a wa 3simpc sylan ) EABGABHCDEABIFJ $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       24-Feb-2005.) $)
    3adantl2 $p |- ( ( ( ph /\ ta /\ ps ) /\ ch ) -> th ) $=
      ( w3a wa 3simpb sylan ) AEBGABHCDAEBIFJ $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       24-Feb-2005.) $)
    3adantl3 $p |- ( ( ( ph /\ ps /\ ta ) /\ ch ) -> th ) $=
      ( w3a wa 3simpa sylan ) ABEGABHCDABEIFJ $.
  $}

  ${
    3adantr.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       27-Apr-2005.) $)
    3adantr1 $p |- ( ( ph /\ ( ta /\ ps /\ ch ) ) -> th ) $=
      ( w3a wa 3simpc sylan2 ) EBCGABCHDEBCIFJ $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       27-Apr-2005.) $)
    3adantr2 $p |- ( ( ph /\ ( ps /\ ta /\ ch ) ) -> th ) $=
      ( w3a wa 3simpb sylan2 ) BECGABCHDBECIFJ $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       27-Apr-2005.) $)
    3adantr3 $p |- ( ( ph /\ ( ps /\ ch /\ ta ) ) -> th ) $=
      ( w3a wa 3simpa sylan2 ) BCEGABCHDBCEIFJ $.
  $}

  ${
    3ad2antl.1 $e |- ( ( ph /\ ch ) -> th ) $.
    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       4-Aug-2007.) $)
    3ad2antl1 $p |- ( ( ( ph /\ ps /\ ta ) /\ ch ) -> th ) $=
      ( adantlr 3adantl2 ) AECDBACDEFGH $.

    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       4-Aug-2007.) $)
    3ad2antl2 $p |- ( ( ( ps /\ ph /\ ta ) /\ ch ) -> th ) $=
      ( adantlr 3adantl1 ) AECDBACDEFGH $.

    $( Deduction adding conjuncts to antecedent.  (Contributed by NM,
       4-Aug-2007.) $)
    3ad2antl3 $p |- ( ( ( ps /\ ta /\ ph ) /\ ch ) -> th ) $=
      ( adantll 3adantl1 ) EACDBACDEFGH $.

    $( Deduction adding a conjuncts to antecedent.  (Contributed by NM,
       25-Dec-2007.) $)
    3ad2antr1 $p |- ( ( ph /\ ( ch /\ ps /\ ta ) ) -> th ) $=
      ( adantrr 3adantr3 ) ACBDEACDBFGH $.

    $( Deduction adding a conjuncts to antecedent.  (Contributed by NM,
       27-Dec-2007.) $)
    3ad2antr2 $p |- ( ( ph /\ ( ps /\ ch /\ ta ) ) -> th ) $=
      ( adantrl 3adantr3 ) ABCDEACDBFGH $.

    $( Deduction adding a conjuncts to antecedent.  (Contributed by NM,
       30-Dec-2007.) $)
    3ad2antr3 $p |- ( ( ph /\ ( ps /\ ta /\ ch ) ) -> th ) $=
      ( adantrl 3adantr1 ) AECDBACDEFGH $.
  $}

  ${
    3anibar.1 $e |- ( ( ph /\ ps /\ ch ) -> ( th <-> ( ch /\ ta ) ) ) $.
    $( Remove a hypothesis from the second member of a biimplication.
       (Contributed by FL, 22-Jul-2008.) $)
    3anibar $p |- ( ( ph /\ ps /\ ch ) -> ( th <-> ta ) ) $=
      ( w3a wa simp3 biantrurd bitr4d ) ABCGZDCEHEFLCEABCIJK $.
  $}

  $( Introduction in triple disjunction.  (Contributed by NM, 4-Apr-1995.) $)
  3mix1 $p |- ( ph -> ( ph \/ ps \/ ch ) ) $=
    ( wo w3o orc 3orass sylibr ) AABCDZDABCEAIFABCGH $.

  $( Introduction in triple disjunction.  (Contributed by NM, 4-Apr-1995.) $)
  3mix2 $p |- ( ph -> ( ps \/ ph \/ ch ) ) $=
    ( w3o 3mix1 3orrot sylibr ) AACBDBACDACBEBACFG $.

  $( Introduction in triple disjunction.  (Contributed by NM, 4-Apr-1995.) $)
  3mix3 $p |- ( ph -> ( ps \/ ch \/ ph ) ) $=
    ( w3o 3mix1 3orrot sylib ) AABCDBCADABCEABCFG $.

  ${
    3pm3.2i.1 $e |- ph $.
    3pm3.2i.2 $e |- ps $.
    3pm3.2i.3 $e |- ch $.
    $( Infer conjunction of premises.  (Contributed by NM, 10-Feb-1995.) $)
    3pm3.2i $p |- ( ph /\ ps /\ ch ) $=
      ( w3a wa pm3.2i df-3an mpbir2an ) ABCGABHCABDEIFABCJK $.
  $}

  ${
    $( ~ pm3.2 for a triple conjunction.  (Contributed by Alan Sare,
       24-Oct-2011.) $)
    pm3.2an3 $p |- ( ph -> ( ps -> ( ch -> ( ph /\ ps /\ ch ) ) ) ) $=
      ( wa w3a wi pm3.2 ex df-3an bicomi syl8ib ) ABCABDZCDZABCEZABCMFLCGHNMABC
      IJK $.
  $}

  ${
    3jca.1 $e |- ( ph -> ps ) $.
    3jca.2 $e |- ( ph -> ch ) $.
    3jca.3 $e |- ( ph -> th ) $.
    $( Join consequents with conjunction.  (Contributed by NM, 9-Apr-1994.) $)
    3jca $p |- ( ph -> ( ps /\ ch /\ th ) ) $=
      ( wa w3a jca31 df-3an sylibr ) ABCHDHBCDIABCDEFGJBCDKL $.
  $}

  ${
    3jcad.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3jcad.2 $e |- ( ph -> ( ps -> th ) ) $.
    3jcad.3 $e |- ( ph -> ( ps -> ta ) ) $.
    $( Deduction conjoining the consequents of three implications.
       (Contributed by NM, 25-Sep-2005.) $)
    3jcad $p |- ( ph -> ( ps -> ( ch /\ th /\ ta ) ) ) $=
      ( w3a wa imp 3jca ex ) ABCDEIABJCDEABCFKABDGKABEHKLM $.
  $}

  ${
    mpbir3an.1 $e |- ps $.
    mpbir3an.2 $e |- ch $.
    mpbir3an.3 $e |- th $.
    mpbir3an.4 $e |- ( ph <-> ( ps /\ ch /\ th ) ) $.
    $( Detach a conjunction of truths in a biconditional.  (Contributed by NM,
       16-Sep-2011.)  (Revised by NM, 9-Jan-2015.) $)
    mpbir3an $p |- ph $=
      ( w3a 3pm3.2i mpbir ) ABCDIBCDEFGJHK $.
  $}

  ${
    mpbir3and.1 $e |- ( ph -> ch ) $.
    mpbir3and.2 $e |- ( ph -> th ) $.
    mpbir3and.3 $e |- ( ph -> ta ) $.
    mpbir3and.4 $e |- ( ph -> ( ps <-> ( ch /\ th /\ ta ) ) ) $.
    $( Detach a conjunction of truths in a biconditional.  (Contributed by
       Mario Carneiro, 11-May-2014.) $)
    mpbir3and $p |- ( ph -> ps ) $=
      ( w3a 3jca mpbird ) ABCDEJACDEFGHKIL $.
  $}

  ${
    mpbir3anOLD.1 $e |- ( ph <-> ( ps /\ ch /\ th ) ) $.
    mpbir3anOLD.2 $e |- ps $.
    mpbir3anOLD.3 $e |- ch $.
    mpbir3anOLD.4 $e |- th $.
    $( Obsolete version of ~ mpbir3an as of 9-Jan-2015.  (Contributed by NM,
       16-Sep-2011.) $)
    mpbir3anOLD $p |- ph $=
      ( mpbir3an ) ABCDFGHEI $.
  $}

  ${
    mpbir3andOLD.1 $e |- ( ph -> ( ps <-> ( ch /\ th /\ ta ) ) ) $.
    mpbir3andOLD.2 $e |- ( ph -> ch ) $.
    mpbir3andOLD.3 $e |- ( ph -> th ) $.
    mpbir3andOLD.4 $e |- ( ph -> ta ) $.
    $( Obsolete version of ~ mpbir3and as of 9-Jan-2015.  (Contributed by NM,
       11-May-2014.) $)
    mpbir3andOLD $p |- ( ph -> ps ) $=
      ( mpbir3and ) ABCDEGHIFJ $.
  $}

  ${
    syl3anbrc.1 $e |- ( ph -> ps ) $.
    syl3anbrc.2 $e |- ( ph -> ch ) $.
    syl3anbrc.3 $e |- ( ph -> th ) $.
    syl3anbrc.4 $e |- ( ta <-> ( ps /\ ch /\ th ) ) $.
    $( Syllogism inference.  (Contributed by Mario Carneiro, 11-May-2014.) $)
    syl3anbrc $p |- ( ph -> ta ) $=
      ( w3a 3jca sylibr ) ABCDJEABCDFGHKIL $.
  $}

  ${
    3anim123i.1 $e |- ( ph -> ps ) $.
    3anim123i.2 $e |- ( ch -> th ) $.
    3anim123i.3 $e |- ( ta -> et ) $.
    $( Join antecedents and consequents with conjunction.  (Contributed by NM,
       8-Apr-1994.) $)
    3anim123i $p |- ( ( ph /\ ch /\ ta ) -> ( ps /\ th /\ et ) ) $=
      ( w3a 3ad2ant1 3ad2ant2 3ad2ant3 3jca ) ACEJBDFACBEGKCADEHLEAFCIMN $.
  $}

  ${
    3animi.1 $e |- ( ph -> ps ) $.
    $( Add two conjuncts to antecedent and consequent.  (Contributed by Jeff
       Hankins, 16-Aug-2009.) $)
    3anim1i $p |- ( ( ph /\ ch /\ th ) -> ( ps /\ ch /\ th ) ) $=
      ( id 3anim123i ) ABCCDDECFDFG $.

    $( Add two conjuncts to antecedent and consequent.  (Contributed by Jeff
       Hankins, 19-Aug-2009.) $)
    3anim3i $p |- ( ( ch /\ th /\ ph ) -> ( ch /\ th /\ ps ) ) $=
      ( id 3anim123i ) CCDDABCFDFEG $.
  $}

  ${
    bi3.1 $e |- ( ph <-> ps ) $.
    bi3.2 $e |- ( ch <-> th ) $.
    bi3.3 $e |- ( ta <-> et ) $.
    $( Join 3 biconditionals with conjunction.  (Contributed by NM,
       21-Apr-1994.) $)
    3anbi123i $p |- ( ( ph /\ ch /\ ta ) <-> ( ps /\ th /\ et ) ) $=
      ( wa w3a anbi12i df-3an 3bitr4i ) ACJZEJBDJZFJACEKBDFKOPEFABCDGHLILACEMBD
      FMN $.

    $( Join 3 biconditionals with disjunction.  (Contributed by NM,
       17-May-1994.) $)
    3orbi123i $p |- ( ( ph \/ ch \/ ta ) <-> ( ps \/ th \/ et ) ) $=
      ( wo w3o orbi12i df-3or 3bitr4i ) ACJZEJBDJZFJACEKBDFKOPEFABCDGHLILACEMBD
      FMN $.
  $}

  ${
    3anbi1i.1 $e |- ( ph <-> ps ) $.
    $( Inference adding two conjuncts to each side of a biconditional.
       (Contributed by NM, 8-Sep-2006.) $)
    3anbi1i $p |- ( ( ph /\ ch /\ th ) <-> ( ps /\ ch /\ th ) ) $=
      ( biid 3anbi123i ) ABCCDDECFDFG $.

    $( Inference adding two conjuncts to each side of a biconditional.
       (Contributed by NM, 8-Sep-2006.) $)
    3anbi2i $p |- ( ( ch /\ ph /\ th ) <-> ( ch /\ ps /\ th ) ) $=
      ( biid 3anbi123i ) CCABDDCFEDFG $.

    $( Inference adding two conjuncts to each side of a biconditional.
       (Contributed by NM, 8-Sep-2006.) $)
    3anbi3i $p |- ( ( ch /\ th /\ ph ) <-> ( ch /\ th /\ ps ) ) $=
      ( biid 3anbi123i ) CCDDABCFDFEG $.
  $}

  ${
    3imp.1 $e |- ( ph -> ( ps -> ( ch -> th ) ) ) $.
    $( Importation inference.  (Contributed by NM, 8-Apr-1994.) $)
    3imp $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( w3a wa df-3an imp31 sylbi ) ABCFABGCGDABCHABCDEIJ $.
  $}

  ${
    3impa.1 $e |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $.
    $( Importation from double to triple conjunction.  (Contributed by NM,
       20-Aug-1995.) $)
    3impa $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( exp31 3imp ) ABCDABCDEFG $.
  $}

  ${
    3impb.1 $e |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $.
    $( Importation from double to triple conjunction.  (Contributed by NM,
       20-Aug-1995.) $)
    3impb $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( exp32 3imp ) ABCDABCDEFG $.
  $}

  ${
    3impia.1 $e |- ( ( ph /\ ps ) -> ( ch -> th ) ) $.
    $( Importation to triple conjunction.  (Contributed by NM, 13-Jun-2006.) $)
    3impia $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( wi ex 3imp ) ABCDABCDFEGH $.
  $}

  ${
    3impib.1 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( Importation to triple conjunction.  (Contributed by NM, 13-Jun-2006.) $)
    3impib $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( exp3a 3imp ) ABCDABCDEFG $.
  $}

  ${
    3exp.1 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( Exportation inference.  (Contributed by NM, 30-May-1994.) $)
    3exp $p |- ( ph -> ( ps -> ( ch -> th ) ) ) $=
      ( w3a pm3.2an3 syl8 ) ABCABCFDABCGEH $.

    $( Exportation from triple to double conjunction.  (Contributed by NM,
       20-Aug-1995.) $)
    3expa $p |- ( ( ( ph /\ ps ) /\ ch ) -> th ) $=
      ( 3exp imp31 ) ABCDABCDEFG $.

    $( Exportation from triple to double conjunction.  (Contributed by NM,
       20-Aug-1995.) $)
    3expb $p |- ( ( ph /\ ( ps /\ ch ) ) -> th ) $=
      ( 3exp imp32 ) ABCDABCDEFG $.

    $( Exportation from triple conjunction.  (Contributed by NM,
       19-May-2007.) $)
    3expia $p |- ( ( ph /\ ps ) -> ( ch -> th ) ) $=
      ( wi 3exp imp ) ABCDFABCDEGH $.

    $( Exportation from triple conjunction.  (Contributed by NM,
       19-May-2007.) $)
    3expib $p |- ( ph -> ( ( ps /\ ch ) -> th ) ) $=
      ( 3exp imp3a ) ABCDABCDEFG $.

    $( Commutation in antecedent.  Swap 1st and 3rd.  (Contributed by NM,
       28-Jan-1996.)  (Proof shortened by Andrew Salmon, 13-May-2011.) $)
    3com12 $p |- ( ( ps /\ ph /\ ch ) -> th ) $=
      ( w3a 3ancoma sylbi ) BACFABCFDBACGEH $.

    $( Commutation in antecedent.  Swap 1st and 3rd.  (Contributed by NM,
       28-Jan-1996.) $)
    3com13 $p |- ( ( ch /\ ps /\ ph ) -> th ) $=
      ( w3a 3anrev sylbi ) CBAFABCFDCBAGEH $.

    $( Commutation in antecedent.  Swap 2nd and 3rd.  (Contributed by NM,
       28-Jan-1996.) $)
    3com23 $p |- ( ( ph /\ ch /\ ps ) -> th ) $=
      ( 3exp com23 3imp ) ACBDABCDABCDEFGH $.

    $( Commutation in antecedent.  Rotate left.  (Contributed by NM,
       28-Jan-1996.) $)
    3coml $p |- ( ( ps /\ ch /\ ph ) -> th ) $=
      ( 3com23 3com13 ) ACBDABCDEFG $.

    $( Commutation in antecedent.  Rotate right.  (Contributed by NM,
       28-Jan-1996.) $)
    3comr $p |- ( ( ch /\ ph /\ ps ) -> th ) $=
      ( 3coml ) BCADABCDEFF $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       16-Feb-2008.) $)
    3adant3r1 $p |- ( ( ph /\ ( ta /\ ps /\ ch ) ) -> th ) $=
      ( 3expb 3adantr1 ) ABCDEABCDFGH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       17-Feb-2008.) $)
    3adant3r2 $p |- ( ( ph /\ ( ps /\ ta /\ ch ) ) -> th ) $=
      ( 3expb 3adantr2 ) ABCDEABCDFGH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       18-Feb-2008.) $)
    3adant3r3 $p |- ( ( ph /\ ( ps /\ ch /\ ta ) ) -> th ) $=
      ( 3expb 3adantr3 ) ABCDEABCDFGH $.
  $}

  ${
    3an1rs.1 $e |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $.
    $( Swap conjuncts.  (Contributed by NM, 16-Dec-2007.) $)
    3an1rs $p |- ( ( ( ph /\ ps /\ th ) /\ ch ) -> ta ) $=
      ( w3a wi ex 3exp com34 3imp imp ) ABDGCEABDCEHABCDEABCDEHABCGDEFIJKLM $.
  $}

  ${
    3imp1.1 $e |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $.
    $( Importation to left triple conjunction.  (Contributed by NM,
       24-Feb-2005.) $)
    3imp1 $p |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $=
      ( w3a wi 3imp imp ) ABCGDEABCDEHFIJ $.

    $( Importation deduction for triple conjunction.  (Contributed by NM,
       26-Oct-2006.) $)
    3impd $p |- ( ph -> ( ( ps /\ ch /\ th ) -> ta ) ) $=
      ( w3a wi com4l 3imp com12 ) BCDGAEBCDAEHABCDEFIJK $.

    $( Importation to right triple conjunction.  (Contributed by NM,
       26-Oct-2006.) $)
    3imp2 $p |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $=
      ( w3a 3impd imp ) ABCDGEABCDEFHI $.
  $}

  ${
    3exp1.1 $e |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $.
    $( Exportation from left triple conjunction.  (Contributed by NM,
       24-Feb-2005.) $)
    3exp1 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wi w3a ex 3exp ) ABCDEGABCHDEFIJ $.
  $}

  ${
    3expd.1 $e |- ( ph -> ( ( ps /\ ch /\ th ) -> ta ) ) $.
    $( Exportation deduction for triple conjunction.  (Contributed by NM,
       26-Oct-2006.) $)
    3expd $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( wi w3a com12 3exp com4r ) BCDAEBCDAEGABCDHEFIJK $.
  $}

  ${
    3exp2.1 $e |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $.
    $( Exportation from right triple conjunction.  (Contributed by NM,
       26-Oct-2006.) $)
    3exp2 $p |- ( ph -> ( ps -> ( ch -> ( th -> ta ) ) ) ) $=
      ( w3a ex 3expd ) ABCDEABCDGEFHI $.
  $}

  ${
    exp5o.1 $e |- ( ( ph /\ ps /\ ch ) -> ( ( th /\ ta ) -> et ) ) $.
    $( A triple exportation inference.  (Contributed by Jeff Hankins,
       8-Jul-2009.) $)
    exp5o $p |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $=
      ( wi w3a exp3a 3exp ) ABCDEFHHABCIDEFGJK $.
  $}

  ${
    exp516.1 $e |- ( ( ( ph /\ ( ps /\ ch /\ th ) ) /\ ta ) -> et ) $.
    $( A triple exportation inference.  (Contributed by Jeff Hankins,
       8-Jul-2009.) $)
    exp516 $p |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $=
      ( wi w3a exp31 3expd ) ABCDEFHABCDIEFGJK $.
  $}

  ${
    exp520.1 $e |- ( ( ( ph /\ ps /\ ch ) /\ ( th /\ ta ) ) -> et ) $.
    $( A triple exportation inference.  (Contributed by Jeff Hankins,
       8-Jul-2009.) $)
    exp520 $p |- ( ph -> ( ps -> ( ch -> ( th -> ( ta -> et ) ) ) ) ) $=
      ( w3a wa ex exp5o ) ABCDEFABCHDEIFGJK $.
  $}

  ${
    3anassrs.1 $e |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $.
    $( Associative law for conjunction applied to antecedent (eliminates
       syllogism).  (Contributed by Mario Carneiro, 4-Jan-2017.) $)
    3anassrs $p |- ( ( ( ( ph /\ ps ) /\ ch ) /\ th ) -> ta ) $=
      ( 3exp2 imp41 ) ABCDEABCDEFGH $.
  $}

  ${
    3adant1l.1 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    3adant1l $p |- ( ( ( ta /\ ph ) /\ ps /\ ch ) -> th ) $=
      ( wa 3expb adantll 3impb ) EAGBCDABCGDEABCDFHIJ $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    3adant1r $p |- ( ( ( ph /\ ta ) /\ ps /\ ch ) -> th ) $=
      ( wa 3expb adantlr 3impb ) AEGBCDABCGDEABCDFHIJ $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    3adant2l $p |- ( ( ph /\ ( ta /\ ps ) /\ ch ) -> th ) $=
      ( wa 3com12 3adant1l ) EBGACDBACDEABCDFHIH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    3adant2r $p |- ( ( ph /\ ( ps /\ ta ) /\ ch ) -> th ) $=
      ( wa 3com12 3adant1r ) BEGACDBACDEABCDFHIH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    3adant3l $p |- ( ( ph /\ ps /\ ( ta /\ ch ) ) -> th ) $=
      ( wa 3com13 3adant1l ) ECGBADCBADEABCDFHIH $.

    $( Deduction adding a conjunct to antecedent.  (Contributed by NM,
       8-Jan-2006.) $)
    3adant3r $p |- ( ( ph /\ ps /\ ( ch /\ ta ) ) -> th ) $=
      ( wa 3com13 3adant1r ) CEGBADCBADEABCDFHIH $.
  $}

  ${
    sylXanc.1 $e |- ( ph -> ps ) $.
    sylXanc.2 $e |- ( ph -> ch ) $.
    sylXanc.3 $e |- ( ph -> th ) $.
    ${
      syl12anc.4 $e |- ( ( ps /\ ( ch /\ th ) ) -> ta ) $.
      $( Syllogism combined with contraction.  (Contributed by Jeff Hankins,
         1-Aug-2009.) $)
      syl12anc $p |- ( ph -> ta ) $=
        ( wa jca32 syl ) ABCDJJEABCDFGHKIL $.
    $}

    ${
      syl21anc.4 $e |- ( ( ( ps /\ ch ) /\ th ) -> ta ) $.
      $( Syllogism combined with contraction.  (Contributed by Jeff Hankins,
         1-Aug-2009.) $)
      syl21anc $p |- ( ph -> ta ) $=
        ( wa jca31 syl ) ABCJDJEABCDFGHKIL $.
    $}

    ${
      syl111anc.4 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl3anc $p |- ( ph -> ta ) $=
        ( w3a 3jca syl ) ABCDJEABCDFGHKIL $.
    $}

    sylXanc.4 $e |- ( ph -> ta ) $.
    ${
      syl22anc.5 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta ) ) -> et ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl22anc $p |- ( ph -> et ) $=
        ( wa jca syl12anc ) ABCLDEFABCGHMIJKN $.
    $}

    ${
      syl13anc.5 $e |- ( ( ps /\ ( ch /\ th /\ ta ) ) -> et ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl13anc $p |- ( ph -> et ) $=
        ( w3a 3jca syl2anc ) ABCDELFGACDEHIJMKN $.
    $}

    ${
      syl31anc.5 $e |- ( ( ( ps /\ ch /\ th ) /\ ta ) -> et ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl31anc $p |- ( ph -> et ) $=
        ( w3a 3jca syl2anc ) ABCDLEFABCDGHIMJKN $.
    $}

    ${
      syl112anc.5 $e |- ( ( ps /\ ch /\ ( th /\ ta ) ) -> et ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl112anc $p |- ( ph -> et ) $=
        ( wa jca syl3anc ) ABCDELFGHADEIJMKN $.
    $}

    ${
      syl121anc.5 $e |- ( ( ps /\ ( ch /\ th ) /\ ta ) -> et ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl121anc $p |- ( ph -> et ) $=
        ( wa jca syl3anc ) ABCDLEFGACDHIMJKN $.
    $}

    ${
      syl211anc.5 $e |- ( ( ( ps /\ ch ) /\ th /\ ta ) -> et ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl211anc $p |- ( ph -> et ) $=
        ( wa jca syl3anc ) ABCLDEFABCGHMIJKN $.
    $}

    sylXanc.5 $e |- ( ph -> et ) $.
    ${
      syl23anc.6 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta /\ et ) ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl23anc $p |- ( ph -> ze ) $=
        ( wa jca syl13anc ) ABCNDEFGABCHIOJKLMP $.
    $}

    ${
      syl32anc.6 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et ) ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl32anc $p |- ( ph -> ze ) $=
        ( wa jca syl31anc ) ABCDEFNGHIJAEFKLOMP $.
    $}

    ${
      syl122anc.6 $e |- ( ( ps /\ ( ch /\ th ) /\ ( ta /\ et ) ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl122anc $p |- ( ph -> ze ) $=
        ( wa jca syl121anc ) ABCDEFNGHIJAEFKLOMP $.
    $}

    ${
      syl212anc.6 $e |- ( ( ( ps /\ ch ) /\ th /\ ( ta /\ et ) ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl212anc $p |- ( ph -> ze ) $=
        ( wa jca syl211anc ) ABCDEFNGHIJAEFKLOMP $.
    $}

    ${
      syl221anc.6 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta ) /\ et ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl221anc $p |- ( ph -> ze ) $=
        ( wa jca syl211anc ) ABCDENFGHIADEJKOLMP $.
    $}

    ${
      syl113anc.6 $e |- ( ( ps /\ ch /\ ( th /\ ta /\ et ) ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl113anc $p |- ( ph -> ze ) $=
        ( w3a 3jca syl3anc ) ABCDEFNGHIADEFJKLOMP $.
    $}

    ${
      syl131anc.6 $e |- ( ( ps /\ ( ch /\ th /\ ta ) /\ et ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl131anc $p |- ( ph -> ze ) $=
        ( w3a 3jca syl3anc ) ABCDENFGHACDEIJKOLMP $.
    $}

    ${
      syl311anc.6 $e |- ( ( ( ps /\ ch /\ th ) /\ ta /\ et ) -> ze ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl311anc $p |- ( ph -> ze ) $=
        ( w3a 3jca syl3anc ) ABCDNEFGABCDHIJOKLMP $.
    $}

    sylXanc.6 $e |- ( ph -> ze ) $.
    ${
      syl33anc.7 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et /\ ze ) )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl33anc $p |- ( ph -> si ) $=
        ( w3a 3jca syl13anc ) ABCDPEFGHABCDIJKQLMNOR $.
    $}

    ${
      syl222anc.7 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta ) /\ ( et /\ ze ) )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl222anc $p |- ( ph -> si ) $=
        ( wa jca syl221anc ) ABCDEFGPHIJKLAFGMNQOR $.
    $}

    ${
      syl123anc.7 $e |- ( ( ps /\ ( ch /\ th ) /\ ( ta /\ et /\ ze ) )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl123anc $p |- ( ph -> si ) $=
        ( wa jca syl113anc ) ABCDPEFGHIACDJKQLMNOR $.
    $}

    ${
      syl132anc.7 $e |- ( ( ps /\ ( ch /\ th /\ ta ) /\ ( et /\ ze ) )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Jul-2012.) $)
      syl132anc $p |- ( ph -> si ) $=
        ( wa jca syl131anc ) ABCDEFGPHIJKLAFGMNQOR $.
    $}

    ${
      syl213anc.7 $e |- ( ( ( ps /\ ch ) /\ th /\ ( ta /\ et /\ ze ) )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl213anc $p |- ( ph -> si ) $=
        ( wa jca syl113anc ) ABCPDEFGHABCIJQKLMNOR $.
    $}

    ${
      syl231anc.7 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta /\ et ) /\ ze )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl231anc $p |- ( ph -> si ) $=
        ( wa jca syl131anc ) ABCPDEFGHABCIJQKLMNOR $.
    $}

    ${
      syl312anc.7 $e |- ( ( ( ps /\ ch /\ th ) /\ ta /\ ( et /\ ze ) )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Jul-2012.) $)
      syl312anc $p |- ( ph -> si ) $=
        ( wa jca syl311anc ) ABCDEFGPHIJKLAFGMNQOR $.
    $}

    ${
      syl321anc.7 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et ) /\ ze )
           -> si ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Jul-2012.) $)
      syl321anc $p |- ( ph -> si ) $=
        ( wa jca syl311anc ) ABCDEFPGHIJKAEFLMQNOR $.
    $}

    sylXanc.7 $e |- ( ph -> si ) $.
    ${
      syl133anc.8 $e |- ( ( ps /\ ( ch /\ th /\ ta ) /\ ( et /\ ze /\ si ) )
           -> rh ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl133anc $p |- ( ph -> rh ) $=
        ( w3a 3jca syl131anc ) ABCDEFGHRIJKLMAFGHNOPSQT $.
    $}

    ${
      syl313anc.8 $e |- ( ( ( ps /\ ch /\ th ) /\ ta /\ ( et /\ ze /\ si ) )
           -> rh ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl313anc $p |- ( ph -> rh ) $=
        ( w3a 3jca syl311anc ) ABCDEFGHRIJKLMAFGHNOPSQT $.
    $}

    ${
      syl331anc.8 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et /\ ze ) /\ si )
           -> rh ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl331anc $p |- ( ph -> rh ) $=
        ( w3a 3jca syl311anc ) ABCDEFGRHIJKLAEFGMNOSPQT $.
    $}

    ${
      syl223anc.8 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta ) /\ ( et /\ ze /\ si )
          ) -> rh ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl223anc $p |- ( ph -> rh ) $=
        ( wa jca syl213anc ) ABCDERFGHIJKADELMSNOPQT $.
    $}

    ${
      syl232anc.8 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta /\ et ) /\ ( ze /\ si )
          ) -> rh ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl232anc $p |- ( ph -> rh ) $=
        ( wa jca syl231anc ) ABCDEFGHRIJKLMNAGHOPSQT $.
    $}

    ${
      syl322anc.8 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et ) /\ ( ze /\ si )
          ) -> rh ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl322anc $p |- ( ph -> rh ) $=
        ( wa jca syl321anc ) ABCDEFGHRIJKLMNAGHOPSQT $.
    $}

    sylXanc.8 $e |- ( ph -> rh ) $.
    ${
      syl233anc.9 $e |- ( ( ( ps /\ ch ) /\ ( th /\ ta /\ et ) /\ ( ze /\ si /\
          rh ) ) -> mu ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl233anc $p |- ( ph -> mu ) $=
        ( wa jca syl133anc ) ABCTDEFGHIJABCKLUAMNOPQRSUB $.
    $}

    ${
      syl323anc.9 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et ) /\ ( ze /\ si /\
          rh ) ) -> mu ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl323anc $p |- ( ph -> mu ) $=
        ( wa jca syl313anc ) ABCDEFTGHIJKLMAEFNOUAPQRSUB $.
    $}

    ${
      syl332anc.9 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et /\ ze ) /\ ( si /\
          rh ) ) -> mu ) $.
      $( Syllogism combined with contraction.  (Contributed by NM,
         11-Mar-2012.) $)
      syl332anc $p |- ( ph -> mu ) $=
        ( wa jca syl331anc ) ABCDEFGHITJKLMNOPAHIQRUASUB $.
    $}

    sylXanc.9 $e |- ( ph -> mu ) $.
    ${
      syl333anc.10 $e |- ( ( ( ps /\ ch /\ th ) /\ ( ta /\ et /\ ze )
          /\ ( si /\ rh /\ mu ) ) -> la ) $.
      $( A syllogism inference combined with contraction.  (Contributed by NM,
         10-Mar-2012.) $)
      syl333anc $p |- ( ph -> la ) $=
        ( w3a 3jca syl331anc ) ABCDEFGHIJUBKLMNOPQAHIJRSTUCUAUD $.
    $}
  $}

  ${
    syl3an1.1 $e |- ( ph -> ps ) $.
    syl3an1.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an1 $p |- ( ( ph /\ ch /\ th ) -> ta ) $=
      ( w3a 3anim1i syl ) ACDHBCDHEABCDFIGJ $.
  $}

  ${
    syl3an2.1 $e |- ( ph -> ch ) $.
    syl3an2.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an2 $p |- ( ( ps /\ ph /\ th ) -> ta ) $=
      ( wi 3exp syl5 3imp ) BADEACBDEHFBCDEGIJK $.
  $}

  ${
    syl3an3.1 $e |- ( ph -> th ) $.
    syl3an3.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an3 $p |- ( ( ps /\ ch /\ ph ) -> ta ) $=
      ( 3exp syl7 3imp ) BCAEADBCEFBCDEGHIJ $.
  $}

  ${
    syl3an1b.1 $e |- ( ph <-> ps ) $.
    syl3an1b.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an1b $p |- ( ( ph /\ ch /\ th ) -> ta ) $=
      ( biimpi syl3an1 ) ABCDEABFHGI $.
  $}

  ${
    syl3an2b.1 $e |- ( ph <-> ch ) $.
    syl3an2b.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an2b $p |- ( ( ps /\ ph /\ th ) -> ta ) $=
      ( biimpi syl3an2 ) ABCDEACFHGI $.
  $}

  ${
    syl3an3b.1 $e |- ( ph <-> th ) $.
    syl3an3b.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an3b $p |- ( ( ps /\ ch /\ ph ) -> ta ) $=
      ( biimpi syl3an3 ) ABCDEADFHGI $.
  $}

  ${
    syl3an1br.1 $e |- ( ps <-> ph ) $.
    syl3an1br.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an1br $p |- ( ( ph /\ ch /\ th ) -> ta ) $=
      ( biimpri syl3an1 ) ABCDEBAFHGI $.
  $}

  ${
    syl3an2br.1 $e |- ( ch <-> ph ) $.
    syl3an2br.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an2br $p |- ( ( ps /\ ph /\ th ) -> ta ) $=
      ( biimpri syl3an2 ) ABCDECAFHGI $.
  $}

  ${
    syl3an3br.1 $e |- ( th <-> ph ) $.
    syl3an3br.2 $e |- ( ( ps /\ ch /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 22-Aug-1995.) $)
    syl3an3br $p |- ( ( ps /\ ch /\ ph ) -> ta ) $=
      ( biimpri syl3an3 ) ABCDEDAFHGI $.
  $}

  ${
    syl3an.1 $e |- ( ph -> ps ) $.
    syl3an.2 $e |- ( ch -> th ) $.
    syl3an.3 $e |- ( ta -> et ) $.
    syl3an.4 $e |- ( ( ps /\ th /\ et ) -> ze ) $.
    $( A triple syllogism inference.  (Contributed by NM, 13-May-2004.) $)
    syl3an $p |- ( ( ph /\ ch /\ ta ) -> ze ) $=
      ( w3a 3anim123i syl ) ACELBDFLGABCDEFHIJMKN $.
  $}

  ${
    syl3anb.1 $e |- ( ph <-> ps ) $.
    syl3anb.2 $e |- ( ch <-> th ) $.
    syl3anb.3 $e |- ( ta <-> et ) $.
    syl3anb.4 $e |- ( ( ps /\ th /\ et ) -> ze ) $.
    $( A triple syllogism inference.  (Contributed by NM, 15-Oct-2005.) $)
    syl3anb $p |- ( ( ph /\ ch /\ ta ) -> ze ) $=
      ( w3a 3anbi123i sylbi ) ACELBDFLGABCDEFHIJMKN $.
  $}

  ${
    syl3anbr.1 $e |- ( ps <-> ph ) $.
    syl3anbr.2 $e |- ( th <-> ch ) $.
    syl3anbr.3 $e |- ( et <-> ta ) $.
    syl3anbr.4 $e |- ( ( ps /\ th /\ et ) -> ze ) $.
    $( A triple syllogism inference.  (Contributed by NM, 29-Dec-2011.) $)
    syl3anbr $p |- ( ( ph /\ ch /\ ta ) -> ze ) $=
      ( bicomi syl3anb ) ABCDEFGBAHLDCILFEJLKM $.
  $}

  ${
    syld3an3.1 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    syld3an3.2 $e |- ( ( ph /\ ps /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 20-May-2007.) $)
    syld3an3 $p |- ( ( ph /\ ps /\ ch ) -> ta ) $=
      ( w3a simp1 simp2 syl3anc ) ABCHABDEABCIABCJFGK $.
  $}

  ${
    syld3an1.1 $e |- ( ( ch /\ ps /\ th ) -> ph ) $.
    syld3an1.2 $e |- ( ( ph /\ ps /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 7-Jul-2008.) $)
    syld3an1 $p |- ( ( ch /\ ps /\ th ) -> ta ) $=
      ( 3com13 syld3an3 ) DBCEDBCAECBDAFHABDEGHIH $.
  $}

  ${
    syld3an2.1 $e |- ( ( ph /\ ch /\ th ) -> ps ) $.
    syld3an2.2 $e |- ( ( ph /\ ps /\ th ) -> ta ) $.
    $( A syllogism inference.  (Contributed by NM, 20-May-2007.) $)
    syld3an2 $p |- ( ( ph /\ ch /\ th ) -> ta ) $=
      ( 3com23 syld3an3 ) ADCEADCBEACDBFHABDEGHIH $.
  $}

  ${
    syl3anl1.1 $e |- ( ph -> ps ) $.
    syl3anl1.2 $e |- ( ( ( ps /\ ch /\ th ) /\ ta ) -> et ) $.
    $( A syllogism inference.  (Contributed by NM, 24-Feb-2005.) $)
    syl3anl1 $p |- ( ( ( ph /\ ch /\ th ) /\ ta ) -> et ) $=
      ( w3a 3anim1i sylan ) ACDIBCDIEFABCDGJHK $.
  $}

  ${
    syl3anl2.1 $e |- ( ph -> ch ) $.
    syl3anl2.2 $e |- ( ( ( ps /\ ch /\ th ) /\ ta ) -> et ) $.
    $( A syllogism inference.  (Contributed by NM, 24-Feb-2005.) $)
    syl3anl2 $p |- ( ( ( ps /\ ph /\ th ) /\ ta ) -> et ) $=
      ( w3a wi ex syl3an2 imp ) BADIEFABCDEFJGBCDIEFHKLM $.
  $}

  ${
    syl3anl3.1 $e |- ( ph -> th ) $.
    syl3anl3.2 $e |- ( ( ( ps /\ ch /\ th ) /\ ta ) -> et ) $.
    $( A syllogism inference.  (Contributed by NM, 24-Feb-2005.) $)
    syl3anl3 $p |- ( ( ( ps /\ ch /\ ph ) /\ ta ) -> et ) $=
      ( w3a 3anim3i sylan ) BCAIBCDIEFADBCGJHK $.
  $}

  ${
    syl3anl.1 $e |- ( ph -> ps ) $.
    syl3anl.2 $e |- ( ch -> th ) $.
    syl3anl.3 $e |- ( ta -> et ) $.
    syl3anl.4 $e |- ( ( ( ps /\ th /\ et ) /\ ze ) -> si ) $.
    $( A triple syllogism inference.  (Contributed by NM, 24-Dec-2006.) $)
    syl3anl $p |- ( ( ( ph /\ ch /\ ta ) /\ ze ) -> si ) $=
      ( w3a 3anim123i sylan ) ACEMBDFMGHABCDEFIJKNLO $.
  $}

  ${
    syl3anr1.1 $e |- ( ph -> ps ) $.
    syl3anr1.2 $e |- ( ( ch /\ ( ps /\ th /\ ta ) ) -> et ) $.
    $( A syllogism inference.  (Contributed by NM, 31-Jul-2007.) $)
    syl3anr1 $p |- ( ( ch /\ ( ph /\ th /\ ta ) ) -> et ) $=
      ( w3a 3anim1i sylan2 ) ADEICBDEIFABDEGJHK $.
  $}

  ${
    syl3anr2.1 $e |- ( ph -> th ) $.
    syl3anr2.2 $e |- ( ( ch /\ ( ps /\ th /\ ta ) ) -> et ) $.
    $( A syllogism inference.  (Contributed by NM, 1-Aug-2007.) $)
    syl3anr2 $p |- ( ( ch /\ ( ps /\ ph /\ ta ) ) -> et ) $=
      ( w3a ancoms syl3anl2 ) BAEICFABDECFGCBDEIFHJKJ $.
  $}

  ${
    syl3anr3.1 $e |- ( ph -> ta ) $.
    syl3anr3.2 $e |- ( ( ch /\ ( ps /\ th /\ ta ) ) -> et ) $.
    $( A syllogism inference.  (Contributed by NM, 23-Aug-2007.) $)
    syl3anr3 $p |- ( ( ch /\ ( ps /\ th /\ ph ) ) -> et ) $=
      ( w3a 3anim3i sylan2 ) BDAICBDEIFAEBDGJHK $.
  $}

  ${
    3impdi.1 $e |- ( ( ( ph /\ ps ) /\ ( ph /\ ch ) ) -> th ) $.
    $( Importation inference (undistribute conjunction).  (Contributed by NM,
       14-Aug-1995.) $)
    3impdi $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( anandis 3impb ) ABCDABCDEFG $.
  $}

  ${
    3impdir.1 $e |- ( ( ( ph /\ ps ) /\ ( ch /\ ps ) ) -> th ) $.
    $( Importation inference (undistribute conjunction).  (Contributed by NM,
       20-Aug-1995.) $)
    3impdir $p |- ( ( ph /\ ch /\ ps ) -> th ) $=
      ( anandirs 3impa ) ACBDACBDEFG $.
  $}

  ${
    3anidm12.1 $e |- ( ( ph /\ ph /\ ps ) -> ch ) $.
    $( Inference from idempotent law for conjunction.  (Contributed by NM,
       7-Mar-2008.) $)
    3anidm12 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( 3expib anabsi5 ) ABCAABCDEF $.
  $}

  ${
    3anidm13.1 $e |- ( ( ph /\ ps /\ ph ) -> ch ) $.
    $( Inference from idempotent law for conjunction.  (Contributed by NM,
       7-Mar-2008.) $)
    3anidm13 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( 3com23 3anidm12 ) ABCABACDEF $.
  $}

  ${
    3anidm23.1 $e |- ( ( ph /\ ps /\ ps ) -> ch ) $.
    $( Inference from idempotent law for conjunction.  (Contributed by NM,
       1-Feb-2007.) $)
    3anidm23 $p |- ( ( ph /\ ps ) -> ch ) $=
      ( 3expa anabss3 ) ABCABBCDEF $.
  $}

  ${
    3ori.1 $e |- ( ph \/ ps \/ ch ) $.
    $( Infer implication from triple disjunction.  (Contributed by NM,
       26-Sep-2006.) $)
    3ori $p |- ( ( -. ph /\ -. ps ) -> ch ) $=
      ( wn wa wo ioran w3o df-3or mpbi ori sylbir ) AEBEFABGZECABHNCABCINCGDABC
      JKLM $.
  $}

  $( Disjunction of 3 antecedents.  (Contributed by NM, 8-Apr-1994.) $)
  3jao $p |- ( ( ( ph -> ps ) /\ ( ch -> ps ) /\ ( th -> ps ) ) ->
              ( ( ph \/ ch \/ th ) -> ps ) ) $=
    ( w3o wo wi w3a df-3or jao syl6 3imp syl5bi ) ACDEACFZDFZABGZCBGZDBGZHBACDI
    PQROBGZPQNBGRSGABCJNBDJKLM $.

  $( Disjunction of 3 antecedents.  (Contributed by NM, 13-Sep-2011.) $)
  3jaob $p |- ( ( ( ph \/ ch \/ th ) -> ps ) <->
              ( ( ph -> ps ) /\ ( ch -> ps ) /\ ( th -> ps ) ) ) $=
    ( w3o wi w3a 3mix1 imim1i 3mix2 3mix3 3jca 3jao impbii ) ACDEZBFZABFZCBFZDB
    FZGPQRSAOBACDHICOBCADJIDOBDACKILABCDMN $.

  ${
    3jaoi.1 $e |- ( ph -> ps ) $.
    3jaoi.2 $e |- ( ch -> ps ) $.
    3jaoi.3 $e |- ( th -> ps ) $.
    $( Disjunction of 3 antecedents (inference).  (Contributed by NM,
       12-Sep-1995.) $)
    3jaoi $p |- ( ( ph \/ ch \/ th ) -> ps ) $=
      ( wi w3a w3o 3pm3.2i 3jao ax-mp ) ABHZCBHZDBHZIACDJBHNOPEFGKABCDLM $.
  $}

  ${
    3jaod.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3jaod.2 $e |- ( ph -> ( th -> ch ) ) $.
    3jaod.3 $e |- ( ph -> ( ta -> ch ) ) $.
    $( Disjunction of 3 antecedents (deduction).  (Contributed by NM,
       14-Oct-2005.) $)
    3jaod $p |- ( ph -> ( ( ps \/ th \/ ta ) -> ch ) ) $=
      ( wi w3o 3jao syl3anc ) ABCIDCIECIBDEJCIFGHBCDEKL $.
  $}

  ${
    3jaoian.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    3jaoian.2 $e |- ( ( th /\ ps ) -> ch ) $.
    3jaoian.3 $e |- ( ( ta /\ ps ) -> ch ) $.
    $( Disjunction of 3 antecedents (inference).  (Contributed by NM,
       14-Oct-2005.) $)
    3jaoian $p |- ( ( ( ph \/ th \/ ta ) /\ ps ) -> ch ) $=
      ( w3o wi ex 3jaoi imp ) ADEIBCABCJDEABCFKDBCGKEBCHKLM $.
  $}

  ${
    3jaodan.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    3jaodan.2 $e |- ( ( ph /\ th ) -> ch ) $.
    3jaodan.3 $e |- ( ( ph /\ ta ) -> ch ) $.
    $( Disjunction of 3 antecedents (deduction).  (Contributed by NM,
       14-Oct-2005.) $)
    3jaodan $p |- ( ( ph /\ ( ps \/ th \/ ta ) ) -> ch ) $=
      ( w3o ex 3jaod imp ) ABDEICABCDEABCFJADCGJAECHJKL $.
  $}

  ${
    3jaao.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3jaao.2 $e |- ( th -> ( ta -> ch ) ) $.
    3jaao.3 $e |- ( et -> ( ze -> ch ) ) $.
    $( Inference conjoining and disjoining the antecedents of three
       implications.  (Contributed by Jeff Hankins, 15-Aug-2009.)  (Proof
       shortened by Andrew Salmon, 13-May-2011.) $)
    3jaao $p |- ( ( ph /\ th /\ et ) -> ( ( ps \/ ta \/ ze ) -> ch ) ) $=
      ( w3a wi 3ad2ant1 3ad2ant2 3ad2ant3 3jaod ) ADFKBCEGADBCLFHMDAECLFINFAGCL
      DJOP $.
  $}

  ${
    syl3an9b.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    syl3an9b.2 $e |- ( th -> ( ch <-> ta ) ) $.
    syl3an9b.3 $e |- ( et -> ( ta <-> ze ) ) $.
    $( Nested syllogism inference conjoining 3 dissimilar antecedents.
       (Contributed by NM, 1-May-1995.) $)
    syl3an9b $p |- ( ( ph /\ th /\ et ) -> ( ps <-> ze ) ) $=
      ( wb wa sylan9bb 3impa ) ADFBGKADLBEFGABCDEHIMJMN $.
  $}

  ${
    bi3d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    bi3d.2 $e |- ( ph -> ( th <-> ta ) ) $.
    bi3d.3 $e |- ( ph -> ( et <-> ze ) ) $.
    $( Deduction joining 3 equivalences to form equivalence of disjunctions.
       (Contributed by NM, 20-Apr-1994.) $)
    3orbi123d $p |- ( ph -> ( ( ps \/ th \/ et ) <-> ( ch \/ ta \/ ze ) ) ) $=
      ( wo w3o orbi12d df-3or 3bitr4g ) ABDKZFKCEKZGKBDFLCEGLAPQFGABCDEHIMJMBDF
      NCEGNO $.

    $( Deduction joining 3 equivalences to form equivalence of conjunctions.
       (Contributed by NM, 22-Apr-1994.) $)
    3anbi123d $p |- ( ph -> ( ( ps /\ th /\ et ) <-> ( ch /\ ta /\ ze ) ) ) $=
      ( wa w3a anbi12d df-3an 3bitr4g ) ABDKZFKCEKZGKBDFLCEGLAPQFGABCDEHIMJMBDF
      NCEGNO $.
  $}

  ${
    3anbi12d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    3anbi12d.2 $e |- ( ph -> ( th <-> ta ) ) $.
    $( Deduction conjoining and adding a conjunct to equivalences.
       (Contributed by NM, 8-Sep-2006.) $)
    3anbi12d $p |- ( ph -> ( ( ps /\ th /\ et ) <-> ( ch /\ ta /\ et ) ) ) $=
      ( biidd 3anbi123d ) ABCDEFFGHAFIJ $.

    $( Deduction conjoining and adding a conjunct to equivalences.
       (Contributed by NM, 8-Sep-2006.) $)
    3anbi13d $p |- ( ph -> ( ( ps /\ et /\ th ) <-> ( ch /\ et /\ ta ) ) ) $=
      ( biidd 3anbi123d ) ABCFFDEGAFIHJ $.

    $( Deduction conjoining and adding a conjunct to equivalences.
       (Contributed by NM, 8-Sep-2006.) $)
    3anbi23d $p |- ( ph -> ( ( et /\ ps /\ th ) <-> ( et /\ ch /\ ta ) ) ) $=
      ( biidd 3anbi123d ) AFFBCDEAFIGHJ $.
  $}

  ${
    3anbi1d.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduction adding conjuncts to an equivalence.  (Contributed by NM,
       8-Sep-2006.) $)
    3anbi1d $p |- ( ph -> ( ( ps /\ th /\ ta ) <-> ( ch /\ th /\ ta ) ) ) $=
      ( biidd 3anbi12d ) ABCDDEFADGH $.

    $( Deduction adding conjuncts to an equivalence.  (Contributed by NM,
       8-Sep-2006.) $)
    3anbi2d $p |- ( ph -> ( ( th /\ ps /\ ta ) <-> ( th /\ ch /\ ta ) ) ) $=
      ( biidd 3anbi12d ) ADDBCEADGFH $.

    $( Deduction adding conjuncts to an equivalence.  (Contributed by NM,
       8-Sep-2006.) $)
    3anbi3d $p |- ( ph -> ( ( th /\ ta /\ ps ) <-> ( th /\ ta /\ ch ) ) ) $=
      ( biidd 3anbi13d ) ADDBCEADGFH $.
  $}

  ${
    3anim123d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    3anim123d.2 $e |- ( ph -> ( th -> ta ) ) $.
    3anim123d.3 $e |- ( ph -> ( et -> ze ) ) $.
    $( Deduction joining 3 implications to form implication of conjunctions.
       (Contributed by NM, 24-Feb-2005.) $)
    3anim123d $p |- ( ph -> ( ( ps /\ th /\ et ) -> ( ch /\ ta /\ ze ) ) ) $=
      ( wa w3a anim12d df-3an 3imtr4g ) ABDKZFKCEKZGKBDFLCEGLAPQFGABCDEHIMJMBDF
      NCEGNO $.

    $( Deduction joining 3 implications to form implication of disjunctions.
       (Contributed by NM, 4-Apr-1997.) $)
    3orim123d $p |- ( ph -> ( ( ps \/ th \/ et ) -> ( ch \/ ta \/ ze ) ) ) $=
      ( wo w3o orim12d df-3or 3imtr4g ) ABDKZFKCEKZGKBDFLCEGLAPQFGABCDEHIMJMBDF
      NCEGNO $.
  $}

  $( Rearrangement of 6 conjuncts.  (Contributed by NM, 13-Mar-1995.) $)
  an6 $p |- ( ( ( ph /\ ps /\ ch ) /\ ( th /\ ta /\ et ) ) <->
              ( ( ph /\ th ) /\ ( ps /\ ta ) /\ ( ch /\ et ) ) ) $=
    ( w3a wa df-3an anbi12i an4 anbi1i 3bitri bitr4i ) ABCGZDEFGZHZADHZBEHZHZCF
    HZHZRSUAGQABHZCHZDEHZFHZHUCUEHZUAHUBOUDPUFABCIDEFIJUCCUEFKUGTUAABDEKLMRSUAI
    N $.

  $( Analog of ~ an4 for triple conjunction.  (Contributed by Scott Fenton,
     16-Mar-2011.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
  3an6 $p |- ( ( ( ph /\ ps ) /\ ( ch /\ th ) /\ ( ta /\ et ) ) <->
                ( ( ph /\ ch /\ ta ) /\ ( ps /\ th /\ et ) ) ) $=
    ( w3a wa an6 bicomi ) ACEGBDFGHABHCDHEFHGACEBDFIJ $.

  $( Analog of ~ or4 for triple conjunction.  (Contributed by Scott Fenton,
     16-Mar-2011.) $)
  3or6 $p |- ( ( ( ph \/ ps ) \/ ( ch \/ th ) \/ ( ta \/ et ) ) <->
                ( ( ph \/ ch \/ ta ) \/ ( ps \/ th \/ et ) ) ) $=
    ( wo w3o or4 orbi1i bitr2i df-3or orbi12i 3bitr4i ) ABGZCDGZGZEFGZGZACGZEGZ
    BDGZFGZGZOPRHACEHZBDFHZGUDTUBGZRGSTEUBFIUGQRACBDIJKOPRLUEUAUFUCACELBDFLMN
    $.

  ${
    mp3an1.1 $e |- ph $.
    mp3an1.2 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       21-Nov-1994.) $)
    mp3an1 $p |- ( ( ps /\ ch ) -> th ) $=
      ( wa 3expb mpan ) ABCGDEABCDFHI $.
  $}

  ${
    mp3an2.1 $e |- ps $.
    mp3an2.2 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       21-Nov-1994.) $)
    mp3an2 $p |- ( ( ph /\ ch ) -> th ) $=
      ( 3expa mpanl2 ) ABCDEABCDFGH $.
  $}

  ${
    mp3an3.1 $e |- ch $.
    mp3an3.2 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       21-Nov-1994.) $)
    mp3an3 $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa 3expia mpi ) ABGCDEABCDFHI $.
  $}

  ${
    mp3an12.1 $e |- ph $.
    mp3an12.2 $e |- ps $.
    mp3an12.3 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       13-Jul-2005.) $)
    mp3an12 $p |- ( ch -> th ) $=
      ( mp3an1 mpan ) BCDFABCDEGHI $.
  $}

  ${
    mp3an13.1 $e |- ph $.
    mp3an13.2 $e |- ch $.
    mp3an13.3 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       14-Jul-2005.) $)
    mp3an13 $p |- ( ps -> th ) $=
      ( mp3an3 mpan ) ABDEABCDFGHI $.
  $}

  ${
    mp3an23.1 $e |- ps $.
    mp3an23.2 $e |- ch $.
    mp3an23.3 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       14-Jul-2005.) $)
    mp3an23 $p |- ( ph -> th ) $=
      ( mp3an3 mpan2 ) ABDEABCDFGHI $.
  $}

  ${
    mp3an1i.1 $e |- ps $.
    mp3an1i.2 $e |- ( ph -> ( ( ps /\ ch /\ th ) -> ta ) ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 5-Jul-2005.) $)
    mp3an1i $p |- ( ph -> ( ( ch /\ th ) -> ta ) ) $=
      ( wa wi w3a com12 mp3an1 ) CDHAEBCDAEIFABCDJEGKLK $.
  $}

  ${
    mp3anl1.1 $e |- ph $.
    mp3anl1.2 $e |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       24-Feb-2005.) $)
    mp3anl1 $p |- ( ( ( ps /\ ch ) /\ th ) -> ta ) $=
      ( wa wi w3a ex mp3an1 imp ) BCHDEABCDEIFABCJDEGKLM $.
  $}

  ${
    mp3anl2.1 $e |- ps $.
    mp3anl2.2 $e |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       24-Feb-2005.) $)
    mp3anl2 $p |- ( ( ( ph /\ ch ) /\ th ) -> ta ) $=
      ( wa wi w3a ex mp3an2 imp ) ACHDEABCDEIFABCJDEGKLM $.
  $}

  ${
    mp3anl3.1 $e |- ch $.
    mp3anl3.2 $e |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       24-Feb-2005.) $)
    mp3anl3 $p |- ( ( ( ph /\ ps ) /\ th ) -> ta ) $=
      ( wa wi w3a ex mp3an3 imp ) ABHDEABCDEIFABCJDEGKLM $.
  $}

  ${
    mp3anr1.1 $e |- ps $.
    mp3anr1.2 $e |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 4-Nov-2006.) $)
    mp3anr1 $p |- ( ( ph /\ ( ch /\ th ) ) -> ta ) $=
      ( wa w3a ancoms mp3anl1 ) CDHAEBCDAEFABCDIEGJKJ $.
  $}

  ${
    mp3anr2.1 $e |- ch $.
    mp3anr2.2 $e |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       24-Nov-2006.) $)
    mp3anr2 $p |- ( ( ph /\ ( ps /\ th ) ) -> ta ) $=
      ( wa w3a ancoms mp3anl2 ) BDHAEBCDAEFABCDIEGJKJ $.
  $}

  ${
    mp3anr3.1 $e |- th $.
    mp3anr3.2 $e |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       19-Oct-2007.) $)
    mp3anr3 $p |- ( ( ph /\ ( ps /\ ch ) ) -> ta ) $=
      ( wa w3a ancoms mp3anl3 ) BCHAEBCDAEFABCDIEGJKJ $.
  $}

  ${
    mp3an.1 $e |- ph $.
    mp3an.2 $e |- ps $.
    mp3an.3 $e |- ch $.
    mp3an.4 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM,
       14-May-1999.) $)
    mp3an $p |- th $=
      ( mp3an1 mp2an ) BCDFGABCDEHIJ $.
  $}

  ${
    mpd3an3.2 $e |- ( ( ph /\ ps ) -> ch ) $.
    mpd3an3.3 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 8-Nov-2007.) $)
    mpd3an3 $p |- ( ( ph /\ ps ) -> th ) $=
      ( wa 3expa mpdan ) ABGCDEABCDFHI $.
  $}

  ${
    mpd3an23.1 $e |- ( ph -> ps ) $.
    mpd3an23.2 $e |- ( ph -> ch ) $.
    mpd3an23.3 $e |- ( ( ph /\ ps /\ ch ) -> th ) $.
    $( An inference based on modus ponens.  (Contributed by NM, 4-Dec-2006.) $)
    mpd3an23 $p |- ( ph -> th ) $=
      ( id syl3anc ) AABCDAHEFGI $.
  $}

  ${
    biimp3a.1 $e |- ( ( ph /\ ps ) -> ( ch <-> th ) ) $.
    $( Infer implication from a logical equivalence.  Similar to ~ biimpa .
       (Contributed by NM, 4-Sep-2005.) $)
    biimp3a $p |- ( ( ph /\ ps /\ ch ) -> th ) $=
      ( wa biimpa 3impa ) ABCDABFCDEGH $.

    $( Infer implication from a logical equivalence.  Similar to ~ biimpar .
       (Contributed by NM, 2-Jan-2009.) $)
    biimp3ar $p |- ( ( ph /\ ps /\ th ) -> ch ) $=
      ( exbiri 3imp ) ABDCABCDEFG $.
  $}

  ${
    3anandis.1 $e |- ( ( ( ph /\ ps ) /\ ( ph /\ ch ) /\ ( ph /\ th ) )
                      -> ta ) $.
    $( Inference that undistributes a triple conjunction in the antecedent.
       (Contributed by NM, 18-Apr-2007.) $)
    3anandis $p |- ( ( ph /\ ( ps /\ ch /\ th ) ) -> ta ) $=
      ( w3a wa simpl simpr1 simpr2 simpr3 syl222anc ) ABCDGZHABACADEANIZABCDJOA
      BCDKOABCDLFM $.
  $}

  ${
    3anandirs.1 $e |- ( ( ( ph /\ th ) /\ ( ps /\ th ) /\ ( ch /\ th ) )
                      -> ta ) $.
    $( Inference that undistributes a triple conjunction in the antecedent.
       (Contributed by NM, 25-Jul-2006.)  (Revised by NM, 18-Apr-2007.) $)
    3anandirs $p |- ( ( ( ph /\ ps /\ ch ) /\ th ) -> ta ) $=
      ( w3a wa simpl1 simpr simpl2 simpl3 syl222anc ) ABCGZDHADBDCDEABCDINDJZAB
      CDKOABCDLOFM $.
  $}

  ${
    ecased.1 $e |- ( ph -> -. ch ) $.
    ecased.2 $e |- ( ph -> ( ps \/ ch ) ) $.
    $( Elimination by cases based on a disjunction (rather than an implication)
       does hold intuitionistically.  However, it is more of a curiosity than
       something useful in proofs, because in intuitionistic logic it will be
       just as hard to prove ` ph \/ ps ` as it would be to prove one of ` ph `
       or ` ps ` .  (Contributed by Jim Kingdon, 9-Dec-2017.) $)
    ecased $p |- ( ph -> ps ) $=
      ( wn wo wa jca orel2 imp syl ) ACFZBCGZHBAMNDEI
      MNBCBJKL $.
  $}

  ${
    ecase23d.1 $e |- ( ph -> -. ch ) $.
    ecase23d.2 $e |- ( ph -> -. th ) $.
    ecase23d.3 $e |- ( ph -> ( ps \/ ch \/ th ) ) $.
    $( Variation of ~ ecased with three disjuncts instead of two.  (Contributed
       by NM, 22-Apr-1994.)  (Revised by Jim Kingdon, 9-Dec-2017.) $)
    ecase23d $p |- ( ph -> ps ) $=
      ( wo w3o df-3or sylib ecased ) ABCEABCHZDFABCDIMDHGBCDJKLL $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                True and false constants
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $c T. $.
  $c F. $.

  $( ` T. ` is a wff. $)
  wtru $a wff T. $.

  $( ` F. ` is a wff. $)
  wfal $a wff F. $.

  $( Soundness justification theorem for ~ df-tru .  (Contributed by NM,
     17-Nov-2013.) $)
  trujust $p |- ( ( ph <-> ph ) <-> ( ps <-> ps ) ) $=
    ( wb biid 2th ) AACBBCADBDE $.

  $( Definition of ` T. ` , a tautology. ` T. ` is a constant true.  In this
     definition ~ biid is used as an antecedent, however, any true wff, such as
     an axiom, can be used in its place.  (Contributed by Anthony Hart,
     13-Oct-2010.) $)
  df-tru $a |- ( T. <-> ( ph <-> ph ) ) $.

  $( Definition of ` F. ` , a contradiction. ` F. ` is a constant false.
     (Contributed by Anthony Hart, 13-Oct-2010.) $)
  df-fal $a |- ( F. <-> -. T. ) $.

  $( ` T. ` is provable.  (Contributed by Anthony Hart, 13-Oct-2010.) $)
  tru $p |- T. $=
    ( wph wtru wb biid df-tru mpbir ) BAACADAEF $.

  $( ` F. ` is not provable.  (Contributed by Anthony Hart, 22-Oct-2010.)
     (Proof shortened by Mel L. O'Cat, 11-Mar-2012.) $)
  fal $p |- -. F. $=
    ( wfal wtru wn tru notnoti df-fal mtbir ) ABCBDEFG $.

  ${
    trud.1 $e |- ( T. -> ph ) $.
    $( Eliminate ` T. ` as an antecedent.  (Contributed by Mario Carneiro,
       13-Mar-2014.) $)
    trud $p |- ph $=
      ( wtru tru ax-mp ) CADBE $.
  $}

  $( If something is true, it outputs ` T. ` .  (Contributed by Anthony Hart,
     14-Aug-2011.) $)
  tbtru $p |- ( ph <-> ( ph <-> T. ) ) $=
    ( wtru tru tbt ) BACD $.

  $( If something is not true, it outputs ` F. ` .  (Contributed by Anthony
     Hart, 14-Aug-2011.) $)
  nbfal $p |- ( -. ph <-> ( ph <-> F. ) ) $=
    ( wfal fal nbn ) BACD $.

  ${
    bitru.1 $e |- ph $.
    $( A theorem is equivalent to truth.  (Contributed by Mario Carneiro,
       9-May-2015.) $)
    bitru $p |- ( ph <-> T. ) $=
      ( wtru tru 2th ) ACBDE $.
  $}

  ${
    bifal.1 $e |- -. ph $.
    $( A contradiction is equivalent to falsehood.  (Contributed by Mario
       Carneiro, 9-May-2015.) $)
    bifal $p |- ( ph <-> F. ) $=
      ( wfal fal 2false ) ACBDE $.
  $}

  $( ` F. ` implies anything.  (Contributed by FL, 20-Mar-2011.)  (Proof
     shortened by Anthony Hart, 1-Aug-2011.) $)
  falim $p |- ( F. -> ph ) $=
    ( wfal fal pm2.21i ) BACD $.

  $( ` F. ` implies anything.  (Contributed by Mario Carneiro, 9-Feb-2017.) $)
  falimd $p |- ( ( ph /\ F. ) -> ps ) $=
    ( wfal falim adantl ) CBABDE $.

  $( Anything implies ` T. ` .  (Contributed by FL, 20-Mar-2011.)  (Proof
     shortened by Anthony Hart, 1-Aug-2011.) $)
  a1tru $p |- ( ph -> T. ) $=
    ( wtru tru a1i ) BACD $.

  $( True can be removed from a conjunction.  (Contributed by FL,
     20-Mar-2011.) $)
  truan $p |- ( ( T. /\ ph ) <-> ph ) $=
    ( wtru wa simpr a1tru ancri impbii ) BACABADABAEFG $.

  $( One definition of negation in logics that take ` F. ` as axiomatic is via
     "implies contradiction", i.e. ` ph -> F. ` .  (Contributed by Mario
     Carneiro, 2-Feb-2015.) $)
  dfnot $p |- ( -. ph <-> ( ph -> F. ) ) $=
    ( wfal wn wi wb fal mtt ax-mp ) BCACABDEFBAGH $.

  ${
    inegd.1 $e |- ( ( ph /\ ps ) -> F. ) $.
    $( Negation introduction rule from natural deduction.  (Contributed by
       Mario Carneiro, 9-Feb-2017.) $)
    inegd $p |- ( ph -> -. ps ) $=
      ( wfal wi wn ex dfnot sylibr ) ABDEBFABDCGBHI $.
  $}

  $( Negation inferred from embedded conjunct.  (Contributed by NM,
     20-Aug-1993.)  (Proof rewritten by Jim Kingdon, 4-May-2018.) $)
  pclem6 $p |- ( ( ph <-> ( ps /\ -. ph ) ) -> -. ps ) $=
    ( wn wa wb wfal wi bi1 pm3.4 com12 syl9r ax-ia3 syl9 impbidd pm5.19 pm2.21i
    bi2 syl6com dfnot sylibr ) ABACZDZEZBFGBCBUCAUAEZFBUCAUAUCAUBBUAAUBHUBBUABU
    AIJKBUAUBUCABUALAUBQMNUDFAOPRBST $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Logical 'xor'
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare connective for exclusive disjunction ('xor'). $)
  $c \/_ $. $( Underlined 'vee' (read:  'xor') $)

  $( Extend wff definition to include exclusive disjunction ('xor'). $)
  wxo $a wff ( ph \/_ ps ) $.

  $( Define exclusive disjunction (logical 'xor').  Return true if either the
     left or right, but not both, are true.  Contrast with ` /\ ` ( ~ wa ),
     ` \/ ` ( ~ wo ), and ` -> ` ( ~ wi ) .  (Contributed by FL, 22-Nov-2010.)
     (Modified by Jim Kingdon, 1-Mar-2018.) $)
  df-xor $a |- ( ( ph \/_ ps ) <-> ( ( ph \/ ps ) /\ -. ( ph /\ ps ) ) ) $.

  $( One way of defining exclusive or.  Equivalent to ~ df-xor .  (Contributed
     by Jim Kingdon and Mario Carneiro, 1-Mar-2018.) $)
  xoranor $p |- ( ( ph \/_ ps ) <-> ( ( ph \/ ps ) /\ ( -. ph \/ -. ps ) ) ) $=
    ( wxo wo wn wa df-xor ax-ia3 con3d olc syl6 pm3.21 orc jaoi imdistani sylbi
    wi pm3.14 anim2i sylibr impbii ) ABCZABDZAEZBEZDZFZUBUCABFZEZFZUGABGZUCUIUF
    AUIUFQBAUIUEUFABUHABHIUEUDJKBUIUDUFBAUHBALIUDUEMKNOPUGUJUBUFUIUCABRSUKTUA
    $.

  $( This tautology shows that xor is really exclusive.  (Contributed by FL,
     22-Nov-2010.)  (Proof rewritten by Jim Kingdon, 5-May-2018.) $)
  excxor $p |- ( ( ph \/_ ps ) <->
       ( ( ph /\ -. ps ) \/ ( -. ph /\ ps ) ) ) $=
    ( wxo wn wa wo xoranor andi orcom pm3.24 biorfi andir pm5.61 orbi12i 3bitri
    3bitr4ri ancom orbi2i ) ABCZBADZEZABDZEZFZUCUAFUCTBEZFSABFZTUBFEUFTEZUFUBEZ
    FUDABGUFTUBHUGUAUHUCUAATEZFUIUAFUAUGUAUIIUIUAAJKABTLPABMNOUAUCIUAUEUCBTQRO
    $.

  $( A consequence of exclusive or.  In classical logic this would be an
     equivalence.  (Contributed by Jim Kingdon, 8-Mar-2018.) $)
  xorbin $p  |- ( ( ph \/_ ps ) -> ( ph <-> -. ps ) ) $=
    ( wn wo wa wi df-xor imnan biimpri adantl sylbi pm2.53 orcoms adantr impbid
    wxo ) ABPZABCZQABDZABECZEZARFZABGZTUBSUBTABHIJKQUARAFZUCSUDTBAUDBALMNKO $.

  $( One direction of ~ pm5.18dc , which holds for all propositions, not just
     decidable propositions.  (Contributed by Jim Kingdon, 10-Mar-2018.) $)
  pm5.18im $p |- ( ( ph <-> ps ) -> -. ( ph <-> -. ps ) ) $=
    ( wb wn pm5.19 bibi1 notbid mpbiri ) ABCZABDZCZDBJCZDBEIKLABJFGH $.

  $( A consequence of exclusive or.  In classical logic this would be an
     equivalence.  (Contributed by Jim Kingdon, 10-Mar-2018.) $)
  xornbi $p  |- ( ( ph \/_ ps ) -> -. ( ph <-> ps ) ) $=
    ( wxo wn wb xorbin pm5.18im con2i syl ) ABCABDEZABEZDABFKJABGHI $.

  $( Two ways to express "exclusive or" between decidable propositions.
     (Contributed by Jim Kingdon, 12-Apr-2018.) $)
  xor3dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( ph <-> ps ) <-> ( ph <-> -. ps ) ) ) ) $=
    ( wdc wb wn wa dcn dcbi syl5 imp pm5.18dc a1d con2biddc bicomd ex
    mpd ) ACZBCZABDZEZABEZDZDQRFZUBTUCUBCZUBTDQRUDRUACQUDBGAUAHIJUCSU
    BUCSUBEDZUDQRUEABKJLMPNO $.

  $( A decidable proposition is equivalent to a decidable proposition or its
     negation.  Based on theorem *5.15 of [WhiteheadRussell] p. 124.
     (Contributed by Jim Kingdon, 18-Apr-2018.) $)
  pm5.15dc $p |- ( DECID ph -> ( DECID ps ->
      ( ( ph <-> ps ) \/ ( ph <-> -. ps ) ) ) ) $=
    ( wdc wb wn wo wa wi xor3dc imp biimpd dcbi dfordc syl mpbird ex
    ) ACZBCZABDZABEDZFZQRGZUASEZTHZUBUCTQRUCTDABIJKUBSCZUAUDDQRUEABLJ
    STMNOP $.

  $( Two ways to express "exclusive or" between decidable propositions.
     (Contributed by Jim Kingdon, 17-Apr-2018.) $)
  xor2dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( ph <-> ps ) <-> ( ( ph \/ ps ) /\ -. ( ph /\ ps ) ) ) ) ) $=
    ( wdc wb wn wo wa xor3dc imp pm5.17dc adantl bitr4d ex ) ACZBCZAB
    DEZABFABGEGZDNOGPABEDZQNOPRDABHIOQRDNABJKLM $.

  $( Exclusive or is equivalent to negated biconditional for decidable
     propositions.  (Contributed by Jim Kingdon, 27-Apr-2018.) $)
  xornbidc $p  |- ( DECID ph -> ( DECID ps ->
      ( ( ph \/_ ps ) <-> -. ( ph <-> ps ) ) ) ) $=
    ( wdc wxo wb wn wa wo xor2dc imp df-xor syl6rbbr ex ) ACZBCZABDZABEFZENOGQA
    BHABGFGZPNOQREABIJABKLM $.

  $( Two ways to express "exclusive or" between decidable propositions.
     Theorem *5.22 of [WhiteheadRussell] p. 124, but for decidable
     propositions.  (Contributed by Jim Kingdon, 5-May-2018.) $)
  xordc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( ph <-> ps ) <-> ( ( ph /\ -. ps ) \/ ( ps /\ -. ph ) ) ) ) ) $=
    ( wdc wb wn wa wo wxo excxor ancom orbi2i bitri xornbidc imp syl5rbbr ex )
    ACZBCZABDEZABEFZBAEZFZGZDUCABHZQRFSUDTUABFZGUCABIUEUBTUABJKLQRUDSDABMNOP $.

  $( Exclusive or implies the left proposition is decidable.  (Contributed by
     Jim Kingdon, 12-Mar-2018.) $)
  xordc1 $p |- ( ( ph \/_ ps ) -> DECID ph ) $=
    ( wo wa wn wxo andir ax-ia1 wi imnan ancom xchbinxr pm3.35 sylan2br orim12i
    wdc sylbi df-xor df-dc 3imtr4i ) ABCABDZEZDZAAEZCZABFAPUCAUBDZBUBDZCUEABUBG
    UFAUGUDAUBHUBBBUDIZUDUHBADUABAJABKLBUDMNOQABRAST $.

  $( Move negation outside of biconditional, for decidable propositions.
     Compare Theorem *5.18 of [WhiteheadRussell] p. 124.  (Contributed by Jim
     Kingdon, 18-Apr-2018.) $)
  nbbndc $p |- ( DECID ph -> ( DECID ps ->
      ( ( -. ph <-> ps ) <-> -. ( ph <-> ps ) ) ) ) $=
    ( wdc wn wb wa xor3dc imp con2bidc bitrd bicom syl6rbb ex ) ACZBCZADZBEZABE
    DZENOFZRBPEZQSRABDEZTNORUAEABGHNOUATEABIHJBPKLM $.

  $( Associative law for the biconditional, for decidable propositions.

     The classical version (without the decidability conditions) is an axiom of
     system DS in Vladimir Lifschitz, "On calculational proofs", Annals of Pure
     and Applied Logic, 113:207-224, 2002,
     ~ http://www.cs.utexas.edu/users/ai-lab/pub-view.php?PubID=26805 , and,
     interestingly, was not included in _Principia Mathematica_ but was
     apparently first noted by Jan Lukasiewicz circa 1923.  (Contributed by Jim
     Kingdon, 4-May-2018.) $)
  biassdc $p |- ( DECID ph -> ( DECID ps -> ( DECID ch ->
      ( ( ( ph <-> ps ) <-> ch ) <-> ( ph <-> ( ps <-> ch ) ) ) ) ) ) $=
    ( wdc wb wn wo wa df-dc pm5.501 bibi1d bitr3d a1d nbbndc imp nbn2
    wi adantl adantr ex jaoi sylbi exp3a ) ADZBDZCDZABEZCEZABCEZEZEZU
    DAAFZGUEUFHZUKQZAIAUNULAUKUMAUIUHUJABUGCABJKAUIJLMULUMUKULUMHZUIF
    ZUHUJUOBFZCEZUPUHUMURUPEZULUEUFUSBCNORULURUHEUMULUQUGCABPKSLULUPU
    JEUMAUIPSLTUAUBUC $.

  $( Lukasiewicz's shortest axiom for equivalential calculus (but modified to
     require decidable propositions).  Storrs McCall, ed., _Polish Logic
     1920-1939_ (Oxford, 1967), p. 96.  (Contributed by Jim Kingdon,
     5-May-2018.) $)
  bilukdc $p |- ( ( ( DECID ph /\ DECID ps ) /\ DECID ch ) ->
      ( ( ph <-> ps ) <-> ( ( ch <-> ps ) <-> ( ph <-> ch ) ) ) ) $=
    ( wdc wa wb bicom bibi1i biassdc syl5bb ancom1s dcbi imp adantr ax-ia2 syl9
    imp31 syl3c mpbid simplr adantlr bitr4d ) ADZBDZEZCDZEZABFZCBACFZFZFZCBFUIF
    ZUGUHCFZUJFZUHUKFZUDUCUFUNUMBAFZCFZUDUCEUFEUJUHUPCABGHUDUCUFUQUJFBACIQJKUGU
    HDZUFUJDZUNUOFUEURUFUCUDURABLMNUEUFOZUCUDUFUSUCUFUIDZUDUSACLZBUILPQUHCUJIRS
    UGUFUDVAULUKFUTUCUDUFTUCUFVAUDUCUFVAVBMUACBUIIRUB $.

  $( An alternate definition of the biconditional for decicable propositions.
     Theorem *5.23 of [WhiteheadRussell] p. 124, but with decidability
     conditions.  (Contributed by Jim Kingdon, 5-May-2018.) $)
  dfbi3dc $p |- ( DECID ph -> ( DECID ps ->
      ( ( ph <-> ps ) <-> ( ( ph /\ ps ) \/ ( -. ph /\ -. ps ) ) ) ) ) $=
    ( wdc wb wa wn wo dcn xordc imp sylan2 pm5.18dc notnotdc anbi2d a1i orbi12d
    ancom adantl 3bitr4d ex ) ACZBCZABDZABEZAFZBFZEZGZDUAUBEAUFDFZAUFFZEZUFUEEZ
    GZUCUHUBUAUFCZUIUMDZBHUAUNUOAUFIJKUAUBUCUIDABLJUBUHUMDUAUBUDUKUGULUBBUJABMN
    UGULDUBUEUFQOPRST $.

  $( Theorem *5.24 of [WhiteheadRussell] p. 124, but for decidable
     propositions.  (Contributed by Jim Kingdon, 5-May-2018.) $)
  pm5.24dc $p |- ( DECID ph -> ( DECID ps ->
      ( -. ( ( ph /\ ps ) \/ ( -. ph /\ -. ps ) ) <->
                ( ( ph /\ -. ps ) \/ ( ps /\ -. ph ) ) ) ) ) $=
    ( wdc wa wn wo wb dfbi3dc imp notbid xordc bitr3d ex ) ACZBCZABDA
    EZBEZDFZEZAQDBPDFZGNODZABGZEZSTUAUBRNOUBRGABHIJNOUCTGABKILM $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Operations on true and false constants
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  For classical logic, truth tables can be used to define propositional
  logic operations, by showing the results of those operations for all
  possible combinations of true ( ` T. ` ) and false ( ` F. ` ).

  Although the intuitionistic logic connectives are not as simply defined,
  ` T. ` and ` F. ` do play similar roles as in classical logic and most
  theorems from classical logic continue to hold.

  Here we show that our definitions and axioms produce equivalent results for
  ` T. ` and ` F. ` as we would get from truth tables for
  ` /\ ` (conjunction aka logical 'and') ~ wa ,
  ` \/ ` (disjunction aka logical inclusive 'or') ~ wo ,
  ` -> ` (implies) ~ wi ,
  ` -. ` (not) ~ wn ,
  ` <-> ` (logical equivalence) ~ df-bi .
$)

  $( A ` /\ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  truantru $p |- ( ( T. /\ T. ) <-> T. ) $=
    ( wtru anidm ) AB $.

  $( A ` /\ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  truanfal $p |- ( ( T. /\ F. ) <-> F. ) $=
    ( wfal truan ) AB $.

  $( A ` /\ ` identity.  (Contributed by David A. Wheeler, 23-Feb-2018.) $)
  falantru $p |- ( ( F. /\ T. ) <-> F. ) $=
    ( wfal wtru wa ax-ia1 falim impbii ) ABCZAABDGEF $.

  $( A ` /\ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  falanfal $p |- ( ( F. /\ F. ) <-> F. ) $=
    ( wfal anidm ) AB $.

  $( A ` \/ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  truortru $p |- ( ( T. \/ T. ) <-> T. ) $=
    ( wtru oridm ) AB $.

  $( A ` \/ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  truorfal $p |- ( ( T. \/ F. ) <-> T. ) $=
    ( wtru wfal wo tru orci bitru ) ABCABDEF $.

  $( A ` \/ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  falortru $p |- ( ( F. \/ T. ) <-> T. ) $=
    ( wfal wtru wo tru olci bitru ) ABCBADEF $.

  $( A ` \/ ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  falorfal $p |- ( ( F. \/ F. ) <-> F. ) $=
    ( wfal oridm ) AB $.

  $( A ` -> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  truimtru $p |- ( ( T. -> T. ) <-> T. ) $=
    ( wtru wi id bitru ) AABACD $.

  $( A ` -> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  truimfal $p |- ( ( T. -> F. ) <-> F. ) $=
    ( wfal wtru wi tru a1bi bicomi ) ABACBADEF $.

  $( A ` -> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  falimtru $p |- ( ( F. -> T. ) <-> T. ) $=
    ( wfal wtru wi falim bitru ) ABCBDE $.

  $( A ` -> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  falimfal $p |- ( ( F. -> F. ) <-> T. ) $=
    ( wfal wi id bitru ) AABACD $.

  $( A ` -. ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.) $)
  nottru $p |- ( -. T. <-> F. ) $=
    ( wfal wtru wn df-fal bicomi ) ABCDE $.

  $( A ` -. ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  notfal $p |- ( -. F. <-> T. ) $=
    ( wfal wn fal bitru ) ABCD $.

  $( A ` <-> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  trubitru $p |- ( ( T. <-> T. ) <-> T. ) $=
    ( wtru wb biid bitru ) AABACD $.

  $( A ` <-> ` identity.  (Contributed by David A. Wheeler, 23-Feb-2018.) $)
  trubifal $p |- ( ( T. <-> F. ) <-> F. ) $=
    ( wtru wfal wb wi dfbi2 truimfal falimtru anbi12i falantru 3bitri
    wa ) ABCABDZBADZKBAKBABELBMAFGHIJ $.

  $( A ` <-> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  falbitru $p |- ( ( F. <-> T. ) <-> F. ) $=
    ( wfal wtru wb bicom trubifal bitri ) ABCBACAABDEF $.

  $( A ` <-> ` identity.  (Contributed by Anthony Hart, 22-Oct-2010.)  (Proof
     shortened by Andrew Salmon, 13-May-2011.) $)
  falbifal $p |- ( ( F. <-> F. ) <-> T. ) $=
    ( wfal wb biid bitru ) AABACD $.

  $( A ` \/_ ` identity.  (Contributed by David A. Wheeler, 2-Mar-2018.) $)
  truxortru $p |- ( ( T. \/_ T. ) <-> F. ) $=
    ( wtru wxo wo wa wn df-xor oridm nottru anidm xchnxbir anbi12i truan 3bitri
    wfal ) AABAACZAADZEZDANDNAAFOAQNAGANPHAIJKNLM $.

  $( A ` \/_ ` identity.  (Contributed by David A. Wheeler, 2-Mar-2018.) $)
  truxorfal $p |- ( ( T. \/_ F. ) <-> T. ) $=
    ( wtru wfal wxo wo wa wn df-xor truorfal notfal truan xchnxbir anidm 3bitri
    anbi12i ) ABCABDZABEZFZEAAEAABGOAQAHBAPIBJKNALM $.

  $( A ` \/_ ` identity.  (Contributed by David A. Wheeler, 2-Mar-2018.) $)
  falxortru $p |- ( ( F. \/_ T. ) <-> T. ) $=
    ( wfal wtru wo wa wn df-xor falortru notfal falantru xchnxbir anbi12i anidm
    wxo 3bitri ) ABMABCZABDZEZDBBDBABFOBQBGABPHIJKBLN $.

  $( A ` \/_ ` identity.  (Contributed by David A. Wheeler, 2-Mar-2018.) $)
  falxorfal $p |- ( ( F. \/_ F. ) <-> F. ) $=
    ( wfal wxo wo wa wn wtru df-xor oridm notfal anidm xchnxbir falantru 3bitri
    anbi12i ) AABAACZAADZEZDAFDAAAGOAQFAHAFPIAJKNLM $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                Stoic logic indemonstrables (Chrysippus of Soli)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  The Greek Stoics developed a system of logic.
  The Stoic Chrysippus, in particular, was often considered one of the greatest
  logicians of antiquity.
  Stoic logic is different from Aristotle's system, since it focuses
  on propositional logic,
  though later thinkers did combine the systems of the Stoics with Aristotle.
  Jan Lukasiewicz reports,
  "For anybody familiar with mathematical logic it is self-evident
  that the Stoic dialectic is the ancient form of modern propositional logic"
  ( _On the history of the logic of proposition_ by Jan Lukasiewicz (1934),
  translated in: _Selected Works_ - Edited by Ludwik Borkowski -
  Amsterdam, North-Holland, 1970 pp. 197-217,
  referenced in "History of Logic"
  ~ https://www.historyoflogic.com/logic-stoics.htm ).
  For more about Aristotle's system, see barbara and related theorems.

  A key part of the Stoic logic system is a set of five "indemonstrables"
  assigned to Chrysippus of Soli by Diogenes Laertius, though in
  general it is difficult to assign specific
  ideas to specific thinkers.
  The indemonstrables are described in, for example,
  [Lopez-Astorga] p. 11 , [Sanford] p. 39, and [Hitchcock] p. 5.
  These indemonstrables are
  modus ponendo ponens (modus ponens) ~ ax-mp ,
  modus tollendo tollens (modus tollens) ~ mto ,
  modus ponendo tollens I ~ mpto1 ,
  modus ponendo tollens II ~ mpto2 , and
  modus tollendo ponens (exclusive-or version) ~ mtp-xor .
  The first is an axiom, the second is already proved; in this section
  we prove the other three.
  Since we assume or prove all of indemonstrables, the system of logic we use
  here is as at least as strong as the set of Stoic indemonstrables.
  Note that modus tollendo ponens ~ mtp-xor originally used exclusive-or,
  but over time the name modus tollendo ponens has increasingly referred
  to an inclusive-or variation, which is proved in ~ mtp-or .
  This set of indemonstrables is not the entire system of Stoic logic.

$)

  ${
    $( Minor premise for modus ponendo tollens 1. $)
    mpto1.1 $e |- ph $.
    $( Major premise for modus ponendo tollens 1. $)
    mpto1.2 $e |- -. ( ph /\ ps ) $.
    $( Modus ponendo tollens 1, one of the "indemonstrables" in Stoic logic.
       See rule 1 on [Lopez-Astorga] p. 12 , rule 1 on [Sanford] p. 40, and
       rule A3 in [Hitchcock] p. 5.  Sanford describes this rule second (after
       ~ mpto2 ) as a "safer, and these days much more common" version of modus
       ponendo tollens because it avoids confusion between inclusive-or and
       exclusive-or.  (Contributed by David A. Wheeler, 2-Mar-2018.) $)
    mpto1 $p |- -. ps $=
      ( wn wi wa imnan mpbir ax-mp ) ABEZCAKFABGEDABHIJ $.
  $}

  ${
    $( Minor premise for modus ponendo tollens 2. $)
    mpto2.1 $e |- ph $.
    $( Major premise for modus ponendo tollens 2. $)
    mpto2.2 $e |- ( ph \/_ ps ) $.
    $( Modus ponendo tollens 2, one of the "indemonstrables" in Stoic logic.
       Note that this uses exclusive-or ` \/_ ` .  See rule 2 on
       [Lopez-Astorga] p. 12 , rule 4 on [Sanford] p. 39 and rule A4 in
       [Hitchcock] p. 5 .  (Contributed by David A. Wheeler, 2-Mar-2018.) $)
    mpto2 $p |- -. ps $=
      ( wo wa wn wxo df-xor mpbi simpri mpto1 ) ABCABEZABFGZABHMNFDABIJKL $.
  $}

  ${
    $( Minor premise for modus tollendo ponens (original exclusive-or version).
    $)
    mtp-xor.1 $e |- -. ph $.
    $( Major premise for modus tollendo ponens (original exclusive-or version).
    $)
    mtp-xor.2 $e |- ( ph \/_ ps ) $.
    $( Modus tollendo ponens (original exclusive-or version), aka disjunctive
       syllogism, one of the five "indemonstrables" in Stoic logic.  The rule
       says, "if ` ph ` is not true, and either ` ph ` or ` ps ` (exclusively)
       are true, then ` ps ` must be true."  Today the name "modus tollendo
       ponens" often refers to a variant, the inclusive-or version as defined
       in ~ mtp-or .  See rule 3 on [Lopez-Astorga] p. 12 (note that the "or"
       is the same as ~ mpto2 , that is, it is exclusive-or ~ df-xor ), rule 3
       of [Sanford] p. 39 (where it is not as clearly stated which kind of "or"
       is used but it appears to be in the same sense as ~ mpto2 ), and rule A5
       in [Hitchcock] p. 5 (exclusive-or is expressly used).  (Contributed by
       David A. Wheeler, 2-Mar-2018.) $)
    mtp-xor $p |- ps $=
      ( wn wo wa wxo df-xor mpbi simpli ori ax-mp ) AEBCABABFZABGEZABHNOGDABIJK
      LM $.
  $}

  ${
    $( Minor premise for modus tollendo ponens (inclusive-or version). $)
    mtp-or.1 $e |- -. ph $.
    $( Major premise for modus tollendo ponens (inclusive-or version). $)
    mtp-or.2 $e |- ( ph \/ ps ) $.
    $( Modus tollendo ponens (inclusive-or version), aka disjunctive
       syllogism.  This is similar to ~ mtp-xor , one of the five original
       "indemonstrables" in Stoic logic.  However, in Stoic logic this rule
       used exclusive-or, while the name modus tollendo ponens often refers to
       a variant of the rule that uses inclusive-or instead.  The rule says,
       "if ` ph ` is not true, and ` ph ` or ` ps ` (or both) are true, then
       ` ps ` must be true."  An alternative phrasing is, "Once you eliminate
       the impossible, whatever remains, no matter how improbable, must be the
       truth." -- Sherlock Holmes (Sir Arthur Conan Doyle, 1890:  The Sign of
       the Four, ch. 6).  (Contributed by David A. Wheeler, 3-Jul-2016.)
       (Proof shortened by Wolf Lammen, 11-Nov-2017.) $)
    mtp-or $p |- ps $=
      ( wn ori ax-mp ) AEBCABDFG $.
  $}


$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
       Auxiliary theorems for Alan Sare's virtual deduction tool, part 1
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    ee22.1 $e |- ( ph -> ( ps -> ch ) ) $.
    ee22.2 $e |- ( ph -> ( ps -> th ) ) $.
    ee22.3 $e |- ( ch -> ( th -> ta ) ) $.
    $( Special theorem needed for Alan Sare's virtual deduction translation
       tool.  (Contributed by Alan Sare, 2-May-2011.) $)
    ee22 $p |- ( ph -> ( ps -> ta ) ) $=
      ( syl6c ) ABCDEFGHI $.
  $}

  ${
    ee12an.1 $e |- ( ph -> ps ) $.
    ee12an.2 $e |- ( ph -> ( ch -> th ) ) $.
    ee12an.3 $e |- ( ( ps /\ th ) -> ta ) $.
    $( Special theorem needed for Alan Sare's virtual deduction translation
       tool.  (Contributed by Alan Sare, 28-Oct-2011.) $)
    ee12an $p |- ( ph -> ( ch -> ta ) ) $=
      ( wa jctild syl6 ) ACBDIEACDBGFJHK $.
  $}

  ${
    ee23.1 $e |- ( ph -> ( ps -> ch ) ) $.
    ee23.2 $e |- ( ph -> ( ps -> ( th -> ta ) ) ) $.
    ee23.3 $e |- ( ch -> ( ta -> et ) ) $.
    $( Special theorem needed for Alan Sare's virtual deduction translation
       tool.  (Contributed by Alan Sare, 17-Jul-2011.) $)
    ee23 $p |- ( ph -> ( ps -> ( th -> et ) ) ) $=
      ( wi syl6 syldd ) ABDEFHABCEFJGIKL $.
  $}

  $( Exportation implication also converting head from biconditional to
     conditional.  (Contributed by Alan Sare, 31-Dec-2011.) $)
  exbir $p |- ( ( ( ph /\ ps ) -> ( ch <-> th ) ) ->
              ( ph -> ( ps -> ( th -> ch ) ) ) ) $=
    ( wa wb wi bi2 imim2i exp3a ) ABEZCDFZGABDCGZLMKCDHIJ $.

  $( ~ impexp with a 3-conjunct antecedent.  (Contributed by Alan Sare,
     31-Dec-2011.) $)
  3impexp $p |- ( ( ( ph /\ ps /\ ch ) -> th ) <->
                ( ph -> ( ps -> ( ch -> th ) ) ) ) $=
    ( w3a wi id 3expd 3impd impbii ) ABCEDFZABCDFFFZKABCDKGHLABCDLGIJ $.

  $( ~ 3impexp with biconditional consequent of antecedent that is commuted in
     consequent.  (Contributed by Alan Sare, 31-Dec-2011.) $)
  3impexpbicom $p |- ( ( ( ph /\ ps /\ ch ) -> ( th <-> ta ) ) <->
                     ( ph -> ( ps -> ( ch -> ( ta <-> th ) ) ) ) ) $=
    ( w3a wb wi bicom imbi2 biimpcd mpi 3expd 3impexp biimpri syl6ibr impbii )
    ABCFZDEGZHZABCEDGZHHHZTABCUATSUAGZRUAHZDEIZUCTUDSUARJKLMUBRUASUDUBABCUANOUE
    PQ $.

  ${
    3impexpbicomi.1 $e |- ( ( ph /\ ps /\ ch ) -> ( th <-> ta ) ) $.
    $( Deduction form of ~ 3impexpbicom .  (Contributed by Alan Sare,
       31-Dec-2011.) $)
    3impexpbicomi $p |- ( ph -> ( ps -> ( ch -> ( ta <-> th ) ) ) ) $=
      ( wb w3a bicomd 3exp ) ABCEDGABCHDEFIJ $.
  $}

  $( Closed form of ~ ancoms .  (Contributed by Alan Sare, 31-Dec-2011.) $)
  ancomsimp $p |- ( ( ( ph /\ ps ) -> ch ) <-> ( ( ps /\ ph ) -> ch ) ) $=
    ( wa ancom imbi1i ) ABDBADCABEF $.

  ${
    exp3acom3r.1 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( Export and commute antecedents.  (Contributed by Alan Sare,
       18-Mar-2012.) $)
    exp3acom3r $p |- ( ps -> ( ch -> ( ph -> th ) ) ) $=
      ( exp3a com3l ) ABCDABCDEFG $.
  $}

  $( Implication form of ~ exp3acom23 .  (Contributed by Alan Sare,
     22-Jul-2012.) $)
  exp3acom23g $p |- ( ( ph -> ( ( ps /\ ch ) -> th ) ) <->
                        ( ph -> ( ch -> ( ps -> th ) ) ) ) $=
    ( wa wi ancomsimp impexp bitri imbi2i ) BCEDFZCBDFFZAKCBEDFLBCDGCBDHIJ $.

  ${
    exp3acom23.1 $e |- ( ph -> ( ( ps /\ ch ) -> th ) ) $.
    $( The exportation deduction ~ exp3a with commutation of the conjoined
       wwfs.  (Contributed by Alan Sare, 22-Jul-2012.) $)
    exp3acom23 $p |- ( ph -> ( ch -> ( ps -> th ) ) ) $=
      ( exp3a com23 ) ABCDABCDEFG $.
  $}

  $( Implication form of ~ simplbi2com .  (Contributed by Alan Sare,
     22-Jul-2012.) $)
  simplbi2comg $p |- ( ( ph <-> ( ps /\ ch ) ) -> ( ch -> ( ps -> ph ) ) ) $=
    ( wa wb bi2 exp3acom23 ) ABCDZEBCAAHFG $.

  ${
    simplbi2com.1 $e |- ( ph <-> ( ps /\ ch ) ) $.
    $( A deduction eliminating a conjunct, similar to ~ simplbi2 .
       (Contributed by Alan Sare, 22-Jul-2012.)  (Proof shortened by Wolf
       Lammen, 10-Nov-2012.) $)
    simplbi2com $p |- ( ch -> ( ps -> ph ) ) $=
      ( simplbi2 com12 ) BCAABCDEF $.
  $}

  ${

    ee21.1 $e |- ( ph -> ( ps -> ch ) ) $.
    ee21.2 $e |- ( ph -> th ) $.
    ee21.3 $e |- ( ch -> ( th -> ta ) ) $.
    $( Special theorem needed for Alan Sare's virtual deduction translation
       tool.  (Contributed by Alan Sare, 18-Mar-2012.) $)
    ee21 $p |- ( ph -> ( ps -> ta ) ) $=
      ( a1d ee22 ) ABCDEFADBGIHJ $.
  $}

  ${
    ee10.1 $e |- ( ph -> ps ) $.
    ee10.2 $e |- ch $.
    ee10.3 $e |- ( ps -> ( ch -> th ) ) $.
    $( Special theorem needed for Alan Sare's virtual deduction translation
       tool.  (Contributed by NM, 25-Jul-2011.) $)
    ee10 $p |- ( ph -> th ) $=
      ( mpi syl ) ABDEBCDFGHI $.
  $}

  ${
    ee02.1 $e |- ph $.
    ee02.2 $e |- ( ps -> ( ch -> th ) ) $.
    ee02.3 $e |- ( ph -> ( th -> ta ) ) $.
    $( Special theorem needed for Alan Sare's virtual deduction translation
       tool.  (Contributed by NM, 22-Jul-2012.) $)
    ee02 $p |- ( ps -> ( ch -> ta ) ) $=
      ( a1i sylsyld ) BACDEABFIGHJ $.
  $}

$( End of auxiliary theorems for Alan Sare's virtual deduction tool, part 1 $)

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
        Predicate calculus mostly without distinct variables
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Equality-free predicate calculus axioms ax-5, ax-7, ax-gen
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare new symbols needed for predicate calculus. $)
  $c A. $. $( "inverted A" universal quantifier (read:  "for all") $)
  $c set $. $( Individual variable type (read:  "the following is an
             individual (set) variable" $)

  $( Declare some names for individual variables. $)
  $v x $.
  $v y $.
  $v z $.
  $v w $.
  $v v $.
  $v u $.
  $v t $.
  $( Let ` x ` be an individual variable. $)
  vx $f set x $.
  $( Let ` y ` be an individual variable. $)
  vy $f set y $.
  $( Let ` z ` be an individual variable. $)
  vz $f set z $.
  $( Let ` w ` be an individual variable. $)
  vw $f set w $.
  $( Let ` v ` be an individual variable. $)
  vv $f set v $.
  $( Let ` u ` be an individual variable. $)
  vu $f set u $.
  $( Let ` t ` be an individual variable. $)
  vt $f set t $.

  $( Extend wff definition to include the universal quantifier ('for all').
     ` A. x ph ` is read " ` ph ` (phi) is true for all ` x ` ."  Typically, in
     its final application ` ph ` would be replaced with a wff containing a
     (free) occurrence of the variable ` x ` , for example ` x = y ` .  In a
     universe with a finite number of objects, "for all" is equivalent to a big
     conjunction (AND) with one wff for each possible case of ` x ` .  When the
     universe is infinite (as with set theory), such a propositional-calculus
     equivalent is not possible because an infinitely long formula has no
     meaning, but conceptually the idea is the same. $)
  wal $a wff A. x ph $.

  $( Axiom of Quantified Implication.  Axiom C4 of [Monk2] p. 105.
     (Contributed by NM, 5-Aug-1993.) $)
  ax-5 $a |- ( A. x ( ph -> ps ) -> ( A. x ph -> A. x ps ) ) $.

  $( Axiom of Quantifier Commutation.  This axiom says universal quantifiers
     can be swapped.  One of the predicate logic axioms which do not involve
     equality.  Axiom scheme C6' in [Megill] p. 448 (p. 16 of the preprint).
     Also appears as Lemma 12 of [Monk2] p. 109 and Axiom C5-3 of [Monk2]
     p. 113.  (Contributed by NM, 5-Aug-1993.) $)
  ax-7 $a |- ( A. x A. y ph -> A. y A. x ph ) $.

  ${
    ax-g.1 $e |- ph $.
    $( Rule of Generalization.  The postulated inference rule of predicate
       calculus.  See e.g.  Rule 2 of [Hamilton] p. 74.  This rule says that if
       something is unconditionally true, then it is true for all values of a
       variable.  For example, if we have proved ` x = x ` , we can conclude
       ` A. x x = x ` or even ` A. y x = x ` .  Theorem ~ a4i shows we can go
       the other way also: in other words we can add or remove universal
       quantifiers from the beginning of any theorem as required.  (Contributed
       by NM, 5-Aug-1993.) $)
    ax-gen $a |- A. x ph $.
  $}

  ${
    gen2.1 $e |- ph $.
    $( Generalization applied twice.  (Contributed by NM, 30-Apr-1998.) $)
    gen2 $p |- A. x A. y ph $=
      ( wal ax-gen ) ACEBACDFF $.
  $}

  ${
    mpg.1 $e |- ( A. x ph -> ps ) $.
    mpg.2 $e |- ph $.
    $( Modus ponens combined with generalization.  (Contributed by NM,
       24-May-1994.) $)
    mpg $p |- ps $=
      ( wal ax-gen ax-mp ) ACFBACEGDH $.
  $}

  ${
    mpgbi.1 $e |- ( A. x ph <-> ps ) $.
    mpgbi.2 $e |- ph $.
    $( Modus ponens on biconditional combined with generalization.
       (Contributed by NM, 24-May-1994.)  (Proof shortened by Stefan Allan,
       28-Oct-2008.) $)
    mpgbi $p |- ps $=
      ( wal ax-gen mpbi ) ACFBACEGDH $.
  $}

  ${
    mpgbir.1 $e |- ( ph <-> A. x ps ) $.
    mpgbir.2 $e |- ps $.
    $( Modus ponens on biconditional combined with generalization.
       (Contributed by NM, 24-May-1994.)  (Proof shortened by Stefan Allan,
       28-Oct-2008.) $)
    mpgbir $p |- ph $=
      ( wal ax-gen mpbir ) ABCFBCEGDH $.
  $}

  ${
    a7s.1 $e |- ( A. x A. y ph -> ps ) $.
    $( Swap quantifiers in an antecedent.  (Contributed by NM, 5-Aug-1993.) $)
    a7s $p |- ( A. y A. x ph -> ps ) $=
      ( wal ax-7 syl ) ACFDFADFCFBADCGEH $.
  $}

  ${
    alimi.1 $e |- ( ph -> ps ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 5-Aug-1993.) $)
    alimi $p |- ( A. x ph -> A. x ps ) $=
      ( wi wal ax-5 mpg ) ABEACFBCFECABCGDH $.

    $( Inference doubly quantifying both antecedent and consequent.
       (Contributed by NM, 3-Feb-2005.) $)
    2alimi $p |- ( A. x A. y ph -> A. x A. y ps ) $=
      ( wal alimi ) ADFBDFCABDEGG $.
  $}

  $( Theorem 19.20 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by O'Cat, 30-Mar-2008.) $)
  alim $p |- ( A. x ( ph -> ps ) -> ( A. x ph -> A. x ps ) ) $=
    ( ax-5 ) ABCD $.

  ${
    al2imi.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Inference quantifying antecedent, nested antecedent, and consequent.
       (Contributed by NM, 5-Aug-1993.) $)
    al2imi $p |- ( A. x ph -> ( A. x ps -> A. x ch ) ) $=
      ( wal wi alimi alim syl ) ADFBCGZDFBDFCDFGAKDEHBCDIJ $.
  $}

  ${
    alanimi.1 $e |- ( ( ph /\ ps ) -> ch ) $.
    $( Variant of ~ al2imi with conjunctive antecedent.  (Contributed by Andrew
       Salmon, 8-Jun-2011.) $)
    alanimi $p |- ( ( A. x ph /\ A. x ps ) -> A. x ch ) $=
      ( wal ex al2imi imp ) ADFBDFCDFABCDABCEGHI $.
  $}

  $c F/ $.  $( The not-free symbol. $)

  $( Extend wff definition to include the not-free predicate. $)
  wnf $a wff F/ x ph $.

  $( Define the not-free predicate for wffs.  This is read " ` x ` is not free
     in ` ph ` ".  Not-free means that the value of ` x ` cannot affect the
     value of ` ph ` , e.g., any occurrence of ` x ` in ` ph ` is effectively
     bound by a "for all" or something that expands to one (such as "there
     exists").  In particular, substitution for a variable not free in a wff
     does not affect its value ( ~ sbf ).  An example of where this is used is
     ~ stdpc5 .  See ~ nf2 for an alternative definition which does not involve
     nested quantifiers on the same variable.

     Not-free is a commonly used constraint, so it is useful to have a notation
     for it.  Surprisingly, there is no common formal notation for it, so here
     we devise one.  Our definition lets us work with the not-free notion
     within the logic itself rather than as a metalogical side condition.

     To be precise, our definition really means "effectively not free," because
     it is slightly less restrictive than the usual textbook definition for
     not-free (which only considers syntactic freedom).  For example, ` x ` is
     effectively not free in the bare expression ` x = x ` , even though ` x `
     would be considered free in the usual textbook definition, because the
     value of ` x ` in the expression ` x = x ` cannot affect the truth of the
     expression (and thus substitution will not change the result).
     (Contributed by Mario Carneiro, 11-Aug-2016.) $)
  df-nf $a |- ( F/ x ph <-> A. x ( ph -> A. x ph ) ) $.

  ${
    nfi.1 $e |- ( ph -> A. x ph ) $.
    $( Deduce that ` x ` is not free in ` ph ` from the definition.
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfi $p |- F/ x ph $=
      ( wnf wal wi df-nf mpgbir ) ABDAABEFBABGCH $.
  $}

  ${
    hbth.1 $e |- ph $.
    $( No variable is (effectively) free in a theorem.

       This and later "hypothesis-building" lemmas, with labels starting
       "hb...", allow us to construct proofs of formulas of the form
       ` |- ( ph -> A. x ph ) ` from smaller formulas of this form.  These are
       useful for constructing hypotheses that state " ` x ` is (effectively)
       not free in ` ph ` ."  (Contributed by NM, 5-Aug-1993.) $)
    hbth $p |- ( ph -> A. x ph ) $=
      ( wal ax-gen a1i ) ABDAABCEF $.

    $( No variable is (effectively) free in a theorem.  (Contributed by Mario
       Carneiro, 11-Aug-2016.) $)
    nfth $p |- F/ x ph $=
      ( hbth nfi ) ABABCDE $.
  $}

  ${
    nfnth.1 $e |- -. ph $.
    $( No variable is (effectively) free in a non-theorem.  (Contributed by
       Mario Carneiro, 6-Dec-2016.) $)
    nfnth $p |- F/ x ph $=
      ( wal pm2.21i nfi ) ABAABDCEF $.
  $}

  $( The true constant has no free variables.  (This can also be proven in one
     step with ~ nfv , but this proof does not use ~ ax-17 .)  (Contributed by
     Mario Carneiro, 6-Oct-2016.) $)
  nftru $p |- F/ x T. $=
    ( wtru tru nfth ) BACD $.

  ${
    alimdh.1 $e |- ( ph -> A. x ph ) $.
    alimdh.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.20 of [Margaris] p. 90.  (Contributed by NM,
       4-Jan-2002.) $)
    alimdh $p |- ( ph -> ( A. x ps -> A. x ch ) ) $=
      ( wal wi al2imi syl ) AADGBDGCDGHEABCDFIJ $.
  $}

  $( Theorem 19.15 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  albi $p |- ( A. x ( ph <-> ps ) -> ( A. x ph <-> A. x ps ) ) $=
    ( wb wal bi1 al2imi bi2 impbid ) ABDZCEACEBCEJABCABFGJBACABHGI $.

  ${
    alrimih.1 $e |- ( ph -> A. x ph ) $.
    alrimih.2 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    alrimih $p |- ( ph -> A. x ps ) $=
      ( wal alimi syl ) AACFBCFDABCEGH $.
  $}

  ${
    albii.1 $e |- ( ph <-> ps ) $.
    $( Inference adding universal quantifier to both sides of an equivalence.
       (Contributed by NM, 7-Aug-1994.) $)
    albii $p |- ( A. x ph <-> A. x ps ) $=
      ( wb wal albi mpg ) ABEACFBCFECABCGDH $.

    $( Inference adding 2 universal quantifiers to both sides of an
       equivalence.  (Contributed by NM, 9-Mar-1997.) $)
    2albii $p |- ( A. x A. y ph <-> A. x A. y ps ) $=
      ( wal albii ) ADFBDFCABDEGG $.
  $}

  ${
    hbxfrbi.1 $e |- ( ph <-> ps ) $.
    hbxfrbi.2 $e |- ( ps -> A. x ps ) $.
    $( A utility lemma to transfer a bound-variable hypothesis builder into a
       definition.  (Contributed by Jonathan Ben-Naim, 3-Jun-2011.) $)
    hbxfrbi $p |- ( ph -> A. x ph ) $=
      ( wal albii 3imtr4i ) BBCFAACFEDABCDGH $.
  $}

  ${
    nfbii.1 $e |- ( ph <-> ps ) $.
    $( Equality theorem for not-free.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfbii $p |- ( F/ x ph <-> F/ x ps ) $=
      ( wal wi wnf albii imbi12i df-nf 3bitr4i ) AACEZFZCEBBCEZFZCEACGBCGMOCABL
      NDABCDHIHACJBCJK $.

    ${
      nfxfr.2 $e |- F/ x ps $.
      $( A utility lemma to transfer a bound-variable hypothesis builder into a
         definition.  (Contributed by Mario Carneiro, 11-Aug-2016.) $)
      nfxfr $p |- F/ x ph $=
        ( wnf nfbii mpbir ) ACFBCFEABCDGH $.
    $}

    ${
      nfxfrd.2 $e |- ( ch -> F/ x ps ) $.
      $( A utility lemma to transfer a bound-variable hypothesis builder into a
         definition.  (Contributed by Mario Carneiro, 24-Sep-2016.) $)
      nfxfrd $p |- ( ch -> F/ x ph ) $=
        ( wnf nfbii sylibr ) CBDGADGFABDEHI $.
    $}
  $}

  ${
    hbal.1 $e |- ( ph -> A. x ph ) $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` A. y ph ` .
       (Contributed by NM, 5-Aug-1993.) $)
    hbal $p |- ( A. y ph -> A. x A. y ph ) $=
      ( wal alimi ax-7 syl ) ACEZABEZCEIBEAJCDFACBGH $.
  $}

  $( Theorem 19.5 of [Margaris] p. 89.  (Contributed by NM, 5-Aug-1993.) $)
  alcom $p |- ( A. x A. y ph <-> A. y A. x ph ) $=
    ( wal ax-7 impbii ) ACDBDABDCDABCEACBEF $.

  ${
    alrimdh.1 $e |- ( ph -> A. x ph ) $.
    alrimdh.2 $e |- ( ps -> A. x ps ) $.
    alrimdh.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
       10-Feb-1997.)  (Proof shortened by Andrew Salmon, 13-May-2011.) $)
    alrimdh $p |- ( ph -> ( ps -> A. x ch ) ) $=
      ( wal alimdh syl5 ) BBDHACDHFABCDEGIJ $.
  $}

  ${
    albidh.1 $e |- ( ph -> A. x ph ) $.
    albidh.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for universal quantifier (deduction rule).
       (Contributed by NM, 5-Aug-1993.) $)
    albidh $p |- ( ph -> ( A. x ps <-> A. x ch ) ) $=
      ( wb wal alrimih albi syl ) ABCGZDHBDHCDHGALDEFIBCDJK $.
  $}

  $( Theorem 19.26 of [Margaris] p. 90.  Also Theorem *10.22 of
     [WhiteheadRussell] p. 119.  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Wolf Lammen, 4-Jul-2014.) $)
  19.26 $p |- ( A. x ( ph /\ ps ) <-> ( A. x ph /\ A. x ps ) ) $=
    ( wa wal simpl alimi simpr jca id alanimi impbii ) ABDZCEZACEZBCEZDNOPMACAB
    FGMBCABHGIABMCMJKL $.

  $( Obsolete proof of ~ 19.26 as of 4-Jul-2014.  (Contributed by NM,
     5-Aug-1993.) $)
  19.26OLD $p |- ( A. x ( ph /\ ps ) <-> ( A. x ph /\ A. x ps ) ) $=
    ( wa wal simpl alimi simpr jca pm3.2 al2imi imp impbii ) ABDZCEZACEZBCEZDOP
    QNACABFGNBCABHGIPQOABNCABJKLM $.

  $( Theorem 19.26 of [Margaris] p. 90 with two quantifiers.  (Contributed by
     NM, 3-Feb-2005.) $)
  19.26-2 $p |- ( A. x A. y ( ph /\ ps ) <->
                ( A. x A. y ph /\ A. x A. y ps ) ) $=
    ( wa wal 19.26 albii bitri ) ABEDFZCFADFZBDFZEZCFKCFLCFEJMCABDGHKLCGI $.

  $( Theorem 19.26 of [Margaris] p. 90 with triple conjunction.  (Contributed
     by NM, 13-Sep-2011.) $)
  19.26-3an $p |- ( A. x ( ph /\ ps /\ ch )
                   <-> ( A. x ph /\ A. x ps /\ A. x ch ) ) $=
    ( wa wal w3a 19.26 anbi1i bitri df-3an albii 3bitr4i ) ABEZCEZDFZADFZBDFZEZ
    CDFZEZABCGZDFQRTGPNDFZTEUANCDHUCSTABDHIJUBODABCKLQRTKM $.

  $( Theorem 19.33 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  19.33 $p |- ( ( A. x ph \/ A. x ps ) -> A. x ( ph \/ ps ) ) $=
    ( wal wo orc alimi olc jaoi ) ACDABEZCDBCDAJCABFGBJCBAHGI $.

  $( Theorem *11.21 in [WhiteheadRussell] p. 160.  (Contributed by Andrew
     Salmon, 24-May-2011.) $)
  alrot3 $p |- ( A. x A. y A. z ph <-> A. y A. z A. x ph ) $=
    ( wal alcom albii bitri ) ADEZCEBEIBEZCEABEDEZCEIBCFJKCABDFGH $.

  $( Rotate 4 universal quantifiers twice.  (Contributed by NM, 2-Feb-2005.)
     (Proof shortened by Wolf Lammen, 28-Jun-2014.) $)
  alrot4 $p |- ( A. x A. y A. z A. w ph <-> A. z A. w A. x A. y ph ) $=
    ( wal alrot3 albii alcom 3bitri ) AEFDFCFZBFACFZEFZDFZBFMBFZDFLBFEFZDFKNBAC
    DEGHMBDIOPDLBEIHJ $.

  $( Obsolete proof of ~ alrot4 as of 28-Jun-2014.  (Contributed by NM,
     2-Feb-2005.) $)
  alrot4OLD $p |- ( A. x A. y A. z A. w ph <-> A. z A. w A. x A. y ph ) $=
    ( wal alcom albii bitri 3bitri ) AEFZDFCFZBFACFZEFZDFZBFNBFZDFMBFEFZDFLOBLK
    CFZDFOKCDGRNDACEGHIHNBDGPQDMBEGHJ $.

  $( Split a biconditional and distribute quantifier.  (Contributed by NM,
     18-Aug-1993.) $)
  albiim $p |- ( A. x ( ph <-> ps ) <->
             ( A. x ( ph -> ps ) /\ A. x ( ps -> ph ) ) ) $=
    ( wb wal wi wa dfbi2 albii 19.26 bitri ) ABDZCEABFZBAFZGZCEMCENCEGLOCABHIMN
    CJK $.

  $( Split a biconditional and distribute 2 quantifiers.  (Contributed by NM,
     3-Feb-2005.) $)
  2albiim $p |- ( A. x A. y ( ph <-> ps ) <->
             ( A. x A. y ( ph -> ps ) /\ A. x A. y ( ps -> ph ) ) ) $=
    ( wb wal wi wa albiim albii 19.26 bitri ) ABEDFZCFABGDFZBAGDFZHZCFNCFOCFHMP
    CABDIJNOCKL $.

  ${
    hband.1 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    hband.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hban .
       (Contributed by NM, 2-Jan-2002.) $)
    hband $p |- ( ph -> ( ( ps /\ ch ) -> A. x ( ps /\ ch ) ) ) $=
      ( wa wal anim12d 19.26 syl6ibr ) ABCGZBDHZCDHZGLDHABMCNEFIBCDJK $.
  $}

  ${
    hb3and.1 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    hb3and.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    hb3and.3 $e |- ( ph -> ( th -> A. x th ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hb3an .
       (Contributed by NM, 17-Feb-2013.) $)
    hb3and $p |- ( ph -> ( ( ps /\ ch /\ th ) -> A. x ( ps /\ ch /\ th ) ) ) $=
      ( w3a wal 3anim123d 19.26-3an syl6ibr ) ABCDIZBEJZCEJZDEJZINEJABOCPDQFGHK
      BCDELM $.
  $}

  ${
    hbald.1 $e |- ( ph -> A. y ph ) $.
    hbald.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hbal .
       (Contributed by NM, 2-Jan-2002.) $)
    hbald $p |- ( ph -> ( A. y ps -> A. x A. y ps ) ) $=
      ( wal alimdh ax-7 syl6 ) ABDGZBCGZDGKCGABLDEFHBDCIJ $.
  $}

  $( Declare the existential quantifier symbol. $)
  $c E. $.   $( Backwards E (read:  "there exists") $)

  $( Extend wff definition to include the existential quantifier ("there
     exists"). $)
  wex $a wff E. x ph $.

  $( ` x ` is bound in ` E. x ph ` .  Axiom 9 of 10 for intuitionistic logic.
     (Contributed by Mario Carneiro, 31-Jan-2015.) $)
  ax-ie1 $a |- ( E. x ph -> A. x E. x ph ) $.

  $( Define existential quantification. ` E. x ph ` means "there exists at
     least one set ` x ` such that ` ph ` is true."  Axiom 10 of 10 for
     intuitionistic logic.  (Contributed by Mario Carneiro, 31-Jan-2015.) $)
  ax-ie2 $a |- ( A. x ( ps -> A. x ps ) ->
               ( A. x ( ph -> ps ) <-> ( E. x ph -> ps ) ) ) $.

  $( ` x ` is not free in ` E. x ph ` .  (Contributed by NM, 5-Aug-1993.) $)
  hbe1 $p |- ( E. x ph -> A. x E. x ph ) $=
    ( ax-ie1 ) ABC $.

  $( ` x ` is not free in ` E. x ph ` .  (Contributed by Mario Carneiro,
     11-Aug-2016.) $)
  nfe1 $p |- F/ x E. x ph $=
    ( wex hbe1 nfi ) ABCBABDE $.

  $( Closed form of Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
     7-Nov-2005.)  (Revised by Mario Carneiro, 1-Feb-2015.) $)
  19.23ht $p |- ( A. x ( ps -> A. x ps ) ->
               ( A. x ( ph -> ps ) <-> ( E. x ph -> ps ) ) ) $=
    ( ax-ie2 ) ABCD $.

  ${
    19.23.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
       (Revised by Mario Carneiro, 1-Feb-2015.) $)
    19.23 $p |- ( A. x ( ph -> ps ) <-> ( E. x ph -> ps ) ) $=
      ( wal wi wex wb ax-gen 19.23ht ax-mp ) BBCEFZCEABFCEACGBFHLCDIABCJK $.
  $}

  $( Theorem 19.7 of [Margaris] p. 89.  To read this intuitionistically, think
     of it as "if ` ph ` can be refuted for all ` x ` , then it is not possible
     to find an ` x ` for which ` ph ` holds" (and likewise for the converse).
     Comparing this with ~ df-ex illustrates that statements which look similar
     (to someone used to classical logic) can be different intuitionistically
     due to different placement of negations.  (Contributed by NM,
     5-Aug-1993.)  (Revised by NM, 1-Feb-2015.)  (Revised by Mario Carneiro,
     12-May-2015.) $)
  alnex $p |- ( A. x -. ph <-> -. E. x ph ) $=
    ( wfal wi wal wex wn fal pm2.21i 19.23 dfnot albii 3bitr4i ) ACDZBEABFZC
    DAGZBEOGACBCCBEHIJPNBAKLOKM $.

  ${
    nex.1 $e |- -. ph $.
    $( Generalization rule for negated wff.  (Contributed by NM,
       18-May-1994.) $)
    nex $p |- -. E. x ph $=
      ( wn wex alnex mpgbi ) ADABEDBABFCG $.
  $}

  $( Defining ` E. x ph ` given decidability.  It is common in classical logic
     to define ` E. x ph ` as ` -. A. x -. ph ` but in intuitionistic logic,
     that definition only holds under certain conditions.  (Contributed by Jim
     Kingdon, 15-Mar-2018.) $)
  dfexdc $p |- ( DECID E. x ph
                 -> ( E. x ph <-> -. A. x -. ph ) ) $=
    ( wn wal wex wb wdc alnex a1i con2biidc ) ACBDZABEZKLCFLGABHIJ $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    Introduce equality axioms
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( --- Start of patch to prevent connective overloading $)
  $c class $.
  $( This syntax construction states that a variable ` x ` , which has been
     declared to be a set variable by $f statement vx, is also a class
     expression.  See comments in set.mm for justification.

     While it is tempting and perhaps occasionally useful to view ~ cv as a
     "type conversion" from a set variable to a class variable, keep in mind
     that ~ cv is intrinsically no different from any other class-building
     syntax.

     (The description above applies to set theory, not predicate calculus.  The
     purpose of introducing ` class x ` here, and not in set theory where it
     belongs, is to allow us to express i.e.  "prove" the ~ weq of predicate
     calculus from the ~ wceq of set theory, so that we don't "overload" the
     ` = ` connective with two syntax definitions.  This is done to prevent
     ambiguity that would complicate some Metamath parsers.) $)
  cv $a class x $.
  $( --- End of patch to prevent connective overloading $)

  $( --- Start of old code before overloading prevention patch. $)
  $(          (None - the above patch had no old code.) $)
  $( --- End of old code before overloading prevention patch. $)

  $( Declare the equality predicate symbol. $)
  $c = $.  $( Equal sign (read:  'is equal to') $)

  $( --- Start of patch to prevent connective overloading $)
  ${
    $v A $.
    $v B $.
    wceq.cA $f class A $.
    wceq.cB $f class B $.
    $( Extend wff definition to include class equality.

       (The purpose of introducing ` wff A = B ` here, and not in set theory
       where it belongs, is to allow us to express i.e.  "prove" the ~ weq of
       predicate calculus in terms of the ~ wceq of set theory, so that we
       don't "overload" the ` = ` connective with two syntax definitions.  This
       is done to prevent ambiguity that would complicate some Metamath
       parsers.  For example, some parsers - although not the Metamath program
       - stumble on the fact that the ` = ` in ` x = y ` could be the ` = ` of
       either ~ weq or ~ wceq , although mathematically it makes no
       difference.  The class variables ` A ` and ` B ` are introduced
       temporarily for the purpose of this definition but otherwise not used in
       predicate calculus.) $)
    wceq $a wff A = B $.
  $}

  $( Extend wff definition to include atomic formulas using the equality
     predicate.

     (Instead of introducing ~ weq as an axiomatic statement, as was done in an
     older version of this database, we introduce it by "proving" a special
     case of set theory's more general ~ wceq .  This lets us avoid overloading
     the ` = ` connective, thus preventing ambiguity that would complicate
     certain Metamath parsers.  However, logically ~ weq is considered to be a
     primitive syntax, even though here it is artificially "derived" from
     ~ wceq .  Note:  To see the proof steps of this syntax proof, type "show
     proof weq /all" in the Metamath program.)  (Contributed by NM,
     24-Jan-2006.) $)
  weq $p wff x = y $=
    ( cv wceq ) ACBCD $.
  $( --- End of patch to prevent connective overloading $)

  $( --- Start of old code before overloading prevention patch. $)
  $(
  @( Extend wff definition to include atomic formulas using the equality
     predicate.

     After we introduce ~ cv and ~ wceq in set theory, this syntax construction
     becomes redundant, since it can be derived with the proof
     "vx cv vy cv wceq". @)
  weq @a wff x = y @.
  $)
  $( --- End of old code before overloading prevention patch. $)

  $( Declare the membership predicate symbol. $)
  $c e. $. $( Stylized epsilon $)

  $( --- Start of patch to prevent connective overloading $)
  ${
    $v A $.
    $v B $.
    wcel.cA $f class A $.
    wcel.cB $f class B $.
    $( Extend wff definition to include the membership connective between
       classes.

       (The purpose of introducing ` wff A e. B ` here is to allow us to
       express i.e.  "prove" the ~ wel of predicate calculus in terms of the
       ~ wceq of set theory, so that we don't "overload" the ` e. ` connective
       with two syntax definitions.  This is done to prevent ambiguity that
       would complicate some Metamath parsers.  The class variables ` A ` and
       ` B ` are introduced temporarily for the purpose of this definition but
       otherwise not used in predicate calculus.) $)
    wcel $a wff A e. B $.
  $}

  $( Extend wff definition to include atomic formulas with the epsilon
     (membership) predicate.  This is read " ` x ` is an element of
     ` y ` ," " ` x ` is a member of ` y ` ," " ` x ` belongs to ` y ` ,"
     or " ` y ` contains ` x ` ."  Note:  The phrase " ` y ` includes
     ` x ` " means " ` x ` is a subset of ` y ` ;" to use it also for
     ` x e. y ` , as some authors occasionally do, is poor form and causes
     confusion, according to George Boolos (1992 lecture at MIT).

     This syntactical construction introduces a binary non-logical predicate
     symbol ` e. ` (epsilon) into our predicate calculus.  We will eventually
     use it for the membership predicate of set theory, but that is irrelevant
     at this point: the predicate calculus axioms for ` e. ` apply to any
     arbitrary binary predicate symbol.  "Non-logical" means that the predicate
     is presumed to have additional properties beyond the realm of predicate
     calculus, although these additional properties are not specified by
     predicate calculus itself but rather by the axioms of a theory (in our
     case set theory) added to predicate calculus.  "Binary" means that the
     predicate has two arguments.

     (Instead of introducing ~ wel as an axiomatic statement, as was done in an
     older version of this database, we introduce it by "proving" a special
     case of set theory's more general ~ wcel .  This lets us avoid overloading
     the ` e. ` connective, thus preventing ambiguity that would complicate
     certain Metamath parsers.  However, logically ~ wel is considered to be a
     primitive syntax, even though here it is artificially "derived" from
     ~ wcel .  Note:  To see the proof steps of this syntax proof, type "show
     proof wel /all" in the Metamath program.)  (Contributed by NM,
     24-Jan-2006.) $)
  wel $p wff x e. y $=
    ( cv wcel ) ACBCD $.
  $( --- End of patch to prevent connective overloading $)

  $( --- Start of old code before overloading prevention patch. $)
  $(
  @( Extend wff definition to include atomic formulas with the epsilon
     (membership) predicate.  This is read " ` x ` is an element of ` y ` ,"
     " ` x ` is a member of ` y ` ," " ` x ` belongs to ` y ` ," or " ` y `
     contains ` x ` ."  Note:  The phrase " ` y ` includes ` x ` " means
     " ` x ` is a subset of ` y ` "; to use it also for ` x e. y ` (as some
     authors occasionally do) is poor form and causes confusion.

     After we introduce ~ cv and ~ wcel in set theory, this syntax construction
     becomes redundant, since it can be derived with the proof
     "vx cv vy cv wcel". @)
  wel @a wff x e. y @.
  $)
  $( --- End of old code before overloading prevention patch. $)

  $( Axiom of Equality.  One of the equality and substitution axioms of
     predicate calculus with equality.  This is similar to, but not quite, a
     transitive law for equality (proved later as ~ equtr ).  Axiom scheme C8'
     in [Megill] p. 448 (p. 16 of the preprint).  Also appears as Axiom C7 of
     [Monk2] p. 105.

     Axioms ~ ax-8 through ~ ax-16 are the axioms having to do with equality,
     substitution, and logical properties of our binary predicate ` e. ` (which
     later in set theory will mean "is a member of").  Note that all axioms
     except ~ ax-16 and ~ ax-17 are still valid even when ` x ` , ` y ` , and
     ` z ` are replaced with the same variable because they do not have any
     distinct variable (Metamath's $d) restrictions.  Distinct variable
     restrictions are required for ~ ax-16 and ~ ax-17 only.  (Contributed by
     NM, 5-Aug-1993.) $)
  ax-8 $a |- ( x = y -> ( x = z -> y = z ) ) $.

  $( Axiom of Quantifier Substitution.  One of the equality and substitution
     axioms of predicate calculus with equality.  Appears as Lemma L12 in
     [Megill] p. 445 (p. 12 of the preprint).

     The original version of this axiom was ~ ax-10o ("o" for "old") and was
     replaced with this shorter ~ ax-10 in May 2008.  The old axiom is proved
     from this one as theorem ~ ax10o .  Conversely, this axiom is proved from
     ~ ax-10o as theorem ~ ax10 .  (Contributed by NM, 5-Aug-1993.) $)
  ax-10 $a |- ( A. x x = y -> A. y y = x ) $.

  $( Axiom of Variable Substitution.  One of the 5 equality axioms of predicate
     calculus.  The final consequent ` A. x ( x = y -> ph ) ` is a way of
     expressing " ` y ` substituted for ` x ` in wff ` ph ` " (cf. ~ sb6 ).  It
     is based on Lemma 16 of [Tarski] p. 70 and Axiom C8 of [Monk2] p. 105,
     from which it can be proved by cases.

     Variants of this axiom which are equivalent in classical logic but which
     have not been shown to be equivalent for intuitionistic logic are
     ~ ax11v , ~ ax11v2 and ~ ax-11o .  (Contributed by NM, 5-Aug-1993.) $)
  ax-11 $a |- ( x = y -> ( A. y ph -> A. x ( x = y -> ph ) ) ) $.

  $( Axiom of Quantifier Introduction.  One of the equality and substitution
     axioms of predicate calculus with equality.  Informally, it says that
     whenever ` z ` is distinct from ` x ` and ` y ` , and ` x = y ` is true,
     then ` x = y ` quantified with ` z ` is also true.  In other words, ` z `
     is irrelevant to the truth of ` x = y ` .  Axiom scheme C9' in [Megill]
     p. 448 (p. 16 of the preprint).  It apparently does not otherwise appear
     in the literature but is easily proved from textbook predicate calculus by
     cases.

     This axiom has been modified from the original ~ ax-12 for compatibility
     with intuitionistic logic.  (Contributed by Mario Carneiro,
     31-Jan-2015.) $)
  ax-i12 $a |- ( A. z z = x \/ ( A. z z = y \/
                 A. z ( x = y -> A. z x = y ) ) ) $.

  $( Axiom of bundling.  The general idea of this axiom is that two variables
     are either distinct or non-distinct.  That idea could be expressed as
     ` A. z z = x \/ -. A. z z = x ` .  However, we instead choose an axiom
     which has many of the same consequences, but which is different with
     respect to a universe which contains only one object. ` A. z z = x ` holds
     if ` z ` and ` x ` are the same variable, likewise for ` z ` and ` y ` ,
     and ` A. x A. z ( x = y -> A. z x = y ) ` holds if ` z ` is distinct from
     the others (and the universe has at least two objects).

     As with other statements of the form "x is decidable (either true or
     false)", this does not entail the full Law of the Excluded Middle (which
     is the proposition that all statements are decidable), but instead merely
     the assertion that particular kinds of statements are decidable (or in
     this case, an assertion similar to decidability).

     This axiom is similar to ~ ax-i12 , but appears to be stronger.  At least
     for now, we keep them both as distinct axioms, but they serve similar
     purposes.

     The reason we call this "bundling" is that a statement without a distinct
     variable constraint "bundles" together two statements, one in which the
     two variables are the same and one in which they are different.
     (Contributed by Mario Carneiro and Jim Kingdon, 14-Mar-2018.) $)
  ax-bnd $a |- ( A. z z = x \/ ( A. z z = y \/
                 A. x A. z ( x = y -> A. z x = y ) ) ) $.

  $( Axiom of Specialization.  A quantified wff implies the wff without a
     quantifier (i.e. an instance, or special case, of the generalized wff).
     In other words if something is true for all ` x ` , it is true for any
     specific ` x ` (that would typically occur as a free variable in the wff
     substituted for ` ph ` ).  (A free variable is one that does not occur in
     the scope of a quantifier: ` x ` and ` y ` are both free in ` x = y ` ,
     but only ` x ` is free in ` A. y x = y ` .)  Axiom scheme C5' in [Megill]
     p. 448 (p. 16 of the preprint).  Also appears as Axiom B5 of [Tarski]
     p. 67 (under his system S2, defined in the last paragraph on p. 77).

     Note that the converse of this axiom does not hold in general, but a
     weaker inference form of the converse holds and is expressed as rule
     ~ ax-gen .  Conditional forms of the converse are given by ~ ax-12 ,
     ~ ax-16 , and ~ ax-17 .

     Unlike the more general textbook Axiom of Specialization, we cannot choose
     a variable different from ` x ` for the special case.  For use, that
     requires the assistance of equality axioms, and we deal with it later
     after we introduce the definition of proper substitution - see ~ stdpc4 .

     (Contributed by NM, 5-Aug-1993.) $)
  ax-4 $a |- ( A. x ph -> ph ) $.

  $( Specialization.  Another name for ~ ax-4 .  (Contributed by NM,
     21-May-2008.) $)
  sp $p |- ( A. x ph -> ph ) $=
    ( ax-4 ) ABC $.

  $( Rederive the original version of the axiom from ~ ax-i12 .  (Contributed
     by Mario Carneiro, 3-Feb-2015.) $)
  ax-12 $p |- ( -. A. z z = x -> ( -. A. z z = y ->
              ( x = y -> A. z x = y ) ) ) $=
    ( cv wceq wal wn wi wo ax-i12 ori ord ax-4 syl6 ) CDZADZECFZGZOBDZECFZGPSEZ
    UACFHZCFZUBRTUCQTUCIABCJKLUBCMN $.

  $( Another name for ~ ax-i12 .  (Contributed by NM, 3-Feb-2015.) $)
  ax12or $p |- ( A. z z = x \/ ( A. z z = y \/
                 A. z ( x = y -> A. z x = y ) ) ) $=
    ( ax-i12 ) ABCD $.

  $( Axiom of Equality.  One of the equality and substitution axioms for a
     non-logical predicate in our predicate calculus with equality.  It
     substitutes equal variables into the left-hand side of the ` e. ` binary
     predicate.  Axiom scheme C12' in [Megill] p. 448 (p. 16 of the preprint).
     It is a special case of Axiom B8 (p. 75) of system S2 of [Tarski] p. 77.
     "Non-logical" means that the predicate is not a primitive of predicate
     calculus proper but instead is an extension to it.  "Binary" means that
     the predicate has two arguments.  In a system of predicate calculus with
     equality, like ours, equality is not usually considered to be a
     non-logical predicate.  In systems of predicate calculus without equality,
     it typically would be.  (Contributed by NM, 5-Aug-1993.) $)
  ax-13 $a |- ( x = y -> ( x e. z -> y e. z ) ) $.

  $( Axiom of Equality.  One of the equality and substitution axioms for a
     non-logical predicate in our predicate calculus with equality.  It
     substitutes equal variables into the right-hand side of the ` e. ` binary
     predicate.  Axiom scheme C13' in [Megill] p. 448 (p. 16 of the preprint).
     It is a special case of Axiom B8 (p. 75) of system S2 of [Tarski] p. 77.
     (Contributed by NM, 5-Aug-1993.) $)
  ax-14 $a |- ( x = y -> ( z e. x -> z e. y ) ) $.

  $( Bound-variable hypothesis builder for ` x = x ` .  This theorem tells us
     that any variable, including ` x ` , is effectively not free in
     ` x = x ` , even though ` x ` is technically free according to the
     traditional definition of free variable.  (The proof uses only ~ ax-5 ,
     ~ ax-8 , ~ ax-12 , and ~ ax-gen .  This shows that this can be proved
     without ~ ax-9 , even though the theorem ~ equid cannot be.  A shorter
     proof using ~ ax-9 is obtainable from ~ equid and ~ hbth .)  (Contributed
     by NM, 13-Jan-2011.)  (Proof shortened by Wolf Lammen, 23-Mar-2014.) $)
  hbequid $p |- ( x = x -> A. y x = x ) $=
    ( cv wceq wal wi wo ax12or ax-8 pm2.43i alimi a1d ax-4 jaoi ax-mp ) BCACZDZ
    BEZRPPDZSBEZFZBEZGZGUAAABHRUAUCRTSQSBQSBAAIJKLZRUAUBUDUABMNNO $.

  $( Commutation law for identical variable specifiers.  The antecedent and
     consequent are true when ` x ` and ` y ` are substituted with the same
     variable.  Lemma L12 in [Megill] p. 445 (p. 12 of the preprint).
     (Contributed by NM, 5-Aug-1993.) $)
  alequcom $p |- ( A. x x = y -> A. y y = x ) $=
    ( ax-10 ) ABC $.

  ${
    alequcoms.1 $e |- ( A. x x = y -> ph ) $.
    $( A commutation rule for identical variable specifiers.  (Contributed by
       NM, 5-Aug-1993.) $)
    alequcoms $p |- ( A. y y = x -> ph ) $=
      ( weq wal alequcom syl ) CBECFBCEBFACBGDH $.
  $}

  ${
    nalequcoms.1 $e |- ( -. A. x x = y -> ph ) $.
    $( A commutation rule for distinct variable specifiers.  (Contributed by
       NM, 2-Jan-2002.)  (Revised by Mario Carneiro, 2-Feb-2015.) $)
    nalequcoms $p |- ( -. A. y y = x -> ph ) $=
      ( cv wceq wal wn alequcom con3i syl ) CEZBEZFCGZHMLFBGZHAONBCIJDK $.
  $}

  $( Consequence of the definition of not-free.  (Contributed by Mario
     Carneiro, 26-Sep-2016.) $)
  nfr $p |- ( F/ x ph -> ( ph -> A. x ph ) ) $=
    ( wnf wal wi df-nf sp sylbi ) ABCAABDEZBDIABFIBGH $.

  ${
    nfri.1 $e |- F/ x ph $.
    $( Consequence of the definition of not-free.  (Contributed by Mario
       Carneiro, 11-Aug-2016.) $)
    nfri $p |- ( ph -> A. x ph ) $=
      ( wnf wal wi nfr ax-mp ) ABDAABEFCABGH $.
  $}

  ${
    nfrd.1 $e |- ( ph -> F/ x ps ) $.
    $( Consequence of the definition of not-free in a context.  (Contributed by
       Mario Carneiro, 11-Aug-2016.) $)
    nfrd $p |- ( ph -> ( ps -> A. x ps ) ) $=
      ( wnf wal wi nfr syl ) ABCEBBCFGDBCHI $.
  $}

  ${
    alimd.1 $e |- F/ x ph $.
    alimd.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.20 of [Margaris] p. 90.  (Contributed by Mario
       Carneiro, 24-Sep-2016.) $)
    alimd $p |- ( ph -> ( A. x ps -> A. x ch ) ) $=
      ( nfri alimdh ) ABCDADEGFH $.
  $}

  ${
    alrimi.1 $e |- F/ x ph $.
    alrimi.2 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Contributed by Mario
       Carneiro, 24-Sep-2016.) $)
    alrimi $p |- ( ph -> A. x ps ) $=
      ( nfri alrimih ) ABCACDFEG $.
  $}

  ${
    nfd.1 $e |- F/ x ph $.
    nfd.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Deduce that ` x ` is not free in ` ps ` in a context.  (Contributed by
       Mario Carneiro, 24-Sep-2016.) $)
    nfd $p |- ( ph -> F/ x ps ) $=
      ( wal wi wnf nfri alrimih df-nf sylibr ) ABBCFGZCFBCHAMCACDIEJBCKL $.
  $}

  ${
    nfdh.1 $e |- ( ph -> A. x ph ) $.
    nfdh.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Deduce that ` x ` is not free in ` ps ` in a context.  (Contributed by
       Mario Carneiro, 24-Sep-2016.) $)
    nfdh $p |- ( ph -> F/ x ps ) $=
      ( nfi nfd ) ABCACDFEG $.
  $}

  ${
    nfrimi.1 $e |- F/ x ph $.
    nfrimi.2 $e |- F/ x ( ph -> ps ) $.
    $( Moving an antecedent outside ` F/ ` .  (Contributed by Jim Kingdon,
       23-Mar-2018.) $)
    nfrimi $p |- ( ph -> F/ x ps ) $=
      ( wal wi nfri ax-5 syl2im pm2.86i nfd ) ABCDABBCFZABGZNCFAACFMNCEHACDHABC
      IJKL $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Axiom ax-17 - first use of the $d distinct variable statement
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    $d x ph $.
    $( Axiom to quantify a variable over a formula in which it does not occur.
       Axiom C5 in [Megill] p. 444 (p. 11 of the preprint).  Also appears as
       Axiom B6 (p. 75) of system S2 of [Tarski] p. 77 and Axiom C5-1 of
       [Monk2] p. 113.

       (Contributed by NM, 5-Aug-1993.) $)
    ax-17 $a |- ( ph -> A. x ph ) $.
  $}

  ${
    $d x ps $.
    $( ~ ax-17 with antecedent.  (Contributed by NM, 1-Mar-2013.) $)
    a17d $p |- ( ph -> ( ps -> A. x ps ) ) $=
      ( wal wi ax-17 a1i ) BBCDEABCFG $.
  $}

  ${
    $d x ph $.
    $( If ` x ` is not present in ` ph ` , then ` x ` is not free in ` ph ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfv $p |- F/ x ph $=
      ( ax-17 nfi ) ABABCD $.
  $}

  ${
    $d x ps $.
    $( ~ nfv with antecedent.  Useful in proofs of deduction versions of
       bound-variable hypothesis builders such as ~ nfimd .  (Contributed by
       Mario Carneiro, 6-Oct-2016.) $)
    nfvd $p |- ( ph -> F/ x ps ) $=
      ( wnf nfv a1i ) BCDABCEF $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Introduce Axiom of Existence
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Axiom of Existence.  One of the equality and substitution axioms of
     predicate calculus with equality.  One thing this axiom tells us is that
     at least one thing exists (although ~ ax-4 and possibly others also tell
     us that, i.e. they are not valid in the empty domain of a "free logic").
     In this form (not requiring that ` x ` and ` y ` be distinct) it was used
     in an axiom system of Tarski (see Axiom B7' in footnote 1 of
     [KalishMontague] p. 81.)  Another name for this theorem is ~ a9e , which
     has additional remarks.  (Contributed by Mario Carneiro, 31-Jan-2015.) $)
  ax-i9 $a |- E. x x = y $.

  $( Derive ~ ax-9 from ~ ax-i9 , the modified version for intuitionistic
     logic.  Although ~ ax-9 does hold intuistionistically, in intuitionistic
     logic it is weaker than ~ ax-i9 .  (Contributed by NM, 3-Feb-2015.) $)
  ax-9 $p |- -. A. x -. x = y $=
    ( cv wceq wn wal wex ax-i9 notnoti alnex mtbir ) ACBCDZEAFLAGZEMABHILAJK $.

  $( ~ equid with some quantification and negation without using ~ ax-4 or
     ~ ax-17 .  (Contributed by NM, 13-Jan-2011.)  (Proof shortened by Wolf
     Lammen, 27-Feb-2014.) $)
  equidqe $p |- -. A. y -. x = x $=
    ( weq wn wal ax-9 ax-8 pm2.43i con3i alimi mto ) AACZDZBEBACZDZBEBAFMOBNLNL
    BAAGHIJK $.

  $( Obsolete proof of ~ equidqe as of 27-Feb-2014.  (Contributed by NM,
     13-Jan-2011.) $)
  equidqeOLD $p |- -. A. y -. x = x $=
    ( weq wn wal ax-9 wi ax-8 pm2.43i con3i ax-gen ax-5 ax-mp mto ) AACZDZBEZBA
    CZDZBEZBAFPSGZBEQTGUABROROBAAHIJKPSBLMN $.

  $( A special case of ~ ax-4 without using ~ ax-4 or ~ ax-17 .  (Contributed
     by NM, 13-Jan-2011.) $)
  ax4sp1 $p |- ( A. y -. x = x -> -. x = x ) $=
    ( weq wn wal equidqe pm2.21i ) AACDZBEHABFG $.


$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Additional intuitionistic axioms
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( ` x ` is not free in ` A. x ph ` .  Axiom 7 of 10 for intuitionistic
     logic.  (Contributed by Mario Carneiro, 31-Jan-2015.) $)
  ax-ial $a |- ( A. x ph -> A. x A. x ph ) $.

  $( Axiom of quantifier collection.  (Contributed by Mario Carneiro,
     31-Jan-2015.) $)
  ax-i5r $a |- ( ( A. x ph -> A. x ps ) -> A. x ( A. x ph -> ps ) ) $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    Predicate calculus including ax-4, without distinct variables
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)


  ${
    a4i.1 $e |- A. x ph $.
    $( Inference rule reversing generalization.  (Contributed by NM,
       5-Aug-1993.) $)
    a4i $p |- ph $=
      ( wal ax-4 ax-mp ) ABDACABEF $.
  $}

  ${
    sps.1 $e |- ( ph -> ps ) $.
    $( Generalization of antecedent.  (Contributed by NM, 5-Aug-1993.) $)
    sps $p |- ( A. x ph -> ps ) $=
      ( wal sp syl ) ACEABACFDG $.
  $}

  ${
    spsd.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction generalizing antecedent.  (Contributed by NM, 17-Aug-1994.) $)
    spsd $p |- ( ph -> ( A. x ps -> ch ) ) $=
      ( wal sp syl5 ) BDFBACBDGEH $.
  $}

  ${
    nfbidf.1 $e |- F/ x ph $.
    nfbidf.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( An equality theorem for effectively not free.  (Contributed by Mario
       Carneiro, 4-Oct-2016.) $)
    nfbidf $p |- ( ph -> ( F/ x ps <-> F/ x ch ) ) $=
      ( wal wi wnf nfri albidh imbi12d df-nf 3bitr4g ) ABBDGZHZDGCCDGZHZDGBDICDI
      APRDADEJZABCOQFABCDSFKLKBDMCDMN $.
  $}

  $( ` x ` is not free in ` A. x ph ` .  Example in Appendix in [Megill] p. 450
     (p. 19 of the preprint).  Also Lemma 22 of [Monk2] p. 114.  (Contributed
     by NM, 5-Aug-1993.) $)
  hba1 $p |- ( A. x ph -> A. x A. x ph ) $=
    ( ax-ial ) ABC $.

  $( ` x ` is not free in ` A. x ph ` .  (Contributed by Mario Carneiro,
     11-Aug-2016.) $)
  nfa1 $p |- F/ x A. x ph $=
    ( wal hba1 nfi ) ABCBABDE $.

  ${
    a5i.1 $e |- ( A. x ph -> ps ) $.
    $( Inference generalizing a consequent.  (Contributed by NM,
       5-Aug-1993.) $)
    a5i $p |- ( A. x ph -> A. x ps ) $=
      ( wal wi hba1 ax-5 syl5 mpg ) ACEZBFZKBCEZFCKKCELCEMACGKBCHIDJ $.
  $}

  $( ` x ` is not free in ` F/ x ph ` .  (Contributed by Mario Carneiro,
     11-Aug-2016.) $)
  nfnf1 $p |- F/ x F/ x ph $=
    ( wnf wal wi df-nf nfa1 nfxfr ) ABCAABDEZBDBABFIBGH $.

  ${
    hb.1 $e |- ( ph -> A. x ph ) $.
    hb.2 $e |- ( ps -> A. x ps ) $.
    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph -> ps ) ` .  (Contributed by NM, 5-Aug-1993.)  (Proof shortened
       by O'Cat, 3-Mar-2008.)  (Revised by Mario Carneiro, 2-Feb-2015.) $)
    hbim $p |- ( ( ph -> ps ) -> A. x ( ph -> ps ) ) $=
      ( wi wal ax-4 imim12i ax-i5r imim1i alimi 3syl ) ABFZACGZBCGZFOBFZCGNCGOA
      BPACHEIABCJQNCAOBDKLM $.

    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph \/ ps ) ` .  (Contributed by NM, 5-Aug-1993.)  (Revised by NM,
       2-Feb-2015.) $)
    hbor $p |- ( ( ph \/ ps ) -> A. x ( ph \/ ps ) ) $=
      ( wo wal orc alimi syl olc jaoi ) AABFZCGZBAACGNDAMCABHIJBBCGNEBMCBAKIJL
      $.

    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph /\ ps ) ` .  (Contributed by NM, 5-Aug-1993.)  (Proof shortened
       by Mario Carneiro, 2-Feb-2015.) $)
    hban $p |- ( ( ph /\ ps ) -> A. x ( ph /\ ps ) ) $=
      ( wa wal anim12i 19.26 sylibr ) ABFZACGZBCGZFKCGALBMDEHABCIJ $.

    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph <-> ps ) ` .  (Contributed by NM, 5-Aug-1993.) $)
    hbbi $p |- ( ( ph <-> ps ) -> A. x ( ph <-> ps ) ) $=
      ( wb wi wa dfbi2 hbim hban hbxfrbi ) ABFABGZBAGZHCABIMNCABCDEJBACEDJKL $.

    hb.3 $e |- ( ch -> A. x ch ) $.
    $( If ` x ` is not free in ` ph ` , ` ps ` , and ` ch ` , it is not free in
       ` ( ph \/ ps \/ ch ) ` .  (Contributed by NM, 14-Sep-2003.) $)
    hb3or $p |- ( ( ph \/ ps \/ ch ) -> A. x ( ph \/ ps \/ ch ) ) $=
      ( w3o wo df-3or hbor hbxfrbi ) ABCHABIZCIDABCJMCDABDEFKGKL $.

    $( If ` x ` is not free in ` ph ` , ` ps ` , and ` ch ` , it is not free in
       ` ( ph /\ ps /\ ch ) ` .  (Contributed by NM, 14-Sep-2003.) $)
    hb3an $p |- ( ( ph /\ ps /\ ch ) -> A. x ( ph /\ ps /\ ch ) ) $=
      ( w3a wa df-3an hban hbxfrbi ) ABCHABIZCIDABCJMCDABDEFKGKL $.
  $}

  $( Lemma 24 of [Monk2] p. 114.  (Contributed by NM, 29-May-2008.) $)
  hba2 $p |- ( A. y A. x ph -> A. x A. y A. x ph ) $=
    ( wal hba1 hbal ) ABDBCABEF $.

  $( Lemma 23 of [Monk2] p. 114.  (Contributed by NM, 29-May-2008.) $)
  hbia1 $p |- ( ( A. x ph -> A. x ps ) -> A. x ( A. x ph -> A. x ps ) ) $=
    ( wal hba1 hbim ) ACDBCDCACEBCEF $.

  ${
    19.3h.1 $e |- ( ph -> A. x ph ) $.
    $( A wff may be quantified with a variable not free in it.  Theorem 19.3 of
       [Margaris] p. 89.  (Contributed by NM, 5-Aug-1993.)  (Revised by NM,
       21-May-2007.) $)
    19.3h $p |- ( A. x ph <-> ph ) $=
      ( wal ax-4 impbii ) ABDAABECF $.
  $}

  ${
    19.3.1 $e |- F/ x ph $.
    $( A wff may be quantified with a variable not free in it.  Theorem 19.3 of
       [Margaris] p. 89.  (Contributed by NM, 5-Aug-1993.)  (Revised by Mario
       Carneiro, 24-Sep-2016.) $)
    19.3 $p |- ( A. x ph <-> ph ) $=
      ( wal sp nfri impbii ) ABDAABEABCFG $.
  $}

  ${
    19.16.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.16 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.16 $p |- ( A. x ( ph <-> ps ) -> ( ph <-> A. x ps ) ) $=
      ( wal wb 19.3h albi syl5bbr ) AACEABFCEBCEACDGABCHI $.
  $}

  ${
    19.17.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.17 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.17 $p |- ( A. x ( ph <-> ps ) -> ( A. x ph <-> ps ) ) $=
      ( wb wal albi 19.3h syl6bb ) ABECFACFBCFBABCGBCDHI $.
  $}

  ${
    19.21h.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.21 of [Margaris] p. 90.  The hypothesis can be thought of
       as " ` x ` is not free in ` ph ` ."  (Contributed by NM, 5-Aug-1993.)
       (New usage is discouraged.) $)
    19.21h $p |- ( A. x ( ph -> ps ) <-> ( ph -> A. x ps ) ) $=
      ( wi wal alim syl5 hba1 hbim ax-4 imim2i alrimih impbii ) ABEZCFZABCFZEZAA
      CFPQDABCGHROCAQCDBCIJQBABCKLMN $.
  $}

  ${
    19.21-2.1 $e |- ( ph -> A. x ph ) $.
    19.21-2.2 $e |- ( ph -> A. y ph ) $.
    $( Theorem 19.21 of [Margaris] p. 90 but with 2 quantifiers.  (Contributed
       by NM, 4-Feb-2005.) $)
    19.21-2 $p |- ( A. x A. y ( ph -> ps ) <-> ( ph -> A. x A. y ps ) ) $=
      ( wi wal 19.21h albii bitri ) ABGDHZCHABDHZGZCHAMCHGLNCABDFIJAMCEIK $.
  $}

  ${
    stdpc5.1 $e |- ( ph -> A. x ph ) $.
    $( An axiom scheme of standard predicate calculus that emulates Axiom 5 of
       [Mendelson] p. 69.  The hypothesis ` ( ph -> A. x ph ) ` can be thought
       of as emulating " ` x ` is not free in ` ph ` ."  With this convention,
       the meaning of "not free" is less restrictive than the usual textbook
       definition; for example ` x ` would not (for us) be free in ` x = x ` by
       ~ hbequid .  This theorem scheme can be proved as a metatheorem of
       Mendelson's axiom system, even though it is slightly stronger than his
       Axiom 5.  (Contributed by NM, 22-Sep-1993.) $)
    stdpc5 $p |- ( A. x ( ph -> ps ) -> ( ph -> A. x ps ) ) $=
      ( wi wal 19.21h biimpi ) ABECFABCFEABCDGH $.
  $}

  ${
    19.21bi.1 $e |- ( ph -> A. x ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.21bi $p |- ( ph -> ps ) $=
      ( wal ax-4 syl ) ABCEBDBCFG $.
  $}

  ${
    19.21bbi.1 $e |- ( ph -> A. x A. y ps ) $.
    $( Inference removing double quantifier.  (Contributed by NM,
       20-Apr-1994.) $)
    19.21bbi $p |- ( ph -> ps ) $=
      ( wal 19.21bi ) ABDABDFCEGG $.
  $}

  ${
    19.27.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.27 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.27 $p |- ( A. x ( ph /\ ps ) <-> ( A. x ph /\ ps ) ) $=
      ( wa wal 19.26 19.3h anbi2i bitri ) ABECFACFZBCFZEKBEABCGLBKBCDHIJ $.
  $}

  ${
    19.28.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.28 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.28 $p |- ( A. x ( ph /\ ps ) <-> ( ph /\ A. x ps ) ) $=
      ( wa wal 19.26 19.3h anbi1i bitri ) ABECFACFZBCFZEALEABCGKALACDHIJ $.
  $}

  ${
    nfan1.1 $e |- F/ x ph $.
    nfan1.2 $e |- ( ph -> F/ x ps ) $.
    $( A closed form of ~ nfan .  (Contributed by Mario Carneiro,
       3-Oct-2016.) $)
    nfan1 $p |- F/ x ( ph /\ ps ) $=
      ( wa wal nfrd imdistani nfri 19.28 sylibr nfi ) ABFZCNABCGZFNCGABOABCEHIA
      BCACDJKLM $.
  $}

  ${
    nfan.1 $e |- F/ x ph $.
    nfan.2 $e |- F/ x ps $.
    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph /\ ps ) ` .  (Contributed by Mario Carneiro, 11-Aug-2016.)
       (Proof shortened by Wolf Lammen, 13-Jan-2018.) $)
    nfan $p |- F/ x ( ph /\ ps ) $=
      ( wnf a1i nfan1 ) ABCDBCFAEGH $.

    nfan.3 $e |- F/ x ch $.
    $( If ` x ` is not free in ` ph ` , ` ps ` , and ` ch ` , it is not free in
       ` ( ph /\ ps /\ ch ) ` .  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nf3an $p |- F/ x ( ph /\ ps /\ ch ) $=
      ( w3a wa df-3an nfan nfxfr ) ABCHABIZCIDABCJMCDABDEFKGKL $.
  $}

  ${
    nfand.1 $e |- ( ph -> F/ x ps ) $.
    nfand.2 $e |- ( ph -> F/ x ch ) $.
    $( If in a context ` x ` is not free in ` ps ` and ` ch ` , it is not free
       in ` ( ps /\ ch ) ` .  (Contributed by Mario Carneiro, 7-Oct-2016.) $)
    nfand $p |- ( ph -> F/ x ( ps /\ ch ) ) $=
      ( wa wal wi wnf jca df-nf anbi12i 19.26 bitr4i prth alimi sylbi
      syl6ibr syl sylibr ) ABCGZUBDHZIZDHZUBDJABDJZCDJZGZUEAUFUGEFKUH
      BBDHZIZCCDHZIZGZDHZUEUHUJDHZULDHZGUNUFUOUGUPBDLCDLMUJULDNOUMUDD
      UMUBUIUKGUCBUICUKPBCDNSQRTUBDLUA $.

    nfand.3 $e |- ( ph -> F/ x th ) $.
    $( Deduction form of bound-variable hypothesis builder ~ nf3an .
       (Contributed by NM, 17-Feb-2013.)  (Revised by Mario Carneiro,
       16-Oct-2016.) $)
    nf3and $p |- ( ph -> F/ x ( ps /\ ch /\ th ) ) $=
      ( w3a wa df-3an nfand nfxfrd ) BCDIBCJZDJAEBCDKANDEABCEFGLHLM $.
  $}

  ${
    hbim1.1 $e |- ( ph -> A. x ph ) $.
    hbim1.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( A closed form of ~ hbim .  (Contributed by NM, 5-Aug-1993.) $)
    hbim1 $p |- ( ( ph -> ps ) -> A. x ( ph -> ps ) ) $=
      ( wi wal a2i 19.21h sylibr ) ABFZABCGZFKCGABLEHABCDIJ $.
  $}

  ${
    nfim1.1 $e |- F/ x ph $.
    nfim1.2 $e |- ( ph -> F/ x ps ) $.
    $( A closed form of ~ nfim .  (Contributed by NM, 5-Aug-1993.)  (Revised by
       Mario Carneiro, 24-Sep-2016.)  (Proof shortened by Wolf Lammen,
       2-Jan-2018.) $)
    nfim1 $p |- F/ x ( ph -> ps ) $=
      ( wi nfri nfrd hbim1 nfi ) ABFCABCACDGABCEHIJ $.
  $}

  ${
    nfim.1 $e |- F/ x ph $.
    nfim.2 $e |- F/ x ps $.
    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph -> ps ) ` .  (Contributed by Mario Carneiro, 11-Aug-2016.)
       (Proof shortened by Wolf Lammen, 2-Jan-2018.) $)
    nfim $p |- F/ x ( ph -> ps ) $=
      ( wnf a1i nfim1 ) ABCDBCFAEGH $.
  $}

  ${
    hbimd.1 $e |- ( ph -> A. x ph ) $.
    hbimd.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    hbimd.3 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hbim .
       (Contributed by NM, 1-Jan-2002.)  (Revised by NM, 2-Feb-2015.) $)
    hbimd $p |- ( ph -> ( ( ps -> ch ) -> A. x ( ps -> ch ) ) ) $=
      ( wi wal imim2d ax-4 imim1i ax-i5r syl syl6 imim1d alimdh syld ) ABCHZBDIZ
      CHZDIZSDIASBCDIZHZUBACUCBGJUDTUCHUBTBUCBDKLBCDMNOAUASDEABTCFPQR $.
  $}

  ${
    nfor.1 $e |- F/ x ph $.
    nfor.2 $e |- F/ x ps $.
    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph \/ ps ) ` .  (Contributed by Jim Kingdon, 11-Mar-2018.) $)
    nfor $p |- F/ x ( ph \/ ps ) $=
      ( wo nfri hbor nfi ) ABFCABCACDGBCEGHI $.
  $}

  ${
    hbbid.1 $e |- ( ph -> A. x ph ) $.
    hbbid.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    hbbid.3 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hbbi .
       (Contributed by NM, 1-Jan-2002.) $)
    hbbid $p |- ( ph -> ( ( ps <-> ch ) -> A. x ( ps <-> ch ) ) ) $=
      ( wi wa wal wb hbimd anim12d dfbi2 albiim 3imtr4g ) ABCHZCBHZIQDJZRDJZIBC
      KZUADJAQSRTABCDEFGLACBDEGFLMBCNBCDOP $.
  $}

  ${
    nfal.1 $e |- F/ x ph $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` A. y ph ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfal $p |- F/ x A. y ph $=
      ( wal nfri hbal nfi ) ACEBABCABDFGH $.

    $( If ` x ` is not free in ` ph ` , it is not free in ` F/ y ph ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.)  (Proof shortened by Wolf
       Lammen, 30-Dec-2017.) $)
    nfnf $p |- F/ x F/ y ph $=
      ( wnf wal wi df-nf nfal nfim nfxfr ) ACEAACFZGZCFBACHMBCALBDABCDIJIK $.
  $}

  $( Closed form of ~ nfal .  (Contributed by Jim Kingdon, 11-May-2018.) $)
  nfalt $p |- ( A. y F/ x ph -> F/ x A. y ph ) $=
    ( wal wi wnf alim alcom syl6ib alimi df-nf albii bitri 3imtr4i ) AABDZEZCDZ
    BDZACDZSBDZEZBDABFZCDZSBFQUABQSOCDTAOCGACBHIJUCPBDZCDRUBUDCABKLPCBHMSBKN $.

  $( Lemma 24 of [Monk2] p. 114.  (Contributed by Mario Carneiro,
     24-Sep-2016.) $)
  nfa2 $p |- F/ x A. y A. x ph $=
    ( wal nfa1 nfal ) ABDBCABEF $.

  $( Lemma 23 of [Monk2] p. 114.  (Contributed by Mario Carneiro,
     24-Sep-2016.) $)
  nfia1 $p |- F/ x ( A. x ph -> A. x ps ) $=
    ( wal nfa1 nfim ) ACDBCDCACEBCEF $.

  $( Closed form of Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
     27-May-1997.)  (New usage is discouraged.) $)
  19.21ht $p |- ( A. x ( ph -> A. x ph ) ->
               ( A. x ( ph -> ps ) <-> ( ph -> A. x ps ) ) ) $=
    ( wal wi alim imim2d com12 sps hba1 ax-4 a1i hbimd imim2i alimi syl6 impbid
    ) AACDZEZCDZABEZCDZABCDZEZSUBUDECUBSUDUBRUCAABCFGHITUDUDCDUBTAUCCSCJSCKUCUC
    CDETBCJLMUDUACUCBABCKNOPQ $.

  $( Closed form of Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
     27-May-1997.) $)
  19.21t $p |- ( F/ x ph ->
               ( A. x ( ph -> ps ) <-> ( ph -> A. x ps ) ) ) $=
    ( wnf wal wi wb df-nf 19.21ht sylbi ) ACDAACEFCEABFCEABCEFGACHABCIJ $.

  ${
    19.21.1 $e |- F/ x ph $.
    $( Theorem 19.21 of [Margaris] p. 90.  The hypothesis can be thought of
       as " ` x ` is not free in ` ph ` ."  (Contributed by NM, 5-Aug-1993.)
       (Revised by Mario Carneiro, 24-Sep-2016.) $)
    19.21 $p |- ( A. x ( ph -> ps ) <-> ( ph -> A. x ps ) ) $=
      ( wnf wi wal wb 19.21t ax-mp ) ACEABFCGABCGFHDABCIJ $.
  $}

  ${
    nfimd.1 $e |- ( ph -> F/ x ps ) $.
    nfimd.2 $e |- ( ph -> F/ x ch ) $.
    $( If in a context ` x ` is not free in ` ps ` and ` ch ` , it is not free
       in ` ( ps -> ch ) ` .  (Contributed by Mario Carneiro, 24-Sep-2016.)
       (Proof shortened by Wolf Lammen, 30-Dec-2017.) $)
    nfimd $p |- ( ph -> F/ x ( ps -> ch ) ) $=
      ( wnf wal nfnf1 nfri nfr imim2d 19.21t biimprd syl9r alrimdh df-nf syl6ibr
      wi sylc ) ABDGZCDGZBCSZDGZEFUAUBUCUCDHZSZDHUDUAUBUFDUADBDIJUBDCDIJUBUCBCD
      HZSZUAUEUBCUGBCDKLUAUEUHBCDMNOPUCDQRT $.
  $}

  ${
    aaan.1 $e |- ( ph -> A. y ph ) $.
    aaan.2 $e |- ( ps -> A. x ps ) $.
    $( Rearrange universal quantifiers.  (Contributed by NM, 12-Aug-1993.) $)
    aaan $p |- ( A. x A. y ( ph /\ ps ) <-> ( A. x ph /\ A. y ps ) ) $=
      ( wa wal 19.28 albii hbal 19.27 bitri ) ABGDHZCHABDHZGZCHACHOGNPCABDEIJAO
      CBCDFKLM $.
  $}

  ${
    nfbid.1 $e |- ( ph -> F/ x ps ) $.
    nfbid.2 $e |- ( ph -> F/ x ch ) $.
    $( If in a context ` x ` is not free in ` ps ` and ` ch ` , it is not free
       in ` ( ps <-> ch ) ` .  (Contributed by Mario Carneiro, 24-Sep-2016.)
       (Proof shortened by Wolf Lammen, 29-Dec-2017.) $)
    nfbid $p |- ( ph -> F/ x ( ps <-> ch ) ) $=
      ( wb wi wa dfbi2 nfimd nfand nfxfrd ) BCGBCHZCBHZIADBCJANODABCDEFKACBDFEK
      LM $.
  $}

  ${
    nfbi.1 $e |- F/ x ph $.
    nfbi.2 $e |- F/ x ps $.
    $( If ` x ` is not free in ` ph ` and ` ps ` , it is not free in
       ` ( ph <-> ps ) ` .  (Contributed by Mario Carneiro, 11-Aug-2016.)
       (Proof shortened by Wolf Lammen, 2-Jan-2018.) $)
    nfbi $p |- F/ x ( ph <-> ps ) $=
      ( wb wnf wtru a1i nfbid trud ) ABFCGHABCACGHDIBCGHEIJK $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                    The existential quantifier
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( If a wff is true, it is true for at least one instance.  Special case of
     Theorem 19.8 of [Margaris] p. 89.  (Contributed by NM, 5-Aug-1993.) $)
  19.8a $p |- ( ph -> E. x ph ) $=
    ( wex wi wal id hbe1 19.23 mpbir a4i ) AABCZDZBLBEKKDKFAKBABGHIJ $.

  ${
    19.23bi.1 $e |- ( E. x ph -> ps ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.23bi $p |- ( ph -> ps ) $=
      ( wex 19.8a syl ) AACEBACFDG $.
  $}

  ${
    exlimih.1 $e |- ( ps -> A. x ps ) $.
    exlimih.2 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Andrew Salmon, 13-May-2011.) $)
    exlimih $p |- ( E. x ph -> ps ) $=
      ( wi wex 19.23 mpgbi ) ABFACGBFCABCDHEI $.
  $}

  ${
    exlimi.1 $e |- F/ x ps $.
    exlimi.2 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Contributed by Mario
       Carneiro, 24-Sep-2016.) $)
    exlimi $p |- ( E. x ph -> ps ) $=
      ( nfri exlimih ) ABCBCDFEG $.
  $}

  ${
    exlimd2.1 $e |- ( ph -> A. x ph ) $.
    exlimd2.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    exlimd2.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.23 of [Margaris] p. 90.  Similar to ~ exlimdh
       but with one slightly different hypothesis.  (Contributed by Jim
       Kingdon, 30-Dec-2017.) $)
    exlimd2 $p |- ( ph -> ( E. x ps -> ch ) ) $=
      ( wal wi wex alrimih 19.23ht biimpd sylc ) ACCDHIZDHZBCIZDHZBDJCI
      ZAODEFKAQDEGKPRSBCDLMN $.
  $}

  ${
    exlimdh.1 $e |- ( ph -> A. x ph ) $.
    exlimdh.2 $e |- ( ch -> A. x ch ) $.
    exlimdh.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       28-Jan-1997.) $)
    exlimdh $p |- ( ph -> ( E. x ps -> ch ) ) $=
      ( wi wal wex alrimih 19.23 sylib ) ABCHZDIBDJCHANDEGKBCDFLM $.
  $}

  ${
    exlimd.1 $e |- F/ x ph $.
    exlimd.2 $e |- F/ x ch $.
    exlimd.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.9 of [Margaris] p. 89.  (Contributed by Mario
       Carneiro, 24-Sep-2016.)  (Proof rewritten by Jim Kingdon,
       18-Jun-2018.) $)
    exlimd $p |- ( ph -> ( E. x ps -> ch ) ) $=
      ( nfri exlimdh ) ABCDADEHCDFHGI $.
  $}

  ${
    $d x ps $.
    exlimiv.1 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.

       This inference, along with our many variants is used to implement a
       metatheorem called "Rule C" that is given in many logic textbooks.  See,
       for example, Rule C in [Mendelson] p. 81, Rule C in [Margaris] p. 40, or
       Rule C in Hirst and Hirst's _A Primer for Logic and Proof_ p. 59 (PDF
       p. 65) at ~ http://www.mathsci.appstate.edu/~~jlh/primer/hirst.pdf .

       In informal proofs, the statement "Let C be an element such that..."
       almost always means an implicit application of Rule C.

       In essence, Rule C states that if we can prove that some element ` x `
       exists satisfying a wff, i.e. ` E. x ph ( x ) ` where ` ph ( x ) ` has
       ` x ` free, then we can use ` ph ( ` C ` ) ` as a hypothesis for the
       proof where C is a new (ficticious) constant not appearing previously in
       the proof, nor in any axioms used, nor in the theorem to be proved.  The
       purpose of Rule C is to get rid of the existential quantifier.

       We cannot do this in Metamath directly.  Instead, we use the original
       ` ph ` (containing ` x ` ) as an antecedent for the main part of the
       proof.  We eventually arrive at ` ( ph -> ps ) ` where ` ps ` is the
       theorem to be proved and does not contain ` x ` .  Then we apply
       ~ exlimiv to arrive at ` ( E. x ph -> ps ) ` .  Finally, we separately
       prove ` E. x ph ` and detach it with modus ponens ~ ax-mp to arrive at
       the final theorem ` ps ` .  (Contributed by NM, 5-Aug-1993.)  (Revised
       by NM, 25-Jul-2012.) $)
    exlimiv $p |- ( E. x ph -> ps ) $=
      ( ax-17 exlimih ) ABCBCEDF $.
  $}

  $( Theorem 19.22 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by Wolf Lammen, 4-Jul-2014.) $)
  exim $p |- ( A. x ( ph -> ps ) -> ( E. x ph -> E. x ps ) ) $=
    ( wi wal wex hba1 hbe1 19.8a imim2i sps exlimdh ) ABDZCEABCFZCMCGBCHMANDCBNA
    BCIJKL $.

  ${
    eximi.1 $e |- ( ph -> ps ) $.
    $( Inference adding existential quantifier to antecedent and consequent.
       (Contributed by NM, 5-Aug-1993.) $)
    eximi $p |- ( E. x ph -> E. x ps ) $=
      ( wi wex exim mpg ) ABEACFBCFECABCGDH $.

    $( Inference adding 2 existential quantifiers to antecedent and
       consequent.  (Contributed by NM, 3-Feb-2005.) $)
    2eximi $p |- ( E. x E. y ph -> E. x E. y ps ) $=
      ( wex eximi ) ADFBDFCABDEGG $.
  $}

  ${
    eximii.1 $e |- E. x ph $.
    eximii.2 $e |- ( ph -> ps ) $.
    $( Inference associated with ~ eximi .  (Contributed by BJ, 3-Feb-2018.) $)
    eximii $p |- E. x ps $=
      ( wex eximi ax-mp ) ACFBCFDABCEGH $.
  $}

  $( A transformation of quantifiers and logical connectives.  (Contributed by
     NM, 19-Aug-1993.) $)
  alinexa $p |- ( A. x ( ph -> -. ps ) <-> -. E. x ( ph /\ ps ) ) $=
    ( wn wi wal wa wex imnan albii alnex bitri ) ABDEZCFABGZDZCFNCHDMOCABIJNCKL
    $.

  $( Theorem 19.18 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  exbi $p |- ( A. x ( ph <-> ps ) -> ( E. x ph <-> E. x ps ) ) $=
    ( wb wal wex wi bi1 alimi exim syl bi2 impbid ) ABDZCEZACFZBCFZOABGZCEPQGNR
    CABHIABCJKOBAGZCEQPGNSCABLIBACJKM $.

  ${
    exbii.1 $e |- ( ph <-> ps ) $.
    $( Inference adding existential quantifier to both sides of an
       equivalence.  (Contributed by NM, 24-May-1994.) $)
    exbii $p |- ( E. x ph <-> E. x ps ) $=
      ( wb wex exbi mpg ) ABEACFBCFECABCGDH $.

    $( Inference adding 2 existential quantifiers to both sides of an
       equivalence.  (Contributed by NM, 16-Mar-1995.) $)
    2exbii $p |- ( E. x E. y ph <-> E. x E. y ps ) $=
      ( wex exbii ) ADFBDFCABDEGG $.

    $( Inference adding 3 existential quantifiers to both sides of an
       equivalence.  (Contributed by NM, 2-May-1995.) $)
    3exbii $p |- ( E. x E. y E. z ph <-> E. x E. y E. z ps ) $=
      ( wex exbii 2exbii ) AEGBEGCDABEFHI $.
  $}

  $( Commutation of conjunction inside an existential quantifier.  (Contributed
     by NM, 18-Aug-1993.) $)
  exancom $p |- ( E. x ( ph /\ ps ) <-> E. x ( ps /\ ph ) ) $=
    ( wa ancom exbii ) ABDBADCABEF $.

  ${
    alrimdd.1 $e |- F/ x ph $.
    alrimdd.2 $e |- ( ph -> F/ x ps ) $.
    alrimdd.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.21 of [Margaris] p. 90.  (Contributed by Mario
       Carneiro, 24-Sep-2016.) $)
    alrimdd $p |- ( ph -> ( ps -> A. x ch ) ) $=
      ( wal nfrd alimd syld ) ABBDHCDHABDFIABCDEGJK $.
  $}

  ${
    alrimd.1 $e |- F/ x ph $.
    alrimd.2 $e |- F/ x ps $.
    alrimd.3 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.21 of [Margaris] p. 90.  (Contributed by Mario
       Carneiro, 24-Sep-2016.) $)
    alrimd $p |- ( ph -> ( ps -> A. x ch ) ) $=
      ( wnf a1i alrimdd ) ABCDEBDHAFIGJ $.
  $}

  ${
    eximdh.1 $e |- ( ph -> A. x ph ) $.
    eximdh.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Contributed by NM,
       20-May-1996.) $)
    eximdh $p |- ( ph -> ( E. x ps -> E. x ch ) ) $=
      ( wi wal wex alrimih exim syl ) ABCGZDHBDICDIGAMDEFJBCDKL $.
  $}

  ${
    eximd.1 $e |- F/ x ph $.
    eximd.2 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Contributed by Mario
       Carneiro, 24-Sep-2016.) $)
    eximd $p |- ( ph -> ( E. x ps -> E. x ch ) ) $=
      ( nfri eximdh ) ABCDADEGFH $.
  $}

  ${
    nexd.1 $e |- ( ph -> A. x ph ) $.
    nexd.2 $e |- ( ph -> -. ps ) $.
    $( Deduction for generalization rule for negated wff.  (Contributed by NM,
       2-Jan-2002.) $)
    nexd $p |- ( ph -> -. E. x ps ) $=
      ( wn wal wex alrimih alnex sylib ) ABFZCGBCHFALCDEIBCJK $.
  $}

  ${
    exbidh.1 $e |- ( ph -> A. x ph ) $.
    exbidh.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for existential quantifier (deduction rule).
       (Contributed by NM, 5-Aug-1993.) $)
    exbidh $p |- ( ph -> ( E. x ps <-> E. x ch ) ) $=
      ( wb wal wex alrimih exbi syl ) ABCGZDHBDICDIGAMDEFJBCDKL $.
  $}

  ${
    albid.1 $e |- F/ x ph $.
    albid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for universal quantifier (deduction rule).
       (Contributed by Mario Carneiro, 24-Sep-2016.) $)
    albid $p |- ( ph -> ( A. x ps <-> A. x ch ) ) $=
      ( nfri albidh ) ABCDADEGFH $.
  $}

  ${
    exbid.1 $e |- F/ x ph $.
    exbid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for existential quantifier (deduction rule).
       (Contributed by Mario Carneiro, 24-Sep-2016.) $)
    exbid $p |- ( ph -> ( E. x ps <-> E. x ch ) ) $=
      ( nfri exbidh ) ABCDADEGFH $.
  $}

  $( Simplification of an existentially quantified conjunction.  (Contributed
     by Rodolfo Medina, 25-Sep-2010.)  (Proof shortened by Andrew Salmon,
     29-Jun-2011.) $)
  exsimpl $p |- ( E. x ( ph /\ ps ) -> E. x ph ) $=
    ( wa simpl eximi ) ABDACABEF $.

  $( Theorem 19.6 of [Margaris] p. 89, given a decidability condition.
     (Contributed by Jim Kingdon, 2-Jun-2018.) $)
  alexdc $p |- ( A. x DECID ph -> ( A. x ph <-> -. E. x -. ph ) ) $=
    ( wdc wal wn wex nfa1 wb notnotdc sps albid alnex syl6bb ) ACZBDZ
    ABDAEZEZBDPBFEOAQBNBGNAQHBAIJKPBLM $.

  $( Theorem 19.29 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by Andrew Salmon, 13-May-2011.) $)
  19.29 $p |- ( ( A. x ph /\ E. x ps ) -> E. x ( ph /\ ps ) ) $=
    ( wal wex wa wi pm3.2 alimi exim syl imp ) ACDZBCEZABFZCEZMBOGZCDNPGAQCABHI
    BOCJKL $.

  $( Variation of Theorem 19.29 of [Margaris] p. 90.  (Contributed by NM,
     18-Aug-1993.) $)
  19.29r $p |- ( ( E. x ph /\ A. x ps ) -> E. x ( ph /\ ps ) ) $=
    ( wal wex wa 19.29 ancom exancom 3imtr4i ) BCDZACEZFBAFCELKFABFCEBACGLKHABC
    IJ $.

  $( Variation of Theorem 19.29 of [Margaris] p. 90 with double
     quantification.  (Contributed by NM, 3-Feb-2005.) $)
  19.29r2 $p |- ( ( E. x E. y ph /\ A. x A. y ps ) ->
             E. x E. y ( ph /\ ps ) ) $=
    ( wex wal wa 19.29r eximi syl ) ADEZCEBDFZCFGKLGZCEABGDEZCEKLCHMNCABDHIJ $.

  $( Variation of Theorem 19.29 of [Margaris] p. 90 with mixed quantification.
     (Contributed by NM, 11-Feb-2005.) $)
  19.29x $p |- ( ( E. x A. y ph /\ A. x E. y ps ) ->
             E. x E. y ( ph /\ ps ) ) $=
    ( wal wex wa 19.29r 19.29 eximi syl ) ADEZCFBDFZCEGLMGZCFABGDFZCFLMCHNOCABD
    IJK $.

  $( Forward direction of Theorem 19.35 of [Margaris] p. 90.  (Contributed by
     Mario Carneiro, 2-Feb-2015.) $)
  19.35-1 $p |- ( E. x ( ph -> ps ) -> ( A. x ph -> E. x ps ) ) $=
    ( wal wi wex wa 19.29 pm3.35 eximi syl expcom ) ACDZABEZCFZBCFZMOGANGZCFPAN
    CHQBCABIJKL $.

  ${
    19.35i.1 $e |- E. x ( ph -> ps ) $.
    $( Inference from Theorem 19.35 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.)  (Revised by NM, 2-Feb-2015.) $)
    19.35i $p |- ( A. x ph -> E. x ps ) $=
      ( wi wex wal 19.35-1 ax-mp ) ABECFACGBCFEDABCHI $.
  $}

  $( Theorem 19.25 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
     (Revised by NM, 2-Feb-2015.) $)
  19.25 $p |- ( A. y E. x ( ph -> ps ) ->
              ( E. y A. x ph -> E. y E. x ps ) ) $=
    ( wi wex wal 19.35-1 alimi exim syl ) ABECFZDGACGZBCFZEZDGMDFNDFELODABCHIMN
    DJK $.

  $( Theorem 19.43 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by Mario Carneiro, 2-Feb-2015.) $)
  19.43 $p |- ( E. x ( ph \/ ps ) <-> ( E. x ph \/ E. x ps ) ) $=
    ( wo wex hbe1 hbor 19.8a orim12i exlimih orc eximi olc jaoi impbii ) ABDZCEZ
    ACEZBCEZDZPTCRSCACFBCFGARBSACHBCHIJRQSAPCABKLBPCBAMLNO $.

  $( The antecedent provides a condition implying the converse of ~ 19.33 .
     Compare Theorem 19.33 of [Margaris] p. 90.  This variation of ~ 19.33bdc
     is intuitionistically valid without a decidability condition.
     (Contributed by Mario Carneiro, 2-Feb-2015.) $)
  19.33b2 $p |- ( ( -. E. x ph \/ -. E. x ps ) ->
               ( A. x ( ph \/ ps ) <-> ( A. x ph \/ A. x ps ) ) ) $=
    ( wex wn wal orcom alnex orbi12i bitr4i pm2.53 orcoms al2imi orim12d syl5bi
    wo wi com12 19.33 impbid1 ) ACDEZBCDEZPZABPZCFZACFZBCFZPZUEUCUHUCBEZCFZAEZC
    FZPZUEUHUCUBUAPUMUAUBGUJUBULUABCHACHIJUEUJUFULUGUDUIACBAUIAQBAKLMUDUKBCABKM
    NORABCST $.

  $( Converse of ~ 19.33 given ` -. ( E. x ph /\ E. x ps ) ` and a decidability
     condition.  Compare Theorem 19.33 of [Margaris] p. 90.  For a version
     which does not require a decidability condition, see ~ 19.33b2
     (Contributed by Jim Kingdon, 23-Apr-2018.) $)
  19.33bdc $p |- ( DECID E. x ph -> ( -. ( E. x ph /\ E. x ps ) ->
               ( A. x ( ph \/ ps ) <-> ( A. x ph \/ A. x ps ) ) ) ) $=
    ( wex wdc wa wn wo wal wb ianordc 19.33b2 syl6bi ) ACDZENBCDZFGNG
    OGHABHCIACIBCIHJNOKABCLM $.

  $( Theorem 19.40 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  19.40 $p |- ( E. x ( ph /\ ps ) -> ( E. x ph /\ E. x ps ) ) $=
    ( wa wex exsimpl simpr eximi jca ) ABDZCEACEBCEABCFJBCABGHI $.

  $( Theorem *11.42 in [WhiteheadRussell] p. 163.  Theorem 19.40 of [Margaris]
     p. 90 with 2 quantifiers.  (Contributed by Andrew Salmon, 24-May-2011.) $)
  19.40-2 $p |- ( E. x E. y ( ph /\ ps ) ->
        ( E. x E. y ph /\ E. x E. y ps ) ) $=
    ( wa wex 19.40 eximi syl ) ABEDFZCFADFZBDFZEZCFKCFLCFEJMCABDGHKLCGI $.

  $( Add/remove a conjunct in the scope of an existential quantifier.
     (Contributed by Raph Levien, 3-Jul-2006.) $)
  exintrbi $p |- ( A. x ( ph -> ps ) -> ( E. x ph <-> E. x ( ph /\ ps ) ) ) $=
    ( wi wal wa wb wex pm4.71 albii exbi sylbi ) ABDZCEAABFZGZCEACHNCHGMOCABIJA
    NCKL $.

  $( Introduce a conjunct in the scope of an existential quantifier.
     (Contributed by NM, 11-Aug-1993.) $)
  exintr $p |- ( A. x ( ph -> ps ) -> ( E. x ph -> E. x ( ph /\ ps ) ) ) $=
    ( wi wal wex wa exintrbi biimpd ) ABDCEACFABGCFABCHI $.

  ${
    hbex.1 $e |- ( ph -> A. x ph ) $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` E. y ph ` .
       (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 2-Feb-2015.) $)
    hbex $p |- ( E. y ph -> A. x E. y ph ) $=
      ( wex wal hbe1 hbal 19.8a alrimih exlimih ) AACEZBFCLCBACGHALBDACIJK $.
  $}

  ${
    nfex.1 $e |- F/ x ph $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` E. y ph ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.)  (Proof shortened by Wolf
       Lammen, 30-Dec-2017.) $)
    nfex $p |- F/ x E. y ph $=
      ( wex nfri hbex nfi ) ACEBABCABDFGH $.
  $}

  $( Theorem 19.2 of [Margaris] p. 89, generalized to use two set variables.
     (Contributed by O'Cat, 31-Mar-2008.) $)
  19.2 $p |- ( A. x ph -> E. y ph ) $=
    ( wex 19.8a sps ) AACDBACEF $.

  $( A closed version of one direction of ~ 19.9 .  (Contributed by NM,
     5-Aug-1993.) $)
  19.9ht $p |- ( A. x ( ph -> A. x ph ) -> ( E. x ph -> ph ) ) $=
    ( wal wi wex id ax-gen 19.23ht mpbii ) AABCDBCAADZBCABEADJBAFGAABHI $.

  $( A closed version of ~ 19.9 .  (Contributed by NM, 5-Aug-1993.)  (Revised
     by Mario Carneiro, 24-Sep-2016.)  (Proof shortended by Wolf Lammen,
     30-Dec-2017.) $)
  19.9t $p |- ( F/ x ph -> ( E. x ph <-> ph ) ) $=
    ( wnf wex wal wi df-nf 19.9ht sylbi 19.8a impbid1 ) ABCZABDZALAABEFBEMAFABG
    ABHIABJK $.

  ${
    19.9h.1 $e |- ( ph -> A. x ph ) $.
    $( A wff may be existentially quantified with a variable not free in it.
       Theorem 19.9 of [Margaris] p. 89.  (Contributed by FL, 24-Mar-2007.) $)
    19.9h $p |- ( E. x ph <-> ph ) $=
      ( wex wal wi 19.9ht mpg 19.8a impbii ) ABDZAAABEFKAFBABGCHABIJ $.
  $}

  ${
    19.9.1 $e |- F/ x ph $.
    $( A wff may be existentially quantified with a variable not free in it.
       Theorem 19.9 of [Margaris] p. 89.  (Contributed by FL, 24-Mar-2007.)
       (Revised by Mario Carneiro, 24-Sep-2016.)  (Proof shortened by Wolf
       Lammen, 30-Dec-2017.) $)
    19.9 $p |- ( E. x ph <-> ph ) $=
      ( nfri 19.9h ) ABABCDE $.
  $}

  $( One direction of theorem 19.6 of [Margaris] p. 89.  (Contributed by Jim
     Kingdon, 2-Jul-2018.) $)
  alexim $p |- ( A. x ph -> -. E. x -. ph ) $=
    ( wal wn wex wfal wi pm2.24 alimi exim syl nfv 19.9 syl6ib sylibr
    dfnot ) ABCZADZBEZFGSDQSFBEZFQRFGZBCSTGAUABAFHIRFBJKFBFBLMNSPO $.

  ${
    ax6blem.1 $e |- ( ph -> A. x ph ) $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` -. ph ` .  This
       theorem doesn't use ~ ax6b compared to ~ hbnt .  (Contributed by GD,
       27-Jan-2018.) $)
    ax6blem $p |- ( -. ph -> A. x -. ph ) $=
      ( wn wex wal id exlimih con3i alnex sylibr ) ADZABEZDLBFMAAABCAGHIABJK $.
  $}

  $( Quantified Negation.  Axiom C5-2 of [Monk2] p. 113.

     (Contributed by GD, 27-Jan-2018.) $)
  ax6b $p |- ( -. A. x ph -> A. x -. A. x ph ) $=
    ( wal ax-ial ax6blem ) ABCBABDE $.

  $( ` x ` is not free in ` -. A. x ph ` .  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by Wolf Lammen, 18-Aug-2014.) $)
  hbn1 $p |- ( -. A. x ph -> A. x -. A. x ph ) $=
    ( ax6b ) ABC $.

  $( Closed theorem version of bound-variable hypothesis builder ~ hbn .
     (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 2-Feb-2015.) $)
  hbnt $p |- ( A. x ( ph -> A. x ph ) -> ( -. ph -> A. x -. ph ) ) $=
    ( wn wal wi ax-4 con3i ax6b syl con3 al2imi syl5 ) ACZABDZCZBDZANEZBDMBDMOP
    NAABFGABHIQOMBANJKL $.

  ${
    hbn.1 $e |- ( ph -> A. x ph ) $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` -. ph ` .
       (Contributed by NM, 5-Aug-1993.) $)
    hbn $p |- ( -. ph -> A. x -. ph ) $=
      ( wal wi wn hbnt mpg ) AABDEAFZIBDEBABGCH $.
  $}

  ${
    hbnd.1 $e |- ( ph -> A. x ph ) $.
    hbnd.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hbn .
       (Contributed by NM, 3-Jan-2002.) $)
    hbnd $p |- ( ph -> ( -. ps -> A. x -. ps ) ) $=
      ( wal wi wn alrimih hbnt syl ) ABBCFGZCFBHZMCFGALCDEIBCJK $.
  $}

  ${
    nfnd.1 $e |- ( ph -> F/ x ps ) $.
    $( If in a context ` x ` is not free in ` ps ` , it is not free in
       ` -. ps ` .  (Contributed by Mario Carneiro, 24-Sep-2016.)  (Proof
       shortened by Wolf Lammen, 28-Dec-2017.) $)
    nfnd $p |- ( ph -> F/ x -. ps ) $=
      ( wnf wn nfnf1 wal wi df-nf hbnt sylbi nfd syl ) ABCEZBFZCEDOPCBCGOBBCHIC
      HPPCHIBCJBCKLMN $.
  $}

  ${
    nfn.1 $e |- F/ x ph $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` -. ph ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfn $p |- F/ x -. ph $=
      ( wn wnf wtru a1i nfnd trud ) ADBEFABABEFCGHI $.
  $}

  ${
    nfdc.1 $e |- F/ x ph $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` DECID ph ` .
       (Contributed by Jim Kingdon, 11-Mar-2018.) $)
    nfdc $p |- F/ x DECID ph $=
      ( wdc wn wo df-dc nfn nfor nfxfr ) ADAAEZFBAGAKBCABCHIJ $.
  $}

  $( The analog in our predicate calculus of axiom 5 of modal logic S5.
     (Contributed by NM, 5-Oct-2005.) $)
  modal-5 $p |- ( -. A. x -. ph -> A. x -. A. x -. ph ) $=
    ( wn hbn1 ) ACBD $.

  ${
    19.9d.1 $e |- ( ps -> F/ x ph ) $.
    $( A deduction version of one direction of ~ 19.9 .  (Contributed by NM,
       5-Aug-1993.)  (Revised by Mario Carneiro, 24-Sep-2016.) $)
    19.9d $p |- ( ps -> ( E. x ph -> ph ) ) $=
      ( wex wnf wb 19.9t syl biimpd ) BACEZABACFKAGDACHIJ $.
  $}

  ${
    19.9hd.1 $e |- ( ps -> A. x ps ) $.
    19.9hd.2 $e |- ( ps -> ( ph -> A. x ph ) ) $.
    $( A deduction version of one direction of ~ 19.9 .  This is an older
       variation of this theorem; new proofs should use ~ 19.9d .  (Contributed
       by NM, 5-Aug-1993.)  (New usage is discouraged.) $)
    19.9hd $p |- ( ps -> ( E. x ph -> ph ) ) $=
      ( wal wi wex alimi 19.9ht 3syl ) BBCFAACFGZCFACHAGDBLCEIACJK $.
  $}

  $( One direction of Theorem 19.11 of [Margaris] p. 89.  (Contributed by NM,
     5-Aug-1993.) $)
  excomim $p |- ( E. x E. y ph -> E. y E. x ph ) $=
    ( wex 19.8a 2eximi hbe1 hbex 19.9h sylib ) ACDBDABDZCDZBDLAKBCABEFLBKBCABGHI
    J $.

  $( Theorem 19.11 of [Margaris] p. 89.  (Contributed by NM, 5-Aug-1993.) $)
  excom $p |- ( E. x E. y ph <-> E. y E. x ph ) $=
    ( wex excomim impbii ) ACDBDABDCDABCEACBEF $.

  $( Theorem 19.12 of [Margaris] p. 89.  Assuming the converse is a mistake
     sometimes made by beginners!  (Contributed by NM, 5-Aug-1993.) $)
  19.12 $p |- ( E. x A. y ph -> A. y E. x ph ) $=
    ( wal wex hba1 hbex ax-4 eximi alrimih ) ACDZBEABECKCBACFGKABACHIJ $.

  ${
    19.19.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.19 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.19 $p |- ( A. x ( ph <-> ps ) -> ( ph <-> E. x ps ) ) $=
      ( wex wb wal 19.9h exbi syl5bbr ) AACEABFCGBCEACDHABCIJ $.
  $}

  $( An alternative definition of ~ df-nf , which does not involve nested
     quantifiers on the same variable.  (Contributed by Mario Carneiro,
     24-Sep-2016.) $)
  nf2 $p |- ( F/ x ph <-> ( E. x ph -> A. x ph ) ) $=
    ( wnf wal wi wex df-nf nfa1 nfri 19.23 bitri ) ABCAABDZEBDABFLEABGALBLBABHI
    JK $.

  $( An alternative definition of ~ df-nf .  (Contributed by Mario Carneiro,
     24-Sep-2016.) $)
  nf3 $p |- ( F/ x ph <-> A. x ( E. x ph -> ph ) ) $=
    ( wnf wex wal wi nf2 nfe1 nfri 19.21h bitr4i ) ABCABDZABEFLAFBEABGLABLBABHIJ
    K $.

  ${
    19.36i.1 $e |- F/ x ps $.
    19.36i.2 $e |- E. x ( ph -> ps ) $.
    $( Inference from Theorem 19.36 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.)  (Revised by NM, 2-Feb-2015.) $)
    19.36i $p |- ( A. x ph -> ps ) $=
      ( wal wex 19.35i id exlimi syl ) ACFBCGBABCEHBBCDBIJK $.
  $}

  ${
    19.36-1.1 $e |- F/ x ps $.
    $( Closed form of ~ 19.36i .  One direction of Theorem 19.36 of [Margaris]
       p. 90.  (Contributed by Jim Kingdon, 20-Jun-2018.) $)
    19.36-1 $p |- ( E. x ( ph -> ps ) -> ( A. x ph -> ps ) ) $=
      ( wi wex wal 19.35-1 19.9 syl6ib ) ABECFACGBCFBABCHBCDIJ $.
  $}

  ${
    19.37-1.1 $e |- F/ x ph $.
    $( One direction of Theorem 19.37 of [Margaris] p. 90.  The converse holds
       in classical logic but not, in general, here.  (Contributed by Jim
       Kingdon, 21-Jun-2018.) $)
    19.37-1 $p |- ( E. x ( ph -> ps ) -> ( ph -> E. x ps ) ) $=
      ( wal wi wex 19.3 19.35-1 syl5bir ) AACEABFCGBCGACDHABCIJ $.
  $}

  ${
    $d x ph $.
    19.37aiv.1 $e |- E. x ( ph -> ps ) $.
    $( Inference from Theorem 19.37 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.37aiv $p |- ( ph -> E. x ps ) $=
      ( wi wex nfv 19.37-1 ax-mp ) ABECFABCFEDABCACGHI $.
  $}

  $( Theorem 19.38 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  19.38 $p |- ( ( E. x ph -> A. x ps ) -> A. x ( ph -> ps ) ) $=
    ( wex wal wi hbe1 hba1 hbim 19.8a ax-4 imim12i alrimih ) ACDZBCEZFABFCNOCACG
    BCHIANOBACJBCKLM $.

  $( Closed form of Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
     7-Nov-2005.)  (Proof shortened by Wolf Lammen, 2-Jan-2018.) $)
  19.23t $p |- ( F/ x ps -> ( A. x ( ph -> ps ) <-> ( E. x ph -> ps ) ) ) $=
    ( wnf wi wal wex exim 19.9t biimpd syl9r nfr imim2d 19.38 syl6 impbid ) BCD
    ZABECFZACGZBEZRSBCGZQBABCHQUABBCIJKQTSBCFZERQBUBSBCLMABCNOP $.

  ${
    19.32dc.1 $e |- F/ x ph $.
    $( Theorem 19.32 of [Margaris] p. 90, where ` ph ` is decidable.
       (Contributed by Jim Kingdon, 4-Jun-2018.) $)
    19.32dc $p |- ( DECID ph ->
        ( A. x ( ph \/ ps ) <-> ( ph \/ A. x ps ) ) ) $=
      ( wdc wn wi wal wo wb nfn 19.21 a1i nfdc dfordc 3bitr4d
      albid ) AEZAFZBGZCHZSBCHZGZABIZCHAUBIUAUCJRSBCACDKLMRUDTCACDNABOQ
      AUBOP $.
  $}

  ${
    19.44.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.44 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.44 $p |- ( E. x ( ph \/ ps ) <-> ( E. x ph \/ ps ) ) $=
      ( wo wex 19.43 19.9h orbi2i bitri ) ABECFACFZBCFZEKBEABCGLBKBCDHIJ $.
  $}

  ${
    19.45.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.45 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.45 $p |- ( E. x ( ph \/ ps ) <-> ( ph \/ E. x ps ) ) $=
      ( wo wex 19.43 19.9h orbi1i bitri ) ABECFACFZBCFZEALEABCGKALACDHIJ $.
  $}

  $( Theorem 19.34 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  19.34 $p |- ( ( A. x ph \/ E. x ps ) -> E. x ( ph \/ ps ) ) $=
    ( wal wex wo 19.2 orim1i 19.43 sylibr ) ACDZBCEZFACEZLFABFCEKMLACCGHABCIJ
    $.

  ${
    19.41h.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.41 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    19.41h $p |- ( E. x ( ph /\ ps ) <-> ( E. x ph /\ ps ) ) $=
      ( wa wex 19.40 id exlimih anim2i syl pm3.21 eximdh impcom impbii ) ABEZCFZA
      CFZBEZQRBCFZESABCGTBRBBCDBHIJKBRQBAPCDBALMNO $.
  $}

  ${
    19.41.1 $e |- F/ x ps $.
    $( Theorem 19.41 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Andrew Salmon, 25-May-2011.)  (Proof shortened by
       Wolf Lammen, 12-Jan-2018.) $)
    19.41 $p |- ( E. x ( ph /\ ps ) <-> ( E. x ph /\ ps ) ) $=
      ( wa wex 19.40 19.9 anbi2i sylib pm3.21 eximd impcom impbii ) ABEZCFZACFZ
      BEZPQBCFZERABCGSBQBCDHIJBQPBAOCDBAKLMN $.
  $}

  ${
    19.42h.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.42 of [Margaris] p. 90.  (Contributed by NM, 18-Aug-1993.) $)
    19.42h $p |- ( E. x ( ph /\ ps ) <-> ( ph /\ E. x ps ) ) $=
      ( wa wex 19.41h exancom ancom 3bitr4i ) BAECFBCFZAEABECFAKEBACDGABCHAKIJ
      $.
  $}

  ${
    19.42.1 $e |- F/ x ph $.
    $( Theorem 19.42 of [Margaris] p. 90.  (Contributed by NM, 18-Aug-1993.) $)
    19.42 $p |- ( E. x ( ph /\ ps ) <-> ( ph /\ E. x ps ) ) $=
      ( wa wex 19.41 exancom ancom 3bitr4i ) BAECFBCFZAEABECFAKEBACDGABCHAKIJ
      $.
  $}

  $( Swap 1st and 3rd existential quantifiers.  (Contributed by NM,
     9-Mar-1995.) $)
  excom13 $p |- ( E. x E. y E. z ph <-> E. z E. y E. x ph ) $=
    ( wex excom exbii 3bitri ) ADEZCEBEIBEZCEABEZDEZCEKCEDEIBCFJLCABDFGKCDFH $.

  $( Rotate existential quantifiers.  (Contributed by NM, 17-Mar-1995.) $)
  exrot3 $p |- ( E. x E. y E. z ph <-> E. y E. z E. x ph ) $=
    ( wex excom13 excom bitri ) ADECEBEABEZCEDEIDECEABCDFIDCGH $.

  $( Rotate existential quantifiers twice.  (Contributed by NM, 9-Mar-1995.) $)
  exrot4 $p |- ( E. x E. y E. z E. w ph <-> E. z E. w E. x E. y ph ) $=
    ( wex excom13 exbii bitri ) AEFDFCFZBFACFZDFEFZBFKBFEFDFJLBACDEGHKBEDGI $.

  ${
    nexr.1 $e |- -. E. x ph $.
    $( Inference from ~ 19.8a .  (Contributed by Jeff Hankins, 26-Jul-2009.) $)
    nexr $p |- -. ph $=
      ( wex 19.8a mto ) AABDCABEF $.
  $}

  ${
    exan.1 $e |- ( E. x ph /\ ps ) $.
    $( Place a conjunct in the scope of an existential quantifier.
       (Contributed by NM, 18-Aug-1993.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    exan $p |- E. x ( ph /\ ps ) $=
      ( wex wal wa hbe1 19.28 mpgbi 19.29r ax-mp ) ACEZBCFGZABGCEMBGNCMBCACHIDJ
      ABCKL $.
  $}

  ${
    hbexd.1 $e |- ( ph -> A. y ph ) $.
    hbexd.2 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Deduction form of bound-variable hypothesis builder ~ hbex .
       (Contributed by NM, 2-Jan-2002.) $)
    hbexd $p |- ( ph -> ( E. y ps -> A. x E. y ps ) ) $=
      ( wex wal eximdh 19.12 syl6 ) ABDGZBCHZDGLCHABMDEFIBDCJK $.
  $}

  ${
    eeor.1 $e |- ( ph -> A. y ph ) $.
    eeor.2 $e |- ( ps -> A. x ps ) $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 8-Aug-1994.) $)
    eeor $p |- ( E. x E. y ( ph \/ ps ) <-> ( E. x ph \/ E. y ps ) ) $=
      ( wo wex 19.45 exbii hbex 19.44 bitri ) ABGDHZCHABDHZGZCHACHOGNPCABDEIJAO
      CBCDFKLM $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
              Equality theorems without distinct variables
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( At least one individual exists.  This is not a theorem of free logic,
     which is sound in empty domains.  For such a logic, we would add this
     theorem as an axiom of set theory (Axiom 0 of [Kunen] p. 10).  In the
     system consisting of ~ ax-5 through ~ ax-14 and ~ ax-17 , all axioms other
     than ~ ax-9 are believed to be theorems of free logic, although the system
     without ~ ax-9 is probably not complete in free logic.  (Contributed by
     NM, 5-Aug-1993.)  (Revised by NM, 3-Feb-2015.) $)
  a9e $p |- E. x x = y $=
    ( ax-i9 ) ABC $.

  $( An implication related to substitution.  (Contributed by NM, 5-Aug-1993.)
     (Revised by NM, 3-Feb-2015.) $)
  ax9o $p |- ( A. x ( x = y -> A. x ph ) -> ph ) $=
    ( cv wceq wex wal wi a9e wa 19.29r hba1 pm3.35 exlimih ax-4 syl mpan ) BDCDE
    ZBFZRABGZHZBGZABCISUBJRUAJZBFZARUABKUDTAUCTBABLRTMNABOPPQ $.

  ${
    $d x y $.
    $( Identity law for equality (reflexivity).  Lemma 6 of [Tarski] p. 68.
       This is often an axiom of equality in textbook systems, but we don't
       need it as an axiom since it can be proved from our other axioms.

       This proof is similar to Tarski's and makes use of a dummy variable
       ` y ` .  It also works in intuitionistic logic, unlike some other
       possible ways of proving this theorem.  (Contributed by NM,
       1-Apr-2005.) $)
    equid $p |- x = x $=
      ( vy weq wex a9e ax-17 ax-8 pm2.43i exlimih ax-mp ) BACZBDAACZBAEKLBLBFKLB
      AAGHIJ $.
  $}

  $( One of the two equality axioms of standard predicate calculus, called
     reflexivity of equality.  (The other one is ~ stdpc7 .)  Axiom 6 of
     [Mendelson] p. 95.  Mendelson doesn't say why he prepended the redundant
     quantifier, but it was probably to be compatible with free logic (which is
     valid in the empty domain).  (Contributed by NM, 16-Feb-2005.) $)
  stdpc6 $p |- A. x x = x $=
    ( weq equid ax-gen ) AABAACD $.

  $( Commutative law for equality.  Lemma 7 of [Tarski] p. 69.  (Contributed by
     NM, 5-Aug-1993.) $)
  equcomi $p |- ( x = y -> y = x ) $=
    ( weq equid ax-8 mpi ) ABCAACBACADABAEF $.

  $( Commutative law for equality.  (Contributed by NM, 20-Aug-1993.) $)
  equcom $p |- ( x = y <-> y = x ) $=
    ( weq equcomi impbii ) ABCBACABDBADE $.

  ${
    equcoms.1 $e |- ( x = y -> ph ) $.
    $( An inference commuting equality in antecedent.  Used to eliminate the
       need for a syllogism.  (Contributed by NM, 5-Aug-1993.) $)
    equcoms $p |- ( y = x -> ph ) $=
      ( weq equcomi syl ) CBEBCEACBFDG $.
  $}

  $( A transitive law for equality.  (Contributed by NM, 23-Aug-1993.) $)
  equtr $p |- ( x = y -> ( y = z -> x = z ) ) $=
    ( weq wi ax-8 equcoms ) BCDACDEBABACFG $.

  $( A transitive law for equality.  Lemma L17 in [Megill] p. 446 (p. 14 of the
     preprint).  (Contributed by NM, 23-Aug-1993.) $)
  equtrr $p |- ( x = y -> ( z = x -> z = y ) ) $=
    ( weq equtr com12 ) CADABDCBDCABEF $.

  $( A transitive law for equality.  (Contributed by NM, 12-Aug-1993.)  (Proof
     shortened by Andrew Salmon, 25-May-2011.) $)
  equtr2 $p |- ( ( x = z /\ y = z ) -> x = y ) $=
    ( weq wi equtrr equcoms impcom ) BCDACDZABDZIJECBCBAFGH $.

  $( An equivalence law for equality.  (Contributed by NM, 5-Aug-1993.) $)
  equequ1 $p |- ( x = y -> ( x = z <-> y = z ) ) $=
    ( weq ax-8 equtr impbid ) ABDACDBCDABCEABCFG $.

  $( An equivalence law for equality.  (Contributed by NM, 5-Aug-1993.) $)
  equequ2 $p |- ( x = y -> ( z = x <-> z = y ) ) $=
    ( weq equtrr wi equcoms impbid ) ABDCADZCBDZABCEJIFBABACEGH $.

  $( An identity law for the non-logical predicate.  (Contributed by NM,
     5-Aug-1993.) $)
  elequ1 $p |- ( x = y -> ( x e. z <-> y e. z ) ) $=
    ( weq wel ax-13 wi equcoms impbid ) ABDACEZBCEZABCFKJGBABACFHI $.

  $( An identity law for the non-logical predicate.  (Contributed by NM,
     5-Aug-1993.) $)
  elequ2 $p |- ( x = y -> ( z e. x <-> z e. y ) ) $=
    ( weq wel ax-14 wi equcoms impbid ) ABDCAEZCBEZABCFKJGBABACFHI $.

  ${
    ax11i.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    ax11i.2 $e |- ( ps -> A. x ps ) $.
    $( Inference that has ~ ax-11 (without ` A. y ` ) as its conclusion and
       doesn't require ~ ax-10 , ~ ax-11 , or ~ ax-12 for its proof.  The
       hypotheses may be eliminable without one or more of these axioms in
       special cases.  Proof similar to Lemma 16 of [Tarski] p. 70.
       (Contributed by NM, 20-May-2008.) $)
    ax11i $p |- ( x = y -> ( ph -> A. x ( x = y -> ph ) ) ) $=
      ( weq wi wal biimprcd alrimih syl6bi ) CDGZABMAHZCIEBNCFMABEJKL $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                  Axioms ax-10 and ax-11
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Show that ~ ax-10o can be derived from ~ ax-10 .  An open problem is
     whether this theorem can be derived from ~ ax-10 and the others when
     ~ ax-11 is replaced with ~ ax-11o .  See theorem ~ ax10 for the
     rederivation of ~ ax-10 from ~ ax10o .

     Normally, ~ ax10o should be used rather than ~ ax-10o , except by theorems
     specifically studying the latter's properties.  (Contributed by NM,
     16-May-2008.) $)
  ax10o $p |- ( A. x x = y -> ( A. x ph -> A. y ph ) ) $=
    ( weq wal wi ax-10 ax-11 equcoms sps pm2.27 al2imi sylsyld ) BCDZBECBDZCEAB
    EZOAFZCEZACEBCGNPRFZBSCBACBHIJOQACOAKLM $.

  $( Axiom ~ ax-10o ("o" for "old") was the original version of ~ ax-10 ,
     before it was discovered (in May 2008) that the shorter ~ ax-10 could
     replace it.  It appears as Axiom scheme C11' in [Megill] p. 448 (p. 16 of
     the preprint).

     This axiom is redundant, as shown by theorem ~ ax10o .

     Normally, ~ ax10o should be used rather than ~ ax-10o , except by theorems
     specifically studying the latter's properties.  (Contributed by NM,
     5-Aug-1993.) $)
  ax-10o $a |- ( A. x x = y -> ( A. x ph -> A. y ph ) ) $.

  $( Rederivation of ~ ax-10 from original version ~ ax-10o .  See theorem
     ~ ax10o for the derivation of ~ ax-10o from ~ ax-10 .

     This theorem should not be referenced in any proof.  Instead, use ~ ax-10
     above so that uses of ~ ax-10 can be more easily identified.  (Contributed
     by NM, 16-May-2008.) $)
  ax10 $p |- ( A. x x = y -> A. y y = x ) $=
    ( weq wal ax-10o pm2.43i equcomi alimi syl ) ABCZADZJBDZBACZBDKLJABEFJMBABG
    HI $.

  $( All variables are effectively bound in an identical variable specifier.
     (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 3-Feb-2015.) $)
  hbae $p |- ( A. x x = y -> A. z A. x x = y ) $=
    ( cv wceq wal wi ax12or ax10o alequcoms pm2.43i syl5 ax-4 imim1i jaoi ax-mp
    wo sps a5i ax-7 syl ) ADZBDZEZAFZUDCFZAFUECFUDUFACDZUBECFZUGUCECFZUDUFGZCFZ
    QZQUEUFGZABCHUHUMULUMACUDACIJUIUMUKUMBCUEUDBFZUCUGEBFUFUEUNUDABIKUDBCILJUJU
    MCUEUDUFUDAMNROOPSUDACTUA $.

  $( All variables are effectively bound in an identical variable specifier.
     (Contributed by Mario Carneiro, 11-Aug-2016.) $)
  nfae $p |- F/ z A. x x = y $=
    ( weq wal hbae nfi ) ABDAECABCFG $.

  ${
    hbalequs.1 $e |- ( A. z A. x x = y -> ph ) $.
    $( Rule that applies ~ hbae to antecedent.  (Contributed by NM,
       5-Aug-1993.) $)
    hbaes $p |- ( A. x x = y -> ph ) $=
      ( weq wal hbae syl ) BCFBGZJDGABCDHEI $.
  $}

  $( All variables are effectively bound in a distinct variable specifier.
     Lemma L19 in [Megill] p. 446 (p. 14 of the preprint).  (Contributed by NM,
     5-Aug-1993.) $)
  hbnae $p |- ( -. A. x x = y -> A. z -. A. x x = y ) $=
    ( weq wal hbae hbn ) ABDAECABCFG $.

  $( All variables are effectively bound in a distinct variable specifier.
     (Contributed by Mario Carneiro, 11-Aug-2016.) $)
  nfnae $p |- F/ z -. A. x x = y $=
    ( weq wal nfae nfn ) ABDAECABCFG $.

  ${
    hbnalequs.1 $e |- ( A. z -. A. x x = y -> ph ) $.
    $( Rule that applies ~ hbnae to antecedent.  (Contributed by NM,
       5-Aug-1993.) $)
    hbnaes $p |- ( -. A. x x = y -> ph ) $=
      ( weq wal wn hbnae syl ) BCFBGHZKDGABCDIEJ $.
  $}

  ${
    naecoms.1 $e |- ( -. A. x x = y -> ph ) $.
    $( A commutation rule for distinct variable specifiers.  (Contributed by
       NM, 2-Jan-2002.) $)
    naecoms $p |- ( -. A. y y = x -> ph ) $=
      ( cv wceq wal wn ax-10 con3i syl ) CEZBEZFCGZHMLFBGZHAO
      NBCIJDK $.
  $}

  $( Lemma used in proofs of substitution properties.  (Contributed by NM,
     5-Aug-1993.)  (Proof shortened by Mario Carneiro, 20-May-2014.) $)
  equs4 $p |- ( A. x ( x = y -> ph ) -> E. x ( x = y /\ ph ) ) $=
    ( cv wceq wi wal wa wex a9e 19.29 mpan2 ancl imp eximi syl ) BDCDEZAFZBGZRQ
    HZBIZQAHZBISQBIUABCJRQBKLTUBBRQUBQAMNOP $.

  ${
    equsal.1 $e |- ( ps -> A. x ps ) $.
    equsal.2 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( A useful equivalence related to substitution.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Andrew Salmon, 12-Aug-2011.) $)
    equsal $p |- ( A. x ( x = y -> ph ) <-> ps ) $=
      ( weq wi wal 19.3h syl6bbr pm5.74i albii a1d alrimih ax9o impbii bitr4i ) C
      DGZAHZCISBCIZHZCIZBTUBCSAUASABUAFBCEJKLMBUCBUBCEBUASENOBCDPQR $.
  $}

  ${
    equsex.1 $e |- ( ps -> A. x ps ) $.
    equsex.2 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( A useful equivalence related to substitution.  (Contributed by NM,
       5-Aug-1993.)  (Revised by NM, 3-Feb-2015.) $)
    equsex $p |- ( E. x ( x = y /\ ph ) <-> ps ) $=
      ( cv wceq wa wex biimpa exlimih a9e idd biimprcd jcad eximdh mpi impbii ) C
      GDGHZAIZCJZBUABCETABFKLBTCJUBCDMBTUACEBTTABTNTABFOPQRS $.
  $}

  ${
    equsexd.1 $e |- ( ph -> A. x ph ) $.
    equsexd.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    equsexd.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Deduction form of ~ equsex .  (Contributed by Jim Kingdon,
       29-Dec-2017.) $)
    equsexd $p |- ( ph -> ( E. x ( x = y /\ ps ) <-> ch ) ) $=
      ( cv wceq wa wex wb wi bi1 imim2i 3syl wal a1i imp exlimd2 prth
      pm3.31 a9e jca syl 19.26 syl6ibr anabsi5 idd bi2 jcad eximdh mpi
      pm2.04 ex impbid ) ADIEIJZBKZDLZCAUSCDFGAURBCMZNZURBCNZNUSCNHVA
      VCURBCOPURBCUCQUAACUTACKZURDLUTDEUDVDURUSDACVDDRZAVDADRZCDRZKZV
      EAAVFNZCVGNZKVDVHNAVIVJVIAFSGUEAVFCVGUBUFACDUGUHUIVDURURBACURUR
      NZCVKNACURUJSTACURBNZAVBURCBNZNCVLNHVAVMURBCUKPURCBUOQTULUMUNUP
      UQ $.
  $}

  ${
    dral1.1 $e |- ( A. x x = y -> ( ph <-> ps ) ) $.
    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       Part of Theorem 9.4 of [Megill] p. 448 (p. 16 of preprint).
       (Contributed by NM, 24-Nov-1994.) $)
    dral1 $p |- ( A. x x = y -> ( A. x ph <-> A. y ps ) ) $=
      ( weq wal hbae biimpd alimdh ax10o syld biimprd wi alequcoms impbid ) CDFC
      GZACGZBDGZQRBCGSQABCCDCHQABEIJBCDKLQSADGZRQBADCDDHQABEMJTRNDCADCKOLP $.
  $}

  ${
    dral2.1 $e |- ( A. x x = y -> ( ph <-> ps ) ) $.
    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       Part of Theorem 9.4 of [Megill] p. 448 (p. 16 of preprint).
       (Contributed by NM, 27-Feb-2005.) $)
    dral2 $p |- ( A. x x = y -> ( A. z ph <-> A. z ps ) ) $=
      ( weq wal hbae albidh ) CDGCHABECDEIFJ $.
  $}

  ${
    drex2.1 $e |- ( A. x x = y -> ( ph <-> ps ) ) $.
    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       Part of Theorem 9.4 of [Megill] p. 448 (p. 16 of preprint).
       (Contributed by NM, 27-Feb-2005.) $)
    drex2 $p |- ( A. x x = y -> ( E. z ph <-> E. z ps ) ) $=
      ( weq wal hbae exbidh ) CDGCHABECDEIFJ $.

    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       (Contributed by Mario Carneiro, 4-Oct-2016.) $)
    drnf1 $p |- ( A. x x = y -> ( F/ x ph <-> F/ y ps ) ) $=
      ( weq wal wi wnf dral1 imbi12d df-nf 3bitr4g ) CDFCGZAACGZHZCGBBDGZHZDGAC
      IBDIPRCDNABOQEABCDEJKJACLBDLM $.

    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       (Contributed by Mario Carneiro, 4-Oct-2016.) $)
    drnf2 $p |- ( A. x x = y -> ( F/ z ph <-> F/ z ps ) ) $=
      ( weq wal wi wnf dral2 imbi12d df-nf 3bitr4g ) CDGCHZAAEHZIZEHBBEHZIZEHAE
      JBEJQSCDEOABPRFABCDEFKLKAEMBEMN $.
  $}

  $( Closed theorem form of ~ a4im .  (Contributed by NM, 15-Jan-2008.) $)
  a4imt $p |- ( A. x ( ( ps -> A. x ps ) /\ ( x = y -> ( ph -> ps ) ) ) ->
              ( A. x ph -> ps ) ) $=
    ( wal wi weq wa imim2 imim2d imp com23 al2imi ax9o syl6 ) BBCEZFZCDGZABFZFZ
    HZCEACERPFZCEBUAAUBCUARAPQTRAPFZFQSUCRBPAIJKLMBCDNO $.

  ${
    a4im.1 $e |- ( ps -> A. x ps ) $.
    a4im.2 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Specialization, using implicit substitition.  Compare Lemma 14 of
       [Tarski] p. 70.  The ~ a4im series of theorems requires that only one
       direction of the substitution hypothesis hold.  (Contributed by NM,
       5-Aug-1993.)  (Revised by NM, 8-May-2008.) $)
    a4im $p |- ( A. x ph -> ps ) $=
      ( wal weq wi syl6com alimi ax9o syl ) ACGCDHZBCGZIZCGBAPCNABOFEJKBCDLM $.
  $}

  ${
    spim.1 $e |- F/ x ps $.
    spim.2 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Specialization, using implicit substitution.  Compare Lemma 14 of
       [Tarski] p. 70.  The ~ spim series of theorems requires that only one
       direction of the substitution hypothesis hold.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Mario Carneiro, 3-Oct-2016.)  (Proof rewritten
       by Jim Kingdon, 10-Jun-2018.) $)
    spim $p |- ( A. x ph -> ps ) $=
      ( nfri a4im ) ABCDBCEGFH $.
  $}

  ${
    a4ime.1 $e |- ( ph -> A. x ph ) $.
    a4ime.2 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Existential introduction, using implicit substitition.  Compare Lemma 14
       of [Tarski] p. 70.  (Contributed by NM, 7-Aug-1994.)  (Revised by NM,
       3-Feb-2015.) $)
    a4ime $p |- ( ph -> E. x ps ) $=
      ( cv wceq wex a9e com12 eximdh mpi ) ACGDGHZCIBCICDJANBCENABFKLM $.
  $}

  ${
    a4imed.1 $e |- ( ch -> A. x ch ) $.
    a4imed.2 $e |- ( ch -> ( ph -> A. x ph ) ) $.
    a4imed.3 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Deduction version of ~ a4ime .  (Contributed by NM, 5-Aug-1993.) $)
    a4imed $p |- ( ch -> ( ph -> E. x ps ) ) $=
      ( wex wa wal adantr imp 19.26 sylanbrc weq adantld a4ime ex ) CABDICAJZBD
      ETCDKZADKZTDKCUAAFLCAUBGMCADNODEPABCHQRS $.
  $}

  ${
    cbv3.1 $e |- F/ y ph $.
    cbv3.2 $e |- F/ x ps $.
    cbv3.3 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       12-May-2018.) $)
    cbv3 $p |- ( A. x ph -> A. y ps ) $=
      ( wal nfal spim alrimi ) ACHBDADCEIABCDFGJK $.
  $}

  ${
    cbv3h.1 $e |- ( ph -> A. y ph ) $.
    cbv3h.2 $e |- ( ps -> A. x ps ) $.
    cbv3h.3 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       25-May-2011.)  (Proof shortened by Wolf Lammen, 12-May-2018.) $)
    cbv3h $p |- ( A. x ph -> A. y ps ) $=
      ( nfi cbv3 ) ABCDADEHBCFHGI $.
  $}

  ${
    cbv1.1 $e |- F/ x ph $.
    cbv1.2 $e |- F/ y ph $.
    cbv1.3 $e |- ( ph -> F/ y ps ) $.
    cbv1.4 $e |- ( ph -> F/ x ch ) $.
    cbv1.5 $e |- ( ph -> ( x = y -> ( ps -> ch ) ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       Revised to format hypotheses to common style.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Mario Carneiro, 3-Oct-2016.)  (Revised by Wolf
       Lammen, 13-May-2018.) $)
    cbv1 $p |- ( ph -> ( A. x ps -> A. y ch ) ) $=
      ( wal wi nfim1 weq com12 a2d cbv3 19.21 3imtr3i pm2.86i ) ABDKZCEKZABLZDK
      ACLZEKAUALAUBLUCUDDEABEGHMACDFIMDENZABCAUEBCLJOPQABDFRACEGRST $.
  $}

  ${
    cbv1h.1 $e |- ( ph -> ( ps -> A. y ps ) ) $.
    cbv1h.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    cbv1h.3 $e |- ( ph -> ( x = y -> ( ps -> ch ) ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen,
       13-May-2018.) $)
    cbv1h $p |- ( A. x A. y ph -> ( A. x ps -> A. y ch ) ) $=
      ( wal nfa1 nfa2 wi sp sps syl nfd weq cbv1 ) AEIZDIZBCDESDJZAEDKZTBEUBTAB
      BEILSADAEMNZFOPTCDUATACCDILUCGOPTADEQBCLLUCHOR $.
  $}

  ${
    cbv2h.1 $e |- ( ph -> ( ps -> A. y ps ) ) $.
    cbv2h.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    cbv2h.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 5-Aug-1993.) $)
    cbv2h $p |- ( A. x A. y ph -> ( A. x ps <-> A. y ch ) ) $=
      ( wal weq wb wi bi1 syl6 cbv1h equcomi bi2 syl56 a7s impbid ) AEIDIBDIZCE
      IZABCDEFGADEJZBCKZBCLHBCMNOAUBUALEDACBEDGFEDJUCAUDCBLEDPHBCQROST $.
  $}

  ${
    cbv2.1 $e |- F/ x ph $.
    cbv2.2 $e |- F/ y ph $.
    cbv2.3 $e |- ( ph -> F/ y ps ) $.
    cbv2.4 $e |- ( ph -> F/ x ch ) $.
    cbv2.5 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       Revised to align format of hypotheses to common style.  (Contributed by
       NM, 5-Aug-1993.)  (Revised by Mario Carneiro, 3-Oct-2016.)  (Revised by
       Wolf Lammen, 13-May-2018.) $)
    cbv2 $p |- ( ph -> ( A. x ps <-> A. y ch ) ) $=
      ( wal wb nfri nfal syl nfrd cbv2h ) AAEKZDKZBDKCEKLARSAEGMRDADEFNMOABCDEA
      BEHPACDIPJQO $.
  $}

  ${
    cbvalh.1 $e |- ( ph -> A. y ph ) $.
    cbvalh.2 $e |- ( ps -> A. x ps ) $.
    cbvalh.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    cbvalh $p |- ( A. x ph <-> A. y ps ) $=
      ( wal weq biimpd cbv3h wb equcoms biimprd impbii ) ACHBDHABCDEFCDIABGJKBAD
      CFEDCIABABLCDGMNKO $.
  $}

  ${
    cbval.1 $e |- F/ y ph $.
    cbval.2 $e |- F/ x ps $.
    cbval.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 5-Aug-1993.)  (Revised by Mario Carneiro,
       3-Oct-2016.) $)
    cbval $p |- ( A. x ph <-> A. y ps ) $=
      ( nfri cbvalh ) ABCDADEHBCFHGI $.
  $}

  ${
    cbvexh.1 $e |- ( ph -> A. y ph ) $.
    cbvexh.2 $e |- ( ps -> A. x ps ) $.
    cbvexh.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 5-Aug-1993.)  (Revised by Mario Carneiro,
       3-Feb-2015.) $)
    cbvexh $p |- ( E. x ph <-> E. y ps ) $=
      ( wex hbex cv wceq wa wb bicomd equcoms equsex simpr eximi sylbir exlimih
      impbii ) ACHZBDHZAUCCBCDFIADJZCJZKZBLZDHUCBADCEBAMCDUEUDKZABGNOPUGBDUFBQR
      STBUBDADCEIBUHALZCHUBABCDFGPUIACUHAQRSTUA $.
  $}

  ${
    cbvex.1 $e |- F/ y ph $.
    cbvex.2 $e |- F/ x ps $.
    cbvex.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 5-Aug-1993.) $)
    cbvex $p |- ( E. x ph <-> E. y ps ) $=
      ( nfri cbvexh ) ABCDADEHBCFHGI $.
  $}

  ${
    chv2.1 $e |- ( ps -> A. x ps ) $.
    chv2.2 $e |- ( x = y -> ( ph <-> ps ) ) $.
    chv2.3 $e |- ph $.
    $( Implicit substitution of ` y ` for ` x ` into a theorem.  (Contributed
       by Raph Levien, 9-Jul-2003.) $)
    chvar $p |- ps $=
      ( weq biimpd a4im mpg ) ABCABCDECDHABFIJGK $.
  $}

  $( A variable introduction law for equality.  Lemma 15 of [Monk2] p. 109,
     however we do not require ` z ` to be distinct from ` x ` and ` y `
     (making the proof longer).  (Contributed by NM, 5-Aug-1993.)  (Proof
     shortened by Andrew Salmon, 25-May-2011.) $)
  equvini $p |- ( x = y -> E. z ( x = z /\ z = y ) ) $=
    ( cv wceq wal wi wo wex ax12or equcomi alimi a9e jctir a1d 19.29 syl6 ax-mp
    wa jaoi eximi a1ii anc2ri 19.29r ax-8 anc2li equcoms com12 exim syl mpi sps
    imim2i ) CDZADZEZCFZUNBDZEZCFZUOUREZVACFZGZCFZHZHVAUOUNEZUSSZCIZGZABCJUQVIV
    EUQVAVFCFZUSCIZSZVHUQVLVAUQVJVKUPVFCCAKZLCBMNOVFUSCPQUTVIVDUTVAVFCIZUTSVHUT
    VAVNUTVAVNUPCIZVNCAMZUPVFCVMUARUBUCVFUSCUDQVCVICVBVHVAVBVOVHVPVBUPVGGZCFVOV
    HGVAVQCUPVAVGVAVGGACVFVAUSACBUEUFUGUHLUPVGCUIUJUKUMULTTR $.

  $( A variable elimination law for equality with no distinct variable
     requirements.  (Compare ~ equvini .)  (Contributed by NM, 1-Mar-2013.)
     (Revised by NM, 3-Feb-2015.) $)
  equveli $p |- ( A. z ( z = x <-> z = y ) -> x = y ) $=
    ( cv wb wal wi wa albiim wo ax12or equequ1 imbi12d sps equid syl6bi adantrd
    wceq ax-4 jaoi dral2 a1bi biimpri dral1 mpi equcomi syl adantld hbequid a1i
    hba1 hbimd equtr ax-8 imim12d ax-gen 19.26 a4imt sylbir sylancl ax-mp sylbi
    a5i mpii ) CDZADZRZVEBDZRZECFVGVIGZCFZVIVGGZCFZHZVFVHRZVGVICIVGCFZVICFZVOVO
    CFGZCFZJZJVNVOGZABCKVPWAVTVPVKVOVMVPVKVFVFRZVOGZCFZVOVJWCCACVGVJWCECVGVGWBV
    IVOCAALCABLMNUAWCVOCVOWCWBVOAOZUBUCNPQVQWAVSVQVMVOVKVQVMVHVHRZVHVFRZGZBFZVO
    VLWHCBVIVLWHECVIVIWFVGWGCBBLCBALMNUDWIWGVOWIWFWGBOWHBSUEBAUFUGPUHVSVKVOVMVS
    VKWBVOWEVSWCWDGZCFZVGVJWCGGZCFZVKWCGZVRWJCVSWBVOCVRCUKWBWBCFGVSACUIUJVRCSUL
    VCWLCVGWBVGVIVOCAAUMCABUNUOUPWKWMHWJWLHCFWNWJWLCUQVJWCCAURUSUTVDQTTVAVB $.

  ${
    nfald.1 $e |- F/ y ph $.
    nfald.2 $e |- ( ph -> F/ x ps ) $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` A. y ph ` .
       (Contributed by Mario Carneiro, 24-Sep-2016.)  (Proof shortened by Wolf
       Lammen, 6-Jan-2018.) $)
    nfald $p |- ( ph -> F/ x A. y ps ) $=
      ( wnf wal nfri alrimih nfnf1 nfal hba1 sp nfrd hbald nfd syl ) ABCGZDHZBDH
      ZCGASDADEIFJTUACSCDBCKLTBCDSDMTBCSDNOPQR $.

    $( If ` x ` is not free in ` ph ` , it is not free in ` E. y ph ` .
       (Contributed by Mario Carneiro, 24-Sep-2016.)  (Proof rewritten by Jim
       Kingdon, 7-Feb-2018.) $)
    nfexd $p |- ( ph -> F/ x E. y ps ) $=
      ( wex wal wi wnf nfri df-nf sylib alrimih alcom exim alimi 19.12
      syl imim2i sylibr ) ABDGZUBCHZIZCHZUBCJAUBBCHZDGZIZCHZUEABUFIZD
      HZCHZUIAUJCHZDHULAUMDADEKABCJUMFBCLMNUJDCOMUKUHCBUFDPQSUHUDCUGU
      CUBBDCRTQSUBCLUA $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Substitution (without distinct variables)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $c [ $. $( Left bracket $)
  $c / $. $( Division. $)
  $c ] $.  $( Right bracket $)

  $( --- Start of patch to prevent connective overloading $)
  ${
    $v A $.
    wsbc.cA $f class A $.
    $( Extend wff notation to include the proper substitution of a class for a
       set.  Read this notation as "the proper substitution of class ` A ` for
       set variable ` x ` in wff ` ph ` ."

       (The purpose of introducing ` wff [ A / x ] ph ` here is to allow us to
       express i.e.  "prove" the ~ wsb of predicate calculus in terms of the
       ~ wsbc of set theory, so that we don't "overload" its connectives with
       two syntax definitions.  This is done to prevent ambiguity that would
       complicate some Metamath parsers.  The class variable ` A ` is
       introduced temporarily for the purpose of this definition but otherwise
       not used in predicate calculus.) $)
    wsbc $a wff [ A / x ] ph $.
  $}

  $( Extend wff definition to include proper substitution (read "the wff that
     results when ` y ` is properly substituted for ` x ` in wff ` ph ` ").

     (Instead of introducing ~ wsb as an axiomatic statement, as was done in an
     older version of this database, we introduce it by "proving" a special
     case of set theory's more general ~ wsbc .  This lets us avoid overloading
     its connectives, thus preventing ambiguity that would complicate some
     Metamath parsers.  Note:  To see the proof steps of this syntax proof,
     type "show proof wsb /all" in the Metamath program.)  (Contributed by NM,
     24-Jan-2006.) $)
  wsb $p wff [ y / x ] ph $=
    ( cv wsbc ) ABCDE $.
  $( --- End of patch to prevent connective overloading $)

  $( --- Start of old code before overloading prevention patch. $)
  $(
  @( Extend wff definition to include proper substitution (read "the wff that
     results when ` y ` is properly substituted for ` x ` in wff ` ph ` ").

     After we introduce ~ cv and ~ wsbc in set theory, this syntax construction
     becomes redundant, since it can be derived with the proof
     "wph vx vy cv wsbc". @)
  wsb @a wff [ y / x ] ph @.
  $)
  $( --- End of old code before overloading prevention patch. $)

  $( Define proper substitution.  Remark 9.1 in [Megill] p. 447 (p. 15 of the
     preprint).  For our notation, we use ` [ y / x ] ph ` to mean "the wff
     that results when ` y ` is properly substituted for ` x ` in the wff
     ` ph ` ."  We can also use ` [ y / x ] ph ` in place of the "free for"
     side condition used in traditional predicate calculus; see, for example,
     ~ stdpc4 .

     Our notation was introduced in Haskell B. Curry's _Foundations of
     Mathematical Logic_ (1977), p. 316 and is frequently used in textbooks of
     lambda calculus and combinatory logic.  This notation improves the common
     but ambiguous notation, " ` ph ( y ) ` is the wff that results when ` y `
     is properly substituted for ` x ` in ` ph ( x ) ` ."  For example, if the
     original ` ph ( x ) ` is ` x = y ` , then ` ph ( y ) ` is ` y = y ` , from
     which we obtain that ` ph ( x ) ` is ` x = x ` .  So what exactly does
     ` ph ( x ) ` mean?  Curry's notation solves this problem.

     In most books, proper substitution has a somewhat complicated recursive
     definition with multiple cases based on the occurrences of free and bound
     variables in the wff.  Instead, we use a single formula that is exactly
     equivalent and gives us a direct definition.  We later prove that our
     definition has the properties we expect of proper substitution (see
     theorems ~ sbequ , ~ sbcom2 and ~ sbid2v ).

     Note that our definition is valid even when ` x ` and ` y ` are replaced
     with the same variable, as ~ sbid shows.  We achieve this by having ` x `
     free in the first conjunct and bound in the second.  We can also achieve
     this by using a dummy variable, as the alternate definition ~ dfsb7 shows
     (which some logicians may prefer because it doesn't mix free and bound
     variables).  Another alternate definition which uses a dummy variable is
     ~ dfsb7a .

     When ` x ` and ` y ` are distinct, we can express proper substitution with
     the simpler expressions of ~ sb5 and ~ sb6 .

     In classical logic, we have additional equivalent definitions ~ dfsb2 and
     ~ dfsb3 , but we do not have intuitionistic proofs that those are
     equivalent.

     There are no restrictions on any of the variables, including what
     variables may occur in wff ` ph ` .  (Contributed by NM, 5-Aug-1993.) $)
  df-sb $a |- ( [ y / x ] ph <->
              ( ( x = y -> ph ) /\ E. x ( x = y /\ ph ) ) ) $.

  ${
    sbimi.1 $e |- ( ph -> ps ) $.
    $( Infer substitution into antecedent and consequent of an implication.
       (Contributed by NM, 25-Jun-1998.) $)
    sbimi $p |- ( [ y / x ] ph -> [ y / x ] ps ) $=
      ( weq wi wa wex wsb imim2i anim2i eximi anim12i df-sb 3imtr4i ) CDFZAGZQA
      HZCIZHQBGZQBHZCIZHACDJBCDJRUATUCABQEKSUBCABQELMNACDOBCDOP $.
  $}

  ${
    sbbii.1 $e |- ( ph <-> ps ) $.
    $( Infer substitution into both sides of a logical equivalence.
       (Contributed by NM, 5-Aug-1993.) $)
    sbbii $p |- ( [ y / x ] ph <-> [ y / x ] ps ) $=
      ( wsb biimpi sbimi biimpri impbii ) ACDFBCDFABCDABEGHBACDABEIHJ $.
  $}

  $( One direction of a simplified definition of substitution.  (Contributed by
     NM, 5-Aug-1993.) $)
  sb1 $p |- ( [ y / x ] ph -> E. x ( x = y /\ ph ) ) $=
    ( wsb weq wi wa wex df-sb simprbi ) ABCDBCEZAFKAGBHABCIJ $.

  $( One direction of a simplified definition of substitution.  (Contributed by
     NM, 5-Aug-1993.) $)
  sb2 $p |- ( A. x ( x = y -> ph ) -> [ y / x ] ph ) $=
    ( weq wi wal wa wex wsb ax-4 equs4 df-sb sylanbrc ) BCDZAEZBFONAGBHABCIOBJA
    BCKABCLM $.

  $( An equality theorem for substitution.  (Contributed by NM, 5-Aug-1993.) $)
  sbequ1 $p |- ( x = y -> ( ph -> [ y / x ] ph ) ) $=
    ( weq wsb wa wi wex pm3.4 19.8a df-sb sylanbrc ex ) BCDZAABCEZNAFZNAGPBHONA
    IPBJABCKLM $.

  $( An equality theorem for substitution.  (Contributed by NM, 5-Aug-1993.) $)
  sbequ2 $p |- ( x = y -> ( [ y / x ] ph -> ph ) ) $=
    ( wsb weq wi wa wex df-sb simpl com12 syl5bi ) ABCDBCEZAFZMAGBHZGZMAABCIPMA
    NOJKL $.

  $( One of the two equality axioms of standard predicate calculus, called
     substitutivity of equality.  (The other one is ~ stdpc6 .)  Translated to
     traditional notation, it can be read:  " ` x = y -> ( ph ( x ` ,
     ` x ) -> ph ( x ` , ` y ) ) ` , provided that ` y ` is free for ` x ` in
     ` ph ( x ` , ` y ) ` ."  Axiom 7 of [Mendelson] p. 95.  (Contributed by
     NM, 15-Feb-2005.) $)
  stdpc7 $p |- ( x = y -> ( [ x / y ] ph -> ph ) ) $=
    ( wsb wi sbequ2 equcoms ) ACBDAECBACBFG $.

  $( An equality theorem for substitution.  (Contributed by NM, 5-Aug-1993.) $)
  sbequ12 $p |- ( x = y -> ( ph <-> [ y / x ] ph ) ) $=
    ( weq wsb sbequ1 sbequ2 impbid ) BCDAABCEABCFABCGH $.

  $( An equality theorem for substitution.  (Contributed by NM, 6-Oct-2004.)
     (Proof shortened by Andrew Salmon, 21-Jun-2011.) $)
  sbequ12r $p |- ( x = y -> ( [ x / y ] ph <-> ph ) ) $=
    ( wsb wb weq sbequ12 bicomd equcoms ) ACBDZAECBCBFAJACBGHI $.

  $( An equality theorem for substitution.  (Contributed by NM, 5-Aug-1993.) $)
  sbequ12a $p |- ( x = y -> ( [ y / x ] ph <-> [ x / y ] ph ) ) $=
    ( weq wsb sbequ12 wb equcoms bitr3d ) BCDAABCEACBEZABCFAJGCBACBFHI $.

  $( An identity theorem for substitution.  Remark 9.1 in [Megill] p. 447 (p.
     15 of the preprint).  (Contributed by NM, 5-Aug-1993.) $)
  sbid $p |- ( [ x / x ] ph <-> ph ) $=
    ( wsb weq wb equid sbequ12 ax-mp bicomi ) AABBCZBBDAJEBFABBGHI $.

  $( The specialization axiom of standard predicate calculus.  It states that
     if a statement ` ph ` holds for all ` x ` , then it also holds for the
     specific case of ` y ` (properly) substituted for ` x ` .  Translated to
     traditional notation, it can be read:  " ` A. x ph ( x ) -> ph ( y ) ` ,
     provided that ` y ` is free for ` x ` in ` ph ( x ) ` ."  Axiom 4 of
     [Mendelson] p. 69.  (Contributed by NM, 5-Aug-1993.) $)
  stdpc4 $p |- ( A. x ph -> [ y / x ] ph ) $=
    ( wal weq wi wsb ax-1 alimi sb2 syl ) ABDBCEZAFZBDABCGAMBALHIABCJK $.

  ${
    sbh.1 $e |- ( ph -> A. x ph ) $.
    $( Substitution for a variable not free in a wff does not affect it.
       (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 17-Oct-2004.) $)
    sbh $p |- ( [ y / x ] ph <-> ph ) $=
      ( wsb weq wex wa sb1 19.41h sylib simprd wal stdpc4 syl impbii ) ABCEZAQBC
      FZBGZAQRAHBGSAHABCIRABDJKLAABMQDABCNOP $.
  $}

  ${
    sbf.1 $e |- F/ x ph $.
    $( Substitution for a variable not free in a wff does not affect it.
       (Contributed by NM, 5-Aug-1993.)  (Revised by Mario Carneiro,
       4-Oct-2016.) $)
    sbf $p |- ( [ y / x ] ph <-> ph ) $=
      ( nfri sbh ) ABCABDEF $.
  $}

  $( Substitution has no effect on a bound variable.  (Contributed by NM,
     1-Jul-2005.) $)
  sbf2 $p |- ( [ y / x ] A. x ph <-> A. x ph ) $=
    ( wal nfa1 sbf ) ABDBCABEF $.

  ${
    sb6x.1 $e |- ( ph -> A. x ph ) $.
    $( Equivalence involving substitution for a variable not free.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       12-Aug-2011.) $)
    sb6x $p |- ( [ y / x ] ph <-> A. x ( x = y -> ph ) ) $=
      ( cv wsbc wceq wi wal sbh biidd equsal bitr4i ) ABCEZFABENGZAHBIABCDJAABC
      DOAKLM $.
  $}

  ${
    nfs1f.1 $e |- F/ x ph $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` [ y / x ] ph ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfs1f $p |- F/ x [ y / x ] ph $=
      ( wsb nfri sbh nfxfr ) ABCEABABCABDFGDH $.
  $}

  ${
    hbs1f.1 $e |- ( ph -> A. x ph ) $.
    $( If ` x ` is not free in ` ph ` , it is not free in ` [ y / x ] ph ` .
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    hbs1f $p |- ( [ y / x ] ph -> A. x [ y / x ] ph ) $=
      ( wsb sbh hbxfrbi ) ABCEABABCDFDG $.
  $}

  $( Substitution does not change an identical variable specifier.
     (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 21-Dec-2004.) $)
  sbequ5 $p |- ( [ w / z ] A. x x = y <-> A. x x = y ) $=
    ( weq wal nfae sbf ) ABEAFCDABCGH $.

  $( Substitution does not change a distinctor.  (Contributed by NM,
     5-Aug-1993.)  (Revised by NM, 14-May-2005.) $)
  sbequ6 $p |- ( [ w / z ] -. A. x x = y <-> -. A. x x = y ) $=
    ( weq wal wn nfnae sbf ) ABEAFGCDABCHI $.

  ${
    sbt.1 $e |- ph $.
    $( A substitution into a theorem remains true.  (See ~ chvar and ~ chvarv
       for versions using implicit substitition.)  (Contributed by NM,
       21-Jan-2004.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    sbt $p |- [ y / x ] ph $=
      ( wsb nfth sbf mpbir ) ABCEADABCABDFGH $.
  $}

  $( Substitution applied to an atomic wff.  (Contributed by NM,
     5-Aug-1993.) $)
  equsb1 $p |- [ y / x ] x = y $=
    ( weq wi wsb sb2 id mpg ) ABCZIDIABEAIABFIGH $.

  $( Substitution applied to an atomic wff.  (Contributed by NM,
     5-Aug-1993.) $)
  equsb2 $p |- [ y / x ] y = x $=
    ( weq wi wsb sb2 equcomi mpg ) ABCBACZDIABEAIABFABGH $.

  ${
    sbiedh.1 $e |- ( ph -> A. x ph ) $.
    sbiedh.2 $e |- ( ph -> ( ch -> A. x ch ) ) $.
    sbiedh.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Conversion of implicit substitution to explicit substitution (deduction
       version of ~ sbieh ).  (Contributed by NM, 30-Jun-1994.)  (Proof
       shortened by Andrew Salmon, 25-May-2011.) $)
    sbiedh $p |- ( ph -> ( [ y / x ] ps <-> ch ) ) $=
      ( wsb wex weq wa sb1 wb wi bi1 syl6 imp3a syld wal eximdh 19.9hd bi2 com23
      syl5 alimdh sb2 impbid ) ABDEIZCAUICDJZCUIDEKZBLZDJAUJBDEMAULCDFAUKBCAUKBC
      NZBCOHBCPQRUAUECADFGUBSACCDTZUIGAUNUKBOZDTUIACUODFAUKCBAUKUMCBOHBCUCQUDUF
      BDEUGQSUH $.
  $}

  ${
    sbied.1 $e |- F/ x ph $.
    sbied.2 $e |- ( ph -> F/ x ch ) $.
    sbied.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Conversion of implicit substitution to explicit substitution (deduction
       version of ~ sbie ).  (Contributed by NM, 30-Jun-1994.)  (Revised by
       Mario Carneiro, 4-Oct-2016.) $)
    sbied $p |- ( ph -> ( [ y / x ] ps <-> ch ) ) $=
      ( nfri nfrd sbiedh ) ABCDEADFIACDGJHK $.
  $}

  ${
    sbieh.1 $e |- ( ps -> A. x ps ) $.
    sbieh.2 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Conversion of implicit substitution to explicit substitution.
       (Contributed by NM, 30-Jun-1994.) $)
    sbieh $p |- ( [ y / x ] ph <-> ps ) $=
      ( wi wsb wb id hbth wal a1i weq sbiedh ax-mp ) AAGZACDHBIAJZQABCDQCRKBBCLG
      QEMCDNABIGQFMOP $.
  $}

  ${
    sbie.1 $e |- F/ x ps $.
    sbie.2 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Conversion of implicit substitution to explicit substitution.
       (Contributed by NM, 30-Jun-1994.)  (Revised by Mario Carneiro,
       4-Oct-2016.)  (Revised by Wolf Lammen, 30-Apr-2018.) $)
    sbie $p |- ( [ y / x ] ph <-> ps ) $=
      ( nfri sbieh ) ABCDBCEGFH $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                  Theorems using axiom ax-11
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( A property related to substitution that unlike ~ equs5 doesn't require a
     distinctor antecedent.  (Contributed by NM, 2-Feb-2007.) $)
  equs5a $p |- ( E. x ( x = y /\ A. y ph ) -> A. x ( x = y -> ph ) ) $=
    ( weq wal wa wi hba1 ax-11 imp exlimih ) BCDZACEZFLAGZBEZBNBHLMOABCIJK $.

  $( A property related to substitution that unlike ~ equs5 doesn't require a
     distinctor antecedent.  (Contributed by NM, 2-Feb-2007.)  (Revised by NM,
     3-Feb-2015.) $)
  equs5e $p |- ( E. x ( x = y /\ ph ) -> A. x ( x = y -> E. y ph ) ) $=
    ( cv wceq wa wex wal wi 19.8a hbe1 syl anim2i eximi equs5a ) BDCDEZAFZBGPAC
    GZCHZFZBGPRIBHQTBASPARSACJACKLMNRBCOL $.

  $( Analogue to ~ ax-11 but for existential quantification.  (Contributed by
     Mario Carneiro and Jim Kingdon, 31-Dec-2017.)  (Proved by Mario Carneiro,
     9-Feb-2018.) $)
  ax11e $p |- ( x = y -> ( E. x ( x = y /\ ph ) -> E. y ph ) ) $=
    ( cv wceq wa wex wi equs5e 19.21bi com12 ) BDCDEZAFBGZLACGZMLNHBA
    BCIJK $.

  $( Quantifier Substitution for existential quantifiers.  Analogue to ~ ax10o
     but for ` E. ` rather than ` A. ` .  (Contributed by Jim Kingdon,
     21-Dec-2017.) $)
  ax10oe $p |- ( A. x x = y -> ( E. x ps -> E. y ps ) ) $=
    ( cv wceq wal wex wa wi ax-ia3 alimi exim syl ax11e sps syld )
    BDCDEZBFZABGZQAHZBGZACGZRATIZBFSUAIQUCBQAJKATBLMQUAUBIBABCNOP $.

  ${
    drex1.1 $e |- ( A. x x = y -> ( ph <-> ps ) ) $.
    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       Part of Theorem 9.4 of [Megill] p. 448 (p. 16 of preprint).
       (Contributed by NM, 27-Feb-2005.)  (Revised by NM, 3-Feb-2015.) $)
    drex1 $p |- ( A. x x = y -> ( E. x ph <-> E. y ps ) ) $=
      ( cv wceq wal wex wa hbae biantrurd bitr2d exbidh wi ax11e sps
      ax-4 sylbird equcomi bitr3d alequcoms impbid ) CFZDFZGZCHZACIZB
      DIZUGUHUFBJZCIZUIUGUJACCDCKUGABUJEUGUFBUFCRLMNUFUKUIOCBCDPQSUGU
      IUEUDGZAJZDIZUHUGUMBDCDDKUGAUMBUGULAUFULCCDTQLEUANUNUHOZDCULUOD
      ADCPQUBSUC $.
  $}

  $( Formula-building lemma for use with the Distinctor Reduction Theorem.
     Part of Theorem 9.4 of [Megill] p. 448 (p. 16 of preprint).  (Contributed
     by NM, 5-Aug-1993.) $)
  drsb1 $p |- ( A. x x = y -> ( [ z / x ] ph <-> [ z / y ] ph ) ) $=
    ( weq wal wi wa wex wsb wb equequ1 sps imbi1d anbi1d drex1 anbi12d 3bitr4g
    df-sb ) BCEZBFZBDEZAGZUBAHZBIZHCDEZAGZUFAHZCIZHABDJACDJUAUCUGUEUIUAUBUFATUB
    UFKBBCDLMZNUDUHBCUAUBUFAUJOPQABDSACDSR $.

  ${
    exdistrf.1 $e |- ( A. x x = y \/ A. x F/ y ph ) $.
    $( Distribution of existential quantifiers, with a bound-variable
       hypothesis saying that ` y ` is not free in ` ph ` , but ` x ` can be
       free in ` ph ` (and there is no distinct variable condition on ` x ` and
       ` y ` ).  (Contributed by Mario Carneiro, 20-Mar-2013.)  (Hypothesis and
       proof modified for intuitionistic logic by Jim Kingdon, 25-Feb-2018.) $)
    exdistrf $p |- ( E. x E. y ( ph /\ ps ) -> E. x ( ph /\ E. y ps ) ) $=
      ( weq wal wnf wo wa wex wi biidd drex1 drex2 hbe1 19.9h 19.8a anim2i eximi
      sylbi syl6bir ax-ial 19.40 19.9t biimpd anim1d syl5 sps eximdh jaoi ax-mp
      ) CDFCGZADHZCGZIABJZDKZCKZABDKZJZCKZLZEUMVBUOUMURUPCKZCKZVAVCUQCDCUPUPCDU
      MUPMNOVDVCVAVCCUPCPQUPUTCBUSABDRSTUAUBUOUQUTCUNCUCUNUQUTLCUQADKZUSJUNUTAB
      DUDUNVEAUSUNVEAADUEUFUGUHUIUJUKUL $.
  $}

  $( A version of ~ sb4 that doesn't require a distinctor antecedent.
     (Contributed by NM, 2-Feb-2007.) $)
  sb4a $p |- ( [ y / x ] A. y ph -> A. x ( x = y -> ph ) ) $=
    ( wal wsb weq wa wex wi sb1 equs5a syl ) ACDZBCEBCFZMGBHNAIBDMBCJABCKL $.

  ${
    equs45f.1 $e |- ( ph -> A. y ph ) $.
    $( Two ways of expressing substitution when ` y ` is not free in ` ph ` .
       (Contributed by NM, 25-Apr-2008.) $)
    equs45f $p |- ( E. x ( x = y /\ ph ) <-> A. x ( x = y -> ph ) ) $=
      ( weq wa wex wi wal anim2i eximi equs5a syl equs4 impbii ) BCEZAFZBGZPAHB
      IZRPACIZFZBGSQUABATPDJKABCLMABCNO $.

    $( Equivalence for substitution when ` y ` is not free in ` ph ` .
       (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 30-Apr-2008.) $)
    sb6f $p |- ( [ y / x ] ph <-> A. x ( x = y -> ph ) ) $=
      ( wsb weq wi wal sbimi sb4a syl sb2 impbii ) ABCEZBCFAGBHZNACHZBCEOAPBCDI
      ABCJKABCLM $.

    $( Equivalence for substitution when ` y ` is not free in ` ph ` .
       (Contributed by NM, 5-Aug-1993.)  (Revised by NM, 18-May-2008.) $)
    sb5f $p |- ( [ y / x ] ph <-> E. x ( x = y /\ ph ) ) $=
      ( wsb weq wi wal wa wex sb6f equs45f bitr4i ) ABCEBCFZAGBHNAIBJABCDKABCDL
      M $.
  $}

  $( One direction of a simplified definition of substitution that unlike ~ sb4
     doesn't require a distinctor antecedent.  (Contributed by NM,
     2-Feb-2007.) $)
  sb4e $p |- ( [ y / x ] ph -> A. x ( x = y -> E. y ph ) ) $=
    ( wsb weq wa wex wi wal sb1 equs5e syl ) ABCDBCEZAFBGMACGHBIABCJABCKL $.

  $( Special case of a bound-variable hypothesis builder for substitution.
     (Contributed by NM, 2-Feb-2007.) $)
  hbsb2a $p |- ( [ y / x ] A. y ph -> A. x [ y / x ] ph ) $=
    ( wal wsb weq wi sb4a sb2 a5i syl ) ACDBCEBCFAGZBDABCEZBDABCHLMBABCIJK $.

  $( Special case of a bound-variable hypothesis builder for substitution.
     (Contributed by NM, 2-Feb-2007.) $)
  hbsb2e $p |- ( [ y / x ] ph -> A. x [ y / x ] E. y ph ) $=
    ( wsb weq wex wi wal sb4e sb2 a5i syl ) ABCDBCEACFZGZBHMBCDZBHABCINOBMBCJKL
    $.

  ${
    hbsb3.1 $e |- ( ph -> A. y ph ) $.
    $( If ` y ` is not free in ` ph ` , ` x ` is not free in
       ` [ y / x ] ph ` .  (Contributed by NM, 5-Aug-1993.) $)
    hbsb3 $p |- ( [ y / x ] ph -> A. x [ y / x ] ph ) $=
      ( wsb wal sbimi hbsb2a syl ) ABCEZACFZBCEJBFAKBCDGABCHI $.
  $}

  ${
    nfs1.1 $e |- F/ y ph $.
    $( If ` y ` is not free in ` ph ` , ` x ` is not free in
       ` [ y / x ] ph ` .  (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfs1 $p |- F/ x [ y / x ] ph $=
      ( wsb nfri hbsb3 nfi ) ABCEBABCACDFGH $.
  $}

  ${
    sbcof2.1 $e |- ( ph -> A. x ph ) $.
    $( Version of ~ sbco where ` x ` is not free in ` ph ` .  (Contributed by
       Jim Kingdon, 28-Dec-2017.) $)
    sbcof2 $p |- ( [ y / x ] [ x / y ] ph <-> [ y / x ] ph ) $=
      ( cv wsbc wceq wi wal sb6f bitri imim1i imim2i syl alimi wex wa
      jca eximi sb5f hbsb3 imbi2i albii equcomi pm2.43 imim2d pm2.43b
      ax-11 syl6 sylbi ax-i9 exim mpi ax-ial 19.9h biimpi sb2 3syl sb1
      ax-ia1 19.8a ax11e anim1i ax-mp imdistani anbi2i exbii sylibr
      idi impbii ) ACBEZFZBCEZFZABVMFZVNVKVMGZVPAHZBIZHZBIZVRVOVNVPVM
      VKGZAHZCIZHZBIZVTVNVPVLHZBIWEVLBCACBDUAZJWFWDBVLWCVPACBDJUBUCKW
      DVSBWDVPVRVPWCVRVPVPWCVPWBHZBIVRWBBCUHWHVQBWHVPVQHVQWBVQVPVPWAA
      BCUDZLMVPAUENOUIUFUGOUJVTVRBPZVRVTVPBPWJBCUKVPVRBULUMWJVRVRBVQB
      UNUOUPNABCUQURVOVPWAAQZCPZQZBPZVNVOVPVPAQZBPZQZBPZWNVOWPWRABCUS
      WOWQBWOVPWPVPAUTZWOBVARSNWQWMBVPWPWLVPWPWLHZHZVPVPWKQZBPZWLHZHX
      AWKBCVBXDWTVPWPXCWLWOXBBWOVPWKWSVPWAAWIVCRSLMVDVIVESNVNVPVLQZBP
      WNVLBCWGTXEWMBVLWLVPACBDTVFVGKVHVJ $.
  $}

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
                  Predicate calculus with distinct variables
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Derive the axiom of distinct variables ax-16
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    $d x ps $.
    a4imv.1 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( A version of ~ a4im with a distinct variable requirement instead of a
       bound variable hypothesis.  (Contributed by NM, 5-Aug-1993.) $)
    a4imv $p |- ( A. x ph -> ps ) $=
      ( ax-17 a4im ) ABCDBCFEG $.
  $}

  ${
    $v f $.
    $( Define a temporary individual variable. $)
    aev.vf $f set f $.
    $d f u v $.  $d f u x y $.  $d u w $.
    $( A "distinctor elimination" lemma with no restrictions on variables in
       the consequent, proved without using ~ ax-16 .  (Contributed by NM,
       8-Nov-2006.)  (Proof shortened by Andrew Salmon, 21-Jun-2011.) $)
    aev $p |- ( A. x x = y -> A. z w = v ) $=
      ( aev.vf vu weq wal hbae ax-8 a4imv alrimih equcomi alequcoms a5i alequcom
      syl6 3syl ) ABHZAIZDEHZCABCJUAFBHZFIZGEHZGIZUBUAUCFABFJTUCAFAFBKLMUDFGHZF
      IZEGHZEIUFUCUGFUGBFBFHZUGBGBGHUJGFHUGBGFKGFNRLOPUHUIEFGEJUGUIFEFEGKLMEGQS
      UEUBGDGDEKLSM $.
  $}

  ${
    $d x y $.  $d z ph $.
    $( Theorem showing that ~ ax-16 is redundant if ~ ax-17 is included in the
       axiom system.  The important part of the proof is provided by ~ aev .

       See ~ ax16ALT for an alternate proof that does not require ~ ax-10 or
       ~ ax-12 .

       This theorem should not be referenced in any proof.  Instead, use
       ~ ax-16 below so that theorems needing ~ ax-16 can be more easily
       identified.  (Contributed by NM, 8-Nov-2006.) $)
    ax16 $p |- ( A. x x = y -> ( ph -> A. x ph ) ) $=
      ( vz weq wal wi aev ax-17 sbequ12 biimpcd alimdh hbsb3 stdpc7 cbv3h syl6com
      wsb syl ) BCEBFBDEZDFZAABFZGBCDBDHATABDQZDFUAASUBDADIZSAUBABDJKLUBADBABDU
      CMUCADBNOPR $.
  $}

  ${
    $d x y $.
    $( Axiom of Distinct Variables.  The only axiom of predicate calculus
       requiring that variables be distinct (if we consider ~ ax-17 to be a
       metatheorem and not an axiom).  Axiom scheme C16' in [Megill] p. 448 (p.
       16 of the preprint).  It apparently does not otherwise appear in the
       literature but is easily proved from textbook predicate calculus by
       cases.  It is a somewhat bizarre axiom since the antecedent is always
       false in set theory, but nonetheless it is technically necessary as you
       can see from its uses.

       This axiom is redundant if we include ~ ax-17 ; see theorem ~ ax16 .

       This axiom is obsolete and should no longer be used.  It is proved above
       as theorem ~ ax16 .  (Contributed by NM, 5-Aug-1993.)
       (New usage is discouraged.) $)
    ax-16 $a |- ( A. x x = y -> ( ph -> A. x ph ) ) $.
  $}

  ${
    $d w z x $.  $d w y $.
    $( Quantifier introduction when one pair of variables is distinct.
       (Contributed by NM, 2-Jan-2002.) $)
    dveeq2 $p |- ( -. A. x x = y -> ( z = y -> A. x z = y ) ) $=
      ( weq wal wn wi wo ax-i12 orcom orbi2i mpbi orass mpbir orel2 mpi ax16 sp
      jaoi syl ) ABDAEZFZACDAEZCBDZUDAEGZAEZHZUEUBUGUAHZUGUHUCUFUAHZHZUCUAUFHZH
      UJCBAIUKUIUCUAUFJKLUCUFUAMNUAUGOPUCUEUFUDACQUEARST $.
  $}

  ${
    $d z x $.
    $( Quantifier introduction when one pair of variables is distinct.  Like
       ~ dveeq2 but connecting ` A. x x = y ` by a disjunction rather than
       negation and implication makes the theorem stronger in intuitionistic
       logic.  (Contributed by Jim Kingdon, 1-Feb-2018.) $)
    dveeq2or $p |- ( A. x x = y \/ F/ x z = y ) $=
      ( weq wal wi wnf ax-i12 orass mpbir pm1.4 orim1i ax-mp mpbi ax16 a5i jaoi
      wo id orim2i df-nf biimpri ) ABDAEZCBDZUDAEFZAEZRZUCUDAGZRUCACDZAEZUFRZRZ
      UGUCUJRZUFRZULUJUCRZUFRZUNUPUJUGRCBAHUJUCUFIJUOUMUFUJUCKLMUCUJUFINUKUFUCU
      JUFUFUIUEAUDACOPUFSQTMUFUHUCUHUFUDAUAUBTM $.
  $}

  ${
    $d x z $.  $d y z $.
    dvelimfALT2.1 $e |- ( ph -> A. x ph ) $.
    dvelimfALT2.2 $e |- ( ps -> A. z ps ) $.
    dvelimfALT2.3 $e |- ( z = y -> ( ph <-> ps ) ) $.
    dvelimfALT2.4 $e |- ( -. A. x x = y -> ( z = y -> A. x z = y ) ) $.
    $( Proof of ~ dvelimf using ~ dveeq2 (shown as the last hypothesis) instead
       of ~ ax-12 .  This shows that ~ ax-12 could be replaced by ~ dveeq2 (the
       last hypothesis).  (Contributed by Andrew Salmon, 21-Jul-2011.) $)
    dvelimfALT2 $p |- ( -. A. x x = y -> ( ps -> A. x ps ) ) $=
      ( cv wceq wal wn wi ax-17 hbn1 a1i hbimd hbald equsal albii 3imtr3g ) CJD
      JZKZCLMZEJUCKZANZELZUHCLBBCLUEUGCEUEEOUEUFACUDCPIAACLNUEFQRSABEDGHTZUHBCU
      IUAUB $.
  $}

  ${
    $d z x $.
    $( A lemma for proving conditionless ZFC axioms.  (Contributed by NM,
       8-Jan-2002.) $)
    nd5 $p |- ( -. A. y y = x -> ( z = y -> A. x z = y ) ) $=
      ( cv wceq wal wi dveeq2 nalequcoms ) CDBDEZJAFGABABCHI $.
  $}

  ${
    $d x ch $.  $d x ph $.
    exlimdv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       27-Apr-1994.) $)
    exlimdv $p |- ( ph -> ( E. x ps -> ch ) ) $=
      ( ax-17 exlimdh ) ABCDADFCDFEG $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.
    ax11v2.1 $e |- ( x = z -> ( ph -> A. x ( x = z -> ph ) ) ) $.
    $( Recovery of ~ ax11o from ~ ax11v without using ~ ax-11 .  The hypothesis
       is even weaker than ~ ax11v , with ` z ` both distinct from ` x ` _and_
       not occurring in ` ph ` .  Thus the hypothesis provides an alternate
       axiom that can be used in place of ~ ax11o .  (Contributed by NM,
       2-Feb-2007.) $)
    ax11v2 $p |- ( -. A. x x = y ->
                 ( x = y -> ( ph -> A. x ( x = y -> ph ) ) ) ) $=
      ( weq wal wn wex wi a9e wa wb equequ2 adantl dveeq2 imp hba1 imbi1d sps
      albidh syl imbi2d imbi12d mpbii ex exlimdv mpi ) BCFZBGHZDCFZDIUIAUIAJZBGZ
      JZJZDCKUJUKUODUJUKUOUJUKLZBDFZAUQAJZBGZJZJUOEUPUQUIUTUNUKUQUIMUJDCBNZOUPU
      SUMAUPUKBGZUSUMMUJUKVBBCDPQVBURULBUKBRUKURULMBUKUQUIAVASTUAUBUCUDUEUFUGUH
      $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.
    ax11a2.1 $e |- ( x = z -> ( A. z ph -> A. x ( x = z -> ph ) ) ) $.
    $( Derive ~ ax-11o from a hypothesis in the form of ~ ax-11 .  The
       hypothesis is even weaker than ~ ax-11 , with ` z ` both distinct from
       ` x ` and not occurring in ` ph ` .  Thus the hypothesis provides an
       alternate axiom that can be used in place of ~ ax11o .  (Contributed by
       NM, 2-Feb-2007.) $)
    ax11a2 $p |- ( -. A. x x = y ->
                 ( x = y -> ( ph -> A. x ( x = y -> ph ) ) ) ) $=
      ( wal weq wi ax-17 syl5 ax11v2 ) ABCDAADFBDGZLAHBFADIEJK $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Derive the obsolete axiom of variable substitution ax-11o
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    $d x z $.  $d y z $.  $d z ph $.
    $( Derivation of set.mm's original ~ ax-11o from the shorter ~ ax-11 that
       has replaced it.

       An open problem is whether this theorem can be proved without relying on
       ~ ax-16 or ~ ax-17 .

       Normally, ~ ax11o should be used rather than ~ ax-11o , except by
       theorems specifically studying the latter's properties.  (Contributed by
       NM, 3-Feb-2007.) $)
    ax11o $p |- ( -. A. x x = y ->
               ( x = y -> ( ph -> A. x ( x = y -> ph ) ) ) ) $=
      ( vz ax-11 ax11a2 ) ABCDABDEF $.
  $}

  $( Axiom ~ ax-11o ("o" for "old") was the original version of ~ ax-11 ,
     before it was discovered (in Jan. 2007) that the shorter ~ ax-11 could
     replace it.  It appears as Axiom scheme C15' in [Megill] p. 448 (p. 16 of
     the preprint).  It is based on Lemma 16 of [Tarski] p. 70 and Axiom C8 of
     [Monk2] p. 105, from which it can be proved by cases.  To understand this
     theorem more easily, think of " ` -. A. x x = y -> ` ..." as informally
     meaning "if ` x ` and ` y ` are distinct variables then..."  The
     antecedent becomes false if the same variable is substituted for ` x ` and
     ` y ` , ensuring the theorem is sound whenever this is the case.  In some
     later theorems, we call an antecedent of the form ` -. A. x x = y ` a
     "distinctor."

     This axiom is redundant, as shown by theorem ~ ax11o .

     This axiom is obsolete and should no longer be used.  It is proved above
     as theorem ~ ax11o .  (Contributed by NM, 5-Aug-1993.)
     (New usage is discouraged.) $)
  ax-11o $a |- ( -. A. x x = y ->
             ( x = y -> ( ph -> A. x ( x = y -> ph ) ) ) ) $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
     More theorems related to ax-11 and substitution
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    $d x ph $.
    albidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for universal quantifier (deduction rule).
       (Contributed by NM, 5-Aug-1993.) $)
    albidv $p |- ( ph -> ( A. x ps <-> A. x ch ) ) $=
      ( ax-17 albidh ) ABCDADFEG $.

    $( Formula-building rule for existential quantifier (deduction rule).
       (Contributed by NM, 5-Aug-1993.) $)
    exbidv $p |- ( ph -> ( E. x ps <-> E. x ch ) ) $=
      ( ax-17 exbidh ) ABCDADFEG $.
  $}

  $( A bidirectional version of ~ ax-11o .  (Contributed by NM,
     30-Jun-2006.) $)
  ax11b $p |- ( ( -. A. x x = y /\ x = y ) ->
              ( ph <-> A. x ( x = y -> ph ) ) ) $=
    ( weq wal wn wa wi ax-11o imp ax-4 com12 adantl impbid ) BCDZBEFZOGAOAHZBEZ
    POARHABCIJORAHPROAQBKLMN $.

  ${
    $d x y $.  $d x z $.  $d y z $.  $d ph z $.
    $( This is a version of ~ ax-11o when the variables are distinct.  Axiom
       (C8) of [Monk2] p. 105.  (Contributed by NM, 5-Aug-1993.)  (Revised by
       Jim Kingdon, 15-Dec-2017.) $)
    ax11v $p |- ( x = y -> ( ph -> A. x ( x = y -> ph ) ) ) $=
      ( vz cv wceq wex wi wal a9e ax-17 ax-11 syl5 imbi1d albidv imbi2d
      equequ2 imbi12d mpbii exlimiv ax-mp ) DEZCEZFZDGBEZUCFZAUFAHZBIZH
      ZHZDCJUDUJDUDUEUBFZAUKAHZBIZHZHUJAADIUKUMADKABDLMUDUKUFUNUIDCBQZU
      DUMUHAUDULUGBUDUKUFAUONOPRSTUA $.
  $}

  ${
    $d x y $.  $d x z $.  $d y z $.  $d ph z $.
    $( Analogue to ~ ax11v for existential quantification.  (Contributed by Jim
       Kingdon, 9-Jan-2018.) $)
    ax11ev $p |- ( x = y -> ( E. x ( x = y /\ ph ) -> ph ) ) $=
      ( vz cv wceq wex wa wi ax11e ax-17 syl6ib equequ2 anbi1d exbidv
      a9e 19.9h imbi1d imbi12d mpbii exlimiv ax-mp ) DEZCEZFZDGBEZUDFZUG
      AHZBGZAIZIZDCPUEUKDUEUFUCFZULAHZBGZAIZIUKULUNADGAABDJADADKQLUEULU
      GUOUJDCBMZUEUNUIAUEUMUHBUEULUGAUPNORSTUAUB $.
  $}

  $( Lemma used in proofs of substitution properties.  (Contributed by NM,
     5-Aug-1993.) $)
  equs5 $p |- ( -. A. x x = y ->
             ( E. x ( x = y /\ ph ) -> A. x ( x = y -> ph ) ) ) $=
    ( weq wal wn wa wi hbnae hba1 ax11o imp3a exlimdh ) BCDZBEFZNAGNAHZBEZBBCBIP
    BJONAQABCKLM $.

  ${
    $d x z $.  $d y z $.  $d ph z $.

    $( Lemma used in proofs of substitution properties.  Like ~ equs5 but, in
       intuitionistic logic, replacing negation and implication with
       disjunction makes this a stronger result.  (Contributed by Jim Kingdon,
       2-Feb-2018.) $)
    equs5or $p |- ( A. x x = y \/
             ( E. x ( x = y /\ ph ) -> A. x ( x = y -> ph ) ) ) $=
      ( vz weq wex wal wa wi wo a9e wnf dveeq2or nfnf1 nfri ax11v equequ2 ax-mp
      wb hba1 adantl nfr imp imbi1d sps albidh syl imbi2d imbi12d mpbii ex imp4a
      alrimih 19.21t mpbid 19.23 syl6ib orim2i pm2.76 olcs exlimiv ) DCEZDFBCEZB
      GZVCAHZBFVCAIZBGZIZJZDCKVBVIDVDVBVIVDVBVHIZJZVDVBJVIIVDVBBLZJVKBCDMVLVJVD
      VLVBVEVGIZBGZVHVLVBVMIZBGVBVNIVLVOBVLBVBBNOVLVBVCAVGVLVBVCAVGIZIZVLVBHZBD
      EZAVSAIZBGZIZIVQABDPVRVSVCWBVPVBVSVCSVLDCBQZUAVRWAVGAVRVBBGZWAVGSVLVBWDVB
      BUBUCWDVTVFBVBBTVBVTVFSBVBVSVCAWCUDUEUFUGUHUIUJUKULUMVBVMBUNUOVEVGBVFBTUP
      UQURRVDVBVHUSRUTVAR $.
  $}

  $( One direction of a simplified definition of substitution when variables
     are distinct.  (Contributed by NM, 5-Aug-1993.) $)
  sb3 $p |- ( -. A. x x = y -> ( E. x ( x = y /\ ph ) -> [ y / x ] ph ) ) $=
    ( weq wal wn wa wex wi wsb equs5 sb2 syl6 ) BCDZBEFNAGBHNAIBEABCJABCKABCLM
    $.

  $( One direction of a simplified definition of substitution when variables
     are distinct.  (Contributed by NM, 5-Aug-1993.) $)
  sb4 $p |- ( -. A. x x = y -> ( [ y / x ] ph -> A. x ( x = y -> ph ) ) ) $=
    ( wsb weq wa wex wal wn wi sb1 equs5 syl5 ) ABCDBCEZAFBGNBHINAJBHABCKABCLM
    $.

  $( One direction of a simplified definition of substitution when variables
     are distinct.  Similar to ~ sb4 but stronger in intuitionistic logic.
     (Contributed by Jim Kingdon, 2-Feb-2018.) $)
  sb4or $p |- ( A. x x = y \/
      A. x ( [ y / x ] ph -> A. x ( x = y -> ph ) ) ) $=
    ( weq wal wa wex wi wo wsb equs5or nfe1 nfa1 nfim nfri imim1i alrimih orim2i
    sb1 ax-mp ) BCDZBEZUAAFZBGZUAAHZBEZHZIUBABCJZUFHZBEZIABCKUGUJUBUGUIBUGBUDUF
    BUCBLUEBMNOUHUDUFABCSPQRT $.

  $( Simplified definition of substitution when variables are distinct.
     (Contributed by NM, 27-May-1997.) $)
  sb4b $p |- ( -. A. x x = y -> ( [ y / x ] ph <-> A. x ( x = y -> ph ) ) ) $=
    ( weq wal wn wsb wi sb4 sb2 impbid1 ) BCDZBEFABCGLAHBEABCIABCJK $.

  $( Simplified definition of substitution when variables are distinct,
     expressed via disjunction.  (Contributed by Jim Kingdon, 18-Mar-2018.) $)
  sb4bor $p |- ( A. x x = y \/
      A. x ( [ y / x ] ph <-> A. x ( x = y -> ph ) ) ) $=
    ( weq wal wsb wi wo wb sb4or sb2 wa df-bi simpri mpan2 alimi orim2i ax-mp )
    BCDZBEZABCFZSAGBEZGZBEZHTUAUBIZBEZHABCJUDUFTUCUEBUCUBUAGZUEABCKUEUCUGLZGUHU
    EGUAUBMNOPQR $.

  $( Bound-variable hypothesis builder for substitution.  (Contributed by NM,
     5-Aug-1993.) $)
  hbsb2 $p |- ( -. A. x x = y -> ( [ y / x ] ph -> A. x [ y / x ] ph ) ) $=
    ( weq wal wn wsb wi sb4 sb2 a5i syl6 ) BCDZBEFABCGZMAHZBENBEABCIONBABCJKL
    $.

  $( Bound-variable hypothesis builder for substitution.  Similar to ~ hbsb2
     but in intuitionistic logic a disjunction is stronger than an
     implication.  (Contributed by Jim Kingdon, 2-Feb-2018.) $)
  nfsb2or $p |- ( A. x x = y \/ F/ x [ y / x ] ph ) $=
    ( weq wal wsb wi wnf sb4or sb2 a5i imim2i alimi df-nf sylibr orim2i ax-mp
    wo ) BCDZBEZABCFZSAGZBEZGZBEZRTUABHZRABCIUEUFTUEUAUABEZGZBEUFUDUHBUCUGUAUBU
    ABABCJKLMUABNOPQ $.

  ${
    sbequilem.1 $e |- ( ph \/ ( ps -> ( ch -> th ) ) ) $.
    sbequilem.2 $e |- ( ta \/ ( ps -> ( th -> et ) ) ) $.
    $( Propositional logic lemma used in the ~ sbequi proof.  (Contributed by
       Jim Kingdon, 1-Feb-2018.) $)
    sbequilem $p |- ( ph \/ ( ta \/ ( ps -> ( ch -> et ) ) ) ) $=
      ( wo wi wa pm3.2i andi andir orbi12i orim2i ax-mp
      mpbi orim1i orass pm3.43 pm3.33 ax-ia2 sylbir ax-ia1 mpbir orbi1i
      syl6 orcom ) AEIZBCFJZJZIZAEULIIEAIZULIZUMUOEAULIZIZEABDFJZJZKZUL
      IZIZUQAEKBCDJZJZEKIZVAIZVBVEUTVDUSKZIZIZVFAVDIZEKZVJUSKZIZVIVJEUS
      IZKVMVJVNGHLVJEUSMRVKVEVLVHAVDENZAVDUSNORVHVAVEVGULUTVGBVCURKUKBV
      CURUACDFUBUHPPQVEEVAVEVKEVOVJEUCUDSQVAUPEUTAULAUSUESPQEAULTUFUNUJ
      ULEAUIUGRAEULTR $.
  $}

  $( An equality theorem for substitution.  (Contributed by NM, 5-Aug-1993.)
     (Proof modified by Jim Kingdon, 1-Feb-2018.) $)
  sbequi $p |- ( x = y -> ( [ x / z ] ph -> [ y / z ] ph ) ) $=
    ( weq wal wsb wi wo wex nfsb2or wa stdpc7 sbequ1 sylan9 orim2i ax-mp biimpd
    wnf sps equvini eximi 19.35-1 3syl syl9 19.9t sbequilem sbequ2 adantr drsb1
    nfr ax-1 alequcoms sylan9r syld ex orim1i pm1.2 syl jaoi ) DBEZDFZDCEZDFZBC
    EZADBGZADCGZHZHZIZIVIVBVEVFVGDJZVDVGVBVFDSZIVBVEVFVKHHZIADBKVLVMVBVLVFVFDFZ
    VEVKVFDUKVEBDEZVCLZDJVHDJVNVKHBCDUAVPVHDVOVFAVCVGABDMADCNZOUBVFVGDUCUDUEPQV
    DVKVGHZIZVDVEVRHZIVDVGDSZIVSADCKWAVRVDWAVKVGVGDUFRPQVRVTVDVRVEULPQUGVBVIVJV
    BVEVHVBVELVFAVGVBVFAHZVEVAWBDADBUHTUIVEAABCGZVBVGABCNWCVGHBDVOBFWCVGABDCUJR
    UMUNUOUPVJVIVIIVIVDVIVIVDVEVHVDVELVFAVGVDVFACBGZVEAVDVFWDADCBUJRABCMOVDAVGH
    ZVEVCWEDVQTUIUOUPUQVIURUSUTQ $.

  $( An equality theorem for substitution.  Used in proof of Theorem 9.7 in
     [Megill] p. 449 (p. 16 of the preprint).  (Contributed by NM,
     5-Aug-1993.) $)
  sbequ $p |- ( x = y -> ( [ x / z ] ph <-> [ y / z ] ph ) ) $=
    ( weq wsb sbequi wi equcoms impbid ) BCEADBFZADCFZABCDGLKHCBACBDGIJ $.

  $( Formula-building lemma for use with the Distinctor Reduction Theorem.
     Part of Theorem 9.4 of [Megill] p. 448 (p. 16 of preprint).  (Contributed
     by NM, 27-Feb-2005.) $)
  drsb2 $p |- ( A. x x = y -> ( [ x / z ] ph <-> [ y / z ] ph ) ) $=
    ( cv wceq wsbc wb sbequ sps ) BEZCEZFADKGADLGHBABCDIJ $.

  $( A specialization theorem, mostly the same as Theorem 19.8 of [Margaris]
     p. 89.  (Contributed by NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon,
     29-Dec-2017.) $)
  a4sbe $p |- ( [ y / x ] ph -> E. x ph ) $=
    ( cv wsbc wceq wa wex sb1 ax-ia2 eximi syl ) ABCDZEBDMFZAGZBHABHA
    BCIOABNAJKL $.

  $( Specialization of implication.  (Contributed by NM, 5-Aug-1993.)  (Proof
     rewritten by Jim Kingdon, 21-Jan-2018.) $)
  a4sbim $p |- ( A. x ( ph -> ps ) -> ( [ y / x ] ph -> [ y / x ] ps ) ) $=
    ( wi wal weq wa wex wsb imim2 sps id anim2d alimi syl anim12d df-sb 3imtr4g
    exim ) ABEZCFZCDGZAEZUCAHZCIZHUCBEZUCBHZCIZHACDJBCDJUBUDUGUFUIUAUDUGECABUCK
    LUBUEUHEZCFUFUIEUAUJCUAABUCUAMNOUEUHCTPQACDRBCDRS $.

  $( Specialization of biconditional.  (Contributed by NM, 5-Aug-1993.)  (Proof
     rewritten by Jim Kingdon, 21-Jan-2018.) $)
  a4sbbi $p |- ( A. x ( ph <-> ps ) -> ( [ y / x ] ph <-> [ y / x ] ps ) ) $=
    ( wi wal wa wsb wb a4sbim anim12i albiim dfbi2 3imtr4i ) ABECFZBAECFZGACDHZ
    BCDHZEZRQEZGABICFQRIOSPTABCDJBACDJKABCLQRMN $.

  ${
    sbbid.1 $e |- ( ph -> A. x ph ) $.
    sbbid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Deduction substituting both sides of a biconditional.  (Contributed by
       NM, 5-Aug-1993.) $)
    sbbid $p |- ( ph -> ( [ y / x ] ps <-> [ y / x ] ch ) ) $=
      ( wb wal wsb alrimih a4sbbi syl ) ABCHZDIBDEJCDEJHANDFGKBCDELM $.
  $}

  $( Elimination of equality from antecedent after substitution.  (Contributed
     by NM, 5-Aug-1993.)  (Proof revised by Jim Kingdon, 20-Jan-2018.) $)
  sbequ8 $p |- ( [ y / x ] ph <-> [ y / x ] ( x = y -> ph ) ) $=
    ( weq wi wa wex wsb pm5.4 ax-ia1 pm3.35 pm3.4 impbii exbii anbi12i 3bitr4ri
    jca df-sb ) BCDZSAEZEZSTFZBGZFTSAFZBGZFTBCHABCHUATUCUESAIUBUDBUBUDUBSASTJSA
    KQUDSTSAJSALQMNOTBCRABCRP $.

  $( Substitution has no effect on a non-free variable.  (Contributed by NM,
     30-May-2009.) $)
  sbf3t $p |- ( A. x ( ph -> A. x ph ) -> ( [ y / x ] ph <-> ph ) ) $=
    ( wal wi wsb a4sbim sbf2 ax-4 sylbi syl6 stdpc4 imim2i sps impbid ) AABDZEZ
    BDZABCFZARSPBCFZAAPBCGTPAABCHABIJKQASEBPSAABCLMNO $.

  ${
    sbid2.1 $e |- ( ph -> A. x ph ) $.
    $( An identity law for substitution.  (Contributed by NM, 5-Aug-1993.) $)
    sbid2 $p |- ( [ y / x ] [ x / y ] ph <-> ph ) $=
      ( cv wsbc sbcof2 sbh bitri ) ACBEFBCEZFABJFAABCDGABCDHI $.
  $}

  $( An idempotent law for substitution.  (Contributed by NM, 30-Jun-1994.)
     (Proof rewritten by Jim Kingdon, 21-Jan-2018.) $)
  sbidm $p |- ( [ y / x ] [ y / x ] ph <-> [ y / x ] ph ) $=
    ( wsb weq wi wa wex df-sb simplbi sbimi sbequ8 sylibr ax-1 sb1 pm4.24 19.41h
    ax-ie1 bitr4i exbii anim2i anim1i eximi sylbi anass sylib anbi2i syl impbii
    sylanbrc ) ABCDZBCDZUKULBCEZAFZBCDUKUKUNBCUKUNUMAGZBHZABCIZJKABCLMUKUMUKFUM
    UKGZBHZULUKUMNUKUPUSABCOUPUMUNUPGZGZBHZUSUPUMUNGZUPGZBHZVBUPUOUPGZBHZVEUPUP
    UPGVGUPPUOUPBUOBRQSVFVDBUOVCUPAUNUMAUMNUAUBUCUDVDVABUMUNUPUETUFURVABUKUTUMU
    QUGTMUHUKBCIUJUI $.

  ${
    sb5rf.1 $e |- ( ph -> A. y ph ) $.
    $( Reversed substitution.  (Contributed by NM, 3-Feb-2005.)  (Proof
       shortened by Andrew Salmon, 25-May-2011.) $)
    sb5rf $p |- ( ph <-> E. y ( y = x /\ [ y / x ] ph ) ) $=
      ( weq wsb wa wex sbid2 sb1 sylbir stdpc7 imp exlimih impbii ) ACBEZABCFZGZ
      CHZAQCBFSACBDIQCBJKRACDPQAACBLMNO $.

    $( Reversed substitution.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Andrew Salmon, 25-May-2011.) $)
    sb6rf $p |- ( ph <-> A. y ( y = x -> [ y / x ] ph ) ) $=
      ( weq wsb wi wal sbequ1 equcoms com12 alrimih sb2 sbid2 sylib impbii ) ACB
      EZABCFZGZCHZASCDQARARGBCABCIJKLTRCBFARCBMACBDNOP $.
  $}

  ${
    sb8h.1 $e |- ( ph -> A. y ph ) $.
    $( Substitution of variable in universal quantifier.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Andrew Salmon, 25-May-2011.)  (Proof
       shortened by Jim Kingdon, 15-Jan-2018.) $)
    sb8h $p |- ( A. x ph <-> A. y [ y / x ] ph ) $=
      ( wsb hbsb3 sbequ12 cbvalh ) AABCEBCDABCDFABCGH $.
  $}

  ${
    sb8eh.1 $e |- ( ph -> A. y ph ) $.
    $( Substitution of variable in existential quantifier.  (Contributed by NM,
       12-Aug-1993.)  (Proof rewritten by Jim Kingdon, 15-Jan-2018.) $)
    sb8eh $p |- ( E. x ph <-> E. y [ y / x ] ph ) $=
      ( wsb hbsb3 sbequ12 cbvexh ) AABCEBCDABCDFABCGH $.
  $}

  ${
    sb8e.1 $e |- F/ y ph $.
    $( Substitution of variable in universal quantifier.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Mario Carneiro, 6-Oct-2016.)  (Proof shortened
       by Jim Kingdon, 15-Jan-2018.) $)
    sb8 $p |- ( A. x ph <-> A. y [ y / x ] ph ) $=
      ( wsb nfs1 sbequ12 cbval ) AABCEBCDABCDFABCGH $.

    $( Substitution of variable in existential quantifier.  (Contributed by NM,
       12-Aug-1993.)  (Revised by Mario Carneiro, 6-Oct-2016.)  (Proof
       shortened by Jim Kingdon, 15-Jan-2018.) $)
    sb8e $p |- ( E. x ph <-> E. y [ y / x ] ph ) $=
      ( wsb nfs1 sbequ12 cbvex ) AABCEBCDABCDFABCGH $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Predicate calculus with distinct variables (cont.)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    $d x y z $.  $d z ph $.
    ax16i.1 $e |- ( x = z -> ( ph <-> ps ) ) $.
    ax16i.2 $e |- ( ps -> A. x ps ) $.
    $( Inference with ~ ax-16 as its conclusion, that doesn't require ~ ax-10 ,
       ~ ax-11 , or ~ ax-12 for its proof.  The hypotheses may be eliminable
       without one or more of these axioms in special cases.  (Contributed by
       NM, 20-May-2008.) $)
    ax16i $p |- ( A. x x = y -> ( ph -> A. x ph ) ) $=
      ( weq wal wi ax-17 ax-8 cbv3h a4imv equid mpi syl syl5com alimdh mpcom
      alimi biimpcd biimprd syl6com ) CDHZCIZCEHZEIZAACIZJUFEDHZEIZUHUEUJCEUEEK
      ZUJCKCEDLMUKECHZEIZUHUEUKUNUJUEECECDLNUEUJUMEULUEDCHZUJUMUECCHUOCOCDCLPUJ
      DEHZUOUMJUJEEHZUPEOZEDELPDECLQRSTUMUGEUMUQUGURECELPZUAQQAUHBEIUIAUGBEAEKZ
      UGABFUBSBAECGUTUMUGBAJUSUGABFUCQMUDQ $.
  $}

  ${
    $d x y z $.  $d z ph $.
    $( Version of ~ ax16 that doesn't require ~ ax-10 or ~ ax-12 for its
       proof.  (Contributed by NM, 17-May-2008.) $)
    ax16ALT $p |- ( A. x x = y -> ( ph -> A. x ph ) ) $=
      ( vz wsb sbequ12 ax-17 hbsb3 ax16i ) AABDEBCDABDFABDADGHI $.
  $}

  ${
    $d x ps $.
    a4v.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Specialization, using implicit substitition.  (Contributed by NM,
       30-Aug-1993.) $)
    a4v $p |- ( A. x ph -> ps ) $=
      ( weq biimpd a4imv ) ABCDCDFABEGH $.
  $}

  ${
    $d x ph $.
    a4imev.1 $e |- ( x = y -> ( ph -> ps ) ) $.
    $( Distinct-variable version of ~ a4ime .  (Contributed by NM,
       5-Aug-1993.) $)
    a4imev $p |- ( ph -> E. x ps ) $=
      ( ax-17 a4ime ) ABCDACFEG $.
  $}

  ${
    $d x ps $.
    a4eiv.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    a4eiv.2 $e |- ps $.
    $( Inference from existential specialization, using implicit substitition.
       (Contributed by NM, 19-Aug-1993.) $)
    a4eiv $p |- E. x ph $=
      ( wex weq biimprd a4imev ax-mp ) BACGFBACDCDHABEIJK $.
  $}

  ${
    $d x z $.  $d y z $.
    $( A variable introduction law for equality.  Lemma 15 of [Monk2] p. 109.
       (Contributed by NM, 5-Aug-1993.) $)
    equvin $p |- ( x = y <-> E. z ( x = z /\ z = y ) ) $=
      ( weq wa wex equvini ax-17 equtr imp exlimih impbii ) ABDZACDZCBDZEZCFABCG
      PMCMCHNOMACBIJKL $.
  $}

  ${
    $d x y $.
    $( A generalization of axiom ~ ax-16 .  (Contributed by NM, 5-Aug-1993.)
       (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    a16g $p |- ( A. x x = y -> ( ph -> A. z ph ) ) $=
      ( weq wal aev ax16 biidd dral1 biimprd sylsyld ) BCEBFDBEDFZAABFZADFZBCD
      DBGABCHMONAADBMAIJKL $.

    $( A generalization of axiom ~ ax-16 .  (Contributed by NM, 5-Aug-1993.) $)
    a16gb $p |- ( A. x x = y -> ( ph <-> A. z ph ) ) $=
      ( weq wal a16g ax-4 impbid1 ) BCEBFAADFABCDGADHI $.

    $( If there is only one element in the universe, then everything satisfies
       ` F/ ` .  (Contributed by Mario Carneiro, 7-Oct-2016.) $)
    a16nf $p |- ( A. x x = y -> F/ z ph ) $=
      ( weq wal nfae a16g nfd ) BCEBFADBCDGABCDHI $.
  $}

  ${
    $d x ph $.  $d y ph $.
    2albidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for 2 existential quantifiers (deduction rule).
       (Contributed by NM, 4-Mar-1997.) $)
    2albidv $p |- ( ph -> ( A. x A. y ps <-> A. x A. y ch ) ) $=
      ( wal albidv ) ABEGCEGDABCEFHH $.

    $( Formula-building rule for 2 existential quantifiers (deduction rule).
       (Contributed by NM, 1-May-1995.) $)
    2exbidv $p |- ( ph -> ( E. x E. y ps <-> E. x E. y ch ) ) $=
      ( wex exbidv ) ABEGCEGDABCEFHH $.
  $}

  ${
    $d x ph $.  $d y ph $.  $d z ph $.
    3exbidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for 3 existential quantifiers (deduction rule).
       (Contributed by NM, 1-May-1995.) $)
    3exbidv $p |- ( ph -> ( E. x E. y E. z ps <-> E. x E. y E. z ch ) ) $=
      ( wex exbidv 2exbidv ) ABFHCFHDEABCFGIJ $.
  $}

  ${
    $d x ph $.  $d y ph $.  $d z ph $.  $d w ph $.
    4exbidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for 4 existential quantifiers (deduction rule).
       (Contributed by NM, 3-Aug-1995.) $)
    4exbidv $p |- ( ph ->
                     ( E. x E. y E. z E. w ps <-> E. x E. y E. z E. w ch ) ) $=
      ( wex 2exbidv ) ABGIFICGIFIDEABCFGHJJ $.
  $}

  ${
    $d x ph $.
    $( Special case of Theorem 19.9 of [Margaris] p. 89.  (Contributed by NM,
       28-May-1995.)  (Revised by NM, 21-May-2007.) $)
    19.9v $p |- ( E. x ph <-> ph ) $=
      ( ax-17 19.9h ) ABABCD $.
  $}

  ${
    $d x ph $.
    $( Special case of Theorem 19.21 of [Margaris] p. 90. _Notational
       convention_:  We sometimes suffix with "v" the label of a theorem
       eliminating a hypothesis such as ` ( ph -> A. x ph ) ` in ~ 19.21 via
       the use of distinct variable conditions combined with ~ ax-17 .
       Conversely, we sometimes suffix with "f" the label of a theorem
       introducing such a hypothesis to eliminate the need for the distinct
       variable condition; e.g. ~ euf derived from ~ df-eu .  The "f" stands
       for "not free in" which is less restrictive than "does not occur in."
       (Contributed by NM, 5-Aug-1993.) $)
    19.21v $p |- ( A. x ( ph -> ps ) <-> ( ph -> A. x ps ) ) $=
      ( ax-17 19.21h ) ABCACDE $.
  $}

  ${
    $d x ph $.
    alrimiv.1 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    alrimiv $p |- ( ph -> A. x ps ) $=
      ( ax-17 alrimih ) ABCACEDF $.
  $}

  ${
    $d x ph $.  $d y ph $.
    alrimivv.1 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
       31-Jul-1995.) $)
    alrimivv $p |- ( ph -> A. x A. y ps ) $=
      ( wal alrimiv ) ABDFCABDEGG $.
  $}

  ${
    $d x ph $.  $d x ps $.
    alrimdv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.21 of [Margaris] p. 90.  (Contributed by NM,
       10-Feb-1997.) $)
    alrimdv $p |- ( ph -> ( ps -> A. x ch ) ) $=
      ( ax-17 alrimdh ) ABCDADFBDFEG $.
  $}

  ${
    $d x ph $.
    nfdv.1 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Apply the definition of not-free in a context.  (Contributed by Mario
       Carneiro, 11-Aug-2016.) $)
    nfdv $p |- ( ph -> F/ x ps ) $=
      ( wal wi wnf alrimiv df-nf sylibr ) ABBCEFZCEBCGAKCDHBCIJ $.
  $}

  ${
    $d x ph $.  $d y ph $.
    $( Quantification of two variables over a formula in which they do not
       occur.  (Contributed by Alan Sare, 12-Apr-2011.) $)
    2ax17 $p |- ( ph -> A. x A. y ph ) $=
      ( id alrimivv ) AABCADE $.
  $}

  ${
    $d x ph $.
    alimdv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.20 of [Margaris] p. 90.  (Contributed by NM,
       3-Apr-1994.) $)
    alimdv $p |- ( ph -> ( A. x ps -> A. x ch ) ) $=
      ( ax-17 alimdh ) ABCDADFEG $.

    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Contributed by NM,
       27-Apr-1994.) $)
    eximdv $p |- ( ph -> ( E. x ps -> E. x ch ) ) $=
      ( ax-17 eximdh ) ABCDADFEG $.
  $}

  ${
    $d x ph $.  $d y ph $.
    2alimdv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Contributed by NM,
       27-Apr-2004.) $)
    2alimdv $p |- ( ph -> ( A. x A. y ps -> A. x A. y ch ) ) $=
      ( wal alimdv ) ABEGCEGDABCEFHH $.

    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Contributed by NM,
       3-Aug-1995.) $)
    2eximdv $p |- ( ph -> ( E. x E. y ps -> E. x E. y ch ) ) $=
      ( wex eximdv ) ABEGCEGDABCEFHH $.
  $}

  ${
    $d x ps $.
    $( Special case of Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       28-Jun-1998.) $)
    19.23v $p |- ( A. x ( ph -> ps ) <-> ( E. x ph -> ps ) ) $=
      ( ax-17 19.23 ) ABCBCDE $.
  $}

  ${
    $d x ps $.  $d y ps $.
    $( Theorem 19.23 of [Margaris] p. 90 extended to two variables.
       (Contributed by NM, 10-Aug-2004.) $)
    19.23vv $p |- ( A. x A. y ( ph -> ps ) <-> ( E. x E. y ph -> ps ) ) $=
      ( wi wal wex 19.23v albii bitri ) ABEDFZCFADGZBEZCFLCGBEKMCABDHILBCHJ $.
  $}

  ${
    $d x y $.
    $( Two equivalent ways of expressing the proper substitution of ` y ` for
       ` x ` in ` ph ` , when ` x ` and ` y ` are distinct.  Theorem 6.2 of
       [Quine] p. 40.  The proof does not involve ~ df-sb .  (Contributed by
       NM, 14-Apr-2008.) $)
    sb56 $p |- ( E. x ( x = y /\ ph ) <-> A. x ( x = y -> ph ) ) $=
      ( weq wi wal hba1 ax11v ax-4 com12 impbid equsex ) ABCDZAEZBFZBCNBGMAOABC
      HOMANBIJKL $.

    $( Equivalence for substitution.  Compare Theorem 6.2 of [Quine] p. 40.
       Also proved as Lemmas 16 and 17 of [Tarski] p. 70.  (Contributed by NM,
       18-Aug-1993.)  (Revised by NM, 14-Apr-2008.) $)
    sb6 $p |- ( [ y / x ] ph <-> A. x ( x = y -> ph ) ) $=
      ( weq wi wa wex wal wsb sb56 anbi2i df-sb ax-4 pm4.71ri 3bitr4i ) BCDZAEZ
      PAFBGZFQQBHZFABCISRSQABCJKABCLSQQBMNO $.

    $( Equivalence for substitution.  Similar to Theorem 6.1 of [Quine] p. 40.
       (Contributed by NM, 18-Aug-1993.)  (Revised by NM, 14-Apr-2008.) $)
    sb5 $p |- ( [ y / x ] ph <-> E. x ( x = y /\ ph ) ) $=
      ( wsb weq wi wal wa wex sb6 sb56 bitr4i ) ABCDBCEZAFBGMAHBIABCJABCKL $.

    $( Version of ~ sbn where ` x ` and ` y ` are distinct.  (Contributed by
       Jim Kingdon, 18-Dec-2017.) $)
    sbnv $p |- ( [ y / x ] -. ph <-> -. [ y / x ] ph ) $=
      ( wn cv wsbc wceq wa wex wal sb6 alinexa bitri sb5 notbii bitr4i
      wi ) ADZBCEZFZBESGZAHBIZDZABSFZDTUARQBJUCRBCKUAABLMUDUBABCNOP $.

    $( Version of ~ sban where ` x ` and ` y ` are distinct.  (Contributed by
       Jim Kingdon, 24-Dec-2017.) $)
    sbanv $p |- ( [ y / x ] ( ph /\ ps ) <->
                  ( [ y / x ] ph /\ [ y / x ] ps ) ) $=
      ( wa cv wsbc wceq wal sb6 anbi12i 19.26 bitr4i pm4.76 albii bitri
      wi ) ABEZCDFZGCFSHZRQZCIZACSGZBCSGZEZRCDJUETAQZTBQZEZCIZUBUEUFCIZ
      UGCIZEUIUCUJUDUKACDJBCDJKUFUGCLMUHUACTABNOPM $.

    $( Version of ~ sbor where ` x ` and ` y ` are distinct.  (Contributed by
       Jim Kingdon, 3-Feb-2018.) $)
    sborv $p |- ( [ y / x ] ( ph \/ ps ) <->
                  ( [ y / x ] ph \/ [ y / x ] ps ) ) $=
      ( wo wsb weq wa wex sb5 andi exbii 19.43 3bitri orbi12i bitr4i ) ABEZCDFZ
      CDGZAHZCIZSBHZCIZEZACDFZBCDFZERSQHZCITUBEZCIUDQCDJUGUHCSABKLTUBCMNUEUAUFU
      CACDJBCDJOP $.

    $( Forward direction of ~ sbimv .  (Contributed by Jim Kingdon,
       25-Dec-2017.) $)
    sbi1v $p |- ( [ y / x ] ( ph -> ps )
                      -> ( [ y / x ] ph -> [ y / x ] ps ) ) $=
      ( cv wsbc wceq wi wal sb6 ax-2 al2imi sb2 syl6 sylbi syl5bi ) A
      CDEZFCEQGZAHZCIZABHZCQFZBCQFZACDJUBRUAHZCIZTUCHUACDJUETRBHZCIUC
      UDSUFCRABKLBCDMNOP $.

    $( Reverse direction of ~ sbimv .  (Contributed by Jim Kingdon,
       18-Jan-2018.) $)
    sbi2v $p |- ( ( [ y / x ] ph -> [ y / x ] ps )
                      -> [ y / x ] ( ph -> ps ) ) $=
      ( weq wa wex wi wal wsb 19.38 pm3.3 pm2.04 syli alimi syl sb5 sb6 imbi12i
      3imtr4i ) CDEZAFZCGZUABHZCIZHZUAABHZHZCIZACDJZBCDJZHUGCDJUFUBUDHZCIUIUBUD
      CKULUHCUAULAUDHUGUAAUDLAUABMNOPUJUCUKUEACDQBCDRSUGCDRT $.

    $( Intuitionistic proof of ~ sbim where ` x ` and ` y ` are distinct.
       (Contributed by Jim Kingdon, 18-Jan-2018.) $)
    sbimv $p |- ( [ y / x ] ( ph -> ps )
                  <-> ( [ y / x ] ph -> [ y / x ] ps ) ) $=
      ( wi wsb sbi1v sbi2v impbii ) ABECDFACDFBCDFEABCDGABCDHI $.
  $}

  ${
    $d x y $.
    sblimv.1 $e |- ( ps -> A. x ps ) $.
    $( Version of ~ sblim where ` x ` and ` y ` are distinct.  (Contributed by
       Jim Kingdon, 19-Jan-2018.) $)
    sblimv $p |- ( [ y / x ] ( ph -> ps ) <-> ( [ y / x ] ph -> ps ) ) $=
      ( wi wsb sbimv sbh imbi2i bitri ) ABFCDGACDGZBCDGZFLBFABCDHMBLBCDEIJK $.
  $}

  ${
    $d ph y $.  $d ps x $.
    $( Theorem *11.53 in [WhiteheadRussell] p. 164.  (Contributed by Andrew
       Salmon, 24-May-2011.) $)
    pm11.53 $p |- ( A. x A. y ( ph -> ps ) <-> ( E. x ph -> A. y ps ) ) $=
      ( wi wal wex 19.21v albii ax-17 hbal 19.23 bitri ) ABEDFZCFABDFZEZCFACGOE
      NPCABDHIAOCBCDBCJKLM $.
  $}

  ${
    $d x ps $.  $d y ps $.
    exlimivv.1 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       1-Aug-1995.) $)
    exlimivv $p |- ( E. x E. y ph -> ps ) $=
      ( wex exlimiv ) ADFBCABDEGG $.
  $}

  ${
    $d x ch $.  $d x ph $.  $d y ch $.  $d y ph $.
    exlimdvv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.23 of [Margaris] p. 90.  (Contributed by NM,
       31-Jul-1995.) $)
    exlimdvv $p |- ( ph -> ( E. x E. y ps -> ch ) ) $=
      ( wex exlimdv ) ABEGCDABCEFHH $.
  $}

  ${
    $d x ps $.
    $( Theorem 19.27 of [Margaris] p. 90.  (Contributed by NM, 3-Jun-2004.) $)
    19.27v $p |- ( A. x ( ph /\ ps ) <-> ( A. x ph /\ ps ) ) $=
      ( ax-17 19.27 ) ABCBCDE $.
  $}

  ${
    $d x ph $.
    $( Theorem 19.28 of [Margaris] p. 90.  (Contributed by NM, 25-Mar-2004.) $)
    19.28v $p |- ( A. x ( ph /\ ps ) <-> ( ph /\ A. x ps ) ) $=
      ( ax-17 19.28 ) ABCACDE $.
  $}

  ${
    $d x ps $.
    19.36aiv.1 $e |- E. x ( ph -> ps ) $.
    $( Inference from Theorem 19.36 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.36aiv $p |- ( A. x ph -> ps ) $=
      ( nfv 19.36i ) ABCBCEDF $.
  $}

  ${
    $d x ps $.
    $( Special case of Theorem 19.41 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.41v $p |- ( E. x ( ph /\ ps ) <-> ( E. x ph /\ ps ) ) $=
      ( ax-17 19.41h ) ABCBCDE $.
  $}

  ${
    $d x ps $.  $d y ps $.
    $( Theorem 19.41 of [Margaris] p. 90 with 2 quantifiers.  (Contributed by
       NM, 30-Apr-1995.) $)
    19.41vv $p |- ( E. x E. y ( ph /\ ps ) <-> ( E. x E. y ph /\ ps ) ) $=
      ( wa wex 19.41v exbii bitri ) ABEDFZCFADFZBEZCFKCFBEJLCABDGHKBCGI $.
  $}

  ${
    $d x ps $.  $d y ps $.  $d z ps $.
    $( Theorem 19.41 of [Margaris] p. 90 with 3 quantifiers.  (Contributed by
       NM, 30-Apr-1995.) $)
    19.41vvv $p |- ( E. x E. y E. z ( ph /\ ps ) <->
                     ( E. x E. y E. z ph /\ ps ) ) $=
      ( wa wex 19.41vv exbii 19.41v bitri ) ABFEGDGZCGAEGDGZBFZCGMCGBFLNCABDEHI
      MBCJK $.
  $}

  ${
    $d w ps $.  $d x ps $.  $d y ps $.  $d z ps $.
    $( Theorem 19.41 of [Margaris] p. 90 with 4 quantifiers.  (Contributed by
       FL, 14-Jul-2007.) $)
    19.41vvvv $p |- ( E. w E. x E. y E. z ( ph /\ ps ) <->
                     ( E. w E. x E. y E. z ph /\ ps ) ) $=
      ( wa wex 19.41vvv exbii 19.41v bitri ) ABGEHDHCHZFHAEHDHCHZBGZFHNFHBGMOFA
      BCDEIJNBFKL $.
  $}

  ${
    $d x ph $.
    $( Special case of Theorem 19.42 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.42v $p |- ( E. x ( ph /\ ps ) <-> ( ph /\ E. x ps ) ) $=
      ( ax-17 19.42h ) ABCACDE $.
  $}

  ${
    $d y ph $.
    $( Distribution of existential quantifiers.  (Contributed by NM,
       9-Mar-1995.) $)
    exdistr $p |- ( E. x E. y ( ph /\ ps ) <-> E. x ( ph /\ E. y ps ) ) $=
      ( wa wex 19.42v exbii ) ABEDFABDFECABDGH $.
  $}

  ${
    $d x ph $.  $d y ph $.
    $( Theorem 19.42 of [Margaris] p. 90 with 2 quantifiers.  (Contributed by
       NM, 16-Mar-1995.) $)
    19.42vv $p |- ( E. x E. y ( ph /\ ps ) <-> ( ph /\ E. x E. y ps ) ) $=
      ( wa wex exdistr 19.42v bitri ) ABEDFCFABDFZECFAJCFEABCDGAJCHI $.
  $}

  ${
    $d x ph $.  $d y ph $.  $d z ph $.
    $( Theorem 19.42 of [Margaris] p. 90 with 3 quantifiers.  (Contributed by
       NM, 21-Sep-2011.) $)
    19.42vvv $p |- ( E. x E. y E. z ( ph /\ ps )
                       <-> ( ph /\ E. x E. y E. z ps ) ) $=
      ( wa wex 19.42vv exbii 19.42v bitri ) ABFEGDGZCGABEGDGZFZCGAMCGFLNCABDEHI
      AMCJK $.
  $}

  ${
    $d y ph $.  $d z ph $.
    $( Distribution of existential quantifiers.  (Contributed by NM,
       17-Mar-1995.) $)
    exdistr2 $p |- ( E. x E. y E. z ( ph /\ ps ) <->
                   E. x ( ph /\ E. y E. z ps ) ) $=
      ( wa wex 19.42vv exbii ) ABFEGDGABEGDGFCABDEHI $.
  $}

  ${
    $d y ph $.  $d z ph $.  $d z ps $.
    $( Distribution of existential quantifiers.  (Contributed by NM,
       9-Mar-1995.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3exdistr $p |- ( E. x E. y E. z ( ph /\ ps /\ ch ) <->
                E. x ( ph /\ E. y ( ps /\ E. z ch ) ) ) $=
      ( w3a wex wa 3anass 2exbii 19.42vv exdistr anbi2i 3bitri exbii ) ABCGZFHE
      HZABCFHIEHZIZDRABCIZIZFHEHAUAFHEHZITQUBEFABCJKAUAEFLUCSABCEFMNOP $.
  $}

  ${
    $d y ph $.  $d z ph $.  $d w ph $.  $d z ps $.  $d w ps $.  $d w ch $.
    $( Distribution of existential quantifiers.  (Contributed by NM,
       9-Mar-1995.) $)
    4exdistr $p |- ( E. x E. y E. z E. w ( ( ph /\ ps ) /\ ( ch /\ th ) ) <->
                E. x ( ph /\ E. y ( ps /\ E. z ( ch /\ E. w th ) ) ) ) $=
      ( wa wex anass exbii 19.42v anbi2i 3bitri bitri ) ABICDIZIZHJZGJZFJZABCDH
      JIZGJIZFJIZEUAAUCIZFJUDTUEFTABUBIZIZGJAUFGJZIUESUGGSABQIZIZHJZUGRUJHABQKL
      UKAUIHJZIABQHJZIZIUGAUIHMULUNABQHMNUNUFAUMUBBCDHMNNOPLAUFGMUHUCABUBGMNOLA
      UCFMPL $.
  $}

  ${
    $d y ph $.  $d x ps $.
    cbvalv.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 5-Aug-1993.) $)
    cbvalv $p |- ( A. x ph <-> A. y ps ) $=
      ( ax-17 cbvalh ) ABCDADFBCFEG $.

    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 5-Aug-1993.) $)
    cbvexv $p |- ( E. x ph <-> E. y ps ) $=
      ( ax-17 cbvexh ) ABCDADFBCFEG $.
  $}

  ${
    $d y x $.  $d y z $.  $d w x $.  $d w z $.
    cbval2.1 $e |- ( ph -> A. z ph ) $.
    cbval2.2 $e |- ( ph -> A. w ph ) $.
    cbval2.3 $e |- ( ps -> A. x ps ) $.
    cbval2.4 $e |- ( ps -> A. y ps ) $.
    cbval2.5 $e |- ( ( x = z /\ y = w ) -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 22-Dec-2003.) $)
    cbval2 $p |- ( A. x A. y ph <-> A. z A. w ps ) $=
      ( wal hbal weq wb wa ax-17 hban cbvalh 19.28v expcom pm5.32d 3bitr3i mpbir
      wi pm5.32 ) ADLZBFLZCEAEDGMBCFIMCENZUGUHOUEUIUGPZUIUHPZOUIAPZDLUIBPZFLUJU
      KULUMDFUIAFUIFQHRUIBDUIDQJRDFNZUIABUIUNABOKUAUBSUIADTUIBFTUCUIUGUHUFUDS
      $.

    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 14-Sep-2003.) $)
    cbvex2 $p |- ( E. x E. y ph <-> E. z E. w ps ) $=
      ( wex hbex weq wb wa ax-17 hban cbvexh 19.42v expcom pm5.32d 3bitr3i mpbir
      wi pm5.32 ) ADLZBFLZCEAEDGMBCFIMCENZUGUHOUEUIUGPZUIUHPZOUIAPZDLUIBPZFLUJU
      KULUMDFUIAFUIFQHRUIBDUIDQJRDFNZUIABUIUNABOKUAUBSUIADTUIBFTUCUIUGUHUFUDS
      $.
  $}

  ${
    $d z w ph $.  $d x y ps $.  $d x w $.  $d z y $.
    cbval2v.1 $e |- ( ( x = z /\ y = w ) -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 4-Feb-2005.) $)
    cbval2v $p |- ( A. x A. y ph <-> A. z A. w ps ) $=
      ( ax-17 cbval2 ) ABCDEFAEHAFHBCHBDHGI $.

    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 26-Jul-1995.) $)
    cbvex2v $p |- ( E. x E. y ph <-> E. z E. w ps ) $=
      ( ax-17 cbvex2 ) ABCDEFAEHAFHBCHBDHGI $.
  $}

  ${
    $d x ph $.  $d x ch $.
    cbvald.1 $e |- F/ y ph $.
    cbvald.2 $e |- ( ph -> F/ y ps ) $.
    cbvald.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Deduction used to change bound variables, using implicit substitution,
       particularly useful in conjunction with ~ dvelim .  (Contributed by NM,
       2-Jan-2002.)  (Revised by Mario Carneiro, 6-Oct-2016.)  (Revised by Wolf
       Lammen, 13-May-2018.) $)
    cbvald $p |- ( ph -> ( A. x ps <-> A. y ch ) ) $=
      ( nfv wnf a1i cbv2 ) ABCDEADIFGCDJACDIKHL $.
  $}

  ${
    $d x ph $.  $d x ch $.
    cbvexdh.1 $e |- ( ph -> A. y ph ) $.
    cbvexdh.2 $e |- ( ph -> ( ps -> A. y ps ) ) $.
    cbvexdh.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Deduction used to change bound variables, using implicit substitition,
       particularly useful in conjunction with ~ dvelim .  (Contributed by NM,
       2-Jan-2002.)  (Proof rewritten by Jim Kingdon, 30-Dec-2017.) $)
    cbvexdh $p |- ( ph -> ( E. x ps <-> E. y ch ) ) $=
      ( wex ax-17 cv wceq wa wb wi equsexd simpr eximi syl6bir wal
      hbex equcomi bicom1 imim12i syl exlimdh eximdh 19.12 syl6 exlimd2
      a1i impbid ) ABDIZCEIZABUNDADJZCDECDJZUAABEKZDKZLZCMZEIUNACBEDF
      GAURUQLZBCNZOUSCBNZOHUSVAVBVCEDUBBCUCUDUEPUTCEUSCQRSUFACUMEFAUM
      BETZDIUMETABVDDUOGUGBDEUHUIACVABMZDIUMABCDEUOCCDTOAUPUKHPVEBDVA
      BQRSUJUL $.
  $}

  ${
    $d x ph $.  $d x ch $.
    cbvexd.1 $e |- F/ y ph $.
    cbvexd.2 $e |- ( ph -> F/ y ps ) $.
    cbvexd.3 $e |- ( ph -> ( x = y -> ( ps <-> ch ) ) ) $.
    $( Deduction used to change bound variables, using implicit substitution,
       particularly useful in conjunction with ~ dvelim .  (Contributed by NM,
       2-Jan-2002.)  (Revised by Mario Carneiro, 6-Oct-2016.)  (Proof rewritten
       by Jim Kingdon, 10-Jun-2018.) $)
    cbvexd $p |- ( ph -> ( E. x ps <-> E. y ch ) ) $=
      ( nfri nfrd cbvexdh ) ABCDEAEFIABEGJHK $.
  $}

  ${
    $d ps y $.  $d ch x $.  $d ph x $.  $d ph y $.
    cbvaldva.1 $e |- ( ( ph /\ x = y ) -> ( ps <-> ch ) ) $.
    $( Rule used to change the bound variable in a universal quantifier with
       implicit substitution.  Deduction form.  (Contributed by David Moews,
       1-May-2017.) $)
    cbvaldva $p |- ( ph -> ( A. x ps <-> A. y ch ) ) $=
      ( nfv nfvd weq wb ex cbvald ) ABCDEAEGABEHADEIBCJFKL $.

    $( Rule used to change the bound variable in an existential quantifier with
       implicit substitution.  Deduction form.  (Contributed by David Moews,
       1-May-2017.) $)
    cbvexdva $p |- ( ph -> ( E. x ps <-> E. y ch ) ) $=
      ( nfv nfvd weq wb ex cbvexd ) ABCDEAEGABEHADEIBCJFKL $.
  $}

  ${
    $v f $.
    $v g $.
    $( Define temporary individual variables. $)
    cbvex4v.vf $f set f $.
    cbvex4v.vg $f set g $.
    $d w z ch $.  $d u v ph $.  $d x y ps $.  $d f g ps $.  $d f w $.
    $d g z $.  $d u v w x y z $.
    cbvex4v.1 $e |- ( ( x = v /\ y = u ) -> ( ph <-> ps ) ) $.
    cbvex4v.2 $e |- ( ( z = f /\ w = g ) -> ( ps <-> ch ) ) $.
    $( Rule used to change bound variables, using implicit substitition.
       (Contributed by NM, 26-Jul-1995.) $)
    cbvex4v $p |- ( E. x E. y E. z E. w ph <-> E. v E. u E. f E. g ch ) $=
      ( wex weq wa 2exbidv cbvex2v 2exbii bitri ) AGNFNZENDNBGNFNZINHNCKNJNZINH
      NUAUBDEHIDHOEIOPABFGLQRUBUCHIBCFGJKMRST $.
  $}

  ${
    eean.1 $e |- F/ y ph $.
    eean.2 $e |- F/ x ps $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 27-Oct-2010.)
       (Revised by Mario Carneiro, 6-Oct-2016.) $)
    eean $p |- ( E. x E. y ( ph /\ ps ) <-> ( E. x ph /\ E. y ps ) ) $=
      ( wa wex 19.42 exbii nfex 19.41 bitri ) ABGDHZCHABDHZGZCHACHOGNPCABDEIJAO
      CBCDFKLM $.
  $}

  ${
    $d y ph $.  $d x ps $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 26-Jul-1995.) $)
    eeanv $p |- ( E. x E. y ( ph /\ ps ) <-> ( E. x ph /\ E. y ps ) ) $=
      ( nfv eean ) ABCDADEBCEF $.
  $}

  ${
    $d y ph $.  $d z ph $.  $d x z ps $.  $d x y ch $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 26-Jul-1995.)
       (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    eeeanv $p |- ( E. x E. y E. z ( ph /\ ps /\ ch ) <->
                 ( E. x ph /\ E. y ps /\ E. z ch ) ) $=
      ( w3a wex wa df-3an 3exbii eeanv exbii anbi1i 19.41v 3bitr4i 3bitri ) ABC
      GZFHEHDHABIZCIZFHEHZDHSEHZCFHZIZDHZADHZBEHZUCGZRTDEFABCJKUAUDDSCEFLMUBDHZ
      UCIUFUGIZUCIUEUHUIUJUCABDELNUBUCDOUFUGUCJPQ $.
  $}

  ${
    $d z ph $.  $d w ph $.  $d x ps $.  $d y ps $.  $d y z $.  $d w x $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 31-Jul-1995.) $)
    ee4anv $p |- ( E. x E. y E. z E. w ( ph /\ ps ) <->
                  ( E. x E. y ph /\ E. z E. w ps ) ) $=
      ( wa wex excom exbii eeanv 2exbii 3bitri ) ABGFHZEHDHZCHNDHZEHZCHADHZBFHZ
      GZEHCHRCHSEHGOQCNDEIJPTCEABDFKLRSCEKM $.
  $}

  ${
    $d x ph $.
    nexdv.1 $e |- ( ph -> -. ps ) $.
    $( Deduction for generalization rule for negated wff.  (Contributed by NM,
       5-Aug-1993.) $)
    nexdv $p |- ( ph -> -. E. x ps ) $=
      ( ax-17 nexd ) ABCACEDF $.
  $}

  ${
    $d x ps $.
    chv.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    chv.2 $e |- ph $.
    $( Implicit substitution of ` y ` for ` x ` into a theorem.  (Contributed
       by NM, 20-Apr-1994.) $)
    chvarv $p |- ps $=
      ( a4v mpg ) ABCABCDEGFH $.
  $}

  ${
    $d x z $.  $d y z $.
    $( When the class variables of set theory are replaced with set variables,
       this theorem of predicate calculus is the result.  This theorem provides
       part of the justification for the consistency of that definition, which
       "overloads" the set variables in ~ wel with the class variables in
       ~ wcel .  (Contributed by NM, 28-Jan-2004.) $)
    cleljust $p |- ( x e. y <-> E. z ( z = x /\ z e. y ) ) $=
      ( weq wel wa wex ax-17 elequ1 equsex bicomi ) CADCBEZFCGABEZLMCAMCHCABIJK
      $.
  $}


$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        More substitution theorems
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

$( The theorems in this section make use of the $d statement. $)

  ${
    $d x y $.
    $( ` x ` is not free in ` [ y / x ] ph ` when ` x ` and ` y ` are
       distinct.  (Contributed by NM, 5-Aug-1993.)  (Proof by Jim Kingdon,
       16-Dec-2017.) $)
    hbs1 $p |- ( [ y / x ] ph -> A. x [ y / x ] ph ) $=
      ( cv wsbc wceq wi wal sb6 ax-ial sylbi albii sylibr ) ABCDZEZBDNF
      AGZBHZBHZOBHOQRABCIZPBJKOQBSLM $.

    $( ` x ` is not free in ` [ y / x ] ph ` when ` x ` and ` y ` are
       distinct.  (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfs1v $p |- F/ x [ y / x ] ph $=
      ( wsb hbs1 nfi ) ABCDBABCEF $.
  $}

  ${
    $d y ph $.
    $( Two ways of expressing " ` x ` is (effectively) not free in ` ph ` ."
       (Contributed by NM, 29-May-2009.) $)
    sbhb $p |- ( ( ph -> A. x ph ) <-> A. y ( ph -> [ y / x ] ph ) ) $=
      ( wal wi wsb ax-17 sb8h imbi2i 19.21v bitr4i ) AABDZEAABCFZCDZEAMECDLNAABC
      ACGHIAMCJK $.
  $}

  ${
    $d x y z $.  $d y z ph $.
    $( Two ways of expressing " ` x ` is (effectively) not free in ` ph ` ."
       (Contributed by G&eacute;rard Lang, 14-Nov-2013.) $)
    sbhb2 $p |- ( A. x ( ph -> A. x ph )
           <-> A. y A. z ( [ y / x ] ph <-> [ z / x ] ph ) ) $=
      ( wsb wb wal wi wa 2albiim sbhb albii alcom bitri ax-17 sb8h sblimv 3bitri
      hbs1 anbi12i anidm 3bitr2ri ) ABCEZABDEZFDGCGUCUDHZDGCGZUDUCHZDGZCGZIAABG
      HZBGZUKIUKUCUDCDJUKUFUKUIUKAUDHZBGZDGZUECGZDGUFUKULDGZBGUNUJUPBABDKLULBDM
      NUMUODUMULBCEZCGUOULBCULCOPUQUECAUDBCABDSQLNLUEDCMRUKAUCHZCGZBGURBGZCGUIU
      JUSBABCKLURBCMUTUHCUTURBDEZDGUHURBDURDOPVAUGDAUCBDABCSQLNLRTUKUAUB $.
  $}

  ${
    $d x z $.  $d y z $.
    hbsbv.1 $e |- ( ph -> A. z ph ) $.
    $( This is a version of ~ hbsb with an extra distinct variable constraint,
       on ` z ` and ` x ` .  (Contributed by Jim Kingdon, 25-Dec-2017.) $)
    hbsbv $p |- ( [ y / x ] ph -> A. z [ y / x ] ph ) $=
      ( cv wsbc wceq wi wa wex df-sb biimpi ax-17 hbim hban
      wal eximi 19.12 syl biimpri alimi 3syl ) ABCFZGZBFUDHZAIZUFAJZBKZ
      JZUJDQUEDQUEUJABCLZMUGUIDUFADUFDNZEOUIUHDQZBKUIDQUHUMBUFADULEPRUH
      BDSTPUJUEDUEUJUKUAUBUC $.
  $}

  ${
    $d x y $.  $d y z $.
    nfsbxy.1 $e |- F/ z ph $.
    $( Similar to ~ hbsb but with an extra distinct variable constraint, on
       ` x ` and ` y ` .  (Contributed by Jim Kingdon, 19-Mar-2018.) $)
    nfsbxy $p |- F/ z [ y / x ] ph $=
      ( weq wal wi wo wsb ax-bnd nfs1v drsb1 drnf2 mpbii a16nf df-nf albii jaoi
      wnf wa wex sb5 nfa1 sp a1i nfand nfexd nfxfrd sylbir ax-mp ) DBFDGZDCFDGZ
      BCFZUNDGHDGZBGZIZIABCJZDTZBCDKULUSUQULADCJZDTUSADCLUTURDBDADBCMNOUMUSUPUR
      DCDPUPUNDTZBGZUSVAUOBUNDQRURUNAUAZBUBVBDABCUCVBVCDBVABUDVBUNADVABUEADTVBE
      UFUGUHUIUJSSUK $.
  $}

  ${
    $d x y $.  $d y z $.
    $( Closed form of ~ nfsbxy .  (Contributed by Jim Kingdon, 9-May-2018.) $)
    nfsbxyt $p |- ( A. x F/ z ph -> F/ z [ y / x ] ph ) $=
      ( weq wal wi wo wnf wsb ax-bnd nfs1v drsb1 drnf2 mpbii a1d wa nfa1 jaoi
      sp a16nf df-nf albii wex sb5 nfan adantr adantl nfand nfexd nfxfrd sylbir
      ex ax-mp ) DBEDFZDCEDFZBCEZUQDFGDFZBFZHZHADIZBFZABCJZDIZGZBCDKUOVEUTUOVDV
      BUOADCJZDIVDADCLVFVCDBDADBCMNOPUPVEUSUPVDVBVCDCDUAPUSUQDIZBFZVEVGURBUQDUB
      UCVHVBVDVCUQAQZBUDVHVBQZDABCUEVJVIDBVHVBBVGBRVABRUFVJUQADVHVGVBVGBTUGVBVA
      VHVABTUHUIUJUKUMULSSUN $.
  $}

  ${
    $d x z $.  $d y z $.
    sbco2vlem.1 $e |- ( ph -> A. z ph ) $.
    $( This is a version of ~ sbco2 where ` z ` is distinct from ` x ` and from
       ` y ` .  It is a lemma on the way to proving ~ sbco2v which only
       requires that ` z ` and ` x ` be distinct.  (Contributed by Jim Kingdon,
       25-Dec-2017.)  (One distinct variable constraint removed by Jim Kingdon,
       3-Feb-2018.) $)
    sbco2vlem $p |- ( [ y / z ] [ z / x ] ph <-> [ y / x ] ph ) $=
      ( wsb hbsbv sbequ sbieh ) ABDFABCFDCABCDEGADCBHI $.
  $}

  ${
    $d x z w $.  $d y w $.  $d z w $.  $d ph w $.
    sbco2v.1 $e |- ( ph -> A. z ph ) $.
    $( This is a version of ~ sbco2 where ` z ` is distinct from ` x ` .
       (Contributed by Jim Kingdon, 12-Feb-2018.) $)
    sbco2v $p |- ( [ y / z ] [ z / x ] ph <-> [ y / x ] ph ) $=
      ( vw wsb sbco2vlem sbbii ax-17 3bitr3i ) ABDGZDFGZFCGABFGZFCGLDCGABCGMNFCABF
      DEHILDCFLFJHABCFAFJHK $.
  $}

  ${
    $d w y z $.  $d w ph $.  $d w x $.
    nfsb.1 $e |- F/ z ph $.
    $( If ` z ` is not free in ` ph ` , it is not free in ` [ y / x ] ph ` when
       ` y ` and ` z ` are distinct.  (Contributed by Mario Carneiro,
       11-Aug-2016.)  (Proof rewritten by Jim Kingdon, 19-Mar-2018.) $)
    nfsb $p |- F/ z [ y / x ] ph $=
      ( vw wsb wnf nfsbxy ax-17 sbco2v nfbii mpbi ) ABFGZFCGZDHABCGZDHNFCDABFDE
      IIOPDABCFAFJKLM $.
  $}

  ${
    $d y z $.
    hbsb.1 $e |- ( ph -> A. z ph ) $.
    $( If ` z ` is not free in ` ph ` , it is not free in ` [ y / x ] ph ` when
       ` y ` and ` z ` are distinct.  (Contributed by NM, 12-Aug-1993.)  (Proof
       rewritten by Jim Kingdon, 22-Mar-2018.) $)
    hbsb $p |- ( [ y / x ] ph -> A. z [ y / x ] ph ) $=
      ( wsb nfi nfsb nfri ) ABCFDABCDADEGHI $.
  $}

  ${
    $d y z $.  $d x y $.
    $( Lemma for ~ equsb3 .  (Contributed by NM, 4-Dec-2005.)  (Proof shortened
       by Andrew Salmon, 14-Jun-2011.) $)
    equsb3lem $p |- ( [ x / y ] y = z <-> x = z ) $=
      ( cv wceq ax-17 equequ1 sbieh ) BDCDZEADIEZBAJBFBACGH $.
  $}

  ${
    $d w y z $.  $d w x $.
    $( Substitution applied to an atomic wff.  (Contributed by Raph Levien and
       FL, 4-Dec-2005.) $)
    equsb3 $p |- ( [ x / y ] y = z <-> x = z ) $=
      ( vw weq wsb equsb3lem sbbii ax-17 sbco2v 3bitr3i ) BCEZBDFZDAFDCEZDAFLBAF
      ACEMNDADBCGHLBADLDIJADCGK $.
  $}

  ${
    $d z ph $.  $d z ps $.  $d z x $.  $d z y $.

    $( Negation inside and outside of substitution are equivalent.
       (Contributed by NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon,
       3-Feb-2018.) $)
    sbn $p |- ( [ y / x ] -. ph <-> -. [ y / x ] ph ) $=
      ( vz wn wsb sbnv sbbii bitri ax-17 hbn sbco2v notbii 3bitr3i ) AEZBDFZDCF
      ZABDFZDCFZEZOBCFABCFZEQREZDCFTPUBDCABDGHRDCGIOBCDADADJZKLSUAABCDUCLMN $.

    $( Implication inside and outside of substitution are equivalent.
       (Contributed by NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon,
       3-Feb-2018.) $)
    sbim $p |- ( [ y / x ] ( ph -> ps ) <->
        ( [ y / x ] ph -> [ y / x ] ps ) ) $=
      ( vz wi wsb sbimv sbbii bitri ax-17 sbco2v imbi12i 3bitr3i ) ABFZCEGZEDGZ
      ACEGZEDGZBCEGZEDGZFZOCDGACDGZBCDGZFQRTFZEDGUBPUEEDABCEHIRTEDHJOCDEOEKLSUC
      UAUDACDEAEKLBCDEBEKLMN $.

    $( Logical OR inside and outside of substitution are equivalent.
       (Contributed by NM, 29-Sep-2002.)  (Proof rewritten by Jim Kingdon,
       3-Feb-2018.) $)
    sbor $p |- ( [ y / x ] ( ph \/ ps ) <->
        ( [ y / x ] ph \/ [ y / x ] ps ) ) $=
      ( vz wo cv wsbc sborv sbbii bitri ax-17 sbco2v orbi12i 3bitr3i ) AB
      FZCEGZHZEDGZHZACQHZESHZBCQHZESHZFZPCSHACSHZBCSHZFTUAUCFZESHUERUHE
      DABCEIJUAUCEDIKPCDEPELMUBUFUDUGACDEAELMBCDEBELMNO $.

    $( Conjunction inside and outside of a substitution are equivalent.
       (Contributed by NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon,
       3-Feb-2018.) $)
    sban $p |- ( [ y / x ] ( ph /\ ps ) <->
        ( [ y / x ] ph /\ [ y / x ] ps ) ) $=
      ( vz wa wsb sbanv sbbii bitri ax-17 sbco2v anbi12i 3bitr3i ) ABFZCEGZEDGZ
      ACEGZEDGZBCEGZEDGZFZOCDGACDGZBCDGZFQRTFZEDGUBPUEEDABCEHIRTEDHJOCDEOEKLSUC
      UAUDACDEAEKLBCDEBEKLMN $.
  $}

  ${
    sbrim.1 $e |- ( ph -> A. x ph ) $.
    $( Substitution with a variable not free in antecedent affects only the
       consequent.  (Contributed by NM, 5-Aug-1993.) $)
    sbrim $p |- ( [ y / x ] ( ph -> ps ) <-> ( ph -> [ y / x ] ps ) ) $=
      ( wi wsb sbim sbh imbi1i bitri ) ABFCDGACDGZBCDGZFAMFABCDHLAMACDEIJK $.
  $}

  ${
    sblim.1 $e |- ( ps -> A. x ps ) $.
    $( Substitution with a variable not free in consequent affects only the
       antecedent.  (Contributed by NM, 14-Nov-2013.) $)
    sblim $p |- ( [ y / x ] ( ph -> ps ) <-> ( [ y / x ] ph -> ps ) ) $=
      ( wi wsb sbim sbh imbi2i bitri ) ABFCDGACDGZBCDGZFLBFABCDHMBLBCDEIJK $.
  $}

  $( Conjunction inside and outside of a substitution are equivalent.
     (Contributed by NM, 14-Dec-2006.) $)
  sb3an $p |- ( [ y / x ] ( ph /\ ps /\ ch ) <->
              ( [ y / x ] ph /\ [ y / x ] ps /\ [ y / x ] ch ) ) $=
    ( w3a wsb wa df-3an sbbii sban anbi1i bitr4i 3bitri ) ABCFZDEGABHZCHZDEGPDE
    GZCDEGZHZADEGZBDEGZSFZOQDEABCIJPCDEKTUAUBHZSHUCRUDSABDEKLUAUBSIMN $.

  $( Equivalence inside and outside of a substitution are equivalent.
     (Contributed by NM, 5-Aug-1993.) $)
  sbbi $p |- ( [ y / x ] ( ph <-> ps )
     <-> ( [ y / x ] ph <-> [ y / x ] ps ) ) $=
    ( wb wsb wi wa dfbi2 sbbii sbim anbi12i sban 3bitr4i bitri ) ABEZCDFABGZBAG
    ZHZCDFZACDFZBCDFZEZPSCDABIJQCDFZRCDFZHUAUBGZUBUAGZHTUCUDUFUEUGABCDKBACDKLQR
    CDMUAUBINO $.

  ${
    sblbis.1 $e |- ( [ y / x ] ph <-> ps ) $.
    $( Introduce left biconditional inside of a substitution.  (Contributed by
       NM, 19-Aug-1993.) $)
    sblbis $p |- ( [ y / x ] ( ch <-> ph ) <-> ( [ y / x ] ch <-> ps ) ) $=
      ( wb wsb sbbi bibi2i bitri ) CAGDEHCDEHZADEHZGLBGCADEIMBLFJK $.
  $}

  ${
    sbrbis.1 $e |- ( [ y / x ] ph <-> ps ) $.
    $( Introduce right biconditional inside of a substitution.  (Contributed by
       NM, 18-Aug-1993.) $)
    sbrbis $p |- ( [ y / x ] ( ph <-> ch ) <-> ( ps <-> [ y / x ] ch ) ) $=
      ( wb wsb sbbi bibi1i bitri ) ACGDEHADEHZCDEHZGBMGACDEILBMFJK $.
  $}

  ${
    sbrbif.1 $e |- ( ch -> A. x ch ) $.
    sbrbif.2 $e |- ( [ y / x ] ph <-> ps ) $.
    $( Introduce right biconditional inside of a substitution.  (Contributed by
       NM, 18-Aug-1993.) $)
    sbrbif $p |- ( [ y / x ] ( ph <-> ch ) <-> ( ps <-> ch ) ) $=
      ( wb wsb sbrbis sbh bibi2i bitri ) ACHDEIBCDEIZHBCHABCDEGJNCBCDEFKLM $.
  $}

  ${
    $d y z $.
    sbco2yz.1 $e |- F/ z ph $.
    $( This is a version of ~ sbco2 where ` z ` is distinct from ` y ` .  It is
       a lemma on the way to proving ~ sbco2 which has no distinct variable
       constraints.  (Contributed by Jim Kingdon, 19-Mar-2018.) $)
    sbco2yz $p |- ( [ y / z ] [ z / x ] ph <-> [ y / x ] ph ) $=
      ( wsb nfsb nfri sbequ sbieh ) ABDFABCFZDCKDABCDEGHADCBIJ $.
  $}

  ${
    $d w z $.  $d w x $.  $d w y $.  $d ph w $.
    sbco2h.1 $e |- ( ph -> A. z ph ) $.
    $( A composition law for substitution.  (Contributed by NM, 30-Jun-1994.)
       (Proof rewritten by Jim Kingdon, 19-Mar-2018.) $)
    sbco2h $p |- ( [ y / z ] [ z / x ] ph <-> [ y / x ] ph ) $=
      ( vw wsb nfi sbco2yz sbbii nfv 3bitr3i ) ABDGZDFGZFCGABFGZFCGMDCGABCGNOFC
      ABFDADEHIJMDCFMFKIABCFAFKIL $.
  $}

  ${
    sbco2.1 $e |- F/ z ph $.
    $( A composition law for substitution.  (Contributed by NM, 30-Jun-1994.)
       (Revised by Mario Carneiro, 6-Oct-2016.) $)
    sbco2 $p |- ( [ y / z ] [ z / x ] ph <-> [ y / x ] ph ) $=
      ( nfri sbco2h ) ABCDADEFG $.
  $}

  ${
    sbco2d.1 $e |- ( ph -> A. x ph ) $.
    sbco2d.2 $e |- ( ph -> A. z ph ) $.
    sbco2d.3 $e |- ( ph -> ( ps -> A. z ps ) ) $.
    $( A composition law for substitution.  (Contributed by NM, 5-Aug-1993.) $)
    sbco2d $p |- ( ph -> ( [ y / z ] [ z / x ] ps <-> [ y / x ] ps ) ) $=
      ( wsb wi hbim1 sbco2h sbrim sbbii bitri 3bitr3i pm5.74ri ) ABCEIZEDIZBCDIZ
      ABJZCEIZEDIZUACDIASJZATJUACDEABEGHKLUCARJZEDIUDUBUEEDABCEFMNAREDGMOABCDFM
      PQ $.
  $}

  ${
    $d x z $.
    sbco2vd.1 $e |- ( ph -> A. x ph ) $.
    sbco2vd.2 $e |- ( ph -> A. z ph ) $.
    sbco2vd.3 $e |- ( ph -> ( ps -> A. z ps ) ) $.
    $( Version of ~ sbco2d with a distinct variable constraint between ` x `
       and ` z ` .  (Contributed by Jim Kingdon, 19-Feb-2018.) $)
    sbco2vd $p |- ( ph -> ( [ y / z ] [ z / x ] ps <-> [ y / x ] ps ) ) $=
      ( wsb wi hbim1 sbco2v sbrim sbbii bitri 3bitr3i pm5.74ri ) ABCEIZEDIZBCDIZ
      ABJZCEIZEDIZUACDIASJZATJUACDEABEGHKLUCARJZEDIUDUBUEEDABCEFMNAREDGMOABCDFM
      PQ $.
  $}

  $( A composition law for substitution.  (Contributed by NM, 5-Aug-1993.) $)
  sbco $p |- ( [ y / x ] [ x / y ] ph <-> [ y / x ] ph ) $=
    ( wsb wb weq equsb2 sbequ12 bicomd sbimi ax-mp sbbi mpbi ) ACBDZAEZBCDZNBCD
    ABCDECBFZBCDPBCGQOBCQANACBHIJKNABCLM $.

  ${
    $d x y $.
    $( Version of ~ sbco3 with a distinct variable constraint between ` x ` and
       ` y ` .  (Contributed by Jim Kingdon, 19-Feb-2018.) $)
    sbco3v $p |- ( [ z / y ] [ y / x ] ph <-> [ z / x ] [ x / y ] ph ) $=
      ( wsb nfs1v nfri sbco2v sbco sbbii bitr3i ) ABCEZCDELCBEZBDEACBEZBDELCDBLB
      ABCFGHMNBDACBIJK $.
  $}

  $( Relationship between composition and commutativity for substitution.
     (Contributed by Jim Kingdon, 28-Feb-2018.) $)
  sbcocom $p |- ( [ z / y ] [ y / x ] ph <-> [ z / y ] [ z / x ] ph ) $=
    ( wsb wb weq equsb1 sbequ sbimi ax-mp sbbi mpbi ) ABCEZABDEZFZCDEZNCDEOCD
    EFCDGZCDEQCDHRPCDACDBIJKNOCDLM $.

  ${
    $d x z $.
    $( Version of ~ sbcom with a distinct variable constraint between ` x ` and
       ` z ` .  (Contributed by Jim Kingdon, 28-Feb-2018.) $)
    sbcomv $p |- ( [ y / z ] [ y / x ] ph <-> [ y / x ] [ y / z ] ph ) $=
      ( wsb sbco3v sbcocom 3bitr3i ) ABDEDCEADBEBCEABCEDCEADCEBCEABDCFABDCGADBC
      GH $.
  $}

  ${
    $d x y $.  $d y z $.
    $( Version of ~ sbcom with distinct variable constraints between ` x ` and
       ` y ` , and ` y ` and ` z ` .  (Contributed by Jim Kingdon,
       21-Mar-2018.) $)
    sbcomxyyz $p |- ( [ y / z ] [ y / x ] ph <-> [ y / x ] [ y / z ] ph ) $=
      ( weq wal wi wo wsb wb ax-ial drsb1 sbbid bitr3d sbequ12 sps wnf a1i nfrd
      nfs1v ax-bnd hbae df-nf albii nfsb nfr wa nfnf1 nfa1 nfan sylan9bb adantl
      nfri ex sbiedh syld bicomd sylbir jaoi ax-mp ) DBEZDFZDCEZDFZBCEZVEDFZGDFZ
      BFZHZHABCIZDCIZADCIZBCIZJZBCDUAVBVNVIVBVLDCIVKVMVBVLVJDCVADKADBCLMVLDBCLN
      VDVNVHVDVJVKVMVCVJVKJDVJDCOZPVDAVLBCDCBUBVCAVLJDADCOPMNVHVEDQZBFZVNVPVGBV
      EDUCUDVQVMVKVQVLVKBCVPBKVQVKBVKBQVQVJDCBABCTUERSVPVEVLVKJZGBVPVEVFVRVEDUF
      VPVFVRVPVFUGZAVKDCVSDVPVFDVEDUHVEDUIUJUMVSVKDVKDQVSVJDCTRSVFVCAVKJZGZVPVE
      WADVEVCVTVEAVJVCVKABCOVOUKUNPULUOUNUPPUOUQURUSUSUT $.
  $}

  ${
    $d x z $.  $d y z $.
    $( Version of ~ sbco3 with distinct variable constraints between ` x ` and
       ` z ` , and ` y ` and ` z ` .  Lemma for proving ~ sbco3 .  (Contributed
       by Jim Kingdon, 22-Mar-2018.) $)
    sbco3xzyz $p |- ( [ z / y ] [ y / x ] ph <-> [ z / x ] [ x / y ] ph ) $=
      ( wsb sbcomxyyz sbcocom 3bitr4i ) ABDECDEACDEBDEABCECDEACBEBDEABDCFABCDGA
      CBDGH $.
  $}

  ${
    $d w x $.  $d w y $.  $d w ph $.
    $( A composition law for substitution.  (Contributed by NM, 5-Aug-1993.)
       (Proof rewritten by Jim Kingdon, 22-Mar-2018.) $)
    sbco3 $p |- ( [ z / y ] [ y / x ] ph <-> [ z / x ] [ x / y ] ph ) $=
      ( vw wsb sbco3xzyz sbbii ax-17 sbco2h 3bitr3i ) ABCFZCEFZEDFACBFZBEFZEDFLC
      DFNBDFMOEDABCEGHLCDELEIJNBDENEIJK $.
  $}

  $( A commutativity law for substitution.  (Contributed by NM, 27-May-1997.)
     (Proof rewritten by Jim Kingdon, 22-Mar-2018.) $)
  sbcom $p |- ( [ y / z ] [ y / x ] ph <-> [ y / x ] [ y / z ] ph ) $=
    ( wsb sbco3 sbcocom 3bitr3i ) ABDEDCEADBEBCEABCEDCEADCEBCEABDCFABDCGADBCGH
    $.

  ${
    $d w y z $.  $d w ph $.  $d w x $.
    $( Closed form of ~ nfsb .  (Contributed by Jim Kingdon, 9-May-2018.) $)
    nfsbt $p |- ( A. x F/ z ph -> F/ z [ y / x ] ph ) $=
      ( vw wnf wal wsbc ax-17 nfsbxyt alimi syl nfv sbco2 nfbii sylib
      cv ) ADFBGZREGZABCQZHZDFZREISABEQHZETHZDFZUBSUCDFZEGUERUFEABEDJKU
      CECDJLUDUADABCEAEMNOPL $.
  $}

  ${
    $d y z $.
    nfsbd.1 $e |- F/ x ph $.
    nfsbd.2 $e |- ( ph -> F/ z ps ) $.
    $( Deduction version of ~ nfsb .  (Contributed by NM, 15-Feb-2013.) $)
    nfsbd $p |- ( ph -> F/ z [ y / x ] ps ) $=
      ( wal wnf cv wsbc nfri alimi nfsbt 3syl ) AACHBEIZCHBCDJKEIACFLAP
      CGMBCDENO $.
  $}

  ${
    $d w y z $.  $d w x $.
    $( Substitution applied to an atomic membership wff.  (Contributed by NM,
       7-Nov-2006.)  (Proof shortened by Andrew Salmon, 14-Jun-2011.) $)
    elsb3 $p |- ( [ x / y ] y e. z <-> x e. z ) $=
      ( vw wel wsb ax-17 elequ1 sbieh sbbii sbco2h bitr3i wb weq sbimi ax-mp sbbi
      equsb1 mpbi sbh 3bitri ) BCEZBAFZDCEZDAFZACEZDAFZUFUCUDDBFZBAFUEUHUBBAUDU
      BDBUBDGDBCHIJUDDABUDBGKLUDUFMZDAFZUEUGMDANZDAFUJDARUKUIDADACHOPUDUFDAQSUF
      DAUFDGTUA $.
  $}

  ${
    $d w y z $.  $d w x $.
    $( Substitution applied to an atomic membership wff.  (Contributed by
       Rodolfo Medina, 3-Apr-2010.)  (Proof shortened by Andrew Salmon,
       14-Jun-2011.) $)
    elsb4 $p |- ( [ x / y ] z e. y <-> z e. x ) $=
      ( vw wel wsb ax-17 elequ2 sbieh sbbii sbco2h bitr3i wb weq sbimi ax-mp sbbi
      equsb1 mpbi sbh 3bitri ) CBEZBAFZCDEZDAFZCAEZDAFZUFUCUDDBFZBAFUEUHUBBAUDU
      BDBUBDGDBCHIJUDDABUDBGKLUDUFMZDAFZUEUGMDANZDAFUJDARUKUIDADACHOPUDUFDAQSUF
      DAUFDGTUA $.
  $}

  ${
    $d x y $.
    $( Like ~ sb9 but with a distinct variable constraint between ` x ` and
       ` y ` .  (Contributed by Jim Kingdon, 28-Feb-2018.) $)
    sb9v $p |- ( A. x [ x / y ] ph <-> A. y [ y / x ] ph ) $=
      ( wsb hbs1 weq wb sbequ12 equcoms bitr3d cbvalh ) ACBDZABCDZBCACBEABCEBCFA
      LMALGCBACBHIABCHJK $.
  $}

  ${
    $d w x $.  $d w y $.  $d w ph $.
    $( Commutation of quantification and substitution variables.  (Contributed
       by NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon, 23-Mar-2018.) $)
    sb9 $p |- ( A. x [ x / y ] ph <-> A. y [ y / x ] ph ) $=
      ( vw wsb wal sb9v sbcom albii 3bitri ax-17 sbco2h 3bitr3ri ) ABDEZDCEZCFZA
      CDEZDBEZBFZABCEZCFACBEZBFPNCDEZDFQBDEZDFSNCDGUBUCDABDCHIQDBGJOTCABCDADKZL
      IRUABACBDUDLIM $.
  $}

  $( Commutation of quantification and substitution variables.  (Contributed by
     NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon, 23-Mar-2018.) $)
  sb9i $p |- ( A. x [ x / y ] ph -> A. y [ y / x ] ph ) $=
    ( wsb wal sb9 biimpi ) ACBDBEABCDCEABCFG $.

  ${
    $d y z $.
    hbsbd.1 $e |- ( ph -> A. x ph ) $.
    hbsbd.2 $e |- ( ph -> A. z ph ) $.
    hbsbd.3 $e |- ( ph -> ( ps -> A. z ps ) ) $.
    $( Deduction version of ~ hbsb .  (Contributed by NM, 15-Feb-2013.)  (Proof
       rewritten by Jim Kingdon, 23-Mar-2018.) $)
    hbsbd $p |- ( ph -> ( [ y / x ] ps -> A. z [ y / x ] ps ) ) $=
      ( wsb nfi wi wnf nfdh nfim1 nfsb sbrim nfbii mpbi nfrimi nfrd ) ABCDIZEAU
      AEAEGJZABKZCDIZELAUAKZELUCCDEABEUBABEGHMNOUDUEEABCDFPQRST $.
  $}

  ${
    $d x y z $.  $d w y $.
    $( Equivalence for double substitution.  (Contributed by NM,
       3-Feb-2005.) $)
    2sb5 $p |- ( [ z / x ] [ w / y ] ph <->
               E. x E. y ( ( x = z /\ y = w ) /\ ph ) ) $=
      ( wsb weq wa wex sb5 19.42v anass exbii anbi2i 3bitr4ri bitri ) ACEFZBDFB
      DGZQHZBIRCEGZHAHZCIZBIQBDJSUBBRTAHZHZCIRUCCIZHUBSRUCCKUAUDCRTALMQUERACEJN
      OMP $.

    $( Equivalence for double substitution.  (Contributed by NM,
       3-Feb-2005.) $)
    2sb6 $p |- ( [ z / x ] [ w / y ] ph <->
               A. x A. y ( ( x = z /\ y = w ) -> ph ) ) $=
      ( wsb weq wi wal wa sb6 19.21v impexp albii imbi2i 3bitr4ri bitri ) ACEFZ
      BDFBDGZRHZBISCEGZJAHZCIZBIRBDKTUCBSUAAHZHZCISUDCIZHUCTSUDCLUBUECSUAAMNRUF
      SACEKOPNQ $.
  $}

  ${
    $d w x z $.  $d x y z $.
    $( Lemma for proving ~ sbcom2 .  It is the same as ~ sbcom2 but with
       additional distinct variable constraints on ` x ` and ` y ` , and on
       ` w ` and ` z ` .  (Contributed by Jim Kingdon, 19-Feb-2018.) $)
    sbcom2v $p |- ( [ w / z ] [ y / x ] ph <-> [ y / x ] [ w / z ] ph ) $=
      ( weq wal wsb alcom bi2.04 albii 19.21v bitri 3bitr3i sb6 imbi2i 3bitr4i
      wi ) DEFZBCFZARZBGZRZDGZTSARZDGZRZBGZABCHZDEHZADEHZBCHZTUERZBGZDGUMDGZBGU
      DUHUMDBIUNUCDUNSUARZBGUCUMUPBTSAJKSUABLMKUOUGBTUEDLKNUJSUIRZDGUDUIDEOUQUC
      DUIUBSABCOPKMULTUKRZBGUHUKBCOURUGBUKUFTADEOPKMQ $.
  $}

  ${
    $d v w x z $.  $d v y z $.  $d v ph $.
    $( Lemma for proving ~ sbcom2 .  It is the same as ~ sbcom2v but removes
       the distinct variable constraint on ` x ` and ` y ` .  (Contributed by
       Jim Kingdon, 19-Feb-2018.) $)
    sbcom2v2 $p |- ( [ w / z ] [ y / x ] ph <-> [ y / x ] [ w / z ] ph ) $=
      ( vv wsb sbcom2v sbbii bitri ax-17 sbco2v 3bitr3i ) ABFGZFCGZDEGZADEGZBFGZ
      FCGZABCGZDEGQBCGPNDEGZFCGSNFCDEHUARFCABFDEHIJOTDEABCFAFKLIQBCFQFKLM $.
  $}

  ${
    $d x z $.  $d v x w $.  $d v y z $.  $d v ph $.
    $( Commutativity law for substitution.  Used in proof of Theorem 9.7 of
       [Megill] p. 449 (p. 16 of the preprint).  (Contributed by NM,
       27-May-1997.)  (Proof modified to be intuitionistic by Jim Kingdon,
       19-Feb-2018.) $)
    sbcom2 $p |- ( [ w / z ] [ y / x ] ph <-> [ y / x ] [ w / z ] ph ) $=
      ( vv wsb sbcom2v2 sbbii bitri ax-17 sbco2v 3bitr3i ) ABCGZDFGZFEGZADFGZFE
      GZBCGZNDEGADEGZBCGPQBCGZFEGSOUAFEABCDFHIQBCFEHJNDEFNFKLRTBCADEFAFKLIM $.
  $}

  ${
    $d ph x y z $.  $d w x z $.
    $( Theorem *11.07 in [WhiteheadRussell] p. 159.  (Contributed by Andrew
       Salmon, 17-Jun-2011.) $)
    pm11.07 $p |- ( [ w / x ] [ y / z ] ph <-> [ y / x ] [ w / z ] ph ) $=
      ( cv wceq wa wex wsbc a9e pm3.2i 2th eeanv 3bitr4i anbi1i 19.41vv 2sb5 )
      BFZEFZGZDFZCFZGZHZAHDIBIZSUCGZUBTGZHZAHDIBIZADUCJBTJADTJBUCJUEDIBIZAHUIDI
      BIZAHUFUJUKULAUABIZUDDIZHZUGBIZUHDIZHZUKULUOURUMUNBEKDCKLUPUQBCKDEKLMUAUD
      BDNUGUHBDNOPUEABDQUIABDQOABDECRABDCERO $.
  $}

  ${
    $d x y $.
    $( Equivalence for substitution.  (Contributed by NM, 5-Aug-1993.) $)
    sb6a $p |- ( [ y / x ] ph <-> A. x ( x = y -> [ x / y ] ph ) ) $=
      ( wsb weq wi wal sb6 wb sbequ12 equcoms pm5.74i albii bitri ) ABCDBCEZAFZ
      BGOACBDZFZBGABCHPRBOAQAQICBACBJKLMN $.
  $}

  ${
    $d x y $.  $d x w $.  $d y z $.  $d z w $.
    2sb5rf.1 $e |- ( ph -> A. z ph ) $.
    2sb5rf.2 $e |- ( ph -> A. w ph ) $.
    $( Reversed double substitution.  (Contributed by NM, 3-Feb-2005.) $)
    2sb5rf $p |- ( ph <->
                E. z E. w ( ( z = x /\ w = y ) /\ [ z / x ] [ w / y ] ph ) ) $=
      ( weq wsb wex sb5rf 19.42v sbcom2 anbi2i anass bitri exbii hbsbv 3bitr4ri
      wa ) ADBHZABDIZTZDJUAECHZTZACEIBDIZTZEJZDJABDFKUCUHDUAUDUBCEIZTZTZEJUAUJE
      JZTUHUCUAUJELUGUKEUGUEUITUKUFUIUEACEBDMNUAUDUIOPQUBULUAUBCEABDEGRKNSQP $.

    $( Reversed double substitution.  (Contributed by NM, 3-Feb-2005.) $)
    2sb6rf $p |- ( ph <->
                A. z A. w ( ( z = x /\ w = y ) -> [ z / x ] [ w / y ] ph ) ) $=
      ( weq wsb wi wal wa sb6rf 19.21v sbcom2 imbi2i impexp bitri albii hbsbv
      3bitr4ri ) ADBHZABDIZJZDKUBECHZLZACEIBDIZJZEKZDKABDFMUDUIDUBUEUCCEIZJZJZE
      KUBUKEKZJUIUDUBUKENUHULEUHUFUJJULUGUJUFACEBDOPUBUEUJQRSUCUMUBUCCEABDEGTMP
      UASR $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.
    $( An alternate definition of proper substitution ~ df-sb .  By introducing
       a dummy variable ` z ` in the definiens, we are able to eliminate any
       distinct variable restrictions among the variables ` x ` , ` y ` , and
       ` ph ` of the definiendum.  No distinct variable conflicts arise because
       ` z ` effectively insulates ` x ` from ` y ` .  To achieve this, we use
       a chain of two substitutions in the form of ~ sb5 , first ` z ` for
       ` x ` then ` y ` for ` z ` .  Compare Definition 2.1'' of [Quine]
       p. 17.  Theorem ~ sb7f provides a version where ` ph ` and ` z ` don't
       have to be distinct.  (Contributed by NM, 28-Jan-2004.) $)
    dfsb7 $p |- ( [ y / x ] ph <-> E. z ( z = y /\ E. x ( x = z /\ ph ) ) ) $=
      ( wsb weq wa wex sb5 sbbii ax-17 sbco2v 3bitr3i ) ABDEZDCEBDFAGBHZDCEABCED
      CFOGDHNODCABDIJABCDADKLODCIM $.
  $}

  ${
    $d w x z $.  $d w y z $.  $d w ph $.
    sb7f.1 $e |- ( ph -> A. z ph ) $.
    $( This version of ~ dfsb7 does not require that ` ph ` and ` z ` be
       distinct.  This permits it to be used as a definition for substitution
       in a formalization that omits the logically redundant axiom ~ ax-17 i.e.
       that doesn't have the concept of a variable not occurring in a wff.
       ( ~ df-sb is also suitable, but its mixing of free and bound variables
       is distasteful to some logicians.)  (Contributed by NM, 26-Jul-2006.)
       (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    sb7f $p |- ( [ y / x ] ph <->
               E. z ( z = y /\ E. x ( x = z /\ ph ) ) ) $=
      ( wsb weq wa wex sb5 sbbii sbco2v 3bitr3i ) ABDFZDCFBDGAHBIZDCFABCFDCGOHDI
      NODCABDJKABCDELODCJM $.
  $}

  ${
    $d x z $.  $d y z $.
    sb7af.1 $e |- F/ z ph $.
    $( An alternative definition of proper substitution ~ df-sb .  Similar to
       ~ dfsb7a but does not require that ` ph ` and ` z ` be distinct.
       Similar to ~ sb7f in that it involves a dummy variable ` z ` , but
       expressed in terms of ` A. ` rather than ` E. ` .  (Contributed by Jim
       Kingdon, 5-Feb-2018.) $)
    sb7af $p |- ( [ y / x ] ph
                      <-> A. z
                             ( z = y
                             -> A. x ( x = z -> ph ) ) ) $=
      ( cv wsbc wceq wi wal nfri sbco2v sb6 sbbii bitri bitr3i )
      ABCFZGABDFZGZDQGZRQHBFRHAIBJZIDJZABCDADEKLTUADQGUBSUADCABDMNUADCM
      OP $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.
    $( An alternative definition of proper substitution ~ df-sb .  Similar to
       ~ dfsb7 in that it involves a dummy variable ` z ` , but expressed in
       terms of ` A. ` rather than ` E. ` .  For a version which only requires
       ` F/ z ph ` rather than ` z ` and ` ph ` being distinct, see ~ sb7af .
       (Contributed by Jim Kingdon, 5-Feb-2018.) $)
    dfsb7a $p |- ( [ y / x ] ph
                      <-> A. z
                             ( z = y
                             -> A. x ( x = z -> ph ) ) ) $=
      ( nfv sb7af ) ABCDADEF $.
  $}

  ${
    $d x y $.
    sb10f.1 $e |- ( ph -> A. x ph ) $.
    $( Hao Wang's identity axiom P6 in Irving Copi, _Symbolic Logic_ (5th ed.,
       1979), p. 328.  In traditional predicate calculus, this is a sole axiom
       for identity from which the usual ones can be derived.  (Contributed by
       NM, 9-May-2005.) $)
    sb10f $p |- ( [ y / z ] ph <-> E. x ( x = y /\ [ x / z ] ph ) ) $=
      ( weq wsb wa wex hbsb sbequ equsex bicomi ) BCFADBGZHBIADCGZNOBCADCBEJABC
      DKLM $.
  $}

  ${
    $d x ph $.
    $( An identity law for substitution.  Used in proof of Theorem 9.7 of
       [Megill] p. 449 (p. 16 of the preprint).  (Contributed by NM,
       5-Aug-1993.) $)
    sbid2v $p |- ( [ y / x ] [ x / y ] ph <-> ph ) $=
      ( ax-17 sbid2 ) ABCABDE $.
  $}

  ${
    $d x y $.  $d x ph $.
    $( Elimination of substitution.  (Contributed by NM, 5-Aug-1993.) $)
    sbelx $p |- ( ph <-> E. x ( x = y /\ [ x / y ] ph ) ) $=
      ( cv wsbc wceq wa wex ax-17 sbid2 sb5 bitr3i ) AACBDZEZBCDZEM
      OFNGBHABCABIJNBCKL $.
  $}

  ${
    $( Note:  A more general case could also be proved with
       "$d x z $.  $d y w $.  $d x ph $.  $d y ph $.", but with more
       difficulty. $)
    $d x y z $.  $d w y $.  $d x y ph $.
    $( Elimination of double substitution.  (Contributed by NM, 5-Aug-1993.) $)
    sbel2x $p |- ( ph <-> E. x E. y ( ( x = z /\ y = w ) /\
                     [ y / w ] [ x / z ] ph ) ) $=
      ( weq wsb wa wex sbelx anbi2i exbii exdistr 3bitr4i anass 2exbii bitr4i )
      ABDFZCEFZADBGZECGZHZHZCIBIZRSHUAHZCIBIRTHZBIRUBCIZHZBIAUDUFUHBTUGRTCEJKLA
      BDJRUBBCMNUEUCBCRSUAOPQ $.
  $}

  ${
    $d x y z $.
    $( Move universal quantifier in and out of substitution.  Identical to
       ~ sbal except that it has an additional distinct variable constraint on
       ` y ` and ` z ` .  (Contributed by Jim Kingdon, 29-Dec-2017.) $)
    sbalyz $p |- ( [ z / y ] A. x ph <-> A. x [ z / y ] ph ) $=
      ( wal cv wsbc ax-ial hbsbv ax-4 sbimi alimi syl wceq wi sb6 albii
      alcom bitri ax-17 alim syl5 sb2 sylbi impbii ) ABEZCDFZGZACUGGZBE
      ZUHUHBEUJUFCDBABHIUHUIBUFACDABJKLMUJCFUGNZAOZBEZCEZUHUJULCEZBEUNU
      IUOBACDPQULBCRSUNUKUFOZCEUHUMUPCUKUKBEUMUFUKBTUKABUAUBLUFCDUCMUDU
      E $.
  $}

  ${
    $d x y w $.  $d x z w $.  $d w ph $.
    $( Move universal quantifier in and out of substitution.  (Contributed by
       NM, 5-Aug-1993.)  (Proof rewritten by Jim Kingdon, 12-Feb-2018.) $)
    sbal $p |- ( [ z / y ] A. x ph <-> A. x [ z / y ] ph ) $=
      ( vw wal wsb sbalyz sbbii bitri ax-17 sbco2v albii 3bitr3i ) ABFZCEGZEDGZ
      ACEGZEDGZBFZOCDGACDGZBFQRBFZEDGTPUBEDABCEHIRBEDHJOCDEOEKLSUABACDEAEKLMN
      $.
  $}

  ${
    $d x y $.  $d y z $.
    $( Lemma for proving ~ sbal1 .  Same as ~ sbal1 but with an additional
       distinct variable constraint on ` y ` and ` z ` .  (Contributed by Jim
       Kingdon, 23-Feb-2018.) $)
    sbal1yz $p |- ( -. A. x x = z ->
             ( [ z / y ] A. x ph <-> A. x [ z / y ] ph ) ) $=
      ( weq wal wn wsb wi wb wo dveeq2or equcom nfbii 19.21t sylbi imbi1i albii
      wnf sb6 orim2i ax-mp ori albidv alcom bitri bitr4i bitr2i 3bitr3g bicomd
      ) BDEBFZGZACDHZBFZABFZCDHZULDCEZAIZBFZCFZUQUOIZCFZUNUPULUSVACUKUSVAJZUKCD
      EZBSZKUKVCKBDCLVEVCUKVEUQBSVCVDUQBCDMZNUQABOPUAUBUCUDUTURCFZBFUNURCBUEUMV
      GBUMVDAIZCFVGACDTVHURCVDUQAVFQRUFRUGUPVDUOIZCFVBUOCDTVIVACVDUQUOVFQRUHUIU
      J $.
  $}

  ${
    $d x y $.  $d w x $.  $d w y $.  $d w z $.  $d ph w $.

    $( A theorem used in elimination of disjoint variable restriction on ` x `
       and ` y ` by replacing it with a distinctor ` -. A. x x = z ` .
       (Contributed by NM, 5-Aug-1993.)  (Proof rewitten by Jim Kingdon,
       24-Feb-2018.) $)
    sbal1 $p |- ( -. A. x x = z ->
             ( [ z / y ] A. x ph <-> A. x [ z / y ] ph ) ) $=
      ( vw weq wal wn wsb sbal sbbii sbal1yz syl5bb ax-17 sbco2v albii 3bitr3g
      ) BDFBGHZABGZCEIZEDIZACEIZEDIZBGZSCDIACDIZBGUAUBBGZEDIRUDTUFEDABCEJKUBBED
      LMSCDESENOUCUEBACDEAENOPQ $.
  $}

  ${
    $d x y z $.
    $( Move existential quantifier in and out of substitution.  Identical to
       ~ sbex except that it has an additional distinct variable constraint on
       ` y ` and ` z ` .  (Contributed by Jim Kingdon, 29-Dec-2017.) $)
    sbexyz $p |- ( [ z / y ] E. x ph <-> E. x [ z / y ] ph ) $=
      ( wex cv wsbc wceq wa sb5 ax-17 19.42h exbii excom 3bitr2i bitr4i
      ) ABEZCDFZGZCFRHZAIZCEZBEZACRGZBESTQIZCEUABEZCEUCQCDJUFUECTABTBKL
      MUACBNOUDUBBACDJMP $.
  $}

  ${
    $d x y w $.  $d x z w $.  $d w ph $.
    $( Move existential quantifier in and out of substitution.  (Contributed by
       NM, 27-Sep-2003.)  (Proof rewritten by Jim Kingdon, 12-Feb-2018.) $)
    sbex $p |- ( [ z / y ] E. x ph <-> E. x [ z / y ] ph ) $=
      ( vw wex wsb sbexyz sbbii bitri ax-17 sbco2v exbii 3bitr3i ) ABFZCEGZEDGZ
      ACEGZEDGZBFZOCDGACDGZBFQRBFZEDGTPUBEDABCEHIRBEDHJOCDEOEKLSUABACDEAEKLMN
      $.
  $}

  ${
    $d x z $.  $d y z $.
    sbalv.1 $e |- ( [ y / x ] ph <-> ps ) $.
    $( Quantify with new variable inside substitution.  (Contributed by NM,
       18-Aug-1993.) $)
    sbalv $p |- ( [ y / x ] A. z ph <-> A. z ps ) $=
      ( wal wsb sbal albii bitri ) AEGCDHACDHZEGBEGAECDILBEFJK $.
  $}

  ${
    $d x y $.  $d y ph $.
    $( An equivalent expression for existence.  (Contributed by NM,
       2-Feb-2005.) $)
    exsb $p |- ( E. x ph <-> E. y A. x ( x = y -> ph ) ) $=
      ( wex wsb weq wi wal ax-17 sb8eh sb6 exbii bitri ) ABDABCEZCDBCFAGBHZCDABC
      ACIJNOCABCKLM $.
  $}

  ${
    $d x y z $.  $d y w $.  $d z w ph $.
    $( An equivalent expression for double existence.  (Contributed by NM,
       2-Feb-2005.) $)
    2exsb $p |- ( E. x E. y ph <->
                  E. z E. w A. x A. y ( ( x = z /\ y = w ) -> ph ) ) $=
      ( wex weq wi wal exsb exbii excom bitri impexp albii 19.21v bitr2i 3bitri
      wa ) ACFZBFZCEGZAHZCIZBFZEFZBDGZUBSAHZCIZBIZDFZEFUJEFDFUAUDEFZBFUFTULBACE
      JKUDBELMUEUKEUEUGUDHZBIZDFUKUDBDJUNUJDUMUIBUIUGUCHZCIUMUHUOCUGUBANOUGUCCP
      QOKMKUJEDLR $.
  $}

  ${
    $d z ps $.  $d x z $.  $d y z $.
    dvelimALT.1 $e |- ( ph -> A. x ph ) $.
    dvelimALT.2 $e |- ( z = y -> ( ph <-> ps ) ) $.
    $( Version of ~ dvelim that doesn't use ~ ax-10 .  (Contributed by NM,
       17-May-2008.)  (Proof modification is discouraged.) $)
    dvelimALT $p |- ( -. A. x x = y -> ( ps -> A. x ps ) ) $=
      ( weq wal wn wi wnf nfv wo ax-i12 orcom orbi2i mpbi a1i nfimd orass mpbir
      nfa1 ax16ALT nfd nfi df-nf id sylbir jaoi orim1i ax-mp nfald ax-17 equsal
      ori nfbii sylib nfrd ) CDHCIZJZBCVAEDHZAKZEIZCLBCLVAVCCEVAEMUTVCCLZVEUTNZ
      UTVENCEHZCIZVBVBCIKCIZNZUTNZVFVKVHVIUTNZNZVHUTVINZNVMEDCOVNVLVHUTVIPQRVHV
      IUTUAUBVJVEUTVHVEVIVHVBACVHVBCVGCUCVBCEUDUEACLZVHACFUFZSTVIVBCLZVEVBCUGVQ
      VBACVQUHVOVQVPSTUIUJUKULVEUTPRUPUMVDBCABEDBEUNGUOUQURUS $.
  $}

  ${
    $d x z $.
    dvelimfv.1 $e |- ( ph -> A. x ph ) $.
    dvelimfv.2 $e |- ( ps -> A. z ps ) $.
    dvelimfv.3 $e |- ( z = y -> ( ph <-> ps ) ) $.
    $( Like ~ dvelimf but with a distinct variable constraint on ` x ` and
       ` z ` .  (Contributed by Jim Kingdon, 6-Mar-2018.) $)
    dvelimfv $p |- ( -. A. x x = y -> ( ps -> A. x ps ) ) $=
      ( weq wal wn wi wnf nfnae wo ax-i12 orcom mpbi a1i nfimd orass mpbir nfae
      orbi2i ax16ALT nfd nfi df-nf id sylbir jaoi orim1i ax-mp ori nfald equsal
      nfbii sylib nfrd ) CDICJZKZBCVAEDIZALZEJZCMBCMVAVCCECDENUTVCCMZVEUTOZUTVE
      OCEICJZVBVBCJLCJZOZUTOZVFVJVGVHUTOZOZVGUTVHOZOVLEDCPVMVKVGUTVHQUDRVGVHUTU
      AUBVIVEUTVGVEVHVGVBACVGVBCCECUCVBCEUEUFACMZVGACFUGZSTVHVBCMZVEVBCUHVPVBAC
      VPUIVNVPVOSTUJUKULUMVEUTQRUNUOVDBCABEDGHUPUQURUS $.
  $}

  ${
    $d w x $.  $d w y $.  $d w z $.  $d ph w $.
    hbsb4.1 $e |- ( ph -> A. z ph ) $.
    $( A variable not free remains so after substitution with a distinct
       variable.  (Contributed by NM, 5-Aug-1993.)  (Proof rewritten by Jim
       Kingdon, 23-Mar-2018.) $)
    hbsb4 $p |- ( -. A. z z = y -> ( [ y / x ] ph -> A. z [ y / x ] ph ) ) $=
      ( vw wsb hbsb sbequ dvelimALT ) ABFGABCGDCFABFDEHAFCBIJ $.
  $}

  $( A variable not free remains so after substitution with a distinct variable
     (closed form of ~ hbsb4 ).  (Contributed by NM, 7-Apr-2004.)  (Proof
     shortened by Andrew Salmon, 25-May-2011.) $)
  hbsb4t $p |- ( A. x A. z ( ph -> A. z ph ) ->
               ( -. A. z z = y -> ( [ y / x ] ph -> A. z [ y / x ] ph ) ) ) $=
    ( weq wal wn wsb wi hba1 hbsb4 a4sbim sps ax-4 sbimi alimi a1i imim12d syl5
    a7s ) DCEDFGADFZBCHZUBDFZIZAUAIZDFBFABCHZUFDFZIZUABCDADJKUEUDUHIDBUEBFZDFZU
    FUBUCUGUIUFUBIDAUABCLMUCUGIUJUBUFDUAABCADNOPQRTS $.

  $( A variable not free remains so after substitution with a distinct variable
     (closed form of ~ hbsb4 ).  (Contributed by NM, 7-Apr-2004.)  (Revised by
     Mario Carneiro, 4-Oct-2016.)  (Proof rewritten by Jim Kingdon,
     9-May-2018.) $)
  nfsb4t $p |- ( A. x F/ z ph ->
                 ( -. A. z z = y -> F/ z [ y / x ] ph ) ) $=
    ( wnf wal cv wceq wn wsbc wa nfnf1 nfal nfnae nfan wi df-nf albii
    hbsb4t sylbi imp nfd ex ) ADEZBFZDGCGZHDFIZABUFJZDEUEUGKUHDUEUGDU
    DDBADLMDCDNOUEUGUHUHDFPZUEAADFPDFZBFUGUIPUDUJBADQRABCDSTUAUBUC $.

  ${
    dvelimf.1 $e |- ( ph -> A. x ph ) $.
    dvelimf.2 $e |- ( ps -> A. z ps ) $.
    dvelimf.3 $e |- ( z = y -> ( ph <-> ps ) ) $.
    $( Version of ~ dvelim without any variable restrictions.  (Contributed by
       NM, 1-Oct-2002.) $)
    dvelimf $p |- ( -. A. x x = y -> ( ps -> A. x ps ) ) $=
      ( weq wal wn wsb hbsb4 sbieh albii 3imtr3g ) CDICJKAEDLZQCJBBCJAEDCFMABEDG
      HNZQBCROP $.
  $}

  ${
    dvelimdf.1 $e |- F/ x ph $.
    dvelimdf.2 $e |- F/ z ph $.
    dvelimdf.3 $e |- ( ph -> F/ x ps ) $.
    dvelimdf.4 $e |- ( ph -> F/ z ch ) $.
    dvelimdf.5 $e |- ( ph -> ( z = y -> ( ps <-> ch ) ) ) $.
    $( Deduction form of ~ dvelimf .  This version may be useful if we want to
       avoid ~ ax-17 and use ~ ax-16 instead.  (Contributed by NM,
       7-Apr-2004.)  (Revised by Mario Carneiro, 6-Oct-2016.)  (Proof shortened
       by Wolf Lammen, 11-May-2018.) $)
    dvelimdf $p |- ( ph -> ( -. A. x x = y -> F/ x ch ) ) $=
      ( weq wal wn wsb wnf wi alrimi nfsb4t syl sbied nfbidf sylibd ) ADELDMNZB
      FEOZDPZCDPABDPZFMUDUFQAUGFHIRBFEDSTAUECDGABCFEHJKUAUBUC $.
  $}

  ${
    $d z ps $.
    dvelim.1 $e |- ( ph -> A. x ph ) $.
    dvelim.2 $e |- ( z = y -> ( ph <-> ps ) ) $.
    $( This theorem can be used to eliminate a distinct variable restriction on
       ` x ` and ` z ` and replace it with the "distinctor" ` -. A. x x = y `
       as an antecedent. ` ph ` normally has ` z ` free and can be read
       ` ph ( z ) ` , and ` ps ` substitutes ` y ` for ` z ` and can be read
       ` ph ( y ) ` .  We don't require that ` x ` and ` y ` be distinct: if
       they aren't, the distinctor will become false (in multiple-element
       domains of discourse) and "protect" the consequent.

       To obtain a closed-theorem form of this inference, prefix the hypotheses
       with ` A. x A. z ` , conjoin them, and apply ~ dvelimdf .

       Other variants of this theorem are ~ dvelimf (with no distinct variable
       restrictions) and ~ dvelimALT (that avoids ~ ax-10 ).  (Contributed by
       NM, 23-Nov-1994.) $)
    dvelim $p |- ( -. A. x x = y -> ( ps -> A. x ps ) ) $=
      ( ax-17 dvelimf ) ABCDEFBEHGI $.
  $}

  ${
    $d z ps $.  $d x z $.
    dvelimor.1 $e |- F/ x ph $.
    dvelimor.2 $e |- ( z = y -> ( ph <-> ps ) ) $.
    $( Disjunctive distinct variable constraint elimination.  A user of this
       theorem starts with a formula ` ph ` (containing ` z ` ) and a distinct
       variable constraint between ` x ` and ` z ` .  The theorem makes it
       possible to replace the distinct variable constraint with the disjunct
       ` A. x x = y ` ( ` ps ` is just a version of ` ph ` with ` y `
       substituted for ` z ` ).  (Contributed by Jim Kingdon, 11-May-2018.) $)
    dvelimor $p |- ( A. x x = y \/ F/ x ps ) $=
      ( weq wal wi wnf wo ax-bnd orcom orbi2i mpbi orass mpbir nfae ax-mp a16nf
      alrimi df-nf a1i nfimd sylbir alimi orim1i nfalt ax-17 equsal nfbii sylib
      id jaoi orim2i ) CDHCIZEDHZAJZCKZEIZLZUQBCKZLVAUQLZVBCEHCIZURURCIJCIZEIZL
      ZUQLZVDVIVEVGUQLZLZVEUQVGLZLVKEDCMVLVJVEUQVGNOPVEVGUQQRVHVAUQVEVAVGVEUTEC
      EESUSCECUAUBVFUTEVFURCKZUTURCUCVMURACVMUNACKVMFUDUEUFUGUOUHTVAUQNPVAVCUQV
      AUSEIZCKVCUSCEUIVNBCABEDBEUJGUKULUMUPT $.
  $}

  ${
    $d w z x $.  $d w y $.
    $( Quantifier introduction when one pair of variables is distinct.
       (Contributed by NM, 2-Jan-2002.)  (Proof rewritten by Jim Kingdon,
       19-Feb-2018.) $)
    dveeq1 $p |- ( -. A. x x = y -> ( y = z -> A. x y = z ) ) $=
      ( weq wal wn dveeq2 equcom albii 3imtr3g ) ABDAEFCBDZKAEBCDZLAEABCGCBHZKL
      AMIJ $.
  $}

  ${
    $d w z x $.  $d w y $.
    $( Quantifier introduction when one pair of variables is distinct.
       (Contributed by NM, 2-Jan-2002.) $)
    dveel1 $p |- ( -. A. x x = y -> ( y e. z -> A. x y e. z ) ) $=
      ( vw wel ax-17 elequ1 dvelimf ) DCEZBCEZABDIAFJDFDBCGH $.
  $}

  ${
    $d w z x $.  $d w y $.
    $( Quantifier introduction when one pair of variables is distinct.
       (Contributed by NM, 2-Jan-2002.) $)
    dveel2 $p |- ( -. A. x x = y -> ( z e. y -> A. x z e. y ) ) $=
      ( vw wel ax-17 elequ2 dvelimf ) CDEZCBEZABDIAFJDFDBCGH $.
  $}

  ${
    $d z y $.  $d z x $.
    $( Move quantifier in and out of substitution.  (Contributed by NM,
       2-Jan-2002.) $)
    sbal2 $p |- ( -. A. x x = y ->
             ( [ z / y ] A. x ph <-> A. x [ z / y ] ph ) ) $=
      ( weq wal wn wi alcom hbnae wb dveeq1 alimi hbnaes 19.21ht albidh syl5rbbr
      wsb syl sb6 albii 3bitr4g ) BCEBFGZCDEZABFZHZCFZUDAHZCFZBFZUECDRACDRZBFUJ
      UHBFZCFUCUGUHCBIUCULUFCBCCJUCUDUDBFHZBFZULUFKUNBCBUCUMBBCDLMNUDABOSPQUECD
      TUKUIBACDTUAUB $.
  $}

  ${
    $d w x $.  $d w y $.  $d w z $.  $d ph w $.
    nfsb4or.1 $e |- F/ z ph $.
    $( A variable not free remains so after substitution with a distinct
       variable.  (Contributed by Jim Kingdon, 11-May-2018.) $)
    nfsb4or $p |- ( A. z z = y \/ F/ z [ y / x ] ph ) $=
      ( vw wsb nfsb sbequ dvelimor ) ABFGABCGDCFABFDEHAFCBIJ $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Existential uniqueness
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare new symbols needed for uniqueness notation. $)
  $c E! $.  $( Backwards E exclamation point. $)
  $c E* $.  $( Backwards E superscript *. $)

  $( Extend wff definition to include existential uniqueness ("there exists a
     unique ` x ` such that ` ph ` "). $)
  weu $a wff E! x ph $.

  $( Extend wff definition to include uniqueness ("there exists at most one
     ` x ` such that ` ph ` "). $)
  wmo $a wff E* x ph $.

  ${
    $d w x y $.  $d x z $.  $d y ph $.  $d w z ph $.
    $( A soundness justification theorem for ~ df-eu , showing that the
       definition is equivalent to itself with its dummy variable renamed.
       Note that ` y ` and ` z ` needn't be distinct variables.  (Contributed
       by NM, 11-Mar-2010.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
    eujust $p |- ( E. y A. x ( ph <-> x = y )
        <-> E. z A. x ( ph <-> x = z ) ) $=
      ( vw cv wceq wb wal wex equequ2 bibi2d albidv cbvexv bitri ) ABFZCFZGZHZB
      IZCJAPEFZGZHZBIZEJAPDFZGZHZBIZDJTUDCEQUAGZSUCBUIRUBACEBKLMNUDUHEDUAUEGZUC
      UGBUJUBUFAEDBKLMNO $.
  $}

  ${
    $d x y $.  $d y ph $.
    $( Define existential uniqueness, i.e.  "there exists exactly one ` x `
       such that ` ph ` ."  Definition 10.1 of [BellMachover] p. 97; also
       Definition *14.02 of [WhiteheadRussell] p. 175.  Other possible
       definitions are given by ~ eu1 , ~ eu2 , ~ eu3 , and ~ eu5 (which in
       some cases we show with a hypothesis ` ph -> A. y ph ` in place of a
       distinct variable condition on ` y ` and ` ph ` ).  Double uniqueness is
       tricky: ` E! x E! y ph ` does not mean "exactly one ` x ` and one
       ` y ` " (see ~ 2eu4 ).  (Contributed by NM, 5-Aug-1993.) $)
    df-eu $a |- ( E! x ph <-> E. y A. x ( ph <-> x = y ) ) $.
  $}

  $( Define "there exists at most one ` x ` such that ` ph ` ."  Here we define
     it in terms of existential uniqueness.  Notation of [BellMachover] p. 460,
     whose definition we show as ~ mo3 .  For other possible definitions see
     ~ mo2 and ~ mo4 .  (Contributed by NM, 5-Aug-1993.) $)
  df-mo $a |- ( E* x ph <-> ( E. x ph -> E! x ph ) ) $.

  ${
    $d x y z $.  $d ph z $.
    euf.1 $e |- ( ph -> A. y ph ) $.
    $( A version of the existential uniqueness definition with a hypothesis
       instead of a distinct variable condition.  (Contributed by NM,
       12-Aug-1993.) $)
    euf $p |- ( E! x ph <-> E. y A. x ( ph <-> x = y ) ) $=
      ( vz weu weq wb wal wex df-eu ax-17 hbbi hbal equequ2 bibi2d albidv cbvexh
      bitri ) ABFABEGZHZBIZEJABCGZHZBIZCJABEKUBUEECUACBATCDTCLMNUEELECGZUAUDBUF
      TUCAECBOPQRS $.
  $}

  ${
    $d x y $.  $d y ph $.  $d y ps $.  $d y ch $.
    eubidh.1 $e |- ( ph -> A. x ph ) $.
    eubidh.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for uniqueness quantifier (deduction rule).
       (Contributed by NM, 9-Jul-1994.) $)
    eubidh $p |- ( ph -> ( E! x ps <-> E! x ch ) ) $=
      ( vy weq wb wal wex weu bibi1d albidh exbidv df-eu 3bitr4g ) ABDGHZIZDJZGK
      CRIZDJZGKBDLCDLATUBGASUADEABCRFMNOBDGPCDGPQ $.
  $}

  ${
    $d x y $.  $d y ph $.  $d y ps $.  $d y ch $.
    eubid.1 $e |- F/ x ph $.
    eubid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for uniqueness quantifier (deduction rule).
       (Contributed by NM, 9-Jul-1994.) $)
    eubid $p |- ( ph -> ( E! x ps <-> E! x ch ) ) $=
      ( vy weq wb wal wex weu bibi1d albid exbidv df-eu 3bitr4g ) ABDGHZIZDJZGK
      CRIZDJZGKBDLCDLATUBGASUADEABCRFMNOBDGPCDGPQ $.
  $}

  ${
    $d x ph $.
    eubidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for uniqueness quantifier (deduction rule).
       (Contributed by NM, 9-Jul-1994.) $)
    eubidv $p |- ( ph -> ( E! x ps <-> E! x ch ) ) $=
      ( nfv eubid ) ABCDADFEG $.
  $}

  ${
    eubii.1 $e |- ( ph <-> ps ) $.
    $( Introduce uniqueness quantifier to both sides of an equivalence.
       (Contributed by NM, 9-Jul-1994.)  (Revised by Mario Carneiro,
       6-Oct-2016.) $)
    eubii $p |- ( E! x ph <-> E! x ps ) $=
      ( weu wb wtru a1i eubidv trud ) ACEBCEFGABCABFGDHIJ $.
  $}

  ${
    $d x y $.  $d y ph $.
    $( Bound-variable hypothesis builder for uniqueness.  (Contributed by NM,
       9-Jul-1994.) $)
    hbeu1 $p |- ( E! x ph -> A. x E! x ph ) $=
      ( vy weu weq wb wal wex df-eu hba1 hbex hbxfrbi ) ABDABCEFZBGZCHBABCINBCM
      BJKL $.
  $}

  ${
    $d x y $.  $d y ph $.
    $( Bound-variable hypothesis builder for uniqueness.  (Contributed by NM,
       9-Jul-1994.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
    nfeu1 $p |- F/ x E! x ph $=
      ( vy weu weq wb wal wex df-eu nfa1 nfex nfxfr ) ABDABCEFZBGZCHBABCINBCMBJ
      KL $.
  $}

  $( Bound-variable hypothesis builder for "at most one."  (Contributed by NM,
     8-Mar-1995.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
  nfmo1 $p |- F/ x E* x ph $=
    ( wmo wex weu wi df-mo nfe1 nfeu1 nfim nfxfr ) ABCABDZABEZFBABGLMBABHABIJK
    $.

  ${
    $d w y z $.  $d ph z w $.  $d w x z $.
    sb8eu.1 $e |- F/ y ph $.
    $( Variable substitution in uniqueness quantifier.  (Contributed by NM,
       7-Aug-1994.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
    sb8eu $p |- ( E! x ph <-> E! y [ y / x ] ph ) $=
      ( vz vw weq wb wal wex wsb weu nfv sb8 sbbi nfsb equsb3 nfxfr nfbi df-eu
      sbequ cbval sblbis albii 3bitri exbii 3bitr4i ) ABEGZHZBIZEJABCKZCEGZHZCI
      ZEJABLUKCLUJUNEUJUIBFKZFIUIBCKZCIUNUIBFUIFMNUOUPFCUOABFKZUHBFKZHCAUHBFOUQ
      URCABFCDPURFEGZCFBEQUSCMRSRUPFMUIFCBUAUBUPUMCUHULABCCBEQUCUDUEUFABETUKCET
      UG $.

    $( Variable substitution for "at most one."  (Contributed by Alexander van
       der Vekens, 17-Jun-2017.) $)
    sb8mo $p |- ( E* x ph <-> E* y [ y / x ] ph ) $=
      ( wex weu wi wsb wmo sb8e sb8eu imbi12i df-mo 3bitr4i ) ABEZABFZGABCHZCEZ
      QCFZGABIQCIORPSABCDJABCDKLABMQCMN $.
  $}

  ${
    $d x y z $.  $d z ph $.  $d z ps $.
    nfeudv.1 $e |- F/ y ph $.
    nfeudv.2 $e |- ( ph -> F/ x ps ) $.
    $( Deduction version of ~ nfeu .  Similar to ~ nfeud but has the additional
       constraint that ` x ` and ` y ` must be distinct.  (Contributed by Jim
       Kingdon, 25-May-2018.) $)
    nfeudv $p |- ( ph -> F/ x E! y ps ) $=
      ( vz cv wceq wb wal wex wnf weu nfv a1i nfbid nfald nfexd df-eu
      nfbii sylibr ) ABDHGHIZJZDKZGLZCMBDNZCMAUECGAGOAUDCDEABUCCFUCCM
      AUCCOPQRSUGUFCBDGTUAUB $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.  $d z ps $.
    nfeud.1 $e |- F/ y ph $.
    nfeud.2 $e |- ( ph -> F/ x ps ) $.
    $( Deduction version of ~ nfeu .  (Contributed by NM, 15-Feb-2013.)
       (Revised by Mario Carneiro, 7-Oct-2016.)  (Proof rewritten by Jim
       Kingdon, 25-May-2018.) $)
    nfeud $p |- ( ph -> F/ x E! y ps ) $=
      ( vz weu cv wsbc nfv sb8eu nfsbd nfeudv nfxfrd ) BDHBDGIJZGHACB
      DGBGKLAPCGAGKABDGCEFMNO $.
  $}

  ${
    $d x y z $.  $d z ph $.
    nfeuv.1 $e |- F/ x ph $.
    $( Bound-variable hypothesis builder for existential uniqueness.  This is
       similar to ~ nfeu but has the additional constraint that ` x ` and ` y `
       must be distinct.  (Contributed by Jim Kingdon, 23-May-2018.) $)
    nfeuv $p |- F/ x E! y ph $=
      ( vz weu wnf weq wb wal wex nfv nfbi nfal nfex df-eu nfbii mpbir ) ACFZBG
      ACEHZIZCJZEKZBGUBBEUABCATBDTBLMNOSUCBACEPQR $.
  $}

  ${
    $d y z $.  $d x z $.  $d z ph $.
    nfeu.1 $e |- F/ x ph $.
    $( Bound-variable hypothesis builder for existential uniqueness.  Note that
       ` x ` and ` y ` needn't be distinct.  (Contributed by NM, 8-Mar-1995.)
       (Revised by Mario Carneiro, 7-Oct-2016.)  (Proof rewritten by Jim
       Kingdon, 23-May-2018.) $)
    nfeu $p |- F/ x E! y ph $=
      ( vz weu cv wsbc nfv sb8eu nfsb nfeuv nfxfr ) ACFACEGHZEFBACEAE
      IJNBEACEBDKLM $.
  $}

  ${
    $d y z $.  $d x z $.  $d z ph $.
    hbeu.1 $e |- ( ph -> A. x ph ) $.
    $( Bound-variable hypothesis builder for uniqueness.  Note that ` x ` and
       ` y ` needn't be distinct.  (Contributed by NM, 8-Mar-1995.)  (Proof
       rewritten by Jim Kingdon, 24-May-2018.) $)
    hbeu $p |- ( E! y ph -> A. x E! y ph ) $=
      ( weu nfi nfeu nfri ) ACEBABCABDFGH $.
  $}

  ${
    $d y z $.  $d x z $.  $d z ph $.  $d z ps $.
    hbeud.1 $e |- ( ph -> A. x ph ) $.
    hbeud.2 $e |- ( ph -> A. y ph ) $.
    hbeud.3 $e |- ( ph -> ( ps -> A. x ps ) ) $.
    $( Deduction version of ~ hbeu .  (Contributed by NM, 15-Feb-2013.)  (Proof
       rewritten by Jim Kingdon, 25-May-2018.) $)
    hbeud $p |- ( ph -> ( E! y ps -> A. x E! y ps ) ) $=
      ( weu nfi nfd nfeud nfrd ) ABDHCABCDADFIABCACEIGJKL $.
  $}

  ${
    $d w y z $.  $d ph z w $.  $d w x z $.
    sb8euh.1 $e |- ( ph -> A. y ph ) $.
    $( Variable substitution in uniqueness quantifier.  (Contributed by NM,
       7-Aug-1994.)  (Revised by Andrew Salmon, 9-Jul-2011.) $)
    sb8euh $p |- ( E! x ph <-> E! y [ y / x ] ph ) $=
      ( vz vw cv wceq wal wex wsbc weu ax-17 sb8h sbbi hbsb equsb3 hbxfrbi df-eu
      wb hbbi sbequ cbvalh sblbis albii 3bitri exbii 3bitr4i ) ABGEGZHZTZBIZEJAB
      CGZKZUMUIHZTZCIZEJABLUNCLULUQEULUKBFGZKZFIUKBUMKZCIUQUKBFUKFMNUSUTFCUSABU
      RKZUJBURKZTCAUJBFOVAVBCABFCDPVBURUIHZCFBEQVCCMRUARUTFMUKFCBUBUCUTUPCUJUOA
      BCCBEQUDUEUFUGABESUNCESUH $.
  $}

  ${
    cbveu.1 $e |- F/ y ph $.
    cbveu.2 $e |- F/ x ps $.
    cbveu.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 25-Nov-1994.)  (Revised by Mario Carneiro,
       7-Oct-2016.) $)
    cbveu $p |- ( E! x ph <-> E! y ps ) $=
      ( weu wsb sb8eu sbie eubii bitri ) ACHACDIZDHBDHACDEJNBDABCDFGKLM $.
  $}

  ${
    $d x y $.
    eu1.1 $e |- ( ph -> A. y ph ) $.
    $( An alternate way to express uniqueness used by some authors.  Exercise
       2(b) of [Margaris] p. 110.  (Contributed by NM, 20-Aug-1993.) $)
    eu1 $p |- ( E! x ph <->
                E. x ( ph /\ A. y ( [ y / x ] ph -> x = y ) ) ) $=
      ( wsb weu weq wb wal wex wi wa hbs1 euf sb8euh equcom imbi2i albii 3bitr4i
      sb6rf anbi12i ancom albiim exbii ) ABCEZCFUECBGZHCIZBJABFAUEBCGZKZCIZLZBJ
      UECBABCMNABCDOUKUGBUJALUEUFKZCIZUFUEKCIZLUKUGUJUMAUNUIULCUHUFUEBCPQRABCDT
      UAAUJUBUEUFCUCSUDS $.
  $}

  ${
    euor.1 $e |- ( ph -> A. x ph ) $.
    $( Introduce a disjunct into a uniqueness quantifier.  (Contributed by NM,
       21-Oct-2005.) $)
    euor $p |- ( ( -. ph /\ E! x ps ) -> E! x ( ph \/ ps ) ) $=
      ( wn weu wo hbn biorf eubidh biimpa ) AEZBCFABGZCFLBMCACDHABIJK $.
  $}

  ${
    $d x ph $.
    $( Introduce a disjunct into a uniqueness quantifier.  (Contributed by NM,
       23-Mar-1995.) $)
    euorv $p |- ( ( -. ph /\ E! x ps ) -> E! x ( ph \/ ps ) ) $=
      ( ax-17 euor ) ABCACDE $.
  $}

  ${
    $d x y $.
    mon.1 $e |- F/ y ph $.
    $( There is at most one of something which does not exist.  (Contributed by
       Jim Kingdon, 2-Jul-2018.) $)
    mon $p |- ( -. E. x ph -> E. y A. x ( ph -> x = y ) ) $=
      ( wex wsb weq wi wal sb8e wn alnex nfs1v sbequ1 equcoms con3d cbv3 pm2.21
      nfn alimi 19.8a 3syl sylbir sylnbi ) ABEABCFZCEZABCGZHZBIZCEZABCDJUFKUEKZ
      CIZUJUECLULAKZBIUIUJUKUMCBUEBABCMSACDSCBGAUEAUEHBCABCNOPQUMUHBAUGRTUICUAU
      BUCUD $.
  $}

  ${
    $d x y $.  $d ph y $.
    $( Existential uniqueness implies existence.  (Contributed by NM,
       15-Sep-1993.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
    euex $p |- ( E! x ph -> E. x ph ) $=
      ( vy weu wsb weq wi wal wa wex ax-17 eu1 exsimpl sylbi ) ABDAABCEBCFGCHZI
      BJABJABCACKLAOBMN $.
  $}

  ${
    $d x y $.
    eumo0.1 $e |- ( ph -> A. y ph ) $.
    $( Existential uniqueness implies "at most one."  (Contributed by NM,
       8-Jul-1994.) $)
    eumo0 $p |- ( E! x ph -> E. y A. x ( ph -> x = y ) ) $=
      ( weu weq wb wal wex wi euf bi1 alimi eximi sylbi ) ABEABCFZGZBHZCIAPJZBH
      ZCIABCDKRTCQSBAPLMNO $.
  $}

  $( Existential uniqueness implies "at most one."  (Contributed by NM,
     23-Mar-1995.)  (Proof rewritten by Jim Kingdon, 27-May-2018.) $)
  eumo $p |- ( E! x ph -> E* x ph ) $=
    ( weu wex wi wmo ax-1 df-mo sylibr ) ABCZABDZJEABFJKGABHI $.

  ${
    eumoi.1 $e |- E! x ph $.
    $( "At most one" inferred from existential uniqueness.  (Contributed by NM,
       5-Apr-1995.) $)
    eumoi $p |- E* x ph $=
      ( weu wmo eumo ax-mp ) ABDABECABFG $.
  $}

  ${
    mobidh.1 $e |- ( ph -> A. x ph ) $.
    mobidh.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for "at most one" quantifier (deduction rule).
       (Contributed by NM, 8-Mar-1995.) $)
    mobidh $p |- ( ph -> ( E* x ps <-> E* x ch ) ) $=
      ( wex weu wi wmo exbidh eubidh imbi12d df-mo 3bitr4g ) ABDGZBDHZICDGZCDHZIB
      DJCDJAPRQSABCDEFKABCDEFLMBDNCDNO $.
  $}

  ${
    mobid.1 $e |- F/ x ph $.
    mobid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for "at most one" quantifier (deduction rule).
       (Contributed by NM, 8-Mar-1995.) $)
    mobid $p |- ( ph -> ( E* x ps <-> E* x ch ) ) $=
      ( wex weu wi wmo exbid eubid imbi12d df-mo 3bitr4g ) ABDGZBDHZICDGZCDHZIB
      DJCDJAPRQSABCDEFKABCDEFLMBDNCDNO $.
  $}

  ${
    $d x ph $.
    mobidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for "at most one" quantifier (deduction rule).
       (Contributed by Mario Carneiro, 7-Oct-2016.) $)
    mobidv $p |- ( ph -> ( E* x ps <-> E* x ch ) ) $=
      ( nfv mobid ) ABCDADFEG $.
  $}

  ${
    mobii.1 $e |- ( ps <-> ch ) $.
    $( Formula-building rule for "at most one" quantifier (inference rule).
       (Contributed by NM, 9-Mar-1995.)  (Revised by Mario Carneiro,
       17-Oct-2016.) $)
    mobii $p |- ( E* x ps <-> E* x ch ) $=
      ( wmo wb wtru a1i mobidv trud ) ACEBCEFGABCABFGDHIJ $.
  $}

  $( Bound-variable hypothesis builder for "at most one."  (Contributed by NM,
     8-Mar-1995.) $)
  hbmo1 $p |- ( E* x ph -> A. x E* x ph ) $=
    ( wmo wex weu wi df-mo hbe1 hbeu1 hbim hbxfrbi ) ABCABDZABEZFBABGLMBABHABIJ
    K $.

  ${
    hbmo.1 $e |- ( ph -> A. x ph ) $.
    $( Bound-variable hypothesis builder for "at most one."  (Contributed by
       NM, 9-Mar-1995.) $)
    hbmo $p |- ( E* y ph -> A. x E* y ph ) $=
      ( wmo wex weu wi df-mo hbex hbeu hbim hbxfrbi ) ACEACFZACGZHBACINOBABCDJA
      BCDKLM $.
  $}

  ${
    cbvmo.1 $e |- F/ y ph $.
    cbvmo.2 $e |- F/ x ps $.
    cbvmo.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 9-Mar-1995.)  (Revised by Andrew Salmon,
       8-Jun-2011.) $)
    cbvmo $p |- ( E* x ph <-> E* y ps ) $=
      ( wex weu wi wmo cbvex cbveu imbi12i df-mo 3bitr4i ) ACHZACIZJBDHZBDIZJAC
      KBDKQSRTABCDEFGLABCDEFGMNACOBDOP $.
  $}

  ${
    $d x y z $.  $d ph z $.
    mo23.1 $e |- F/ y ph $.
    $( An implication between two definitions of "there exists at most one."
       (Contributed by Jim Kingdon, 25-Jun-2018.) $)
    mo23 $p |- ( E. y A. x ( ph -> x = y ) ->
               A. x A. y ( ( ph /\ [ y / x ] ph ) -> x = y ) ) $=
      ( vz cv wceq wi wal wex wsbc wa nfim nfal equequ2 imbi2d albidv
      nfv cbvex nfri nfs1v sbequ2 ax-8 imim12d cbv3 ancli aaan sylibr
      prth equtr2 syl6 2alimi syl exlimiv sylbir ) ABFZCFZGZHZBIZCJAU
      PEFZGZHZBIZEJAABUQKZLZURHZCIBIZVDUTECVCCBAVBCDVBCRMZNUTERVAUQGZ
      VCUSBVJVBURAECBOPQSVDVHEVDVCVEUQVAGZHZLZCIBIZVHVDVDVLCIZLVNVDVO
      VCVLBCVIVEVKBABCUAVKBRMZURVEAVBVKABCUBBCEUCUDUEUFVCVLBCVCCVITVL
      BVPTUGUHVMVGBCVMVFVBVKLURAVBVEVKUIBCEUJUKULUMUNUO $.
  $}

  ${
    $d x y z $.  $d ph z $.
    mor.1 $e |- F/ y ph $.
    $( Converse of ~ mo23 with an additional ` E. x ph ` condition.
       (Contributed by Jim Kingdon, 25-Jun-2018.) $)
    mor $p |- ( E. x ph ->
        ( A. x A. y ( ( ph /\ [ y / x ] ph ) -> x = y ) ->
          E. y A. x ( ph -> x = y ) ) ) $=
      ( wex cv wsbc wa wceq wal sb8e impexp bi2.04 bitri 2albii nfs1v
      wi nfri eximi alim alimi a7s exim syl syl5com syl5bi sylbi ) AB
      EABCFZGZCEZAUIHBFUHIZQZCJBJZAUKQZBJZCEZQABCDKUMUIUNQZCJBJZUJUPU
      LUQBCULAUIUKQQUQAUIUKLAUIUKMNOUJUIBJZCEZURUPUIUSCUIBABCPRSURUSU
      OQZCJZUTUPQUQVBCBUQBJVACUIUNBTUAUBUSUOCUCUDUEUFUG $.
  $}

  ${
    $d x y $.
    modc.1 $e |- F/ y ph $.
    $( Equivalent definitions of "there exists at most one," given decidable
       existence.  (Contributed by Jim Kingdon, 1-Jul-2018.) $)
    modc $p |- ( DECID E. x ph ->
        ( E. y A. x ( ph -> x = y ) <->
          A. x A. y ( ( ph /\ [ y / x ] ph ) -> x = y ) ) ) $=
      ( wex wdc weq wi wal wsb wa mo23 wn wo exmiddc mor mon a1d jaoi syl
      impbid2 ) ABEZFZABCGZHBICEZAABCJKUDHCIBIZABCDLUCUBUBMZNUFUEHZUBOUBUHUGABC
      DPUGUEUFABCDQRSTUA $.
  $}

  ${
    $d x y $.
    eu2.1 $e |- F/ y ph $.
    $( An alternate way of defining existential uniqueness.  Definition 6.10 of
       [TakeutiZaring] p. 26.  (Contributed by NM, 8-Jul-1994.) $)
    eu2 $p |- ( E! x ph <->
        ( E. x ph /\ A. x A. y ( ( ph /\ [ y / x ] ph ) -> x = y ) ) ) $=
      ( weu wex cv wsbc wa wceq wi wal euex nfri eumo0 syl jca 19.29r
      mo23 impexp albii 19.21 bitri anbi2i bitr4i exbii sylibr impbii
      abai sylib eu1 ) ABEZABFZAABCGZHZIBGUNJZKZCLZBLZIZULUMUSABMULAU
      PKBLCFUSABCACDNZOABCDSPQUTAUOUPKZCLZIZBFZULUTAURIZBFVEAURBRVFVD
      BVFAAVCKZIVDURVGAURAVBKZCLVGUQVHCAUOUPTUAAVBCDUBUCUDAVCUIUEUFUJ
      ABCVAUKUGUH $.
  $}

  ${
    $d x y $.
    eu3.1 $e |- ( ph -> A. y ph ) $.
    $( An alternate way to express existential uniqueness.  (Contributed by NM,
       8-Jul-1994.) $)
    eu3 $p |- ( E! x ph <->
                ( E. x ph /\ E. y A. x ( ph -> x = y ) ) ) $=
      ( weu wex cv wceq wi wal wa euex eumo0 jca wsbc nfi mo23 anim2i
      eu2 sylibr impbii ) ABEZABFZABGCGZHZIBJCFZKZUBUCUFABLABCDMNUGUC
      AABUDOKUEICJBJZKUBUFUHUCABCACDPZQRABCUISTUA $.
  $}

  ${
    $d x y $.  $d y ph $.
    $( Uniqueness in terms of "at most one."  (Contributed by NM,
       23-Mar-1995.)  (Proof rewritten by Jim Kingdon, 27-May-2018.) $)
    eu5 $p |- ( E! x ph <-> ( E. x ph /\ E* x ph ) ) $=
      ( weu wex wmo wa euex eumo jca df-mo biimpi imp ancoms impbii
      wi ) ABCZABDZABEZFPQRABGABHIRQPRQPRQPOABJKLMN $.
  $}

  $( Existence implies "at most one" is equivalent to uniqueness.  (Contributed
     by NM, 5-Apr-2004.) $)
  exmoeu2 $p |- ( E. x ph -> ( E* x ph <-> E! x ph ) ) $=
    ( weu wex wmo eu5 baibr ) ABCABDABEABFG $.

  $( Absorption of existence condition by "at most one."  (Contributed by NM,
     4-Nov-2002.) $)
  moabs $p |- ( E* x ph <-> ( E. x ph -> E* x ph ) ) $=
    ( wex weu wi wmo pm5.4 df-mo imbi2i 3bitr4ri ) ABCZKABDZEZEMKABFZENKLGNMKAB
    HZIOJ $.

  $( If existence is decidable, something exists or at most one exists.
     (Contributed by Jim Kingdon, 30-Jun-2018.) $)
  exmodc $p |- ( DECID E. x ph -> ( E. x ph \/ E* x ph ) ) $=
    ( wex wdc wn wo wmo df-dc weu wi pm2.21 df-mo sylibr orim2i sylbi
    ) ABCZDPPEZFPABGZFPHQRPQPABIZJRPSKABLMNO $.

  ${
    $d x y $.
    mo2r.1 $e |- F/ y ph $.
    $( A condition which implies "at most one."  (Contributed by Jim Kingdon,
       2-Jul-2018.) $)
    mo2r $p |- ( E. y A. x ( ph -> x = y ) -> E* x ph ) $=
      ( weq wi wal wex weu wmo nfri eu3 simplbi2com df-mo sylibr ) ABCEFBGCHZAB
      HZABIZFABJRQPABCACDKLMABNO $.
  $}

  ${
    $d x y $.
    mo3.1 $e |- ( ph -> A. y ph ) $.
    $( Alternate definition of "at most one."  Definition of [BellMachover]
       p. 460, except that definition has the side condition that ` y ` not
       occur in ` ph ` in place of our hypothesis.  (Contributed by NM,
       8-Mar-1995.) $)
    mo3 $p |- ( E* x ph <->
               A. x A. y ( ( ph /\ [ y / x ] ph ) -> x = y ) ) $=
      ( wmo wsb wa weq wi wal wex weu nfi eu2 imbi2i df-mo anclb 3bitr4i sylibr
      19.38 19.21 albii anabs5 pm3.31 syl5bir 2alimi sylbi simplbi2com impbii
      syl ) ABEZAABCFZGZBCHZIZCJZBJZUKABKZUQIZUQURABLZIZURURUQGZIUKUSUTVBURABCA
      CDMZNZOABPZURUQQRUSAUOIZCJZBJZUQUSAUPIZBJVHAUPBTVGVIBAUOCVCUAUBSVFUOBCUMA
      UMGVFUNAULUCAUMUNUDUEUFUJUGUQVAUKUTURUQVDUHVESUI $.
  $}

  ${
    $d x y $.
    mo2dc.1 $e |- F/ y ph $.
    $( Alternate definition of "at most one" where existence is decidable.
       (Contributed by Jim Kingdon, 2-Jul-2018.) $)
    mo2dc $p |- ( DECID E. x ph ->
        ( E* x ph <-> E. y A. x ( ph -> x = y ) ) ) $=
      ( wex wdc weq wi wal wsb wa wmo modc nfri mo3 syl6rbbr ) ABEFABCGZHBICEAA
      BCJKQHCIBIABLABCDMABCACDNOP $.
  $}

  ${
    euan.1 $e |- ( ph -> A. x ph ) $.
    $( Introduction of a conjunct into uniqueness quantifier.  (Contributed by
       NM, 19-Feb-2005.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
    euan $p |- ( E! x ( ph /\ ps ) <-> ( ph /\ E! x ps ) ) $=
      ( wa weu wex wmo simpl exlimih adantr simpr eximi hbe1 ancrd impbid2 mobidh
      a1d biimpa eu5 jca32 anbi2i 3imtr4i ibar eubidh impbii ) ABEZCFZABCFZEZUGC
      GZUGCHZEZABCGZBCHZEZEUHUJUMAUNUOUKAULUGACDABIJZKUKUNULUGBCABLZMKUKULUOUKU
      GBCUGCNUKUGBURUKBAUKABUQROPQSUAUGCTUIUPABCTUBUCAUIUHABUGCDABUDUESUF $.
  $}

  ${
    $d x ph $.
    $( Introduction of a conjunct into uniqueness quantifier.  (Contributed by
       NM, 23-Mar-1995.) $)
    euanv $p |- ( E! x ( ph /\ ps ) <-> ( ph /\ E! x ps ) ) $=
      ( ax-17 euan ) ABCACDE $.
  $}

  $( Introduce or eliminate a disjunct in a uniqueness quantifier.
     (Contributed by NM, 21-Oct-2005.)  (Proof shortened by Andrew Salmon,
     9-Jul-2011.) $)
  euor2 $p |- ( -. E. x ph -> ( E! x ( ph \/ ps ) <-> E! x ps ) ) $=
    ( wex wn wo hbe1 hbn wb 19.8a con3i orel1 olc impbid1 syl eubidh ) ACDZEZABF
    ZBCQCACGHRAEZSBIAQACJKTSBABLBAMNOP $.

  $( Double existential uniqueness.  (Contributed by NM, 3-Dec-2001.) $)
  2eu2ex $p |- ( E! x E! y ph -> E. x E. y ph ) $=
    ( weu wex euex eximi syl ) ACDZBDIBEACEZBEIBFIJBACFGH $.

  $( Two equivalent expressions for double existential uniqueness.
     (Contributed by NM, 19-Feb-2005.) $)
  2eu7 $p |- ( ( E! x E. y ph /\ E! y E. x ph ) <->
             E! x E! y ( E. x ph /\ E. y ph ) ) $=
    ( wex weu wa hbe1 hbeu euan ancom eubii 3bitri 3bitr4ri ) ABDZCEZACDZFZBEOP
    BEZFNPFZCEZBEROFOPBNBCABGHITQBTPNFZCEPOFQSUACNPJKPNCACGIPOJLKROJM $.

  ${
    $d x y $.
    $( Two ways to express "only one thing exists."  The left-hand side
       requires only one variable to express this.  Both sides are false in set
       theory.  (Contributed by NM, 5-Apr-2004.) $)
    exists1 $p |- ( E! x x = x <-> A. x x = y ) $=
      ( weq weu wb wal wex df-eu equid tbt bicom bitri albii exbii hbae 3bitr2i
      19.9h ) AACZADRABCZEZAFZBGSAFZBGUBRABHUBUABSTASSRETRSAIJSRKLMNUBBABBOQP $.
  $}

$(
###############################################################################
                                 SET THEORY
###############################################################################

  Set theory uses the formalism of propositional and predicate calculus to
  assert properties of arbitrary mathematical objects called "sets."  A set can
  be contained in another set, and this relationship is indicated by the ` e. `
  symbol.  Starting with the simplest mathematical object, called the empty
  set, set theory builds up more and more complex structures whose existence
  follows from the axioms, eventually resulting in extremely complicated sets
  that we identify with the real numbers and other familiar mathematical
  objects.

  Here we develop set theory based on the Intuitionistic
  Zermelo-Fraenkel (IZF) system of [Crosilla] (Crosilla's Constructive
  Zermelo-Fraenkel (CZF) is not as easy to formalize in metamath
  because the Axiom of Restricted Separation would require us to
  develop the ability to classify formulas as bounded formulas, similar
  to the machinery we have built up for asserting on whether variables
  are free in formulas).

$)

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
             IZF Set Theory - start with the Axiom of Extensionality
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Introduce the Axiom of Extensionality
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  ${
    $d x y z $.
    $( Axiom of Extensionality.  It states that two sets are identical if they
       contain the same elements.  Axiom 1 of [Crosilla] (with unnnecessary
       quantifiers removed).

       Set theory can also be formulated with a _single_ primitive predicate
       ` e. ` on top of traditional predicate calculus _without_ equality.  In
       that case the Axiom of Extensionality becomes
       ` ( A. w ( w e. x <-> w e. y ) -> ( x e. z -> y e. z ) ) ` , and
       equality ` x = y ` is _defined_ as ` A. w ( w e. x <-> w e. y ) ` .  All
       of the usual axioms of equality then become theorems of set theory.
       See, for example, Axiom 1 of [TakeutiZaring] p. 8.

       To use the above "equality-free" version of Extensionality with
       Metamath's logical axioms, we would rewrite ~ ax-8 through ~ ax-16 with
       equality expanded according to the above definition.  Some of those
       axioms could be proved from set theory and would be redundant.  Not all
       of them are redundant, since our axioms of predicate calculus make
       essential use of equality for the proper substitution that is a
       primitive notion in traditional predicate calculus.  A study of such an
       axiomatization would be an interesting project for someone exploring the
       foundations of logic.

       It is important to understand that strictly speaking, all of our set
       theory axioms are really schemes that represent an infinite number of
       actual axioms.  This is inherent in the design of Metamath
       ("metavariable math"), which manipulates only metavariables.  For
       example, the metavariable ` x ` in ~ ax-ext can represent any actual
       variable _v1_, _v2_, _v3_,... .  Distinct variable restrictions ($d)
       prevent us from substituting say _v1_ for both ` x ` and ` z ` .  This
       is in contrast to typical textbook presentations that present actual
       axioms (except for axioms which involve wff metavariables).  In
       practice, though, the theorems and proofs are essentially the same.  The
       $d restrictions make each of the infinite axioms generated by the
       ~ ax-ext scheme exactly logically equivalent to each other and in
       particular to the actual axiom of the textbook version.  (Contributed by
       NM, 5-Aug-1993.) $)
    ax-ext $a |- ( A. z ( z e. x <-> z e. y ) -> x = y ) $.
  $}

  ${
    $d z x w $.  $d z y w $.
    $( A generalization of the Axiom of Extensionality in which ` x ` and ` y `
       need not be distinct.  (Contributed by NM, 15-Sep-1993.)  (Proof
       shortened by Andrew Salmon, 12-Aug-2011.) $)
    axext3 $p |- ( A. z ( z e. x <-> z e. y ) -> x = y ) $=
      ( vw wel wb wal weq wi elequ2 bibi1d albidv equequ1 imbi12d ax-ext chvarv
      ) CDEZCBEZFZCGZDBHZICAEZRFZCGZABHZIDADAHZTUDUAUEUFSUCCUFQUBRDACJKLDABMNDB
      COP $.

    $( A bidirectional version of Extensionality.  Although this theorem
       "looks" like it is just a definition of equality, it requires the Axiom
       of Extensionality for its proof under our axiomatization.  See the
       comments for ~ ax-ext .  (Contributed by NM, 14-Nov-2008.) $)
    axext4 $p |- ( x = y <-> A. z ( z e. x <-> z e. y ) ) $=
      ( weq wel wb wal elequ2 alrimiv axext3 impbii ) ABDZCAECBEFZCGLMCABCHIABC
      JK $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                   Class abstractions (a.k.a. class builders)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare new constants use in class definition. $)
  $c { $. $( Left brace $)
  $c | $.  $( Vertical bar $)
  $c } $. $( Right brace $)
  $( --- Start of old code before overloading prevention patch. $)
  $(
  @c class @. @( Class variable type @)
  $)
  $( --- End of old code before overloading prevention patch. $)

  $( Declare symbols as variables $)
  $v ./\ $.
  $v .\/ $.
  $v .<_ $.
  $v .< $.
  $v .+ $.
  $v .- $.
  $v .X. $.
  $v ./ $.
  $v .^ $.
  $v .0. $.
  $v .1. $.
  $v .|| $.
  $v .~ $.
  $v ._|_ $.
  $v .+^ $.
  $v .+b $.
  $v .(+) $.
  $v .* $.
  $v .x. $.
  $v .xb $.
  $v ., $.
  $v .(x) $.
  $v .0b $.

  $( Declare variable symbols that will be used to represent classes.  Note
     that later on ` R ` , ` S ` , ` F ` and ` G ` denote relations and
     functions, but these letters serve as mnemonics only and in fact behave
     no differently from the variables ` A ` through ` D ` . $)
  $v A $.
  $v B $.
  $v C $.
  $v D $.
  $v P $.
  $v Q $.
  $v R $.
  $v S $.
  $v T $.
  $v U $.

  $( Introduce the class builder or class abstraction notation ("the class of
     sets ` x ` such that ` ph ` is true").  Our class variables ` A ` ,
     ` B ` , etc. range over class builders (sometimes implicitly).  Note that
     a set variable can be expressed as a class builder per theorem ~ cvjust ,
     justifying the assignment of set variables to class variables via the use
     of ~ cv . $)
  cab $a class { x | ph } $.

  $( --- Start of old code before overloading prevention patch. $)
  $(
  @( A set variable is a class expression.  The syntax " ` class x ` " can be
     viewed as an abbreviation for " ` class { y | y e. x } ` " (a special case
     of ~ cab ), where ` y ` is distinct from ` x ` .  See the discussion under
     the definition of class in [Jech] p. 4.  Note that ` { y | y e. x } = x `
     by ~ cvjust . @)
  cv @a class x @.
  $)
  $( --- End of old code before overloading prevention patch. $)
  $( $j primitive 'cv' 'wceq' 'wcel' 'cab'; $)

  $( Let ` A ` be a class variable. $)
  cA $f class A $.
  $( Let ` B ` be a class variable. $)
  cB $f class B $.
  $( Let ` C ` be a class variable. $)
  cC $f class C $.

  $( Define a connective symbol for use as a class variable. $)
  c.pa $f class .|| $.

  $( Let ` D ` be a class variable. $)
  cD $f class D $.

  $( Define a connective symbol for use as a class variable. $)
  c.dv $f class ./ $.

  $( Let ` P ` be a class variable. $)
  cP $f class P $.

  $( Define a connective symbol for use as a class variable. $)
  c.pl $f class .+ $.

  $( Define a connective symbol for use as a class variable. $)
  c.pd $f class .+^ $.

  $( Define a connective symbol for use as a class variable. $)
  c.pb $f class .+b $.

  $( Define a connective symbol for use as a class variable. $)
  c.po $f class .(+) $.

  $( Let ` Q ` be a class variable. $)
  cQ $f class Q $.

  $( Define a connective symbol for use as a class variable. $)
  c.sm $f class .~ $.

  $( Let ` R ` be a class variable. $)
  cR $f class R $.
  $( Let ` S ` be a class variable. $)
  cS $f class S $.

  $( Define a connective symbol for use as a class variable. $)
  c.lt $f class .< $.

  $( Define a connective symbol for use as a class variable. $)
  c.xb $f class .xb $.

  $( Let ` T ` be a class variable. $)
  cT $f class T $.

  $( Define a connective symbol for use as a class variable. $)
  c.x $f class .x. $.

  $( Define a connective symbol for use as a class variable. $)
  c.xp $f class .X. $.

  $( Define a connective symbol for use as a class variable. $)
  c.xo $f class .(x) $.

  $( Let ` U ` be a class variable. $)
  cU $f class U $.

  $( Define a connective symbol for use as a class variable. $)
  c.1 $f class .1. $.

  $v e $.
  $v f $.
  $v g $.
  $v h $.
  $v i $.
  $v j $.
  $v k $.
  $v m $.
  $v n $.
  $v o $.
  $v E $.
  $v F $.
  $v G $.
  $v H $.
  $v I $.
  $v J $.
  $v K $.
  $v L $.
  $v M $.
  $v N $.
  $v V $.
  $v W $.
  $v X $.
  $v Y $.
  $v Z $.
  $v O $.
  $v s $.
  $v r $.
  $v q $.
  $v p $.
  $v a $.
  $v b $.
  $v c $.
  $v d $.
  $v l $.


  $( Let ` e ` be an individual variable. $)
  ve $f set e $.
  $( Let ` f ` be an individual variable. $)
  vf $f set f $.
  $( Let ` g ` be an individual variable. $)
  vg $f set g $.
  $( Let ` h ` be an individual variable. $)
  vh $f set h $.
  $( Let ` i ` be an individual variable. $)
  vi $f set i $.
  $( Let ` j ` be an individual variable. $)
  vj $f set j $.
  $( Let ` k ` be an individual variable. $)
  vk $f set k $.
  $( Let ` m ` be an individual variable. $)
  vm $f set m $.
  $( Let ` n ` be an individual variable. $)
  vn $f set n $.
  $( Let ` o ` be an individual variable. $)
  vo $f set o $.
  $( Let ` E ` be a class variable. $)
  cE $f class E $.

  $( Define a connective symbol for use as a class variable. $)
  c.ex $f class .^ $.

  $( Let ` F ` be a class variable. $)
  cF $f class F $.
  $( Let ` G ` be a class variable. $)
  cG $f class G $.
  $( Let ` H ` be a class variable. $)
  cH $f class H $.

  $( Define a connective symbol for use as a class variable. $)
  c.xi $f class ., $.

  $( Let ` I ` be a class variable. $)
  cI $f class I $.

  $( Define a connective symbol for use as a class variable. $)
  c.as $f class .* $.

  $( Let ` J ` be a class variable. $)
  cJ $f class J $.

  $( Define a connective symbol for use as a class variable. $)
  c.or $f class .\/ $.

  $( Let ` K ` be a class variable. $)
  cK $f class K $.
  $( Let ` L ` be a class variable. $)
  cL $f class L $.

  $( Define a connective symbol for use as a class variable. $)
  c.le $f class .<_ $.

  $( Let ` M ` be a class variable. $)
  cM $f class M $.

  $( Define a connective symbol for use as a class variable. $)
  c.an $f class ./\ $.

  $( Define a connective symbol for use as a class variable. $)
  c.mi $f class .- $.

  $( Let ` N ` be a class variable. $)
  cN $f class N $.

  $( Define a connective symbol for use as a class variable. $)
  c.pe $f class ._|_ $.

  $( Let ` O ` be a class variable. $)
  cO $f class O $.
  $( Let ` V ` be a class variable. $)
  cV $f class V $.
  $( Let ` W ` be a class variable. $)
  cW $f class W $.
  $( Let ` X ` be a class variable. $)
  cX $f class X $.
  $( Let ` Y ` be a class variable. $)
  cY $f class Y $.

  $( Define a connective symbol for use as a class variable. $)
  c.0 $f class .0. $.

  $( Define a connective symbol for use as a class variable. $)
  c.0b $f class .0b $.

  $( Let ` Z ` be a class variable. $)
  cZ $f class Z $.
  $( Let ` s ` be an individual variable. $)
  vs $f set s $.
  $( Let ` r ` be an individual variable. $)
  vr $f set r $.
  $( Let ` q ` be an individual variable. $)
  vq $f set q $.
  $( Let ` p ` be an individual variable. $)
  vp $f set p $.
  $( Let ` a ` be an individual variable. $)
  va $f set a $.
  $( Let ` b ` be an individual variable. $)
  vb $f set b $.
  $( Let ` c ` be an individual variable. $)
  vc $f set c $.
  $( Let ` d ` be an individual variable. $)
  vd $f set d $.
  $( Let ` l ` be an individual variable. $)
  vl $f set l $.

  $( --- Start of old code before overloading prevention patch. $)
  $(
  @( Extend wff definition to include class equality. @)
  wceq @a wff A = B @.
  $)
  $( --- End of old code before overloading prevention patch. $)

  $( --- Start of old code before overloading prevention patch. $)
  $(
  @( Extend wff definition to include the membership connective between
     classes. @)
  wcel @a wff A e. B @.
  $)
  $( --- End of old code before overloading prevention patch. $)

  $( Define class abstraction notation (so-called by Quine), also called a
     "class builder" in the literature. ` x ` and ` y ` need not be distinct.
     Definition 2.1 of [Quine] p. 16.  Typically, ` ph ` will have ` y ` as a
     free variable, and " ` { y | ph } ` " is read "the class of all sets ` y `
     such that ` ph ( y ) ` is true."  We do not define ` { y | ph } ` in
     isolation but only as part of an expression that extends or "overloads"
     the ` e. ` relationship.

     This is our first use of the ` e. ` symbol to connect classes instead of
     sets.  The syntax definition ~ wcel , which extends or "overloads" the
     ~ wel definition connecting set variables, requires that both sides of
     ` e. ` be a class.  In ~ df-cleq and ~ df-clel , we introduce a new kind
     of variable (class variable) that can substituted with expressions such as
     ` { y | ph } ` .  In the present definition, the ` x ` on the left-hand
     side is a set variable.  Syntax definition ~ cv allows us to substitute a
     set variable ` x ` for a class variable: all sets are classes by ~ cvjust
     (but not necessarily vice-versa).  For a full description of how classes
     are introduced and how to recover the primitive language, see the
     discussion in Quine (and under ~ abeq2 for a quick overview).

     Because class variables can be substituted with compound expressions and
     set variables cannot, it is often useful to convert a theorem containing a
     free set variable to a more general version with a class variable.

     This is called the "axiom of class comprehension" by [Levy] p. 338, who
     treats the theory of classes as an extralogical extension to our logic and
     set theory axioms.  He calls the construction ` { y | ph } ` a "class
     term".

     For a general discussion of the theory of classes, see
     ~ http://us.metamath.org/mpeuni/mmset.html#class .  (Contributed by NM,
     5-Aug-1993.) $)
  df-clab $a |- ( x e. { y | ph } <-> [ x / y ] ph ) $.

  $( Simplification of class abstraction notation when the free and bound
     variables are identical.  (Contributed by NM, 5-Aug-1993.) $)
  abid $p |- ( x e. { x | ph } <-> ph ) $=
    ( cv cab wcel wsb df-clab sbid bitri ) BCABDEABBFAABBGABHI $.

  ${
    $d x y $.
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by NM, 5-Aug-1993.) $)
    hbab1 $p |- ( y e. { x | ph } -> A. x y e. { x | ph } ) $=
      ( cv cab wcel wsb df-clab hbs1 hbxfrbi ) CDABEFABCGBACBHABCIJ $.

    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by Mario Carneiro, 11-Aug-2016.) $)
    nfsab1 $p |- F/ x y e. { x | ph } $=
      ( cv cab wcel hbab1 nfi ) CDABEFBABCGH $.
  $}

  ${
    $d x z $.
    hbab.1 $e |- ( ph -> A. x ph ) $.
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by NM, 1-Mar-1995.) $)
    hbab $p |- ( z e. { y | ph } -> A. x z e. { y | ph } ) $=
      ( cv cab wcel wsb df-clab hbsb hbxfrbi ) DFACGHACDIBADCJACDBEKL $.
  $}

  ${
    $d x z $.
    nfsab.1 $e |- F/ x ph $.
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by Mario Carneiro, 11-Aug-2016.) $)
    nfsab $p |- F/ x z e. { y | ph } $=
      ( cv cab wcel nfri hbab nfi ) DFACGHBABCDABEIJK $.
  $}

  ${
    $d x A $.  $d x B $.  $d x y z $.
    df-cleq.1 $e |- ( A. x ( x e. y <-> x e. z ) -> y = z ) $.
    $( Define the equality connective between classes.  Definition 2.7 of
       [Quine] p. 18.  Also Definition 4.5 of [TakeutiZaring] p. 13; Chapter 4
       provides its justification and methods for eliminating it.  Note that
       its elimination will not necessarily result in a single wff in the
       original language but possibly a "scheme" of wffs.

       This is an example of a somewhat "risky" definition, meaning that it has
       a more complex than usual soundness justification (outside of Metamath),
       because it "overloads" or reuses the existing equality symbol rather
       than introducing a new symbol.  This allows us to make statements that
       may not hold for the original symbol.  For example, it permits us to
       deduce ` y = z <-> A. x ( x e. y <-> x e. z ) ` , which is not a theorem
       of logic but rather presupposes the Axiom of Extensionality (see theorem
       ~ axext4 ).  We therefore include this axiom as a hypothesis, so that
       the use of Extensionality is properly indicated.

       We could avoid this complication by introducing a new symbol, say =_2,
       in place of ` = ` .  This would also have the advantage of making
       elimination of the definition straightforward, so that we could
       eliminate Extensionality as a hypothesis.  We would then also have the
       advantage of being able to identify in various proofs exactly where
       Extensionality truly comes into play rather than just being an artifact
       of a definition.  One of our theorems would then be ` x ` =_2
       ` y <-> x = y ` by invoking Extensionality.

       However, to conform to literature usage, we retain this overloaded
       definition.  This also makes some proofs shorter and probably easier to
       read, without the constant switching between two kinds of equality.

       See also comments under ~ df-clab , ~ df-clel , and ~ abeq2 .

       In the form of ~ dfcleq , this is called the "axiom of extensionality"
       by [Levy] p. 338, who treats the theory of classes as an extralogical
       extension to our logic and set theory axioms.

       For a general discussion of the theory of classes, see
       ~ http://us.metamath.org/mpeuni/mmset.html#class .  (Contributed by NM,
       15-Sep-1993.) $)
    df-cleq $a |- ( A = B <-> A. x ( x e. A <-> x e. B ) ) $.
  $}

  ${
    $d x A $.  $d x B $.  $d x y z $.
    $( The same as ~ df-cleq with the hypothesis removed using the Axiom of
       Extensionality ~ ax-ext .  (Contributed by NM, 15-Sep-1993.) $)
    dfcleq $p |- ( A = B <-> A. x ( x e. A <-> x e. B ) ) $=
      ( vy vz ax-ext df-cleq ) ADEBCDEAFG $.
  $}

  ${
    $d x y z $.
    $( Every set is a class.  Proposition 4.9 of [TakeutiZaring] p. 13.  This
       theorem shows that a set variable can be expressed as a class
       abstraction.  This provides a motivation for the class syntax
       construction ~ cv , which allows us to substitute a set variable for a
       class variable.  See also ~ cab and ~ df-clab .  Note that this is not a
       rigorous justification, because ~ cv is used as part of the proof of
       this theorem, but a careful argument can be made outside of the
       formalism of Metamath, for example as is done in Chapter 4 of Takeuti
       and Zaring.  See also the discussion under the definition of class in
       [Jech] p. 4 showing that "Every set can be considered to be a class."
       (Contributed by NM, 7-Nov-2006.) $)
    cvjust $p |- x = { y | y e. x } $=
      ( vz cv wcel cab wceq wb dfcleq wsb df-clab elsb3 bitr2i mpgbir ) ADZBDOE
      ZBFZGCDZOEZRQEZHCCOQITPBCJSPCBKCBALMN $.
  $}

  ${
    $d x A $.  $d x B $.
    $( Define the membership connective between classes.  Theorem 6.3 of
       [Quine] p. 41, or Proposition 4.6 of [TakeutiZaring] p. 13, which we
       adopt as a definition.  See these references for its metalogical
       justification.  Note that like ~ df-cleq it extends or "overloads" the
       use of the existing membership symbol, but unlike ~ df-cleq it does not
       strengthen the set of valid wffs of logic when the class variables are
       replaced with set variables (see ~ cleljust ), so we don't include any
       set theory axiom as a hypothesis.  See also comments about the syntax
       under ~ df-clab .

       This is called the "axiom of membership" by [Levy] p. 338, who treats
       the theory of classes as an extralogical extension to our logic and set
       theory axioms.

       For a general discussion of the theory of classes, see
       ~ http://us.metamath.org/mpeuni/mmset.html#class .  (Contributed by NM,
       5-Aug-1993.) $)
    df-clel $a |- ( A e. B <-> E. x ( x = A /\ x e. B ) ) $.
  $}

  ${
    $d x A $.  $d x B $.
    eqriv.1 $e |- ( x e. A <-> x e. B ) $.
    $( Infer equality of classes from equivalence of membership.  (Contributed
       by NM, 5-Aug-1993.) $)
    eqriv $p |- A = B $=
      ( wceq cv wcel wb dfcleq mpgbir ) BCEAFZBGKCGHAABCIDJ $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ph $.
    eqrdv.1 $e |- ( ph -> ( x e. A <-> x e. B ) ) $.
    $( Deduce equality of classes from equivalence of membership.  (Contributed
       by NM, 17-Mar-1996.) $)
    eqrdv $p |- ( ph -> A = B ) $=
      ( cv wcel wb wal wceq alrimiv dfcleq sylibr ) ABFZCGNDGHZBICDJAOBEKBCDLM
      $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ph $.
    eqrdav.1 $e |- ( ( ph /\ x e. A ) -> x e. C ) $.
    eqrdav.2 $e |- ( ( ph /\ x e. B ) -> x e. C ) $.
    eqrdav.3 $e |- ( ( ph /\ x e. C ) -> ( x e. A <-> x e. B ) ) $.
    $( Deduce equality of classes from an equivalence of membership that
       depends on the membership variable.  (Contributed by NM, 7-Nov-2008.) $)
    eqrdav $p |- ( ph -> A = B ) $=
      ( cv wcel wa biimpd impancom mpd wi exbiri com23 imp impbida eqrdv ) ABCD
      ABIZCJZUADJZAUBKUAEJZUCFAUDUBUCAUDKUBUCHLMNAUCKUDUBGAUCUDUBOAUDUCUBAUDUBU
      CHPQRNST $.
  $}

  ${
    $d x A $.
    $( Law of identity (reflexivity of class equality).  Theorem 6.4 of [Quine]
       p. 41.

       This law is thought to have originated with Aristotle (_Metaphysics_,
       Zeta, 17, 1041 a, 10-20:  "Therefore, inquiring why a thing is itself,
       it's inquiring nothing; ... saying that the thing is itself constitutes
       the sole reasoning and the sole cause, in every case, to the question of
       why the man is man or the musician musician.").  (Thanks to Stefan Allan
       and Beno&icirc;t Jubin for this information.)  (Contributed by NM,
       5-Aug-1993.)  (Revised by Beno&icirc;t Jubin, 14-Oct-2017.) $)
    eqid $p |- A = A $=
      ( vx cv wcel biid eqriv ) BAABCADEF $.
  $}

  $( Class identity law with antecedent.  (Contributed by NM, 21-Aug-2008.) $)
  eqidd $p |- ( ph -> A = A ) $=
    ( wceq eqid a1i ) BBCABDE $.

  ${
    $d x A $.  $d x B $.
    $( Commutative law for class equality.  Theorem 6.5 of [Quine] p. 41.
       (Contributed by NM, 5-Aug-1993.) $)
    eqcom $p |- ( A = B <-> B = A ) $=
      ( vx cv wcel wb wal wceq bicom albii dfcleq 3bitr4i ) CDZAEZMBEZFZCGONFZC
      GABHBAHPQCNOIJCABKCBAKL $.
  $}

  ${
    eqcoms.1 $e |- ( A = B -> ph ) $.
    $( Inference applying commutative law for class equality to an antecedent.
       (Contributed by NM, 5-Aug-1993.) $)
    eqcoms $p |- ( B = A -> ph ) $=
      ( wceq eqcom sylbi ) CBEBCEACBFDG $.
  $}

  ${
    eqcomi.1 $e |- A = B $.
    $( Inference from commutative law for class equality.  (Contributed by NM,
       5-Aug-1993.) $)
    eqcomi $p |- B = A $=
      ( wceq eqcom mpbi ) ABDBADCABEF $.
  $}

  ${
    eqcomd.1 $e |- ( ph -> A = B ) $.
    $( Deduction from commutative law for class equality.  (Contributed by NM,
       15-Aug-1994.) $)
    eqcomd $p |- ( ph -> B = A ) $=
      ( wceq eqcom sylib ) ABCECBEDBCFG $.
  $}

  ${
    $d x A $.  $d x B $.  $d x C $.
    $( Equality implies equivalence of equalities.  (Contributed by NM,
       5-Aug-1993.) $)
    eqeq1 $p |- ( A = B -> ( A = C <-> B = C ) ) $=
      ( vx wceq cv wcel wb wal dfcleq biimpi 19.21bi bibi1d albidv 3bitr4g ) AB
      EZDFZAGZQCGZHZDIQBGZSHZDIACEBCEPTUBDPRUASPRUAHZDPUCDIDABJKLMNDACJDBCJO $.
  $}

  ${
    eqeq1i.1 $e |- A = B $.
    $( Inference from equality to equivalence of equalities.  (Contributed by
       NM, 5-Aug-1993.) $)
    eqeq1i $p |- ( A = C <-> B = C ) $=
      ( wceq wb eqeq1 ax-mp ) ABEACEBCEFDABCGH $.
  $}

  ${
    eqeq1d.1 $e |- ( ph -> A = B ) $.
    $( Deduction from equality to equivalence of equalities.  (Contributed by
       NM, 27-Dec-1993.) $)
    eqeq1d $p |- ( ph -> ( A = C <-> B = C ) ) $=
      ( wceq wb eqeq1 syl ) ABCFBDFCDFGEBCDHI $.
  $}

  $( Equality implies equivalence of equalities.  (Contributed by NM,
     5-Aug-1993.) $)
  eqeq2 $p |- ( A = B -> ( C = A <-> C = B ) ) $=
    ( wceq eqeq1 eqcom 3bitr4g ) ABDACDBCDCADCBDABCECAFCBFG $.

  ${
    eqeq2i.1 $e |- A = B $.
    $( Inference from equality to equivalence of equalities.  (Contributed by
       NM, 5-Aug-1993.) $)
    eqeq2i $p |- ( C = A <-> C = B ) $=
      ( wceq wb eqeq2 ax-mp ) ABECAECBEFDABCGH $.
  $}

  ${
    eqeq2d.1 $e |- ( ph -> A = B ) $.
    $( Deduction from equality to equivalence of equalities.  (Contributed by
       NM, 27-Dec-1993.) $)
    eqeq2d $p |- ( ph -> ( C = A <-> C = B ) ) $=
      ( wceq wb eqeq2 syl ) ABCFDBFDCFGEBCDHI $.
  $}

  $( Equality relationship among 4 classes.  (Contributed by NM,
     3-Aug-1994.) $)
  eqeq12 $p |- ( ( A = B /\ C = D ) -> ( A = C <-> B = D ) ) $=
    ( wceq eqeq1 eqeq2 sylan9bb ) ABEACEBCECDEBDEABCFCDBGH $.

  ${
    eqeq12i.1 $e |- A = B $.
    eqeq12i.2 $e |- C = D $.
    $( A useful inference for substituting definitions into an equality.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    eqeq12i $p |- ( A = C <-> B = D ) $=
      ( wceq wb eqeq12 mp2an ) ABGCDGACGBDGHEFABCDIJ $.

    $( Theorem eqeq12i is the congruence law for equality. $)
    $( $j congruence 'eqeq12i'; $)
  $}

  ${
    eqeq12d.1 $e |- ( ph -> A = B ) $.
    eqeq12d.2 $e |- ( ph -> C = D ) $.
    $( A useful inference for substituting definitions into an equality.
       (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    eqeq12d $p |- ( ph -> ( A = C <-> B = D ) ) $=
      ( wceq wb eqeq12 syl2anc ) ABCHDEHBDHCEHIFGBCDEJK $.
  $}

  ${
    eqeqan12d.1 $e |- ( ph -> A = B ) $.
    eqeqan12d.2 $e |- ( ps -> C = D ) $.
    $( A useful inference for substituting definitions into an equality.
       (Contributed by NM, 9-Aug-1994.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    eqeqan12d $p |- ( ( ph /\ ps ) -> ( A = C <-> B = D ) ) $=
      ( wceq wb eqeq12 syl2an ) ACDIEFICEIDFIJBGHCDEFKL $.
  $}

  ${
    eqeqan12rd.1 $e |- ( ph -> A = B ) $.
    eqeqan12rd.2 $e |- ( ps -> C = D ) $.
    $( A useful inference for substituting definitions into an equality.
       (Contributed by NM, 9-Aug-1994.) $)
    eqeqan12rd $p |- ( ( ps /\ ph ) -> ( A = C <-> B = D ) ) $=
      ( wceq wb eqeqan12d ancoms ) ABCEIDFIJABCDEFGHKL $.
  $}

  $( Transitive law for class equality.  Proposition 4.7(3) of [TakeutiZaring]
     p. 13.  (Contributed by NM, 25-Jan-2004.) $)
  eqtr $p |- ( ( A = B /\ B = C ) -> A = C ) $=
    ( wceq eqeq1 biimpar ) ABDACDBCDABCEF $.

  $( A transitive law for class equality.  (Contributed by NM, 20-May-2005.)
     (Proof shortened by Andrew Salmon, 25-May-2011.) $)
  eqtr2 $p |- ( ( A = B /\ A = C ) -> B = C ) $=
    ( wceq eqcom eqtr sylanb ) ABDBADACDBCDABEBACFG $.

  $( A transitive law for class equality.  (Contributed by NM, 20-May-2005.) $)
  eqtr3 $p |- ( ( A = C /\ B = C ) -> A = B ) $=
    ( wceq eqcom eqtr sylan2b ) BCDACDCBDABDBCEACBFG $.

  ${
    eqtri.1 $e |- A = B $.
    eqtri.2 $e |- B = C $.
    $( An equality transitivity inference.  (Contributed by NM, 5-Aug-1993.) $)
    eqtri $p |- A = C $=
      ( wceq eqeq2i mpbi ) ABFACFDBCAEGH $.
  $}

  ${
    eqtr2i.1 $e |- A = B $.
    eqtr2i.2 $e |- B = C $.
    $( An equality transitivity inference.  (Contributed by NM,
       21-Feb-1995.) $)
    eqtr2i $p |- C = A $=
      ( eqtri eqcomi ) ACABCDEFG $.
  $}

  ${
    eqtr3i.1 $e |- A = B $.
    eqtr3i.2 $e |- A = C $.
    $( An equality transitivity inference.  (Contributed by NM, 6-May-1994.) $)
    eqtr3i $p |- B = C $=
      ( eqcomi eqtri ) BACABDFEG $.
  $}

  ${
    eqtr4i.1 $e |- A = B $.
    eqtr4i.2 $e |- C = B $.
    $( An equality transitivity inference.  (Contributed by NM, 5-Aug-1993.) $)
    eqtr4i $p |- A = C $=
      ( eqcomi eqtri ) ABCDCBEFG $.
  $}

  $( Register '=' as an equality for its type (class). $)
  $( $j equality 'wceq' from 'eqid' 'eqcomi' 'eqtri'; $)

  ${
    3eqtri.1 $e |- A = B $.
    3eqtri.2 $e |- B = C $.
    3eqtri.3 $e |- C = D $.
    $( An inference from three chained equalities.  (Contributed by NM,
       29-Aug-1993.) $)
    3eqtri $p |- A = D $=
      ( eqtri ) ABDEBCDFGHH $.

    $( An inference from three chained equalities.  (Contributed by NM,
       3-Aug-2006.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtrri $p |- D = A $=
      ( eqtri eqtr2i ) ACDABCEFHGI $.
  $}

  ${
    3eqtr2i.1 $e |- A = B $.
    3eqtr2i.2 $e |- C = B $.
    3eqtr2i.3 $e |- C = D $.
    $( An inference from three chained equalities.  (Contributed by NM,
       3-Aug-2006.) $)
    3eqtr2i $p |- A = D $=
      ( eqtr4i eqtri ) ACDABCEFHGI $.

    $( An inference from three chained equalities.  (Contributed by NM,
       3-Aug-2006.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtr2ri $p |- D = A $=
      ( eqtr4i eqtr2i ) ACDABCEFHGI $.
  $}

  ${
    3eqtr3i.1 $e |- A = B $.
    3eqtr3i.2 $e |- A = C $.
    3eqtr3i.3 $e |- B = D $.
    $( An inference from three chained equalities.  (Contributed by NM,
       6-May-1994.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtr3i $p |- C = D $=
      ( eqtr3i ) BCDABCEFHGH $.

    $( An inference from three chained equalities.  (Contributed by NM,
       15-Aug-2004.) $)
    3eqtr3ri $p |- D = C $=
      ( eqtr3i ) BDCGABCEFHH $.
  $}

  ${
    3eqtr4i.1 $e |- A = B $.
    3eqtr4i.2 $e |- C = A $.
    3eqtr4i.3 $e |- D = B $.
    $( An inference from three chained equalities.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtr4i $p |- C = D $=
      ( eqtr4i ) CADFDBAGEHH $.

    $( An inference from three chained equalities.  (Contributed by NM,
       2-Sep-1995.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtr4ri $p |- D = C $=
      ( eqtr4i ) DACDBAGEHFH $.
  $}

  ${
    eqtrd.1 $e |- ( ph -> A = B ) $.
    eqtrd.2 $e |- ( ph -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM, 5-Aug-1993.) $)
    eqtrd $p |- ( ph -> A = C ) $=
      ( wceq eqeq2d mpbid ) ABCGBDGEACDBFHI $.
  $}

  ${
    eqtr2d.1 $e |- ( ph -> A = B ) $.
    eqtr2d.2 $e |- ( ph -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM,
       18-Oct-1999.) $)
    eqtr2d $p |- ( ph -> C = A ) $=
      ( eqtrd eqcomd ) ABDABCDEFGH $.
  $}

  ${
    eqtr3d.1 $e |- ( ph -> A = B ) $.
    eqtr3d.2 $e |- ( ph -> A = C ) $.
    $( An equality transitivity equality deduction.  (Contributed by NM,
       18-Jul-1995.) $)
    eqtr3d $p |- ( ph -> B = C ) $=
      ( eqcomd eqtrd ) ACBDABCEGFH $.
  $}

  ${
    eqtr4d.1 $e |- ( ph -> A = B ) $.
    eqtr4d.2 $e |- ( ph -> C = B ) $.
    $( An equality transitivity equality deduction.  (Contributed by NM,
       18-Jul-1995.) $)
    eqtr4d $p |- ( ph -> A = C ) $=
      ( eqcomd eqtrd ) ABCDEADCFGH $.
  $}

  ${
    3eqtrd.1 $e |- ( ph -> A = B ) $.
    3eqtrd.2 $e |- ( ph -> B = C ) $.
    3eqtrd.3 $e |- ( ph -> C = D ) $.
    $( A deduction from three chained equalities.  (Contributed by NM,
       29-Oct-1995.) $)
    3eqtrd $p |- ( ph -> A = D ) $=
      ( eqtrd ) ABCEFACDEGHII $.

    $( A deduction from three chained equalities.  (Contributed by NM,
       4-Aug-2006.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtrrd $p |- ( ph -> D = A ) $=
      ( eqtrd eqtr2d ) ABDEABCDFGIHJ $.
  $}

  ${
    3eqtr2d.1 $e |- ( ph -> A = B ) $.
    3eqtr2d.2 $e |- ( ph -> C = B ) $.
    3eqtr2d.3 $e |- ( ph -> C = D ) $.
    $( A deduction from three chained equalities.  (Contributed by NM,
       4-Aug-2006.) $)
    3eqtr2d $p |- ( ph -> A = D ) $=
      ( eqtr4d eqtrd ) ABDEABCDFGIHJ $.

    $( A deduction from three chained equalities.  (Contributed by NM,
       4-Aug-2006.) $)
    3eqtr2rd $p |- ( ph -> D = A ) $=
      ( eqtr4d eqtr2d ) ABDEABCDFGIHJ $.
  $}

  ${
    3eqtr3d.1 $e |- ( ph -> A = B ) $.
    3eqtr3d.2 $e |- ( ph -> A = C ) $.
    3eqtr3d.3 $e |- ( ph -> B = D ) $.
    $( A deduction from three chained equalities.  (Contributed by NM,
       4-Aug-1995.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtr3d $p |- ( ph -> C = D ) $=
      ( eqtr3d ) ACDEABCDFGIHI $.

    $( A deduction from three chained equalities.  (Contributed by NM,
       14-Jan-2006.) $)
    3eqtr3rd $p |- ( ph -> D = C ) $=
      ( eqtr3d ) ACEDHABCDFGII $.
  $}

  ${
    3eqtr4d.1 $e |- ( ph -> A = B ) $.
    3eqtr4d.2 $e |- ( ph -> C = A ) $.
    3eqtr4d.3 $e |- ( ph -> D = B ) $.
    $( A deduction from three chained equalities.  (Contributed by NM,
       4-Aug-1995.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    3eqtr4d $p |- ( ph -> C = D ) $=
      ( eqtr4d ) ADBEGAECBHFII $.

    $( A deduction from three chained equalities.  (Contributed by NM,
       21-Sep-1995.) $)
    3eqtr4rd $p |- ( ph -> D = C ) $=
      ( eqtr4d ) AEBDAECBHFIGI $.
  $}

  ${
    syl5eq.1 $e |- A = B $.
    syl5eq.2 $e |- ( ph -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM, 5-Aug-1993.) $)
    syl5eq $p |- ( ph -> A = C ) $=
      ( wceq a1i eqtrd ) ABCDBCGAEHFI $.
  $}

  ${
    syl5req.1 $e |- A = B $.
    syl5req.2 $e |- ( ph -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM,
       29-Mar-1998.) $)
    syl5req $p |- ( ph -> C = A ) $=
      ( syl5eq eqcomd ) ABDABCDEFGH $.
  $}

  ${
    syl5eqr.1 $e |- B = A $.
    syl5eqr.2 $e |- ( ph -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM, 5-Aug-1993.) $)
    syl5eqr $p |- ( ph -> A = C ) $=
      ( eqcomi syl5eq ) ABCDCBEGFH $.
  $}

  ${
    syl5reqr.1 $e |- B = A $.
    syl5reqr.2 $e |- ( ph -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM,
       29-Mar-1998.) $)
    syl5reqr $p |- ( ph -> C = A ) $=
      ( eqcomi syl5req ) ABCDCBEGFH $.
  $}

  ${
    syl6eq.1 $e |- ( ph -> A = B ) $.
    syl6eq.2 $e |- B = C $.
    $( An equality transitivity deduction.  (Contributed by NM, 5-Aug-1993.) $)
    syl6eq $p |- ( ph -> A = C ) $=
      ( wceq a1i eqtrd ) ABCDECDGAFHI $.
  $}

  ${
    syl6req.1 $e |- ( ph -> A = B ) $.
    syl6req.2 $e |- B = C $.
    $( An equality transitivity deduction.  (Contributed by NM,
       29-Mar-1998.) $)
    syl6req $p |- ( ph -> C = A ) $=
      ( syl6eq eqcomd ) ABDABCDEFGH $.
  $}

  ${
    syl6eqr.1 $e |- ( ph -> A = B ) $.
    syl6eqr.2 $e |- C = B $.
    $( An equality transitivity deduction.  (Contributed by NM, 5-Aug-1993.) $)
    syl6eqr $p |- ( ph -> A = C ) $=
      ( eqcomi syl6eq ) ABCDEDCFGH $.
  $}

  ${
    syl6reqr.1 $e |- ( ph -> A = B ) $.
    syl6reqr.2 $e |- C = B $.
    $( An equality transitivity deduction.  (Contributed by NM,
       29-Mar-1998.) $)
    syl6reqr $p |- ( ph -> C = A ) $=
      ( eqcomi syl6req ) ABCDEDCFGH $.
  $}

  ${
    sylan9eq.1 $e |- ( ph -> A = B ) $.
    sylan9eq.2 $e |- ( ps -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM, 8-May-1994.)
       (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    sylan9eq $p |- ( ( ph /\ ps ) -> A = C ) $=
      ( wceq eqtr syl2an ) ACDHDEHCEHBFGCDEIJ $.
  $}

  ${
    sylan9req.1 $e |- ( ph -> B = A ) $.
    sylan9req.2 $e |- ( ps -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM,
       23-Jun-2007.) $)
    sylan9req $p |- ( ( ph /\ ps ) -> A = C ) $=
      ( eqcomd sylan9eq ) ABCDEADCFHGI $.
  $}

  ${
    sylan9eqr.1 $e |- ( ph -> A = B ) $.
    sylan9eqr.2 $e |- ( ps -> B = C ) $.
    $( An equality transitivity deduction.  (Contributed by NM, 8-May-1994.) $)
    sylan9eqr $p |- ( ( ps /\ ph ) -> A = C ) $=
      ( wceq sylan9eq ancoms ) ABCEHABCDEFGIJ $.
  $}

  ${
    3eqtr3g.1 $e |- ( ph -> A = B ) $.
    3eqtr3g.2 $e |- A = C $.
    3eqtr3g.3 $e |- B = D $.
    $( A chained equality inference, useful for converting from definitions.
       (Contributed by NM, 15-Nov-1994.) $)
    3eqtr3g $p |- ( ph -> C = D ) $=
      ( syl5eqr syl6eq ) ADCEADBCGFIHJ $.
  $}

  ${
    3eqtr3a.1 $e |- A = B $.
    3eqtr3a.2 $e |- ( ph -> A = C ) $.
    3eqtr3a.3 $e |- ( ph -> B = D ) $.
    $( A chained equality inference, useful for converting from definitions.
       (Contributed by Mario Carneiro, 6-Nov-2015.) $)
    3eqtr3a $p |- ( ph -> C = D ) $=
      ( syl5eq eqtr3d ) ABDEGABCEFHIJ $.
  $}

  ${
    3eqtr4g.1 $e |- ( ph -> A = B ) $.
    3eqtr4g.2 $e |- C = A $.
    3eqtr4g.3 $e |- D = B $.
    $( A chained equality inference, useful for converting to definitions.
       (Contributed by NM, 5-Aug-1993.) $)
    3eqtr4g $p |- ( ph -> C = D ) $=
      ( syl5eq syl6eqr ) ADCEADBCGFIHJ $.
  $}

  ${
    3eqtr4a.1 $e |- A = B $.
    3eqtr4a.2 $e |- ( ph -> C = A ) $.
    3eqtr4a.3 $e |- ( ph -> D = B ) $.
    $( A chained equality inference, useful for converting to definitions.
       (Contributed by NM, 2-Feb-2007.)  (Proof shortened by Andrew Salmon,
       25-May-2011.) $)
    3eqtr4a $p |- ( ph -> C = D ) $=
      ( syl6eq eqtr4d ) ADCEADBCGFIHJ $.
  $}

  ${
    eq2tr.1 $e |- ( A = C -> D = F ) $.
    eq2tr.2 $e |- ( B = D -> C = G ) $.
    $( A compound transitive inference for class equality.  (Contributed by NM,
       22-Jan-2004.) $)
    eq2tri $p |- ( ( A = C /\ B = F ) <-> ( B = D /\ A = G ) ) $=
      ( wceq wa ancom eqeq2d pm5.32i 3bitr3i ) ACIZBDIZJPOJOBEIZJPAFIZJOPKOPQOD
      EBGLMPORPCFAHLMN $.
  $}

  ${
    $d x A $.  $d x B $.  $d x C $.
    $( Equality implies equivalence of membership.  (Contributed by NM,
       5-Aug-1993.) $)
    eleq1 $p |- ( A = B -> ( A e. C <-> B e. C ) ) $=
      ( vx wceq cv wcel wa wex eqeq2 anbi1d exbidv df-clel 3bitr4g ) ABEZDFZAEZ
      PCGZHZDIPBEZRHZDIACGBCGOSUADOQTRABPJKLDACMDBCMN $.

    $( Equality implies equivalence of membership.  (Contributed by NM,
       5-Aug-1993.) $)
    eleq2 $p |- ( A = B -> ( C e. A <-> C e. B ) ) $=
      ( vx wceq cv wcel wa wex wal dfcleq biimpi 19.21bi anbi2d df-clel 3bitr4g
      wb exbidv ) ABEZDFZCEZTAGZHZDIUATBGZHZDICAGCBGSUCUEDSUBUDUASUBUDQZDSUFDJD
      ABKLMNRDCAODCBOP $.
  $}

  $( Equality implies equivalence of membership.  (Contributed by NM,
     31-May-1999.) $)
  eleq12 $p |- ( ( A = B /\ C = D ) -> ( A e. C <-> B e. D ) ) $=
    ( wceq wcel eleq1 eleq2 sylan9bb ) ABEACFBCFCDEBDFABCGCDBHI $.

  ${
    eleq1i.1 $e |- A = B $.
    $( Inference from equality to equivalence of membership.  (Contributed by
       NM, 5-Aug-1993.) $)
    eleq1i $p |- ( A e. C <-> B e. C ) $=
      ( wceq wcel wb eleq1 ax-mp ) ABEACFBCFGDABCHI $.

    $( Inference from equality to equivalence of membership.  (Contributed by
       NM, 5-Aug-1993.) $)
    eleq2i $p |- ( C e. A <-> C e. B ) $=
      ( wceq wcel wb eleq2 ax-mp ) ABECAFCBFGDABCHI $.

    ${
      eleq12i.2 $e |- C = D $.
      $( Inference from equality to equivalence of membership.  (Contributed by
         NM, 31-May-1994.) $)
      eleq12i $p |- ( A e. C <-> B e. D ) $=
        ( wcel eleq2i eleq1i bitri ) ACGADGBDGCDAFHABDEIJ $.

      $( Theorem eleq12i is the congruence law for elementhood. $)
      $( $j congruence 'eleq12i'; $)
    $}
  $}

  ${
    eleq1d.1 $e |- ( ph -> A = B ) $.
    $( Deduction from equality to equivalence of membership.  (Contributed by
       NM, 5-Aug-1993.) $)
    eleq1d $p |- ( ph -> ( A e. C <-> B e. C ) ) $=
      ( wceq wcel wb eleq1 syl ) ABCFBDGCDGHEBCDIJ $.

    $( Deduction from equality to equivalence of membership.  (Contributed by
       NM, 27-Dec-1993.) $)
    eleq2d $p |- ( ph -> ( C e. A <-> C e. B ) ) $=
      ( wceq wcel wb eleq2 syl ) ABCFDBGDCGHEBCDIJ $.

    ${
      eleq12d.2 $e |- ( ph -> C = D ) $.
      $( Deduction from equality to equivalence of membership.  (Contributed by
         NM, 31-May-1994.) $)
      eleq12d $p |- ( ph -> ( A e. C <-> B e. D ) ) $=
        ( wcel eleq2d eleq1d bitrd ) ABDHBEHCEHADEBGIABCEFJK $.
    $}
  $}

  $( A transitive-type law relating membership and equality.  (Contributed by
     NM, 9-Apr-1994.) $)
  eleq1a $p |- ( A e. B -> ( C = A -> C e. B ) ) $=
    ( wceq wcel eleq1 biimprcd ) CADCBEABECABFG $.

  ${
    eqeltr.1 $e |- A = B $.
    eqeltr.2 $e |- B e. C $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       NM, 5-Aug-1993.) $)
    eqeltri $p |- A e. C $=
      ( wcel eleq1i mpbir ) ACFBCFEABCDGH $.
  $}

  ${
    eqeltrr.1 $e |- A = B $.
    eqeltrr.2 $e |- A e. C $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       NM, 5-Aug-1993.) $)
    eqeltrri $p |- B e. C $=
      ( eqcomi eqeltri ) BACABDFEG $.
  $}

  ${
    eleqtr.1 $e |- A e. B $.
    eleqtr.2 $e |- B = C $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       NM, 5-Aug-1993.) $)
    eleqtri $p |- A e. C $=
      ( wcel eleq2i mpbi ) ABFACFDBCAEGH $.
  $}

  ${
    eleqtrr.1 $e |- A e. B $.
    eleqtrr.2 $e |- C = B $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       NM, 5-Aug-1993.) $)
    eleqtrri $p |- A e. C $=
      ( eqcomi eleqtri ) ABCDCBEFG $.
  $}

  ${
    eqeltrd.1 $e |- ( ph -> A = B ) $.
    eqeltrd.2 $e |- ( ph -> B e. C ) $.
    $( Substitution of equal classes into membership relation, deduction form.
       (Contributed by Raph Levien, 10-Dec-2002.) $)
    eqeltrd $p |- ( ph -> A e. C ) $=
      ( wcel eleq1d mpbird ) ABDGCDGFABCDEHI $.
  $}

  ${
    eqeltrrd.1 $e |- ( ph -> A = B ) $.
    eqeltrrd.2 $e |- ( ph -> A e. C ) $.
    $( Deduction that substitutes equal classes into membership.  (Contributed
       by NM, 14-Dec-2004.) $)
    eqeltrrd $p |- ( ph -> B e. C ) $=
      ( eqcomd eqeltrd ) ACBDABCEGFH $.
  $}

  ${
    eleqtrd.1 $e |- ( ph -> A e. B ) $.
    eleqtrd.2 $e |- ( ph -> B = C ) $.
    $( Deduction that substitutes equal classes into membership.  (Contributed
       by NM, 14-Dec-2004.) $)
    eleqtrd $p |- ( ph -> A e. C ) $=
      ( wcel eleq2d mpbid ) ABCGBDGEACDBFHI $.
  $}

  ${
    eleqtrrd.1 $e |- ( ph -> A e. B ) $.
    eleqtrrd.2 $e |- ( ph -> C = B ) $.
    $( Deduction that substitutes equal classes into membership.  (Contributed
       by NM, 14-Dec-2004.) $)
    eleqtrrd $p |- ( ph -> A e. C ) $=
      ( eqcomd eleqtrd ) ABCDEADCFGH $.
  $}

  ${
    3eltr3.1 $e |- A e. B $.
    3eltr3.2 $e |- A = C $.
    3eltr3.3 $e |- B = D $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       Mario Carneiro, 6-Jan-2017.) $)
    3eltr3i $p |- C e. D $=
      ( eleqtri eqeltrri ) ACDFABDEGHI $.
  $}

  ${
    3eltr4.1 $e |- A e. B $.
    3eltr4.2 $e |- C = A $.
    3eltr4.3 $e |- D = B $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       Mario Carneiro, 6-Jan-2017.) $)
    3eltr4i $p |- C e. D $=
      ( eleqtrri eqeltri ) CADFABDEGHI $.
  $}

  ${
    3eltr3d.1 $e |- ( ph -> A e. B ) $.
    3eltr3d.2 $e |- ( ph -> A = C ) $.
    3eltr3d.3 $e |- ( ph -> B = D ) $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       Mario Carneiro, 6-Jan-2017.) $)
    3eltr3d $p |- ( ph -> C e. D ) $=
      ( eleqtrd eqeltrrd ) ABDEGABCEFHIJ $.
  $}

  ${
    3eltr4d.1 $e |- ( ph -> A e. B ) $.
    3eltr4d.2 $e |- ( ph -> C = A ) $.
    3eltr4d.3 $e |- ( ph -> D = B ) $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       Mario Carneiro, 6-Jan-2017.) $)
    3eltr4d $p |- ( ph -> C e. D ) $=
      ( eleqtrrd eqeltrd ) ADBEGABCEFHIJ $.
  $}

  ${
    3eltr3g.1 $e |- ( ph -> A e. B ) $.
    3eltr3g.2 $e |- A = C $.
    3eltr3g.3 $e |- B = D $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       Mario Carneiro, 6-Jan-2017.) $)
    3eltr3g $p |- ( ph -> C e. D ) $=
      ( wcel eleq12i sylib ) ABCIDEIFBDCEGHJK $.
  $}

  ${
    3eltr4g.1 $e |- ( ph -> A e. B ) $.
    3eltr4g.2 $e |- C = A $.
    3eltr4g.3 $e |- D = B $.
    $( Substitution of equal classes into membership relation.  (Contributed by
       Mario Carneiro, 6-Jan-2017.) $)
    3eltr4g $p |- ( ph -> C e. D ) $=
      ( wcel eleq12i sylibr ) ABCIDEIFDBECGHJK $.
  $}

  ${
    syl5eqel.1 $e |- A = B $.
    syl5eqel.2 $e |- ( ph -> B e. C ) $.
    $( B membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl5eqel $p |- ( ph -> A e. C ) $=
      ( wceq a1i eqeltrd ) ABCDBCGAEHFI $.
  $}

  ${
    syl5eqelr.1 $e |- B = A $.
    syl5eqelr.2 $e |- ( ph -> B e. C ) $.
    $( B membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl5eqelr $p |- ( ph -> A e. C ) $=
      ( eqcomi syl5eqel ) ABCDCBEGFH $.
  $}

  ${
    syl5eleq.1 $e |- A e. B $.
    syl5eleq.2 $e |- ( ph -> B = C ) $.
    $( B membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl5eleq $p |- ( ph -> A e. C ) $=
      ( wcel a1i eleqtrd ) ABCDBCGAEHFI $.
  $}

  ${
    syl5eleqr.1 $e |- A e. B $.
    syl5eleqr.2 $e |- ( ph -> C = B ) $.
    $( B membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl5eleqr $p |- ( ph -> A e. C ) $=
      ( eqcomd syl5eleq ) ABCDEADCFGH $.
  $}

  ${
    syl6eqel.1 $e |- ( ph -> A = B ) $.
    syl6eqel.2 $e |- B e. C $.
    $( A membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl6eqel $p |- ( ph -> A e. C ) $=
      ( wcel a1i eqeltrd ) ABCDECDGAFHI $.
  $}

  ${
    syl6eqelr.1 $e |- ( ph -> B = A ) $.
    syl6eqelr.2 $e |- B e. C $.
    $( A membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl6eqelr $p |- ( ph -> A e. C ) $=
      ( eqcomd syl6eqel ) ABCDACBEGFH $.
  $}

  ${
    syl6eleq.1 $e |- ( ph -> A e. B ) $.
    syl6eleq.2 $e |- B = C $.
    $( A membership and equality inference.  (Contributed by NM,
       4-Jan-2006.) $)
    syl6eleq $p |- ( ph -> A e. C ) $=
      ( wceq a1i eleqtrd ) ABCDECDGAFHI $.
  $}

  ${
    syl6eleqr.1 $e |- ( ph -> A e. B ) $.
    syl6eleqr.2 $e |- C = B $.
    $( A membership and equality inference.  (Contributed by NM,
       24-Apr-2005.) $)
    syl6eleqr $p |- ( ph -> A e. C ) $=
      ( eqcomi syl6eleq ) ABCDEDCFGH $.
  $}

  ${
    eleq2s.1 $e |- ( A e. B -> ph ) $.
    eleq2s.2 $e |- C = B $.
    $( Substitution of equal classes into a membership antecedent.
       (Contributed by Jonathan Ben-Naim, 3-Jun-2011.) $)
    eleq2s $p |- ( A e. C -> ph ) $=
      ( wcel eleq2i sylbi ) BDGBCGADCBFHEI $.
  $}

  ${
    eqneltrd.1 $e |- ( ph -> A = B ) $.
    eqneltrd.2 $e |- ( ph -> -. B e. C ) $.
    $( If a class is not an element of another class, an equal class is also
       not an element.  Deduction form.  (Contributed by David Moews,
       1-May-2017.) $)
    eqneltrd $p |- ( ph -> -. A e. C ) $=
      ( wcel eleq1d mtbird ) ABDGCDGFABCDEHI $.
  $}

  ${
    eqneltrrd.1 $e |- ( ph -> A = B ) $.
    eqneltrrd.2 $e |- ( ph -> -. A e. C ) $.
    $( If a class is not an element of another class, an equal class is also
       not an element.  Deduction form.  (Contributed by David Moews,
       1-May-2017.) $)
    eqneltrrd $p |- ( ph -> -. B e. C ) $=
      ( wcel eleq1d mtbid ) ABDGCDGFABCDEHI $.
  $}

  ${
    neleqtrd.1 $e |- ( ph -> -. C e. A ) $.
    neleqtrd.2 $e |- ( ph -> A = B ) $.
    $( If a class is not an element of another class, it is also not an element
       of an equal class.  Deduction form.  (Contributed by David Moews,
       1-May-2017.) $)
    neleqtrd $p |- ( ph -> -. C e. B ) $=
      ( wcel eleq2d mtbid ) ADBGDCGEABCDFHI $.
  $}

  ${
    neleqtrrd.1 $e |- ( ph -> -. C e. B ) $.
    neleqtrrd.2 $e |- ( ph -> A = B ) $.
    $( If a class is not an element of another class, it is also not an element
       of an equal class.  Deduction form.  (Contributed by David Moews,
       1-May-2017.) $)
    neleqtrrd $p |- ( ph -> -. C e. A ) $=
      ( wcel eleq2d mtbird ) ADBGDCGEABCDFHI $.
  $}

  ${
    $d y A $.  $d y B $.  $d x y $.
    cleqh.1 $e |- ( y e. A -> A. x y e. A ) $.
    cleqh.2 $e |- ( y e. B -> A. x y e. B ) $.
    $( Establish equality between classes, using bound-variable hypotheses
       instead of distinct variable conditions.  (Contributed by NM,
       5-Aug-1993.) $)
    cleqh $p |- ( A = B <-> A. x ( x e. A <-> x e. B ) ) $=
      ( wceq cv wcel wb wal dfcleq ax-17 wi wa dfbi2 hbim weq eleq1 cbv3h hban
      hbxfrbi bibi12d biimpd equcoms biimprd impbii bitr4i ) CDGBHZCIZUIDIZJZBK
      ZAHZCIZUNDIZJZAKZBCDLURUMUQULABUQBMZULUJUKNZUKUJNZOAUJUKPUTVAAUJUKAEFQUKU
      JAFEQUAUBZABRZUQULVCUOUJUPUKUNUICSUNUIDSUCZUDTULUQBAVBUSBARUQULUQULJABVDU
      EUFTUGUH $.
  $}

  $( A way of showing two classes are not equal.  (Contributed by NM,
     1-Apr-1997.) $)
  nelneq $p |- ( ( A e. C /\ -. B e. C ) -> -. A = B ) $=
    ( wcel wceq eleq1 biimpcd con3and ) ACDZABEZBCDZJIKABCFGH $.

  $( A way of showing two classes are not equal.  (Contributed by NM,
     12-Jan-2002.) $)
  nelneq2 $p |- ( ( A e. B /\ -. A e. C ) -> -. B = C ) $=
    ( wcel wceq eleq2 biimpcd con3and ) ABDZBCEZACDZJIKBCAFGH $.

  ${
    $d x y $.  $d y A $.
    $( Lemma for ~ eqsb3 .  (Contributed by Rodolfo Medina, 28-Apr-2010.)
       (Proof shortened by Andrew Salmon, 14-Jun-2011.) $)
    eqsb3lem $p |- ( [ x / y ] y = A <-> x = A ) $=
      ( cv wceq nfv eqeq1 sbie ) BDZCEADZCEZBAKBFIJCGH $.
  $}

  ${
    $d y A $.  $d w y $.  $d w A $.  $d x w $.
    $( Substitution applied to an atomic wff (class version of ~ equsb3 ).
       (Contributed by Rodolfo Medina, 28-Apr-2010.) $)
    eqsb3 $p |- ( [ x / y ] y = A <-> x = A ) $=
      ( vw cv wceq wsb eqsb3lem sbbii nfv sbco2 3bitr3i ) BECFZBDGZDAGDECFZDAGM
      BAGAECFNODADBCHIMBADMDJKADCHL $.
  $}

  ${
    $d y A $.  $d w y $.  $d w A $.  $d w x $.
    $( Substitution applied to an atomic wff (class version of ~ elsb3 ).
       (Contributed by Rodolfo Medina, 28-Apr-2010.)  (Proof shortened by
       Andrew Salmon, 14-Jun-2011.) $)
    clelsb3 $p |- ( [ x / y ] y e. A <-> x e. A ) $=
      ( vw cv wcel wsb nfv sbco2 eleq1 sbie sbbii 3bitr3i ) DEZCFZDBGZBAGODAGBE
      ZCFZBAGAEZCFZODABOBHIPRBAORDBRDHNQCJKLOTDATDHNSCJKM $.
  $}

  ${
    hbxfr.1 $e |- A = B $.
    hbxfr.2 $e |- ( y e. B -> A. x y e. B ) $.
    $( A utility lemma to transfer a bound-variable hypothesis builder into a
       definition.  See ~ hbxfrbi for equivalence version.  (Contributed by NM,
       21-Aug-2007.) $)
    hbxfreq $p |- ( y e. A -> A. x y e. A ) $=
      ( cv wcel eleq2i hbxfrbi ) BGZCHKDHACDKEIFJ $.
  $}

  ${
    $d w y A $.  $d w x z $.
    hblem.1 $e |- ( y e. A -> A. x y e. A ) $.
    $( Change the free variable of a hypothesis builder.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Andrew Salmon, 11-Jul-2011.) $)
    hblem $p |- ( z e. A -> A. x z e. A ) $=
      ( cv wcel wsb wal hbsb clelsb3 albii 3imtr3i ) BFDGZBCHZOAICFDGZPAINBCAEJ
      CBDKZOPAQLM $.
  $}

  ${
    $d x A y $.  $d ph y $.
    $( Equality of a class variable and a class abstraction (also called a
       class builder).  Theorem 5.1 of [Quine] p. 34.  This theorem shows the
       relationship between expressions with class abstractions and expressions
       with class variables.  Note that ~ abbi and its relatives are among
       those useful for converting theorems with class variables to equivalent
       theorems with wff variables, by first substituting a class abstraction
       for each class variable.

       Class variables can always be eliminated from a theorem to result in an
       equivalent theorem with wff variables, and vice-versa.  The idea is
       roughly as follows.  To convert a theorem with a wff variable ` ph `
       (that has a free variable ` x ` ) to a theorem with a class variable
       ` A ` , we substitute ` x e. A ` for ` ph ` throughout and simplify,
       where ` A ` is a new class variable not already in the wff.  Conversely,
       to convert a theorem with a class variable ` A ` to one with ` ph ` , we
       substitute ` { x | ph } ` for ` A ` throughout and simplify, where ` x `
       and ` ph ` are new set and wff variables not already in the wff.  For
       more information on class variables, see Quine pp. 15-21 and/or Takeuti
       and Zaring pp. 10-13.  (Contributed by NM, 5-Aug-1993.) $)
    abeq2 $p |- ( A = { x | ph } <-> A. x ( x e. A <-> ph ) ) $=
      ( vy cab wceq cv wcel wb wal ax-17 hbab1 cleqh abid bibi2i albii bitri )
      CABEZFBGZCHZSRHZIZBJTAIZBJBDCRDGCHBKABDLMUBUCBUAATABNOPQ $.
  $}

  ${
    $d x A y $.  $d ph y $.
    $( Equality of a class variable and a class abstraction.  (Contributed by
       NM, 20-Aug-1993.) $)
    abeq1 $p |- ( { x | ph } = A <-> A. x ( ph <-> x e. A ) ) $=
      ( cab wceq cv wcel wb wal abeq2 eqcom bicom albii 3bitr4i ) CABDZEBFCGZAH
      ZBIOCEAPHZBIABCJOCKRQBAPLMN $.
  $}

  ${
    abeqi.1 $e |- A = { x | ph } $.
    $( Equality of a class variable and a class abstraction (inference rule).
       (Contributed by NM, 3-Apr-1996.) $)
    abeq2i $p |- ( x e. A <-> ph ) $=
      ( cv wcel cab eleq2i abid bitri ) BEZCFKABGZFACLKDHABIJ $.
  $}

  ${
    abeqri.1 $e |- { x | ph } = A $.
    $( Equality of a class variable and a class abstraction (inference rule).
       (Contributed by NM, 31-Jul-1994.) $)
    abeq1i $p |- ( ph <-> x e. A ) $=
      ( cv cab wcel abid eleq2i bitr3i ) ABEZABFZGKCGABHLCKDIJ $.
  $}

  ${
    abeqd.1 $e |- ( ph -> A = { x | ps } ) $.
    $( Equality of a class variable and a class abstraction (deduction).
       (Contributed by NM, 16-Nov-1995.) $)
    abeq2d $p |- ( ph -> ( x e. A <-> ps ) ) $=
      ( cv wcel cab eleq2d abid syl6bb ) ACFZDGLBCHZGBADMLEIBCJK $.
  $}

  ${
    $d ph y $.  $d ps y $.  $d x y $.
    $( Equivalent wff's correspond to equal class abstractions.  (Contributed
       by NM, 25-Nov-2013.)  (Revised by Mario Carneiro, 11-Aug-2016.) $)
    abbi $p |- ( A. x ( ph <-> ps ) <-> { x | ph } = { x | ps } ) $=
      ( vy cab wceq wcel wal dfcleq nfsab1 nfbi nfv wsb df-clab sbequ12r syl5bb
      cv wb bibi12d cbval bitr2i ) ACEZBCEZFDQZUBGZUDUCGZRZDHABRZCHDUBUCIUGUHDC
      UEUFCACDJBCDJKUHDLUDCQFZUEAUFBUEACDMUIAADCNADCOPUFBCDMUIBBDCNBDCOPSTUA $.
  $}

  ${
    $d x A $.
    abbiri.1 $e |- ( x e. A <-> ph ) $.
    $( Equality of a class variable and a class abstraction (inference rule).
       (Contributed by NM, 5-Aug-1993.) $)
    abbi2i $p |- A = { x | ph } $=
      ( cab wceq cv wcel wb abeq2 mpgbir ) CABEFBGCHAIBABCJDK $.
  $}

  ${
    abbii.1 $e |- ( ph <-> ps ) $.
    $( Equivalent wff's yield equal class abstractions (inference rule).
       (Contributed by NM, 5-Aug-1993.) $)
    abbii $p |- { x | ph } = { x | ps } $=
      ( wb cab wceq abbi mpgbi ) ABEACFBCFGCABCHDI $.

    $( Theorem abbii is the congruence law for class abstraction. $)
    $( $j congruence 'abbii'; $)
  $}

  ${
    $d x y $.  $d ph y $.  $d ps y $.  $d ch y $.  $( ` y ` is a dummy var. $)
    abbid.1 $e |- F/ x ph $.
    abbid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Equivalent wff's yield equal class abstractions (deduction rule).
       (Contributed by NM, 5-Aug-1993.)  (Revised by Mario Carneiro,
       7-Oct-2016.) $)
    abbid $p |- ( ph -> { x | ps } = { x | ch } ) $=
      ( wb wal cab wceq alrimi abbi sylib ) ABCGZDHBDICDIJANDEFKBCDLM $.
  $}

  ${
    $d x ph $.
    abbidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Equivalent wff's yield equal class abstractions (deduction rule).
       (Contributed by NM, 10-Aug-1993.) $)
    abbidv $p |- ( ph -> { x | ps } = { x | ch } ) $=
      ( nfv abbid ) ABCDADFEG $.
  $}

  ${
    $d x y A $.  $d ph x y $.  $d ps y $.  $( ` y ` is a dummy var. $)
    abbirdv.1 $e |- ( ph -> ( x e. A <-> ps ) ) $.
    $( Deduction from a wff to a class abstraction.  (Contributed by NM,
       9-Jul-1994.) $)
    abbi2dv $p |- ( ph -> A = { x | ps } ) $=
      ( cv wcel wb wal cab wceq alrimiv abeq2 sylibr ) ACFDGBHZCIDBCJKAOCELBCDM
      N $.
  $}

  ${
    $d x y A $.  $d ph x y $.  $d ps y $.  $( ` y ` is a dummy var. $)
    abbildv.1 $e |- ( ph -> ( ps <-> x e. A ) ) $.
    $( Deduction from a wff to a class abstraction.  (Contributed by NM,
       9-Jul-1994.) $)
    abbi1dv $p |- ( ph -> { x | ps } = A ) $=
      ( cv wcel wb wal cab wceq alrimiv abeq1 sylibr ) ABCFDGHZCIBCJDKAOCELBCDM
      N $.
  $}

  ${
    $d x A $.
    $( A simplification of class abstraction.  Theorem 5.2 of [Quine] p. 35.
       (Contributed by NM, 26-Dec-1993.) $)
    abid2 $p |- { x | x e. A } = A $=
      ( cv wcel cab biid abbi2i eqcomi ) BACBDZAEIABIFGH $.
  $}

  ${
    $d x z $.  $d y z $.  $d ph z $.  $d ps z $.
    cbvab.1 $e |- F/ y ph $.
    cbvab.2 $e |- F/ x ps $.
    cbvab.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by Andrew Salmon, 11-Jul-2011.) $)
    cbvab $p |- { x | ph } = { y | ps } $=
      ( vz cab wsb cv wcel nfsb weq wb equcoms bicomd sbie sbequ df-clab eqriv
      syl5bbr 3bitr4i ) HACIZBDIZACHJBDHJZHKZUDLUGUELAUFCHBDHCFMABDCJCHNUFBADCE
      DCNABABOCDGPQRBCHDSUBRAHCTBHDTUCUA $.
  $}

  ${
    $d y ph $.  $d x ps $.
    cbvabv.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 26-May-1999.) $)
    cbvabv $p |- { x | ph } = { y | ps } $=
      ( nfv cbvab ) ABCDADFBCFEG $.
  $}

  ${
    $d x A y $.  $d ph y $.
    $( Membership of a class variable in a class abstraction.  (Contributed by
       NM, 23-Dec-1993.) $)
    clelab $p |- ( A e. { x | ph } <-> E. x ( x = A /\ ph ) ) $=
      ( vy cv wceq cab wcel wex wsb df-clab anbi2i exbii df-clel nfv nfs1v nfan
      wa eqeq1 sbequ12 anbi12d cbvex 3bitr4i ) DEZCFZUDABGZHZRZDIUEABDJZRZDICUF
      HBEZCFZARZBIUHUJDUGUIUEADBKLMDCUFNUMUJBDUMDOUEUIBUEBOABDPQUKUDFULUEAUIUKU
      DCSABDTUAUBUC $.
  $}

  ${
    $d y A $.  $d y ph $.  $d x y $.
    $( Membership of a class abstraction in another class.  (Contributed by NM,
       17-Jan-2006.) $)
    clabel $p |- ( { x | ph } e. A <->
                 E. y ( y e. A /\ A. x ( x e. y <-> ph ) ) ) $=
      ( cab wcel cv wceq wa wex wb wal df-clel abeq2 anbi2ci exbii bitri ) ABEZ
      DFCGZRHZSDFZIZCJUABGSFAKBLZIZCJCRDMUBUDCTUCUAABSNOPQ $.
  $}

  ${
    $d z A $.  $d z x $.  $d z y $.
    $( The right-hand side of the second equality is a way of representing
       proper substitution of ` y ` for ` x ` into a class variable.
       (Contributed by NM, 14-Sep-2003.) $)
    sbab $p |- ( x = y -> A = { z | [ y / x ] z e. A } ) $=
      ( weq cv wcel wsb sbequ12 abbi2dv ) ABECFDGZABHCDKABIJ $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Class form not-free predicate
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $c F/_ $.  $( Underlined not-free symbol. $)

  $( Extend wff definition to include the not-free predicate for classes. $)
  wnfc $a wff F/_ x A $.

  ${
    $d x y z $.  $d y z A $.
    $( Justification theorem for ~ df-nfc .  (Contributed by Mario Carneiro,
       13-Oct-2016.) $)
    nfcjust $p |- ( A. y F/ x y e. A <-> A. z F/ x z e. A ) $=
      ( cv wcel wnf weq nfv eleq1 nfbidf cbvalv ) BEZDFZAGCEZDFZAGBCBCHZNPAQAIM
      ODJKL $.
  $}

  ${
    $d x y $.  $d y A $.
    $( Define the not-free predicate for classes.  This is read " ` x ` is not
       free in ` A ` ".  Not-free means that the value of ` x ` cannot affect
       the value of ` A ` , e.g., any occurrence of ` x ` in ` A ` is
       effectively bound by a quantifier or something that expands to one (such
       as "there exists at most one").  It is defined in terms of the not-free
       predicate ~ df-nf for wffs; see that definition for more information.
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    df-nfc $a |- ( F/_ x A <-> A. y F/ x y e. A ) $.

    ${
      nfci.1 $e |- F/ x y e. A $.
      $( Deduce that a class ` A ` does not have ` x ` free in it.
         (Contributed by Mario Carneiro, 11-Aug-2016.) $)
      nfci $p |- F/_ x A $=
        ( wnfc cv wcel wnf df-nfc mpgbir ) ACEBFCGAHBABCIDJ $.
    $}

    ${
      nfcii.1 $e |- ( y e. A -> A. x y e. A ) $.
      $( Deduce that a class ` A ` does not have ` x ` free in it.
         (Contributed by Mario Carneiro, 11-Aug-2016.) $)
      nfcii $p |- F/_ x A $=
        ( cv wcel nfi nfci ) ABCBECFADGH $.
    $}

    $( Consequence of the not-free predicate.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfcr $p |- ( F/_ x A -> F/ x y e. A ) $=
      ( wnfc cv wcel wnf wal df-nfc sp sylbi ) ACDBECFAGZBHLABCILBJK $.
  $}

  ${
    $d x y z $.  $d z A $.
    nfcri.1 $e |- F/_ x A $.
    $( Consequence of the not-free predicate.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfcrii $p |- ( y e. A -> A. x y e. A ) $=
      ( vz cv wcel wnfc wnf nfcr ax-mp nfri hblem ) AEBCEFCGZAACHNAIDAECJKLM $.

    $( Consequence of the not-free predicate.  (Note that unlike ~ nfcr , this
       does not require ` y ` and ` A ` to be disjoint.)  (Contributed by Mario
       Carneiro, 11-Aug-2016.) $)
    nfcri $p |- F/ x y e. A $=
      ( cv wcel nfcrii nfi ) BECFAABCDGH $.
  $}

  ${
    $d x y $.  $d y A $.
    nfcd.1 $e |- F/ y ph $.
    nfcd.2 $e |- ( ph -> F/ x y e. A ) $.
    $( Deduce that a class ` A ` does not have ` x ` free in it.  (Contributed
       by Mario Carneiro, 11-Aug-2016.) $)
    nfcd $p |- ( ph -> F/_ x A ) $=
      ( cv wcel wnf wal wnfc alrimi df-nfc sylibr ) ACGDHBIZCJBDKAOCEFLBCDMN $.
  $}

  ${
    $d x y $.  $d y A $.  $d y B $.
    nfceqi.1 $e |- A = B $.
    $( Equality theorem for class not-free.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfceqi $p |- ( F/_ x A <-> F/_ x B ) $=
      ( vy cv wcel wnf wal wnfc eleq2i nfbii albii df-nfc 3bitr4i ) EFZBGZAHZEI
      PCGZAHZEIABJACJRTEQSABCPDKLMAEBNAECNO $.

    ${
      nfcxfr.2 $e |- F/_ x B $.
      $( A utility lemma to transfer a bound-variable hypothesis builder into a
         definition.  (Contributed by Mario Carneiro, 11-Aug-2016.) $)
      nfcxfr $p |- F/_ x A $=
        ( wnfc nfceqi mpbir ) ABFACFEABCDGH $.
    $}

    ${
      nfcxfrd.2 $e |- ( ph -> F/_ x B ) $.
      $( A utility lemma to transfer a bound-variable hypothesis builder into a
         definition.  (Contributed by Mario Carneiro, 11-Aug-2016.) $)
      nfcxfrd $p |- ( ph -> F/_ x A ) $=
        ( wnfc nfceqi sylibr ) ABDGBCGFBCDEHI $.
    $}
  $}

  ${
    $d x y $.  $d A y $.  $d B y $.  $d ph y $.
    nfceqdf.1 $e |- F/ x ph $.
    nfceqdf.2 $e |- ( ph -> A = B ) $.
    $( An equality theorem for effectively not free.  (Contributed by Mario
       Carneiro, 14-Oct-2016.) $)
    nfceqdf $p |- ( ph -> ( F/_ x A <-> F/_ x B ) ) $=
      ( vy cv wcel wnf wal wnfc eleq2d nfbidf albidv df-nfc 3bitr4g ) AGHZCIZBJ
      ZGKRDIZBJZGKBCLBDLATUBGASUABEACDRFMNOBGCPBGDPQ $.
  $}

  ${
    $d x y A $.
    $( If ` x ` is disjoint from ` A ` , then ` x ` is not free in ` A ` .
       (Contributed by Mario Carneiro, 11-Aug-2016.) $)
    nfcv $p |- F/_ x A $=
      ( vy cv wcel nfv nfci ) ACBCDBEAFG $.

    $( If ` x ` is disjoint from ` A ` , then ` x ` is not free in ` A ` .
       (Contributed by Mario Carneiro, 7-Oct-2016.) $)
    nfcvd $p |- ( ph -> F/_ x A ) $=
      ( wnfc nfcv a1i ) BCDABCEF $.
  $}

  ${
    $d x y $.  $d y A $.  $d y ph $.
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by Mario Carneiro, 11-Aug-2016.) $)
    nfab1 $p |- F/_ x { x | ph } $=
      ( vy cab nfsab1 nfci ) BCABDABCEF $.

    $( ` x ` is bound in ` F/_ x A ` .  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfnfc1 $p |- F/ x F/_ x A $=
      ( vy wnfc cv wcel wnf wal df-nfc nfnf1 nfal nfxfr ) ABDCEBFZAGZCHAACBINAC
      MAJKL $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.
    nfab.1 $e |- F/ x ph $.
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by Mario Carneiro, 11-Aug-2016.) $)
    nfab $p |- F/_ x { y | ph } $=
      ( vz cab nfsab nfci ) BEACFABCEDGH $.
  $}

  ${
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by Mario Carneiro, 14-Oct-2016.) $)
    nfaba1 $p |- F/_ x { y | A. x ph } $=
      ( wal nfa1 nfab ) ABDBCABEF $.
  $}

  ${
    $d x z $.  $d y z $.  $d z A $.  $d z B $.
    nfnfc.1 $e |- F/_ x A $.
    $( Hypothesis builder for ` F/_ y A ` .  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfnfc $p |- F/ x F/_ y A $=
      ( vz wnfc cv wcel wnf wal df-nfc nfcri nfnf nfal nfxfr ) BCFEGCHZBIZEJABE
      CKQAEPABAECDLMNO $.

    nfeq.2 $e |- F/_ x B $.
    $( Hypothesis builder for equality.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfeq $p |- F/ x A = B $=
      ( vz wceq cv wcel wb wal dfcleq nfcri nfbi nfal nfxfr ) BCGFHZBIZQCIZJZFK
      AFBCLTAFRSAAFBDMAFCEMNOP $.

    $( Hypothesis builder for elementhood.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfel $p |- F/ x A e. B $=
      ( vz wcel cv wceq wa wex df-clel nfcv nfeq nfcri nfan nfex nfxfr ) BCGFHZ
      BIZSCGZJZFKAFBCLUBAFTUAAASBASMDNAFCEOPQR $.
  $}

  ${
    $d x B $.
    nfeq1.1 $e |- F/_ x A $.
    $( Hypothesis builder for equality, special case.  (Contributed by Mario
       Carneiro, 10-Oct-2016.) $)
    nfeq1 $p |- F/ x A = B $=
      ( nfcv nfeq ) ABCDACEF $.

    $( Hypothesis builder for elementhood, special case.  (Contributed by Mario
       Carneiro, 10-Oct-2016.) $)
    nfel1 $p |- F/ x A e. B $=
      ( nfcv nfel ) ABCDACEF $.
  $}

  ${
    $d x A $.
    nfeq2.1 $e |- F/_ x B $.
    $( Hypothesis builder for equality, special case.  (Contributed by Mario
       Carneiro, 10-Oct-2016.) $)
    nfeq2 $p |- F/ x A = B $=
      ( nfcv nfeq ) ABCABEDF $.

    $( Hypothesis builder for elementhood, special case.  (Contributed by Mario
       Carneiro, 10-Oct-2016.) $)
    nfel2 $p |- F/ x A e. B $=
      ( nfcv nfel ) ABCABEDF $.
  $}

  ${
    $d x y $.  $d y A $.  $d y B $.
    nfeqd.1 $e |- ( ph -> F/_ x A ) $.
    $( Consequence of the not-free predicate.  (Contributed by Mario Carneiro,
       11-Aug-2016.) $)
    nfcrd $p |- ( ph -> F/ x y e. A ) $=
      ( wnfc cv wcel wnf nfcr syl ) ABDFCGDHBIEBCDJK $.

    $d y ph $.
    nfeqd.2 $e |- ( ph -> F/_ x B ) $.
    $( Hypothesis builder for equality.  (Contributed by Mario Carneiro,
       7-Oct-2016.) $)
    nfeqd $p |- ( ph -> F/ x A = B ) $=
      ( vy wceq cv wcel wb wal dfcleq nfv nfcrd nfbid nfald nfxfrd ) CDHGIZCJZS
      DJZKZGLABGCDMAUBBGAGNATUABABGCEOABGDFOPQR $.

    $( Hypothesis builder for elementhood.  (Contributed by Mario Carneiro,
       7-Oct-2016.) $)
    nfeld $p |- ( ph -> F/ x A e. B ) $=
      ( vy wcel cv wceq wa wex df-clel nfv nfcvd nfeqd nfcrd nfand nfexd nfxfrd
      ) CDHGIZCJZUADHZKZGLABGCDMAUDBGAGNAUBUCBABUACABUAOEPABGDFQRST $.
  $}

  ${
    $d w x $.  $d w y $.  $d w z $.  $d w A $.  $d w B $.
    drnfc1.1 $e |- ( A. x x = y -> A = B ) $.
    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       (Contributed by Mario Carneiro, 8-Oct-2016.) $)
    drnfc1 $p |- ( A. x x = y -> ( F/_ x A <-> F/_ y B ) ) $=
      ( vw weq wal cv wcel wnf wnfc eleq2d drnf1 dral2 df-nfc 3bitr4g ) ABGAHZF
      IZCJZAKZFHSDJZBKZFHACLBDLUAUCABFTUBABRCDSEMNOAFCPBFDPQ $.

    $( Formula-building lemma for use with the Distinctor Reduction Theorem.
       (Contributed by Mario Carneiro, 8-Oct-2016.) $)
    drnfc2 $p |- ( A. x x = y -> ( F/_ z A <-> F/_ z B ) ) $=
      ( vw weq wal cv wcel wnf wnfc eleq2d drnf2 dral2 df-nfc 3bitr4g ) ABHAIZG
      JZDKZCLZGITEKZCLZGICDMCEMUBUDABGUAUCABCSDETFNOPCGDQCGEQR $.
  $}

  ${
    $d x z $.  $d y z $.  $d z ph $.  $d z ps $.
    nfabd.1 $e |- F/ y ph $.
    nfabd.2 $e |- ( ph -> F/ x ps ) $.
    $( Bound-variable hypothesis builder for a class abstraction.  (Contributed
       by Mario Carneiro, 8-Oct-2016.) $)
    nfabd $p |- ( ph -> F/_ x { y | ps } ) $=
      ( vz cab nfv cv wcel wsbc df-clab nfsbd nfxfrd nfcd ) ACGBDHZAG
      IGJZQKBDRLACBGDMABDGCEFNOP $.
  $}

  ${
    $d w x $.  $d w y $.  $d w z $.  $d w A $.  $d w B $.  $d w ph $.
    dvelimdc.1 $e |- F/ x ph $.
    dvelimdc.2 $e |- F/ z ph $.
    dvelimdc.3 $e |- ( ph -> F/_ x A ) $.
    dvelimdc.4 $e |- ( ph -> F/_ z B ) $.
    dvelimdc.5 $e |- ( ph -> ( z = y -> A = B ) ) $.
    $( Deduction form of ~ dvelimc .  (Contributed by Mario Carneiro,
       8-Oct-2016.) $)
    dvelimdc $p |- ( ph -> ( -. A. x x = y -> F/_ x B ) ) $=
      ( vw weq wal wn wnfc wa nfv wcel nfcrd cv wnf wceq wb eleq2 syl6 dvelimdf
      imp nfcd ex ) ABCMBNOZBFPAUKQZBLFULLRAUKLUAZFSZBUBAUMESZUNBCDGHABLEITADLF
      JTADCMEFUCUOUNUDKEFUMUEUFUGUHUIUJ $.
  $}

  ${
    dvelimc.1 $e |- F/_ x A $.
    dvelimc.2 $e |- F/_ z B $.
    dvelimc.3 $e |- ( z = y -> A = B ) $.
    $( Version of ~ dvelim for classes.  (Contributed by Mario Carneiro,
       8-Oct-2016.) $)
    dvelimc $p |- ( -. A. x x = y -> F/_ x B ) $=
      ( weq wal wn wnfc wi wtru nftru a1i wceq dvelimdc trud ) ABIAJKAELMNABCDE
      AOCOADLNFPCELNGPCBIDEQMNHPRS $.
  $}

  ${
    $d x z $.  $d y z $.
    $( If ` x ` and ` y ` are distinct, then ` x ` is not free in ` y ` .
       (Contributed by Mario Carneiro, 8-Oct-2016.) $)
    nfcvf $p |- ( -. A. x x = y -> F/_ x y ) $=
      ( vz cv nfcv weq id dvelimc ) ABCCDZBDZAIECJECBFGH $.

    $( If ` x ` and ` y ` are distinct, then ` y ` is not free in ` x ` .
       (Contributed by Mario Carneiro, 5-Dec-2016.) $)
    nfcvf2 $p |- ( -. A. x x = y -> F/_ y x ) $=
      ( cv wnfc nfcvf naecoms ) BACDBABAEF $.
  $}

  ${
    $d y A $.  $d y B $.  $d x y $.
    cleqf.1 $e |- F/_ x A $.
    cleqf.2 $e |- F/_ x B $.
    $( Establish equality between classes, using bound-variable hypotheses
       instead of distinct variable conditions.  (Contributed by NM,
       5-Aug-1993.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
    cleqf $p |- ( A = B <-> A. x ( x e. A <-> x e. B ) ) $=
      ( vy wceq cv wcel wb wal dfcleq nfv nfcri nfbi eleq1 bibi12d cbval bitr4i
      ) BCGFHZBIZTCIZJZFKAHZBIZUDCIZJZAKFBCLUGUCAFUGFMUAUBAAFBDNAFCENOUDTGUEUAU
      FUBUDTBPUDTCPQRS $.
  $}

  ${
    $d y A $.  $d x y $.
    abid2f.1 $e |- F/_ x A $.
    $( A simplification of class abstraction.  Theorem 5.2 of [Quine] p. 35.
       (Contributed by NM, 5-Sep-2011.)  (Revised by Mario Carneiro,
       7-Oct-2016.) $)
    abid2f $p |- { x | x e. A } = A $=
      ( cv wcel cab wceq wb wal nfab1 cleqf abid bibi2i albii bitri biid mpgbir
      eqcomi ) BADZBEZAFZBUAGZTTHZAUBTSUAEZHZAIUCAIABUACTAJKUEUCAUDTTTALMNOTPQR
      $.
  $}

  ${
    $d v A w $.  $d x z v u $.  $d y z v u $.  $d v ph $.
    sbabel.1 $e |- F/_ x A $.
    $( Theorem to move a substitution in and out of a class abstraction.
       (Contributed by NM, 27-Sep-2003.)  (Revised by Mario Carneiro,
       7-Oct-2016.) $)
    sbabel $p |- ( [ y / x ] { z | ph } e. A <-> { z | [ y / x ] ph } e. A ) $=
      ( vv cv cab wceq wcel wa wex wsb wb wal sbf abeq2 sbbii 3bitr4i sbex sban
      nfv sbrbis sbalv nfcri anbi12i bitri exbii df-clel ) GHZADIZJZUKEKZLZGMZB
      CNZUKABCNZDIZJZUNLZGMZULEKZBCNUSEKUQUOBCNZGMVBUOGBCUAVDVAGVDUMBCNZUNBCNZL
      VAUMUNBCUBVEUTVFUNDHUKKZAOZDPZBCNVGUROZDPVEUTVHVJBCDVGVGABCVGBCVGBUCQUDUE
      UMVIBCADUKRSURDUKRTUNBCBGEFUFQUGUHUIUHVCUPBCGULEUJSGUSEUJT $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Negated equality and membership
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare new connectives. $)
  $c =/= $. $( Not equal to (equal sign with slash through it). $)
  $c e/ $. $( Not an element of (epsilon with slash through it). $)

  $( Extend wff notation to include inequality. $)
  wne $a wff A =/= B $.

  $( Extend wff notation to include negated membership. $)
  wnel $a wff A e/ B $.

  $( Define inequality.  (Contributed by NM, 5-Aug-1993.) $)
  df-ne $a |- ( A =/= B <-> -. A = B ) $.

  $( Define negated membership.  (Contributed by NM, 7-Aug-1994.) $)
  df-nel $a |- ( A e/ B <-> -. A e. B ) $.

$(
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
        Negated equality
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
$)

  $( Negation of inequality where equality is decidable.  (Contributed by Jim
     Kingdon, 15-May-2018.) $)
  nnedc $p |- ( DECID A = B -> ( -. A =/= B <-> A = B ) ) $=
    ( wceq wdc wne wn wb df-ne a1i con2biidc bicomd ) ABCZDZLABEZFNLN
    LFGMABHIJK $.

  $( No class is unequal to itself.  (Contributed by Stefan O'Rear,
     1-Jan-2015.)  (Proof rewritten by Jim Kingdon, 15-May-2018.) $)
  neirr $p |- -. A =/= A $=
    ( wne wn wceq eqid notnoti df-ne notbii mpbir ) AABZCAADZCZCKAEFJ
    LAAGHI $.

  $( Excluded middle with equality and inequality where equality is decidable.
     (Contributed by Jim Kingdon, 15-May-2018.) $)
  exmidnedc $p |- ( DECID A = B -> ( A = B \/ A =/= B ) ) $=
    ( wceq wdc wn wo wne exmiddc df-ne orbi2i sylibr ) ABCZDLLEZFLABG
    ZFLHNMLABIJK $.

  $( Law of noncontradiction with equality and inequality.  (Contributed by NM,
     3-Feb-2012.) $)
  nonconne $p |- -. ( A = B /\ A =/= B ) $=
    ( wceq wne wa wn pm3.24 df-ne anbi2i mtbir ) ABCZABDZEKKFZEKGLMKABHIJ $.

  $( Equality theorem for inequality.  (Contributed by NM, 19-Nov-1994.) $)
  neeq1 $p |- ( A = B -> ( A =/= C <-> B =/= C ) ) $=
    ( wceq wn wne eqeq1 notbid df-ne 3bitr4g ) ABDZACDZEBCDZEACFBCFKLMABCGHACIB
    CIJ $.

  $( Equality theorem for inequality.  (Contributed by NM, 19-Nov-1994.) $)
  neeq2 $p |- ( A = B -> ( C =/= A <-> C =/= B ) ) $=
    ( wceq wn wne eqeq2 notbid df-ne 3bitr4g ) ABDZCADZECBDZECAFCBFKLMABCGHCAIC
    BIJ $.

  ${
    neeq1i.1 $e |- A = B $.
    $( Inference for inequality.  (Contributed by NM, 29-Apr-2005.) $)
    neeq1i $p |- ( A =/= C <-> B =/= C ) $=
      ( wceq wne wb neeq1 ax-mp ) ABEACFBCFGDABCHI $.

    $( Inference for inequality.  (Contributed by NM, 29-Apr-2005.) $)
    neeq2i $p |- ( C =/= A <-> C =/= B ) $=
      ( wceq wne wb neeq2 ax-mp ) ABECAFCBFGDABCHI $.

    neeq12i.2 $e |- C = D $.
    $( Inference for inequality.  (Contributed by NM, 24-Jul-2012.) $)
    neeq12i $p |- ( A =/= C <-> B =/= D ) $=
      ( wne neeq2i neeq1i bitri ) ACGADGBDGCDAFHABDEIJ $.
  $}

  ${
    neeq1d.1 $e |- ( ph -> A = B ) $.
    $( Deduction for inequality.  (Contributed by NM, 25-Oct-1999.) $)
    neeq1d $p |- ( ph -> ( A =/= C <-> B =/= C ) ) $=
      ( wceq wne wb neeq1 syl ) ABCFBDGCDGHEBCDIJ $.

    $( Deduction for inequality.  (Contributed by NM, 25-Oct-1999.) $)
    neeq2d $p |- ( ph -> ( C =/= A <-> C =/= B ) ) $=
      ( wceq wne wb neeq2 syl ) ABCFDBGDCGHEBCDIJ $.

    neeq12d.2 $e |- ( ph -> C = D ) $.
    $( Deduction for inequality.  (Contributed by NM, 24-Jul-2012.) $)
    neeq12d $p |- ( ph -> ( A =/= C <-> B =/= D ) ) $=
      ( wne neeq1d neeq2d bitrd ) ABDHCDHCEHABCDFIADECGJK $.
  $}

  ${
    neneqd.1 $e |- ( ph -> A =/= B ) $.
    $( Deduction eliminating inequality definition.  (Contributed by Jonathan
       Ben-Naim, 3-Jun-2011.) $)
    neneqd $p |- ( ph -> -. A = B ) $=
      ( wne wceq wn df-ne sylib ) ABCEBCFGDBCHI $.
  $}

  ${
    eqnetr.1 $e |- A = B $.
    eqnetr.2 $e |- B =/= C $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    eqnetri $p |- A =/= C $=
      ( wne neeq1i mpbir ) ACFBCFEABCDGH $.
  $}

  ${
    eqnetrd.1 $e |- ( ph -> A = B ) $.
    eqnetrd.2 $e |- ( ph -> B =/= C ) $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    eqnetrd $p |- ( ph -> A =/= C ) $=
      ( wne neeq1d mpbird ) ABDGCDGFABCDEHI $.
  $}

  ${
    eqnetrr.1 $e |- A = B $.
    eqnetrr.2 $e |- A =/= C $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    eqnetrri $p |- B =/= C $=
      ( eqcomi eqnetri ) BACABDFEG $.
  $}

  ${
    eqnetrrd.1 $e |- ( ph -> A = B ) $.
    eqnetrrd.2 $e |- ( ph -> A =/= C ) $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    eqnetrrd $p |- ( ph -> B =/= C ) $=
      ( eqcomd eqnetrd ) ACBDABCEGFH $.
  $}

  ${
    neeqtr.1 $e |- A =/= B $.
    neeqtr.2 $e |- B = C $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    neeqtri $p |- A =/= C $=
      ( wne neeq2i mpbi ) ABFACFDBCAEGH $.
  $}

  ${
    neeqtrd.1 $e |- ( ph -> A =/= B ) $.
    neeqtrd.2 $e |- ( ph -> B = C ) $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    neeqtrd $p |- ( ph -> A =/= C ) $=
      ( wne neeq2d mpbid ) ABCGBDGEACDBFHI $.
  $}

  ${
    neeqtrr.1 $e |- A =/= B $.
    neeqtrr.2 $e |- C = B $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    neeqtrri $p |- A =/= C $=
      ( eqcomi neeqtri ) ABCDCBEFG $.
  $}

  ${
    neeqtrrd.1 $e |- ( ph -> A =/= B ) $.
    neeqtrrd.2 $e |- ( ph -> C = B ) $.
    $( Substitution of equal classes into an inequality.  (Contributed by NM,
       4-Jul-2012.) $)
    neeqtrrd $p |- ( ph -> A =/= C ) $=
      ( eqcomd neeqtrd ) ABCDEADCFGH $.
  $}

  ${
    syl5eqner.1 $e |- B = A $.
    syl5eqner.2 $e |- ( ph -> B =/= C ) $.
    $( B chained equality inference for inequality.  (Contributed by NM,
       6-Jun-2012.) $)
    syl5eqner $p |- ( ph -> A =/= C ) $=
      ( wne neeq1i sylib ) ACDGBDGFCBDEHI $.
  $}

  ${
    3netr3d.1 $e |- ( ph -> A =/= B ) $.
    3netr3d.2 $e |- ( ph -> A = C ) $.
    3netr3d.3 $e |- ( ph -> B = D ) $.
    $( Substitution of equality into both sides of an inequality.  (Contributed
       by NM, 24-Jul-2012.) $)
    3netr3d $p |- ( ph -> C =/= D ) $=
      ( wne neeq12d mpbid ) ABCIDEIFABDCEGHJK $.
  $}

  ${
    3netr4d.1 $e |- ( ph -> A =/= B ) $.
    3netr4d.2 $e |- ( ph -> C = A ) $.
    3netr4d.3 $e |- ( ph -> D = B ) $.
    $( Substitution of equality into both sides of an inequality.  (Contributed
       by NM, 24-Jul-2012.) $)
    3netr4d $p |- ( ph -> C =/= D ) $=
      ( wne neeq12d mpbird ) ADEIBCIFADBECGHJK $.
  $}

  ${
    3netr3g.1 $e |- ( ph -> A =/= B ) $.
    3netr3g.2 $e |- A = C $.
    3netr3g.3 $e |- B = D $.
    $( Substitution of equality into both sides of an inequality.  (Contributed
       by NM, 24-Jul-2012.) $)
    3netr3g $p |- ( ph -> C =/= D ) $=
      ( wne neeq12i sylib ) ABCIDEIFBDCEGHJK $.
  $}

  ${
    3netr4g.1 $e |- ( ph -> A =/= B ) $.
    3netr4g.2 $e |- C = A $.
    3netr4g.3 $e |- D = B $.
    $( Substitution of equality into both sides of an inequality.  (Contributed
       by NM, 14-Jun-2012.) $)
    3netr4g $p |- ( ph -> C =/= D ) $=
      ( wne neeq12i sylibr ) ABCIDEIFDBECGHJK $.
  $}

  ${
    necon3abii.1 $e |- ( A = B <-> ph ) $.
    $( Deduction from equality to inequality.  (Contributed by NM,
       9-Nov-2007.) $)
    necon3abii $p |- ( A =/= B <-> -. ph ) $=
      ( wne wceq df-ne xchbinx ) BCEBCFABCGDH $.
  $}

  ${
    necon3bbii.1 $e |- ( ph <-> A = B ) $.
    $( Deduction from equality to inequality.  (Contributed by NM,
       13-Apr-2007.) $)
    necon3bbii $p |- ( -. ph <-> A =/= B ) $=
      ( wne wn wceq bicomi necon3abii ) BCEAFABCABCGDHIH $.
  $}

  ${
    necon3bii.1 $e |- ( A = B <-> C = D ) $.
    $( Inference from equality to inequality.  (Contributed by NM,
       23-Feb-2005.) $)
    necon3bii $p |- ( A =/= B <-> C =/= D ) $=
      ( wne wceq wn necon3abii df-ne bitr4i ) ABFCDGZHCDFLABEICDJK $.
  $}

  ${
    necon3abid.1 $e |- ( ph -> ( A = B <-> ps ) ) $.
    $( Deduction from equality to inequality.  (Contributed by NM,
       21-Mar-2007.) $)
    necon3abid $p |- ( ph -> ( A =/= B <-> -. ps ) ) $=
      ( wne wceq wn df-ne notbid syl5bb ) CDFCDGZHABHCDIALBEJK $.
  $}

  ${
    necon3bbid.1 $e |- ( ph -> ( ps <-> A = B ) ) $.
    $( Deduction from equality to inequality.  (Contributed by NM,
       2-Jun-2007.) $)
    necon3bbid $p |- ( ph -> ( -. ps <-> A =/= B ) ) $=
      ( wne wn wceq bicomd necon3abid ) ACDFBGABCDABCDHEIJI $.
  $}

  ${
    necon3bid.1 $e |- ( ph -> ( A = B <-> C = D ) ) $.
    $( Deduction from equality to inequality.  (Contributed by NM,
       23-Feb-2005.)  (Proof shortened by Andrew Salmon, 25-May-2011.) $)
    necon3bid $p |- ( ph -> ( A =/= B <-> C =/= D ) ) $=
      ( wne wceq wn df-ne necon3bbid syl5bb ) BCGBCHZIADEGBCJAMDEFKL $.
  $}

  ${
    necon3ad.1 $e |- ( ph -> ( ps -> A = B ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by NM,
       2-Apr-2007.)  (Proof rewritten by Jim Kingdon, 15-May-2018.) $)
    necon3ad $p |- ( ph -> ( A =/= B -> -. ps ) ) $=
      ( wne wceq wn df-ne con3d syl5bi ) CDFCDGZHABHCDIABLEJK $.
  $}

  ${
    necon3bd.1 $e |- ( ph -> ( A = B -> ps ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by NM,
       2-Apr-2007.)  (Proof rewritten by Jim Kingdon, 15-May-2018.) $)
    necon3bd $p |- ( ph -> ( -. ps -> A =/= B ) ) $=
      ( wn wceq wne con3d df-ne syl6ibr ) ABFCDGZFCDHALBEICDJK $.
  $}

  ${
    necon3d.1 $e |- ( ph -> ( A = B -> C = D ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by NM,
       10-Jun-2006.) $)
    necon3d $p |- ( ph -> ( C =/= D -> A =/= B ) ) $=
      ( wne wceq wn necon3ad df-ne syl6ibr ) ADEGBCHZIBCGAMDEFJBCKL $.
  $}

  ${
    necon3i.1 $e |- ( A = B -> C = D ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       9-Aug-2006.) $)
    necon3i $p |- ( C =/= D -> A =/= B ) $=
      ( wceq wi wne id necon3d ax-mp ) ABFCDFGZCDHABHGELABCDLIJK $.
  $}

  ${
    necon3ai.1 $e |- ( ph -> A = B ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       23-May-2007.)  (Proof rewritten by Jim Kingdon, 15-May-2018.) $)
    necon3ai $p |- ( A =/= B -> -. ph ) $=
      ( wne wceq wn df-ne con3i sylbi ) BCEBCFZGAGBCHAKDIJ $.
  $}

  ${
    necon3bi.1 $e |- ( A = B -> ph ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       1-Jun-2007.)  (Proof rewritten by Jim Kingdon, 15-May-2018.) $)
    necon3bi $p |- ( -. ph -> A =/= B ) $=
      ( wn wceq wne con3i df-ne sylibr ) AEBCFZEBCGKADHBCIJ $.
  $}

  ${
    necon1aidc.1 $e |- ( DECID ph -> ( -. ph -> A = B ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       15-May-2018.) $)
    necon1aidc $p |- ( DECID ph -> ( A =/= B -> ph ) ) $=
      ( wne wceq wn wdc df-ne wi con1dc mpd syl5bi ) BCEBC
      FZGZAHZABCIPAGNJOAJDANKLM $.
  $}

  ${
    necon1bidc.1 $e |- ( DECID A = B -> ( A =/= B -> ph ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       15-May-2018.) $)
    necon1bidc $p |- ( DECID A = B -> ( -. ph -> A = B ) ) $=
      ( wceq wdc wn wi wne df-ne syl5bir con1dc mpd ) BCEZ
      FZNGZAHAGNHPBCIOABCJDKNALM $.
  $}

  ${
    necon1idc.1 $e |- ( A =/= B -> C = D ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon1idc $p |- ( DECID A = B -> ( C =/= D -> A = B ) ) $=
      ( wceq wn wi wdc wne df-ne sylbir a1i necon1aidc ) ABFZCDOGZCDFZH
      OIPABJQABKELMN $.
  $}

  ${
    necon2ai.1 $e |- ( A = B -> -. ph ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       16-Jan-2007.)  (Proof rewritten by Jim Kingdon, 16-May-2018.) $)
    necon2ai $p |- ( ph -> A =/= B ) $=
      ( wceq wn wne con2i df-ne sylibr ) ABCEZFBCGKADHBCIJ $.
  $}

  ${
    necon2bi.1 $e |- ( ph -> A =/= B ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       1-Apr-2007.) $)
    necon2bi $p |- ( A = B -> -. ph ) $=
      ( wceq neneqd con2i ) ABCEABCDFG $.
  $}

  ${
    necon2i.1 $e |- ( A = B -> C =/= D ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       18-Mar-2007.) $)
    necon2i $p |- ( C = D -> A =/= B ) $=
      ( wceq neneqd necon2ai ) CDFABABFCDEGH $.
  $}

  ${
    necon2ad.1 $e |- ( ph -> ( A = B -> -. ps ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       19-Apr-2007.)  (Proof rewritten by Jim Kingdon, 16-May-2018.) $)
    necon2ad $p |- ( ph -> ( ps -> A =/= B ) ) $=
      ( wceq wn wne con2d df-ne syl6ibr ) ABCDFZGCDHALBEICDJK $.
  $}

  ${
    necon2bd.1 $e |- ( ph -> ( ps -> A =/= B ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       13-Apr-2007.) $)
    necon2bd $p |- ( ph -> ( A = B -> -. ps ) ) $=
      ( wceq wne wn df-ne syl6ib con2d ) ABCDFZABCDGLHECDIJK $.
  $}

  ${
    necon2d.1 $e |- ( ph -> ( A = B -> C =/= D ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by NM,
       28-Dec-2008.) $)
    necon2d $p |- ( ph -> ( C = D -> A =/= B ) ) $=
      ( wceq wne wn df-ne syl6ib necon2ad ) ADEGZBCABCGDEHMIFDEJKL $.
  $}

  ${
    necon1abiidc.1 $e |- ( DECID ph -> ( -. ph <-> A = B ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon1abiidc $p |- ( DECID ph -> ( A =/= B <-> ph ) ) $=
      ( wne wceq wn wdc df-ne con1biidc syl5bb ) B
      CEBCFZGAHABCIALDJK $.
  $}

  ${
    necon1bbiidc.1 $e |- ( DECID A = B -> ( A =/= B <-> ph ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon1bbiidc $p |- ( DECID A = B -> ( -. ph <-> A = B ) ) $=
      ( wceq wn wne wdc df-ne syl5bbr con1biidc ) BCEZAL
      FBCGLHABCIDJK $.
  $}

  ${
    necon1abiddc.1 $e |- ( ph -> ( DECID ps -> ( -. ps <-> A = B ) ) ) $.
    $( Contrapositive deduction for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon1abiddc $p |- ( ph -> ( DECID ps -> ( A =/= B <-> ps ) ) ) $=
      ( wdc wceq wn wne con1biddc df-ne bibi1i syl6ibr
      wb ) ABFCDGZHZBNCDIZBNABOEJQPBCDKLM $.
  $}

  ${
    necon1bbiddc.1 $e |- ( ph -> ( DECID A = B -> ( A =/= B <-> ps ) ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon1bbiddc $p |- ( ph -> ( DECID A = B -> ( -. ps <-> A = B ) ) ) $=
      ( wceq wdc wne wb wn df-ne bibi1i syl6ib con1biddc
      ) ACDFZBAOGCDHZBIOJZBIEPQBCDKLMN $.
  $}

  ${
    necon2abiidc.1 $e |- ( DECID ph -> ( A = B <-> -. ph ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon2abiidc $p |- ( DECID ph -> ( ph <-> A =/= B ) ) $=
      ( wdc wne wceq wn bicomd necon1abiidc ) AEZBCFAABCKBCGAHDIJI $.
  $}

  ${
    necon2bbii.1 $e |- ( DECID A = B -> ( ph <-> A =/= B ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon2bbii $p |- ( DECID A = B -> ( A = B <-> -. ph ) ) $=
      ( wceq wdc wn wne bicomd necon1bbiidc ) BCEZFZAGKABCLABCHDIJI $.
  $}

  ${
    necon2abiddc.1 $e |- ( ph -> ( DECID ps -> ( A = B <-> -. ps ) ) ) $.
    $( Contrapositive deduction for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon2abiddc $p |- ( ph -> ( DECID ps -> ( ps <-> A =/= B ) ) ) $=
      ( wdc wne wb wceq wn bicom syl6ib necon1abiddc ) ABFZCDGZBHBOHABCDANCDIZB
      JZHQPHEPQKLMOBKL $.
  $}

  ${
    necon2bbiddc.1 $e |- ( ph -> ( DECID A = B -> ( ps <-> A =/= B ) ) ) $.
    $( Contrapositive deduction for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon2bbiddc $p |- ( ph -> ( DECID A = B -> ( A = B <-> -. ps ) ) ) $=
      ( wceq wdc wn wb wne bicom syl6ib necon1bbiddc ) A
      CDFZGZBHZNINPIABCDAOBCDJZIQBIEBQKLMPNKL $.
  $}

  ${
    necon4aidc.1 $e |- ( DECID A = B -> ( A =/= B -> -. ph ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon4aidc $p |- ( DECID A = B -> ( ph -> A = B ) ) $=
      ( wceq wdc wn wi wne df-ne syl5bir condc mpd ) BCEZF
      ZNGZAGZHANHPBCIOQBCJDKNALM $.
  $}

  ${
    necon4idc.1 $e |- ( DECID A = B -> ( A =/= B -> C =/= D ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       16-May-2018.) $)
    necon4idc $p |- ( DECID A = B -> ( C = D -> A = B ) ) $=
      ( wceq wdc wne wn df-ne syl6ib necon4aidc ) CDFZABABF
      GABHCDHMIECDJKL $.
  $}

  ${
    necon4addc.1 $e |- ( ph -> ( DECID A = B -> ( A =/= B -> -. ps ) ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       17-May-2018.) $)
    necon4addc $p |- ( ph -> ( DECID A = B -> ( ps -> A = B ) ) ) $=
      ( wceq wdc wne wn df-ne imbi1i condc syl5bi sylcom
      wi ) ACDFZGZCDHZBIZOZBPOZETPIZSOQUARUBSCDJKPBLMN $.
  $}

  ${
    necon4bddc.1 $e |- ( ph -> ( DECID ps -> ( -. ps -> A =/= B ) ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       17-May-2018.) $)
    necon4bddc $p |- ( ph -> ( DECID ps -> ( A = B -> ps ) ) ) $=
      ( wdc wn wceq wi wne df-ne syl8ib condc sylcom ) ABF
      ZBGZCDHZGZIQBIAOPCDJRECDKLBQMN $.
  $}

  ${
    necon4ddc.1 $e |- ( ph -> ( DECID A = B -> ( A =/= B -> C =/= D ) ) ) $.
    $( Contrapositive inference for inequality.  (Contributed by Jim Kingdon,
       17-May-2018.) $)
    necon4ddc $p |- ( ph -> ( DECID A = B -> ( C = D -> A = B ) ) ) $=
      ( wceq wdc wn wne df-ne imbi12i syl6ib condc sylcom
     wi ) ABCGZHZQIZDEGZIZPZTQPARBCJZDEJZPUBFUCSUDUABCKDEKLMQTNO $.
  $}

  ${
    necon4abiddc.1 $e |- ( ph -> ( DECID A = B -> ( DECID ps ->
        ( A =/= B <-> -. ps ) ) ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by Jim
       Kingdon, 18-May-2018.) $)
    necon4abiddc $p |- ( ph -> ( DECID A = B -> ( DECID ps ->
        ( A = B <-> ps ) ) ) ) $=
      ( wceq wdc wne wn wb df-ne bibi1i syl8ib con4biddc
      ) ACDFZBAOGBGCDHZBIZJOIZQJEPRQCDKLMN $.
  $}

  ${
    necon4bbiddc.1 $e |- ( ph -> ( DECID ps -> ( DECID A = B ->
        ( -. ps <-> A =/= B ) ) ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by Jim
       Kingdon, 19-May-2018.) $)
    necon4bbiddc $p |- ( ph -> ( DECID ps -> ( DECID A = B ->
        ( ps <-> A = B ) ) ) ) $=
      ( wdc wceq wb wne wn bicom syl8ib com23 necon4abiddc ) ABFZCDGZ
      FZPBHZBPHAQORABCDAOQCDIZBJZHZAOQTSHUAETSKLMNMPBKL $.
  $}

  ${
    necon4biddc.1 $e |- ( ph -> ( DECID A = B -> ( DECID C = D ->
        ( A =/= B <-> C =/= D ) ) ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by Jim
       Kingdon, 19-May-2018.) $)
    necon4biddc $p |- ( ph -> ( DECID A = B -> ( DECID C = D ->
        ( A = B <-> C = D ) ) ) ) $=
      ( wceq wdc wne wb df-ne bibi2i syl8ib necon4abiddc
      wn ) ADEGZBCABCGHPHBCIZDEIZJQPOZJFRSQDEKLMN $.
  $}

  ${
    necon1addc.1 $e |- ( ph -> ( DECID ps -> ( -. ps -> A = B ) ) ) $.
    $( Contrapositive deduction for inequality.  (Contributed by Jim Kingdon,
       19-May-2018.) $)
    necon1addc $p |- ( ph -> ( DECID ps -> ( A =/= B -> ps ) ) ) $=
      ( wne wceq wn wdc df-ne wi con1dc sylcom syl7bi ) CD
      FCDGZHZABIZBCDJAQBHOKPBKEBOLMN $.
  $}

  ${
    necon1bddc.1 $e |- ( ph -> ( DECID A = B -> ( A =/= B -> ps ) ) ) $.
    $( Contrapositive deduction for inequality.  (Contributed by Jim Kingdon,
       19-May-2018.) $)
    necon1bddc $p |- ( ph -> ( DECID A = B -> ( -. ps -> A = B ) ) ) $=
      ( wceq wdc wn wne df-ne imbi1i syl6ib con1dc sylcom
      wi ) ACDFZGZPHZBOZBHPOAQCDIZBOSETRBCDJKLPBMN $.
  $}

  ${
    necon1ddc.1 $e |- ( ph -> ( DECID A = B -> ( A =/= B -> C = D ) ) ) $.
    $( Contrapositive law deduction for inequality.  (Contributed by Jim
       Kingdon, 19-May-2018.) $)
    necon1ddc $p |- ( ph -> ( DECID A = B -> ( C =/= D -> A = B ) ) ) $=
      ( wne wceq wn wdc df-ne necon1bddc syl7bi ) DEGDEHZIA
      BCHZJODEKANBCFLM $.
  $}

  ${
    neneqad.1 $e |- ( ph -> -. A = B ) $.
    $( If it is not the case that two classes are equal, they are unequal.
       Converse of ~ neneqd .  One-way deduction form of ~ df-ne .
       (Contributed by David Moews, 28-Feb-2017.) $)
    neneqad $p |- ( ph -> A =/= B ) $=
      ( wceq con2i necon2ai ) ABCABCEDFG $.
  $}

  $( Contraposition law for inequality.  (Contributed by Jim Kingdon,
     19-May-2018.) $)
  nebidc $p |- ( DECID A = B -> ( DECID C = D ->
      ( ( A = B <-> C = D ) <-> ( A =/= B <-> C =/= D ) ) ) ) $=
    ( wdc wb wne wa id necon3bid wi a1d necon4biddc com3l imp impbid2
    wceq ex ) ABQZEZCDQZEZSUAFZABGCDGFZFTUBHUCUDUCABCDUCIJTUBUDUCKUDT
    UBUCUDABCDUDUBUDKTUDUDUBUDILLMNOPR $.

  $( Theorem *13.18 in [WhiteheadRussell] p. 178.  (Contributed by Andrew
     Salmon, 3-Jun-2011.) $)
  pm13.18 $p |- ( ( A = B /\ A =/= C ) -> B =/= C ) $=
    ( wceq wne eqeq1 biimprd necon3d imp ) ABDZACEBCEJBCACJACDBCDABCFGHI $.

  $( Theorem *13.181 in [WhiteheadRussell] p. 178.  (Contributed by Andrew
     Salmon, 3-Jun-2011.) $)
  pm13.181 $p |- ( ( A = B /\ B =/= C ) -> A =/= C ) $=
    ( wceq wne eqcom pm13.18 sylanb ) ABDBADBCEACEABFBACGH $.

  ${
    pm2.21ddne.1 $e |- ( ph -> A = B ) $.
    pm2.21ddne.2 $e |- ( ph -> A =/= B ) $.
    $( A contradiction implies anything.  Equality/inequality deduction form.
       (Contributed by David Moews, 28-Feb-2017.) $)
    pm2.21ddne $p |- ( ph -> ps ) $=
      ( wceq neneqd pm2.21dd ) ACDGBEACDFHI $.
  $}

  $( Commutation of inequality.  (Contributed by NM, 14-May-1999.) $)
  necom $p |- ( A =/= B <-> B =/= A ) $=
    ( eqcom necon3bii ) ABBAABCD $.

  ${
    necomi.1 $e |- A =/= B $.
    $( Inference from commutative law for inequality.  (Contributed by NM,
       17-Oct-2012.) $)
    necomi $p |- B =/= A $=
      ( wne necom mpbi ) ABDBADCABEF $.
  $}

  ${
    necomd.1 $e |- ( ph -> A =/= B ) $.
    $( Deduction from commutative law for inequality.  (Contributed by NM,
       12-Feb-2008.) $)
    necomd $p |- ( ph -> B =/= A ) $=
      ( wne necom sylib ) ABCECBEDBCFG $.
  $}

  $( A De Morgan's law for inequality.  (Contributed by NM, 18-May-2007.) $)
  neanior $p |- ( ( A =/= B /\ C =/= D ) <-> -. ( A = B \/ C = D ) ) $=
    ( wne wa wceq wn wo df-ne anbi12i pm4.56 bitri ) ABEZCDEZFABGZHZCDGZHZFPRIH
    NQOSABJCDJKPRLM $.

  $( A De Morgan's law for inequality.  (Contributed by NM, 30-Sep-2013.)
     (Proof rewritten by Jim Kingdon, 19-May-2018.) $)
  ne3anior $p |- ( ( A =/= B /\ C =/= D /\ E =/= F )
        <-> -. ( A = B \/ C = D \/ E = F ) ) $=
    ( wne w3a wceq wn w3o df-ne 3anbi123i 3ioran bitr4i ) ABGZCDGZEFG
    ZHABIZJZCDIZJZEFIZJZHSUAUCKJPTQUBRUDABLCDLEFLMSUAUCNO $.

  ${
    nemtbir.1 $e |- A =/= B $.
    nemtbir.2 $e |- ( ph <-> A = B ) $.
    $( An inference from an inequality, related to modus tollens.  (Contributed
       by NM, 13-Apr-2007.) $)
    nemtbir $p |- -. ph $=
      ( wceq wne wn df-ne mpbi mtbir ) ABCFZBCGLHDBCIJEK $.
  $}

  $( Two classes are different if they don't contain the same element.
     (Contributed by NM, 3-Feb-2012.) $)
  nelne1 $p |- ( ( A e. B /\ -. A e. C ) -> B =/= C ) $=
    ( wcel wn wne wceq eleq2 biimpcd necon3bd imp ) ABDZACDZEBCFLMBCBCGLMBCAHIJ
    K $.

  $( Two classes are different if they don't belong to the same class.
     (Contributed by NM, 25-Jun-2012.) $)
  nelne2 $p |- ( ( A e. C /\ -. B e. C ) -> A =/= B ) $=
    ( wcel wn wne wceq eleq1 biimpcd necon3bd imp ) ACDZBCDZEABFLMABABGLMABCHIJ
    K $.

  ${
    $d y A $.  $d y B $.
    nfne.1 $e |- F/_ x A $.
    nfne.2 $e |- F/_ x B $.
    $( Bound-variable hypothesis builder for inequality.  (Contributed by NM,
       10-Nov-2007.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
    nfne $p |- F/ x A =/= B $=
      ( wne wceq wn df-ne nfeq nfn nfxfr ) BCFBCGZHABCIMAABCDEJKL $.
  $}

  ${
    $d y A $.  $d y B $.
    nfned.1 $e |- ( ph -> F/_ x A ) $.
    nfned.2 $e |- ( ph -> F/_ x B ) $.
    $( Bound-variable hypothesis builder for inequality.  (Contributed by NM,
       10-Nov-2007.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
    nfned $p |- ( ph -> F/ x A =/= B ) $=
      ( wne wceq wn df-ne nfeqd nfnd nfxfrd ) CDGCDHZIABCDJANBABCDEFKLM $.
  $}

$(
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
        Negated membership
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
$)

  $( Equality theorem for negated membership.  (Contributed by NM,
     20-Nov-1994.) $)
  neleq1 $p |- ( A = B -> ( A e/ C <-> B e/ C ) ) $=
    ( wceq wcel wn wnel eleq1 notbid df-nel 3bitr4g ) ABDZACEZFBCEZFACGBCGLMNAB
    CHIACJBCJK $.

  $( Equality theorem for negated membership.  (Contributed by NM,
     20-Nov-1994.) $)
  neleq2 $p |- ( A = B -> ( C e/ A <-> C e/ B ) ) $=
    ( wceq wcel wn wnel eleq2 notbid df-nel 3bitr4g ) ABDZCAEZFCBEZFCAGCBGLMNAB
    CHICAJCBJK $.

  ${
    neleq12d.1 $e |- ( ph -> A = B ) $.
    neleq12d.2 $e |- ( ph -> C = D ) $.
    $( Equality theorem for negated membership.  (Contributed by FL,
       10-Aug-2016.) $)
    neleq12d $p |- ( ph -> ( A e/ C <-> B e/ D ) ) $=
      ( wnel wceq wb neleq1 syl neleq2 bitrd ) ABDHZCDHZCEHZABCIOPJFBCDKLADEIPQ
      JGDECMLN $.
  $}

  ${
    $d y A $.  $d z B $.
    nfnel.1 $e |- F/_ x A $.
    nfnel.2 $e |- F/_ x B $.
    $( Bound-variable hypothesis builder for negated membership.  (Contributed
       by David Abernethy, 26-Jun-2011.)  (Revised by Mario Carneiro,
       7-Oct-2016.) $)
    nfnel $p |- F/ x A e/ B $=
      ( wnel wcel wn df-nel nfel nfn nfxfr ) BCFBCGZHABCIMAABCDEJKL $.
  $}

  ${
    $d y A $.  $d z B $.
    nfneld.1 $e |- ( ph -> F/_ x A ) $.
    nfneld.2 $e |- ( ph -> F/_ x B ) $.
    $( Bound-variable hypothesis builder for negated membership.  (Contributed
       by David Abernethy, 26-Jun-2011.)  (Revised by Mario Carneiro,
       7-Oct-2016.) $)
    nfneld $p |- ( ph -> F/ x A e/ B ) $=
      ( wnel wcel wn df-nel nfeld nfnd nfxfrd ) CDGCDHZIABCDJANBABCDEFKLM $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Restricted quantification
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Extend wff notation to include restricted universal quantification. $)
  wral $a wff A. x e. A ph $.

  $( Extend wff notation to include restricted existential quantification. $)
  wrex $a wff E. x e. A ph $.

  $( Extend wff notation to include restricted existential uniqueness. $)
  wreu $a wff E! x e. A ph $.

  $( Extend wff notation to include restricted "at most one." $)
  wrmo $a wff E* x e. A ph $.

  $( Extend class notation to include the restricted class abstraction (class
     builder). $)
  crab $a class { x e. A | ph } $.

  $( Define restricted universal quantification.  Special case of Definition
     4.15(3) of [TakeutiZaring] p. 22.  (Contributed by NM, 19-Aug-1993.) $)
  df-ral $a |- ( A. x e. A ph <-> A. x ( x e. A -> ph ) ) $.

  $( Define restricted existential quantification.  Special case of Definition
     4.15(4) of [TakeutiZaring] p. 22.  (Contributed by NM, 30-Aug-1993.) $)
  df-rex $a |- ( E. x e. A ph <-> E. x ( x e. A /\ ph ) ) $.

  $( Define restricted existential uniqueness.  (Contributed by NM,
     22-Nov-1994.) $)
  df-reu $a |- ( E! x e. A ph <-> E! x ( x e. A /\ ph ) ) $.

  $( Define restricted "at most one".  (Contributed by NM, 16-Jun-2017.) $)
  df-rmo $a |- ( E* x e. A ph <-> E* x ( x e. A /\ ph ) ) $.

  $( Define a restricted class abstraction (class builder), which is the class
     of all ` x ` in ` A ` such that ` ph ` is true.  Definition of
     [TakeutiZaring] p. 20.  (Contributed by NM, 22-Nov-1994.) $)
  df-rab $a |- { x e. A | ph } = { x | ( x e. A /\ ph ) } $.

  $( Relationship between restricted universal and existential quantifiers.
     (Contributed by NM, 21-Jan-1997.) $)
  ralnex $p |- ( A. x e. A -. ph <-> -. E. x e. A ph ) $=
    ( wn wral cv wcel wi wal wrex df-ral wa wex alinexa df-rex xchbinxr bitri )
    ADZBCEBFCGZRHBIZABCJZDRBCKTSALBMUASABNABCOPQ $.

  ${
    ralbida.1 $e |- F/ x ph $.
    ralbida.2 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifier (deduction
       rule).  (Contributed by NM, 6-Oct-2003.) $)
    ralbida $p |- ( ph -> ( A. x e. A ps <-> A. x e. A ch ) ) $=
      ( cv wcel wi wal wral pm5.74da albid df-ral 3bitr4g ) ADHEIZBJZDKQCJZDKBD
      ELCDELARSDFAQBCGMNBDEOCDEOP $.

    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 6-Oct-2003.) $)
    rexbida $p |- ( ph -> ( E. x e. A ps <-> E. x e. A ch ) ) $=
      ( cv wcel wa wex wrex pm5.32da exbid df-rex 3bitr4g ) ADHEIZBJZDKQCJZDKBD
      ELCDELARSDFAQBCGMNBDEOCDEOP $.
  $}

  ${
    $d x ph $.
    ralbidva.1 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifier (deduction
       rule).  (Contributed by NM, 4-Mar-1997.) $)
    ralbidva $p |- ( ph -> ( A. x e. A ps <-> A. x e. A ch ) ) $=
      ( nfv ralbida ) ABCDEADGFH $.

    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 9-Mar-1997.) $)
    rexbidva $p |- ( ph -> ( E. x e. A ps <-> E. x e. A ch ) ) $=
      ( nfv rexbida ) ABCDEADGFH $.
  $}

  ${
    ralbid.1 $e |- F/ x ph $.
    ralbid.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifier (deduction
       rule).  (Contributed by NM, 27-Jun-1998.) $)
    ralbid $p |- ( ph -> ( A. x e. A ps <-> A. x e. A ch ) ) $=
      ( wb cv wcel adantr ralbida ) ABCDEFABCHDIEJGKL $.

    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 27-Jun-1998.) $)
    rexbid $p |- ( ph -> ( E. x e. A ps <-> E. x e. A ch ) ) $=
      ( wb cv wcel adantr rexbida ) ABCDEFABCHDIEJGKL $.
  $}

  ${
    $d x ph $.
    ralbidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifier (deduction
       rule).  (Contributed by NM, 20-Nov-1994.) $)
    ralbidv $p |- ( ph -> ( A. x e. A ps <-> A. x e. A ch ) ) $=
      ( nfv ralbid ) ABCDEADGFH $.

    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 20-Nov-1994.) $)
    rexbidv $p |- ( ph -> ( E. x e. A ps <-> E. x e. A ch ) ) $=
      ( nfv rexbid ) ABCDEADGFH $.
  $}

  ${
    $d x ph $.
    ralbidv2.1 $e |- ( ph -> ( ( x e. A -> ps ) <-> ( x e. B -> ch ) ) ) $.
    $( Formula-building rule for restricted universal quantifier (deduction
       rule).  (Contributed by NM, 6-Apr-1997.) $)
    ralbidv2 $p |- ( ph -> ( A. x e. A ps <-> A. x e. B ch ) ) $=
      ( cv wcel wi wal wral albidv df-ral 3bitr4g ) ADHZEIBJZDKPFICJZDKBDELCDFL
      AQRDGMBDENCDFNO $.
  $}

  ${
    $d x ph $.
    rexbidv2.1 $e |- ( ph -> ( ( x e. A /\ ps ) <-> ( x e. B /\ ch ) ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 22-May-1999.) $)
    rexbidv2 $p |- ( ph -> ( E. x e. A ps <-> E. x e. B ch ) ) $=
      ( cv wcel wa wex wrex exbidv df-rex 3bitr4g ) ADHZEIBJZDKPFICJZDKBDELCDFL
      AQRDGMBDENCDFNO $.
  $}

  ${
    ralbii.1 $e |- ( ph <-> ps ) $.
    $( Inference adding restricted universal quantifier to both sides of an
       equivalence.  (Contributed by NM, 23-Nov-1994.)  (Revised by Mario
       Carneiro, 17-Oct-2016.) $)
    ralbii $p |- ( A. x e. A ph <-> A. x e. A ps ) $=
      ( wral wb wtru a1i ralbidv trud ) ACDFBCDFGHABCDABGHEIJK $.

    $( Inference adding restricted existential quantifier to both sides of an
       equivalence.  (Contributed by NM, 23-Nov-1994.)  (Revised by Mario
       Carneiro, 17-Oct-2016.) $)
    rexbii $p |- ( E. x e. A ph <-> E. x e. A ps ) $=
      ( wrex wb wtru a1i rexbidv trud ) ACDFBCDFGHABCDABGHEIJK $.

    $( Inference adding two restricted universal quantifiers to both sides of
       an equivalence.  (Contributed by NM, 1-Aug-2004.) $)
    2ralbii $p |- ( A. x e. A A. y e. B ph <-> A. x e. A A. y e. B ps ) $=
      ( wral ralbii ) ADFHBDFHCEABDFGII $.

    $( Inference adding two restricted existential quantifiers to both sides of
       an equivalence.  (Contributed by NM, 11-Nov-1995.) $)
    2rexbii $p |- ( E. x e. A E. y e. B ph <-> E. x e. A E. y e. B ps ) $=
      ( wrex rexbii ) ADFHBDFHCEABDFGII $.
  $}

  ${
    ralbii2.1 $e |- ( ( x e. A -> ph ) <-> ( x e. B -> ps ) ) $.
    $( Inference adding different restricted universal quantifiers to each side
       of an equivalence.  (Contributed by NM, 15-Aug-2005.) $)
    ralbii2 $p |- ( A. x e. A ph <-> A. x e. B ps ) $=
      ( cv wcel wi wal wral albii df-ral 3bitr4i ) CGZDHAIZCJOEHBIZCJACDKBCEKPQ
      CFLACDMBCEMN $.
  $}

  ${
    rexbii2.1 $e |- ( ( x e. A /\ ph ) <-> ( x e. B /\ ps ) ) $.
    $( Inference adding different restricted existential quantifiers to each
       side of an equivalence.  (Contributed by NM, 4-Feb-2004.) $)
    rexbii2 $p |- ( E. x e. A ph <-> E. x e. B ps ) $=
      ( cv wcel wa wex wrex exbii df-rex 3bitr4i ) CGZDHAIZCJOEHBIZCJACDKBCEKPQ
      CFLACDMBCEMN $.
  $}

  ${
    raleqbii.1 $e |- A = B $.
    raleqbii.2 $e |- ( ps <-> ch ) $.
    $( Equality deduction for restricted universal quantifier, changing both
       formula and quantifier domain.  Inference form.  (Contributed by David
       Moews, 1-May-2017.) $)
    raleqbii $p |- ( A. x e. A ps <-> A. x e. B ch ) $=
      ( cv wcel eleq2i imbi12i ralbii2 ) ABCDECHZDIMEIABDEMFJGKL $.

    $( Equality deduction for restricted existential quantifier, changing both
       formula and quantifier domain.  Inference form.  (Contributed by David
       Moews, 1-May-2017.) $)
    rexeqbii $p |- ( E. x e. A ps <-> E. x e. B ch ) $=
      ( cv wcel eleq2i anbi12i rexbii2 ) ABCDECHZDIMEIABDEMFJGKL $.
  $}

  ${
    ralbiia.1 $e |- ( x e. A -> ( ph <-> ps ) ) $.
    $( Inference adding restricted universal quantifier to both sides of an
       equivalence.  (Contributed by NM, 26-Nov-2000.) $)
    ralbiia $p |- ( A. x e. A ph <-> A. x e. A ps ) $=
      ( cv wcel pm5.74i ralbii2 ) ABCDDCFDGABEHI $.

    $( Inference adding restricted existential quantifier to both sides of an
       equivalence.  (Contributed by NM, 26-Oct-1999.) $)
    rexbiia $p |- ( E. x e. A ph <-> E. x e. A ps ) $=
      ( cv wcel pm5.32i rexbii2 ) ABCDDCFDGABEHI $.
  $}

  ${
    $d x y $.  $d y A $.
    2rexbiia.1 $e |- ( ( x e. A /\ y e. B ) -> ( ph <-> ps ) ) $.
    $( Inference adding two restricted existential quantifiers to both sides of
       an equivalence.  (Contributed by NM, 1-Aug-2004.) $)
    2rexbiia $p |- ( E. x e. A E. y e. B ph <-> E. x e. A E. y e. B ps ) $=
      ( wrex cv wcel rexbidva rexbiia ) ADFHBDFHCECIEJABDFGKL $.
  $}

  ${
    $d x y $.
    r2alf.1 $e |- F/_ y A $.
    $( Double restricted universal quantification.  (Contributed by Mario
       Carneiro, 14-Oct-2016.) $)
    r2alf $p |- ( A. x e. A A. y e. B ph <->
               A. x A. y ( ( x e. A /\ y e. B ) -> ph ) ) $=
      ( wral cv wi wal wa df-ral nfcri 19.21 impexp albii imbi2i 3bitr4i bitr4i
      wcel ) ACEGZBDGBHDTZUAIZBJUBCHETZKAIZCJZBJUABDLUFUCBUBUDAIZIZCJUBUGCJZIUF
      UCUBUGCCBDFMNUEUHCUBUDAOPUAUIUBACELQRPS $.

    $( Double restricted existential quantification.  (Contributed by Mario
       Carneiro, 14-Oct-2016.) $)
    r2exf $p |- ( E. x e. A E. y e. B ph <->
               E. x E. y ( ( x e. A /\ y e. B ) /\ ph ) ) $=
      ( wrex cv wcel wex df-rex nfcri 19.42 anass exbii anbi2i 3bitr4i bitr4i
      wa ) ACEGZBDGBHDIZTSZBJUACHEIZSASZCJZBJTBDKUEUBBUAUCASZSZCJUAUFCJZSUEUBUA
      UFCCBDFLMUDUGCUAUCANOTUHUAACEKPQOR $.
  $}

  ${
    $d x y $.  $d y A $.
    $( Double restricted universal quantification.  (Contributed by NM,
       19-Nov-1995.) $)
    r2al $p |- ( A. x e. A A. y e. B ph <->
               A. x A. y ( ( x e. A /\ y e. B ) -> ph ) ) $=
      ( nfcv r2alf ) ABCDECDFG $.

    $( Double restricted existential quantification.  (Contributed by NM,
       11-Nov-1995.) $)
    r2ex $p |- ( E. x e. A E. y e. B ph <->
               E. x E. y ( ( x e. A /\ y e. B ) /\ ph ) ) $=
      ( nfcv r2exf ) ABCDECDFG $.
  $}

  ${
    $d x y $.  $d y A $.
    2ralbida.1 $e |- F/ x ph $.
    2ralbida.2 $e |- F/ y ph $.
    2ralbida.3 $e |- ( ( ph /\ ( x e. A /\ y e. B ) ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifier (deduction
       rule).  (Contributed by NM, 24-Feb-2004.) $)
    2ralbida $p |- ( ph ->
                     ( A. x e. A A. y e. B ps <-> A. x e. A A. y e. B ch ) ) $=
      ( wral cv wcel wa nfv nfan wb anassrs ralbida ) ABEGKCEGKDFHADLFMZNBCEGAT
      EITEOPATELGMBCQJRSS $.
  $}

  ${
    $d x y ph $.  $d y A $.
    2ralbidva.1 $e |- ( ( ph /\ ( x e. A /\ y e. B ) ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifiers (deduction
       rule).  (Contributed by NM, 4-Mar-1997.) $)
    2ralbidva $p |- ( ph ->
                     ( A. x e. A A. y e. B ps <-> A. x e. A A. y e. B ch ) ) $=
      ( nfv 2ralbida ) ABCDEFGADIAEIHJ $.

    $( Formula-building rule for restricted existential quantifiers (deduction
       rule).  (Contributed by NM, 15-Dec-2004.) $)
    2rexbidva $p |- ( ph ->
                    ( E. x e. A E. y e. B ps <-> E. x e. A E. y e. B ch ) ) $=
      ( wrex cv wcel wa wb anassrs rexbidva ) ABEGICEGIDFADJFKZLBCEGAPEJGKBCMHN
      OO $.
  $}

  ${
    $d x ph $.  $d y ph $.
    2ralbidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted universal quantifiers (deduction
       rule).  (Contributed by NM, 28-Jan-2006.)  (Revised by Szymon
       Jaroszewicz, 16-Mar-2007.) $)
    2ralbidv $p |- ( ph ->
                     ( A. x e. A A. y e. B ps <-> A. x e. A A. y e. B ch ) ) $=
      ( wral ralbidv ) ABEGICEGIDFABCEGHJJ $.

    $( Formula-building rule for restricted existential quantifiers (deduction
       rule).  (Contributed by NM, 28-Jan-2006.) $)
    2rexbidv $p |- ( ph ->
                    ( E. x e. A E. y e. B ps <-> E. x e. A E. y e. B ch ) ) $=
      ( wrex rexbidv ) ABEGICEGIDFABCEGHJJ $.

    $( Formula-building rule for restricted quantifiers (deduction rule).
       (Contributed by NM, 28-Jan-2006.) $)
    rexralbidv $p |- ( ph ->
                    ( E. x e. A A. y e. B ps <-> E. x e. A A. y e. B ch ) ) $=
      ( wral ralbidv rexbidv ) ABEGICEGIDFABCEGHJK $.
  $}

  $( A transformation of restricted quantifiers and logical connectives.
     (Contributed by NM, 4-Sep-2005.) $)
  ralinexa $p |- ( A. x e. A ( ph -> -. ps ) <-> -. E. x e. A ( ph /\ ps ) ) $=
    ( wn wi wral wa wrex imnan ralbii ralnex bitri ) ABEFZCDGABHZEZCDGOCDIENPCD
    ABJKOCDLM $.

  ${
    $d x A $.  $d x B $.
    $( Two ways to say " ` A ` belongs to ` B ` ."  (Contributed by NM,
       22-Nov-1994.) $)
    risset $p |- ( A e. B <-> E. x e. B x = A ) $=
      ( cv wcel wceq wa wex wrex exancom df-rex df-clel 3bitr4ri ) ADZCEZNBFZGA
      HPOGAHPACIBCEOPAJPACKABCLM $.
  $}

  ${
    hbral.1 $e |- ( y e. A -> A. x y e. A ) $.
    hbral.2 $e |- ( ph -> A. x ph ) $.
    $( Bound-variable hypothesis builder for restricted quantification.
       (Contributed by NM, 1-Sep-1999.)  (Revised by David Abernethy,
       13-Dec-2009.) $)
    hbral $p |- ( A. y e. A ph -> A. x A. y e. A ph ) $=
      ( wral cv wcel wi wal df-ral hbim hbal hbxfrbi ) ACDGCHDIZAJZCKBACDLQBCPA
      BEFMNO $.
  $}

  $( ` x ` is not free in ` A. x e. A ph ` .  (Contributed by NM,
     18-Oct-1996.) $)
  hbra1 $p |- ( A. x e. A ph -> A. x A. x e. A ph ) $=
    ( wral cv wcel wi wal df-ral hba1 hbxfrbi ) ABCDBECFAGZBHBABCILBJK $.

  $( ` x ` is not free in ` A. x e. A ph ` .  (Contributed by NM,
     18-Oct-1996.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
  nfra1 $p |- F/ x A. x e. A ph $=
    ( wral cv wcel wi wal df-ral nfa1 nfxfr ) ABCDBECFAGZBHBABCILBJK $.

  ${
    $d x y $.
    nfraldxy.2 $e |- F/ y ph $.
    nfraldxy.3 $e |- ( ph -> F/_ x A ) $.
    nfraldxy.4 $e |- ( ph -> F/ x ps ) $.
    $( Not-free for restricted universal quantification where ` x ` and ` y `
       are distinct.  See ~ nfraldya for a version with ` y ` and ` A `
       distinct instead.  (Contributed by Jim Kingdon, 29-May-2018.) $)
    nfraldxy $p |- ( ph -> F/ x A. y e. A ps ) $=
      ( wral cv wcel wal df-ral wnfc nfcv
      wi a1i nfeld nfimd nfald nfxfrd ) BDEIDJZEKZBPZDLACBDEMAUDCDFAUCB
      CACUBECUBNACUBOQGRHSTUA $.

    $( Not-free for restricted existential quantification where ` x ` and ` y `
       are distinct.  See ~ nfrexdya for a version with ` y ` and ` A `
       distinct instead.  (Contributed by Jim Kingdon, 30-May-2018.) $)
    nfrexdxy $p |- ( ph -> F/ x E. y e. A ps ) $=
      ( wrex cv wcel wa wex df-rex wnfc nfcv a1i nfeld nfand nfexd
      nfxfrd ) BDEIDJZEKZBLZDMACBDENAUDCDFAUCBCACUBECUBOACUBPQGRHSTUA
      $.
  $}

  ${
    $d y A $.  $d x z $.  $d y z $.  $d A z $.  $d ph z $.  $d ps z $.
    nfraldya.2 $e |- F/ y ph $.
    nfraldya.3 $e |- ( ph -> F/_ x A ) $.
    nfraldya.4 $e |- ( ph -> F/ x ps ) $.
    $( Not-free for restricted universal quantification where ` y ` and ` A `
       are distinct.  See ~ nfraldxy for a version with ` x ` and ` y `
       distinct instead.  (Contributed by Jim Kingdon, 30-May-2018.) $)
    nfraldya $p |- ( ph -> F/ x A. y e. A ps ) $=
      ( vz wral cv wcel wi wal df-ral wsbc wnf nfv nfsbd bitri imbi1i
      nfraldxy sb8 sbim clelsb3 albii bitr4i nfbii sylibr nfxfrd ) BDE
      JDKELZBMZDNZACBDEOABDIKZPZIEJZCQUMCQAUOCIEAIRGABDICFHSUBUMUPCUM
      ULDUNPZINZUPULDIULIRUCURUNELZUOMZINUPUQUTIUQUKDUNPZUOMUTUKBDIUD
      VAUSUOIDEUEUATUFUOIEOUGTUHUIUJ $.

    $( Not-free for restricted existential quantification where ` y ` and ` A `
       are distinct.  See ~ nfrexdxy for a version with ` x ` and ` y `
       distinct instead.  (Contributed by Jim Kingdon, 30-May-2018.) $)
    nfrexdya $p |- ( ph -> F/ x E. y e. A ps ) $=
      ( vz wrex cv wcel wa wex df-rex wsbc wnf nfv nfsbd bitri nfrexdxy
      sb8e sban clelsb3 anbi1i exbii bitr4i nfbii sylibr nfxfrd ) BDEJD
      KELZBMZDNZACBDEOABDIKZPZIEJZCQUMCQAUOCIEAIRGABDICFHSUAUMUPCUMULDU
      NPZINZUPULDIULIRUBURUNELZUOMZINUPUQUTIUQUKDUNPZUOMUTUKBDIUCVAUSUO
      IDEUDUETUFUOIEOUGTUHUIUJ $.
  $}

  ${
    $d x y $.
    nfralxy.1 $e |- F/_ x A $.
    nfralxy.2 $e |- F/ x ph $.
    $( Not-free for restricted universal quantification where ` x ` and ` y `
       are distinct.  See ~ nfralya for a version with ` y ` and ` A ` distinct
       instead.  (Contributed by Jim Kingdon, 30-May-2018.) $)
    nfralxy $p |- F/ x A. y e. A ph $=
      ( wral wnf wtru nftru wnfc a1i nfraldxy trud ) ACDGBHIABCDCJBDKIELABHIFLMN
      $.

    $( Not-free for restricted existential quantification where ` x ` and ` y `
       are distinct.  See ~ nfrexya for a version with ` y ` and ` A ` distinct
       instead.  (Contributed by Jim Kingdon, 30-May-2018.) $)
    nfrexxy $p |- F/ x E. y e. A ph $=
      ( wrex wnf wtru nftru wnfc a1i nfrexdxy trud ) ACDGBHIABCDCJBDKIELABHIFLMN
      $.
  $}

  ${
    $d y A $.
    nfralya.1 $e |- F/_ x A $.
    nfralya.2 $e |- F/ x ph $.
    $( Not-free for restricted universal quantification where ` y ` and ` A `
       are distinct.  See ~ nfralxy for a version with ` x ` and ` y ` distinct
       instead.  (Contributed by Jim Kingdon, 3-Jun-2018.) $)
    nfralya $p |- F/ x A. y e. A ph $=
      ( wral wnf wtru nftru wnfc a1i nfraldya trud ) ACDGBHIABCDCJBDK
      IELABHIFLMN $.

    $( Not-free for restricted existential quantification where ` y ` and ` A `
       are distinct.  See ~ nfrexxy for a version with ` x ` and ` y ` distinct
       instead.  (Contributed by Jim Kingdon, 3-Jun-2018.) $)
    nfrexya $p |- F/ x E. y e. A ph $=
      ( wrex wnf wtru nftru wnfc a1i nfrexdya trud ) ACDGBHIABCDCJBDK
      IELABHIFLMN $.
  $}

  $( ` x ` is not free in ` E. x e. A ph ` .  (Contributed by NM,
     19-Mar-1997.)  (Revised by Mario Carneiro, 7-Oct-2016.) $)
  nfre1 $p |- F/ x E. x e. A ph $=
    ( wrex cv wcel wa wex df-rex nfe1 nfxfr ) ABCDBECFAGZBHBABCILBJK $.

  ${
    $d x y z $.  $d y z A $.  $d z B $.
    $( Triple restricted universal quantification.  (Contributed by NM,
       19-Nov-1995.) $)
    r3al $p |- ( A. x e. A A. y e. B A. z e. C ph <->
               A. x A. y A. z ( ( x e. A /\ y e. B /\ z e. C ) -> ph ) ) $=
      ( cv wcel wa wi wal wral w3a df-ral r2al ralbii bitri albii 19.21v 3anass
      imbi1i impexp 3bitr4i ) CHFIZDHGIZJZAKZDLZCLZBEMBHEIZUJKZBLADGMCFMZBEMUKU
      EUFNZAKZDLZCLZBLUJBEOUMUJBEACDFGPQUQULBUQUKUIKZCLULUPURCUPUKUHKZDLURUOUSD
      UOUKUGJZAKUSUNUTAUKUEUFUAUBUKUGAUCRSUKUHDTRSUKUICTRSUD $.
  $}

  $( Universal quantification implies restricted quantification.  (Contributed
     by NM, 20-Oct-2006.) $)
  alral $p |- ( A. x ph -> A. x e. A ph ) $=
    ( wal cv wcel wi wral ax-1 alimi df-ral sylibr ) ABDBECFZAGZBDABCHANBAMIJAB
    CKL $.

  $( Restricted existence implies existence.  (Contributed by NM,
     11-Nov-1995.) $)
  rexex $p |- ( E. x e. A ph -> E. x ph ) $=
    ( wrex cv wcel wa wex df-rex simpr eximi sylbi ) ABCDBECFZAGZBHABHABCINABMA
    JKL $.

  $( Restricted specialization.  (Contributed by NM, 17-Oct-1996.) $)
  rsp $p |- ( A. x e. A ph -> ( x e. A -> ph ) ) $=
    ( wral cv wcel wi wal df-ral sp sylbi ) ABCDBECFAGZBHLABCILBJK $.

  $( Restricted specialization.  (Contributed by NM, 12-Oct-1999.) $)
  rspe $p |- ( ( x e. A /\ ph ) -> E. x e. A ph ) $=
    ( cv wcel wa wex wrex 19.8a df-rex sylibr ) BDCEAFZLBGABCHLBIABCJK $.

  $( Restricted specialization.  (Contributed by NM, 11-Feb-1997.) $)
  rsp2 $p |- ( A. x e. A A. y e. B ph -> ( ( x e. A /\ y e. B ) -> ph ) ) $=
    ( wral cv wcel wi rsp syl6 imp3a ) ACEFZBDFZBGDHZCGEHZANOMPAIMBDJACEJKL $.

  $( Restricted specialization.  (Contributed by FL, 4-Jun-2012.) $)
  rsp2e $p |- ( ( x e. A /\ y e. B /\ ph ) -> E. x e. A E. y e. B ph ) $=
    ( cv wcel w3a wrex wa wex simp1 rspe 3adant1 19.8a syl2anc df-rex sylibr )
    BFDGZCFEGZAHZSACEIZJZBKZUBBDIUASUBUDSTALTAUBSACEMNUCBOPUBBDQR $.

  ${
    rspec.1 $e |- A. x e. A ph $.
    $( Specialization rule for restricted quantification.  (Contributed by NM,
       19-Nov-1994.) $)
    rspec $p |- ( x e. A -> ph ) $=
      ( wral cv wcel wi rsp ax-mp ) ABCEBFCGAHDABCIJ $.
  $}

  ${
    rgen.1 $e |- ( x e. A -> ph ) $.
    $( Generalization rule for restricted quantification.  (Contributed by NM,
       19-Nov-1994.) $)
    rgen $p |- A. x e. A ph $=
      ( wral cv wcel wi df-ral mpgbir ) ABCEBFCGAHBABCIDJ $.
  $}

  ${
    $d y z A $.  $d x z $.
    rgen2a.1 $e |- ( ( x e. A /\ y e. A ) -> ph ) $.
    $( Generalization rule for restricted quantification.  Note that ` x ` and
       ` y ` needn't be distinct (and illustrates the use of ~ dvelimor ).
       (Contributed by NM, 23-Nov-1994.)  (Proof rewritten by Jim Kingdon,
       1-Jun-2018.) $)
    rgen2a $p |- A. x e. A A. y e. A ph $=
      ( vz wral cv wcel wi wal wnf wo nfv eleq1 dvelimor syl6bi alimi
      wceq ex pm2.43d a1d nfr syl6 jaoi ax-mp df-ral sylibr rgen ) AC
      DGZBDBHZDIZCHZDIZAJZCKZUJUMUKSZCKZULCLZMULUPJZFHZDIZULCBFVBCNVA
      UKDOPURUTUSURUPULUQUOCUQUNAUQUNULUOUMUKDOULUNAETZQUARUBUSULULCK
      UPULCUCULUOCVCRUDUEUFACDUGUHUI $.
  $}

  ${
    rgenw.1 $e |- ph $.
    $( Generalization rule for restricted quantification.  (Contributed by NM,
       18-Jun-2014.) $)
    rgenw $p |- A. x e. A ph $=
      ( cv wcel a1i rgen ) ABCABECFDGH $.

    $( Generalization rule for restricted quantification.  Note that ` x ` and
       ` y ` needn't be distinct.  (Contributed by NM, 18-Jun-2014.) $)
    rgen2w $p |- A. x e. A A. y e. B ph $=
      ( wral rgenw ) ACEGBDACEFHH $.
  $}

  ${
    mprg.1 $e |- ( A. x e. A ph -> ps ) $.
    mprg.2 $e |- ( x e. A -> ph ) $.
    $( Modus ponens combined with restricted generalization.  (Contributed by
       NM, 10-Aug-2004.) $)
    mprg $p |- ps $=
      ( wral rgen ax-mp ) ACDGBACDFHEI $.
  $}

  ${
    mprgbir.1 $e |- ( ph <-> A. x e. A ps ) $.
    mprgbir.2 $e |- ( x e. A -> ps ) $.
    $( Modus ponens on biconditional combined with restricted generalization.
       (Contributed by NM, 21-Mar-2004.) $)
    mprgbir $p |- ph $=
      ( wral rgen mpbir ) ABCDGBCDFHEI $.
  $}

  $( Distribution of restricted quantification over implication.  (Contributed
     by NM, 9-Feb-1997.) $)
  ralim $p |- ( A. x e. A ( ph -> ps ) ->
               ( A. x e. A ph -> A. x e. A ps ) ) $=
    ( wi wral cv wcel wal df-ral ax-2 al2imi sylbi 3imtr4g ) ABEZCDFZCGDHZAEZCI
    ZQBEZCIZACDFBCDFPQOEZCISUAEOCDJUBRTCQABKLMACDJBCDJN $.

  ${
    ralimi2.1 $e |- ( ( x e. A -> ph ) -> ( x e. B -> ps ) ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 22-Feb-2004.) $)
    ralimi2 $p |- ( A. x e. A ph -> A. x e. B ps ) $=
      ( cv wcel wi wal wral alimi df-ral 3imtr4i ) CGZDHAIZCJOEHBIZCJACDKBCEKPQ
      CFLACDMBCEMN $.
  $}

  ${
    ralimia.1 $e |- ( x e. A -> ( ph -> ps ) ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 19-Jul-1996.) $)
    ralimia $p |- ( A. x e. A ph -> A. x e. A ps ) $=
      ( cv wcel a2i ralimi2 ) ABCDDCFDGABEHI $.
  $}

  ${
    ralimiaa.1 $e |- ( ( x e. A /\ ph ) -> ps ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 4-Aug-2007.) $)
    ralimiaa $p |- ( A. x e. A ph -> A. x e. A ps ) $=
      ( cv wcel ex ralimia ) ABCDCFDGABEHI $.
  $}

  ${
    ralimi.1 $e |- ( ph -> ps ) $.
    $( Inference quantifying both antecedent and consequent, with strong
       hypothesis.  (Contributed by NM, 4-Mar-1997.) $)
    ralimi $p |- ( A. x e. A ph -> A. x e. A ps ) $=
      ( wi cv wcel a1i ralimia ) ABCDABFCGDHEIJ $.
  $}

  ${
    ral2imi.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Inference quantifying antecedent, nested antecedent, and consequent,
       with a strong hypothesis.  (Contributed by NM, 19-Dec-2006.) $)
    ral2imi $p |- ( A. x e. A ph -> ( A. x e. A ps -> A. x e. A ch ) ) $=
      ( wral wi ralimi ralim syl ) ADEGBCHZDEGBDEGCDEGHALDEFIBCDEJK $.
  $}

  ${
    ralimdaa.1 $e |- F/ x ph $.
    ralimdaa.2 $e |- ( ( ph /\ x e. A ) -> ( ps -> ch ) ) $.
    $( Deduction quantifying both antecedent and consequent, based on Theorem
       19.20 of [Margaris] p. 90.  (Contributed by NM, 22-Sep-2003.) $)
    ralimdaa $p |- ( ph -> ( A. x e. A ps -> A. x e. A ch ) ) $=
      ( cv wcel wi wal wral ex a2d alimd df-ral 3imtr4g ) ADHEIZBJZDKRCJZDKBDEL
      CDELASTDFARBCARBCJGMNOBDEPCDEPQ $.
  $}

  ${
    $d x ph $.
    ralimdva.1 $e |- ( ( ph /\ x e. A ) -> ( ps -> ch ) ) $.
    $( Deduction quantifying both antecedent and consequent, based on Theorem
       19.20 of [Margaris] p. 90.  (Contributed by NM, 22-May-1999.) $)
    ralimdva $p |- ( ph -> ( A. x e. A ps -> A. x e. A ch ) ) $=
      ( nfv ralimdaa ) ABCDEADGFH $.
  $}

  ${
    $d x ph $.
    ralimdv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction quantifying both antecedent and consequent, based on Theorem
       19.20 of [Margaris] p. 90.  (Contributed by NM, 8-Oct-2003.) $)
    ralimdv $p |- ( ph -> ( A. x e. A ps -> A. x e. A ch ) ) $=
      ( wi cv wcel adantr ralimdva ) ABCDEABCGDHEIFJK $.
  $}

  ${
    $d x ph $.
    ralimdv2.1 $e |- ( ph -> ( ( x e. A -> ps ) -> ( x e. B -> ch ) ) ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 1-Feb-2005.) $)
    ralimdv2 $p |- ( ph -> ( A. x e. A ps -> A. x e. B ch ) ) $=
      ( cv wcel wi wal wral alimdv df-ral 3imtr4g ) ADHZEIBJZDKPFICJZDKBDELCDFL
      AQRDGMBDENCDFNO $.
  $}

  ${
    ralrimi.1 $e |- F/ x ph $.
    ralrimi.2 $e |- ( ph -> ( x e. A -> ps ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 10-Oct-1999.) $)
    ralrimi $p |- ( ph -> A. x e. A ps ) $=
      ( cv wcel wi wal wral alrimi df-ral sylibr ) ACGDHBIZCJBCDKAOCEFLBCDMN $.
  $}

  ${
    $d x ph $.
    ralrimiv.1 $e |- ( ph -> ( x e. A -> ps ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 22-Nov-1994.) $)
    ralrimiv $p |- ( ph -> A. x e. A ps ) $=
      ( nfv ralrimi ) ABCDACFEG $.
  $}

  ${
    $d x ph $.
    ralrimiva.1 $e |- ( ( ph /\ x e. A ) -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 2-Jan-2006.) $)
    ralrimiva $p |- ( ph -> A. x e. A ps ) $=
      ( cv wcel ex ralrimiv ) ABCDACFDGBEHI $.
  $}

  ${
    $d x ph $.
    ralrimivw.1 $e |- ( ph -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 18-Jun-2014.) $)
    ralrimivw $p |- ( ph -> A. x e. A ps ) $=
      ( cv wcel a1d ralrimiv ) ABCDABCFDGEHI $.
  $}

  ${
    $( Theorem 19.21 of [Margaris] p. 90 with restricted quantifiers (closed
       theorem version).  (Contributed by NM, 1-Mar-2008.) $)
    r19.21t $p |- ( F/ x ph ->
             ( A. x e. A ( ph -> ps ) <-> ( ph -> A. x e. A ps ) ) ) $=
      ( wnf cv wcel wal wral bi2.04 albii 19.21t syl5bb df-ral imbi2i 3bitr4g
      wi ) ACEZCFDGZABQZQZCHZASBQZCHZQZTCDIABCDIZQUBAUCQZCHRUEUAUGCSABJKAUCCLMT
      CDNUFUDABCDNOP $.
  $}

  ${
    r19.21.1 $e |- F/ x ph $.
    $( Theorem 19.21 of [Margaris] p. 90 with restricted quantifiers.
       (Contributed by Scott Fenton, 30-Mar-2011.) $)
    r19.21 $p |- ( A. x e. A ( ph -> ps ) <-> ( ph -> A. x e. A ps ) ) $=
      ( wnf wi wral wb r19.21t ax-mp ) ACFABGCDHABCDHGIEABCDJK $.
  $}

  ${
    $d x ph $.
    $( Theorem 19.21 of [Margaris] p. 90 with restricted quantifiers.
       (Contributed by NM, 15-Oct-2003.)  (Proof shortened by Andrew Salmon,
       30-May-2011.) $)
    r19.21v $p |- ( A. x e. A ( ph -> ps ) <-> ( ph -> A. x e. A ps ) ) $=
      ( nfv r19.21 ) ABCDACEF $.
  $}

  ${
    ralrimd.1 $e |- F/ x ph $.
    ralrimd.2 $e |- F/ x ps $.
    ralrimd.3 $e |- ( ph -> ( ps -> ( x e. A -> ch ) ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 16-Feb-2004.) $)
    ralrimd $p |- ( ph -> ( ps -> A. x e. A ch ) ) $=
      ( cv wcel wi wal wral alrimd df-ral syl6ibr ) ABDIEJCKZDLCDEMABQDFGHNCDEO
      P $.
  $}

  ${
    $d x ph $.  $d x ps $.
    ralrimdv.1 $e |- ( ph -> ( ps -> ( x e. A -> ch ) ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 27-May-1998.) $)
    ralrimdv $p |- ( ph -> ( ps -> A. x e. A ch ) ) $=
      ( nfv ralrimd ) ABCDEADGBDGFH $.
  $}

  ${
    $d x ph $.  $d x ps $.
    ralrimdva.1 $e |- ( ( ph /\ x e. A ) -> ( ps -> ch ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 2-Feb-2008.) $)
    ralrimdva $p |- ( ph -> ( ps -> A. x e. A ch ) ) $=
      ( cv wcel wi ex com23 ralrimdv ) ABCDEADGEHZBCAMBCIFJKL $.
  $}

  ${
    $d x y ph $.  $d y A $.
    ralrimivv.1 $e |- ( ph -> ( ( x e. A /\ y e. B ) -> ps ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version with double quantification.)  (Contributed by NM,
       24-Jul-2004.) $)
    ralrimivv $p |- ( ph -> A. x e. A A. y e. B ps ) $=
      ( wral cv wcel exp3a ralrimdv ralrimiv ) ABDFHCEACIEJZBDFANDIFJBGKLM $.
  $}

  ${
    $d ph x y $.  $d A y $.
    ralrimivva.1 $e |- ( ( ph /\ ( x e. A /\ y e. B ) ) -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version with double quantification.)  (Contributed by Jeff
       Madsen, 19-Jun-2011.) $)
    ralrimivva $p |- ( ph -> A. x e. A A. y e. B ps ) $=
      ( cv wcel wa ex ralrimivv ) ABCDEFACHEIDHFIJBGKL $.
  $}

  ${
    $d ph x y z $.  $d A y z $.  $d B z $.
    ralrimivvva.1 $e |- ( ( ph /\ ( x e. A /\ y e. B /\ z e. C ) ) -> ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version with triple quantification.)  (Contributed by Mario
       Carneiro, 9-Jul-2014.) $)
    ralrimivvva $p |- ( ph -> A. x e. A A. y e. B A. z e. C ps ) $=
      ( wral cv wcel wa 3anassrs ralrimiva ) ABEHJZDGJCFACKFLZMZPDGRDKGLZMBEHAQ
      SEKHLBINOOO $.
  $}

  ${
    $d x y ph $.  $d x y ps $.  $d y A $.
    ralrimdvv.1 $e |- ( ph -> ( ps -> ( ( x e. A /\ y e. B ) -> ch ) ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version with double quantification.)  (Contributed by NM,
       1-Jun-2005.) $)
    ralrimdvv $p |- ( ph -> ( ps -> A. x e. A A. y e. B ch ) ) $=
      ( wral wa cv wcel wi imp ralrimivv ex ) ABCEGIDFIABJCDEFGABDKFLEKGLJCMHNO
      P $.
  $}

  ${
    $d x y ph $.  $d x y ps $.  $d y A $.
    ralrimdvva.1 $e |- ( ( ph /\ ( x e. A /\ y e. B ) ) -> ( ps -> ch ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version with double quantification.)  (Contributed by NM,
       2-Feb-2008.) $)
    ralrimdvva $p |- ( ph -> ( ps -> A. x e. A A. y e. B ch ) ) $=
      ( cv wcel wa wi ex com23 ralrimdvv ) ABCDEFGADIFJEIGJKZBCAPBCLHMNO $.
  $}

  ${
    $d x y $.  $d y A $.
    rgen2.1 $e |- ( ( x e. A /\ y e. B ) -> ph ) $.
    $( Generalization rule for restricted quantification.  (Contributed by NM,
       30-May-1999.) $)
    rgen2 $p |- A. x e. A A. y e. B ph $=
      ( wral cv wcel ralrimiva rgen ) ACEGBDBHDIACEFJK $.
  $}

  ${
    $d y z A $.  $d z B $.  $d x y z $.
    rgen3.1 $e |- ( ( x e. A /\ y e. B /\ z e. C ) -> ph ) $.
    $( Generalization rule for restricted quantification.  (Contributed by NM,
       12-Jan-2008.) $)
    rgen3 $p |- A. x e. A A. y e. B A. z e. C ph $=
      ( wral cv wcel wa 3expa ralrimiva rgen2 ) ADGIBCEFBJEKZCJFKZLADGPQDJGKAHM
      NO $.
  $}

  ${
    r19.21bi.1 $e |- ( ph -> A. x e. A ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 20-Nov-1994.) $)
    r19.21bi $p |- ( ( ph /\ x e. A ) -> ps ) $=
      ( cv wcel wi wral wal df-ral sylib 19.21bi imp ) ACFDGZBAOBHZCABCDIPCJEBC
      DKLMN $.
  $}

  ${
    rspec2.1 $e |- A. x e. A A. y e. B ph $.
    $( Specialization rule for restricted quantification.  (Contributed by NM,
       20-Nov-1994.) $)
    rspec2 $p |- ( ( x e. A /\ y e. B ) -> ph ) $=
      ( cv wcel wral rspec r19.21bi ) BGDHACEACEIBDFJK $.
  $}

  ${
    rspec3.1 $e |- A. x e. A A. y e. B A. z e. C ph $.
    $( Specialization rule for restricted quantification.  (Contributed by NM,
       20-Nov-1994.) $)
    rspec3 $p |- ( ( x e. A /\ y e. B /\ z e. C ) -> ph ) $=
      ( cv wcel wa wral rspec2 r19.21bi 3impa ) BIEJZCIFJZDIGJAPQKADGADGLBCEFHM
      NO $.
  $}

  ${
    r19.21be.1 $e |- ( ph -> A. x e. A ps ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 21-Nov-1994.) $)
    r19.21be $p |- A. x e. A ( ph -> ps ) $=
      ( wi cv wcel r19.21bi expcom rgen ) ABFCDACGDHBABCDEIJK $.
  $}

  ${
    nrex.1 $e |- ( x e. A -> -. ps ) $.
    $( Inference adding restricted existential quantifier to negated wff.
       (Contributed by NM, 16-Oct-2003.) $)
    nrex $p |- -. E. x e. A ps $=
      ( wn wral wrex rgen ralnex mpbi ) AEZBCFABCGEKBCDHABCIJ $.
  $}

  ${
    $d x ph $.
    nrexdv.1 $e |- ( ( ph /\ x e. A ) -> -. ps ) $.
    $( Deduction adding restricted existential quantifier to negated wff.
       (Contributed by NM, 16-Oct-2003.) $)
    nrexdv $p |- ( ph -> -. E. x e. A ps ) $=
      ( wn wral wrex ralrimiva ralnex sylib ) ABFZCDGBCDHFALCDEIBCDJK $.
  $}

  $( Theorem 19.22 of [Margaris] p. 90.  (Restricted quantifier version.)
     (Contributed by NM, 22-Nov-1994.)  (Proof shortened by Andrew Salmon,
     30-May-2011.) $)
  rexim $p |- ( A. x e. A ( ph -> ps ) ->
               ( E. x e. A ph -> E. x e. A ps ) ) $=
    ( wi wral cv wcel wa wex wrex wal df-ral ax-ia1 pm3.31 jcad alimi
    a1i sylbi df-rex exim syl 3imtr4g ) ABEZCDFZCGDHZAIZCJZUFBIZCJZAC
    DKBCDKUEUGUIEZCLZUHUJEUEUFUDEZCLULUDCDMUMUKCUMUGUFBUGUFEUMUFANRUF
    ABOPQSUGUICUAUBACDTBCDTUC $.

  ${
    reximia.1 $e |- ( x e. A -> ( ph -> ps ) ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 10-Feb-1997.) $)
    reximia $p |- ( E. x e. A ph -> E. x e. A ps ) $=
      ( wi wrex rexim mprg ) ABFACDGBCDGFCDABCDHEI $.
  $}

  ${
    reximi2.1 $e |- ( ( x e. A /\ ph ) -> ( x e. B /\ ps ) ) $.
    $( Inference quantifying both antecedent and consequent, based on Theorem
       19.22 of [Margaris] p. 90.  (Contributed by NM, 8-Nov-2004.) $)
    reximi2 $p |- ( E. x e. A ph -> E. x e. B ps ) $=
      ( cv wcel wa wex wrex eximi df-rex 3imtr4i ) CGZDHAIZCJOEHBIZCJACDKBCEKPQ
      CFLACDMBCEMN $.
  $}

  ${
    reximi.1 $e |- ( ph -> ps ) $.
    $( Inference quantifying both antecedent and consequent.  (Contributed by
       NM, 18-Oct-1996.) $)
    reximi $p |- ( E. x e. A ph -> E. x e. A ps ) $=
      ( wi cv wcel a1i reximia ) ABCDABFCGDHEIJ $.
  $}

  ${
    reximdai.1 $e |- F/ x ph $.
    reximdai.2 $e |- ( ph -> ( x e. A -> ( ps -> ch ) ) ) $.
    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 31-Aug-1999.) $)
    reximdai $p |- ( ph -> ( E. x e. A ps -> E. x e. A ch ) ) $=
      ( wi wral wrex ralrimi rexim syl ) ABCHZDEIBDEJCDEJHANDEFGKBCDELM $.
  $}

  ${
    $d x ph $.
    reximdv2.1 $e |- ( ph -> ( ( x e. A /\ ps ) -> ( x e. B /\ ch ) ) ) $.
    $( Deduction quantifying both antecedent and consequent, based on Theorem
       19.22 of [Margaris] p. 90.  (Contributed by NM, 17-Sep-2003.) $)
    reximdv2 $p |- ( ph -> ( E. x e. A ps -> E. x e. B ch ) ) $=
      ( cv wcel wa wex wrex eximdv df-rex 3imtr4g ) ADHZEIBJZDKPFICJZDKBDELCDFL
      AQRDGMBDENCDFNO $.
  $}

  ${
    $d x ph $.
    reximdvai.1 $e |- ( ph -> ( x e. A -> ( ps -> ch ) ) ) $.
    $( Deduction quantifying both antecedent and consequent, based on Theorem
       19.22 of [Margaris] p. 90.  (Contributed by NM, 14-Nov-2002.) $)
    reximdvai $p |- ( ph -> ( E. x e. A ps -> E. x e. A ch ) ) $=
      ( nfv reximdai ) ABCDEADGFH $.
  $}

  ${
    $d x ph $.
    reximdv.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Deduction from Theorem 19.22 of [Margaris] p. 90.  (Restricted
       quantifier version with strong hypothesis.)  (Contributed by NM,
       24-Jun-1998.) $)
    reximdv $p |- ( ph -> ( E. x e. A ps -> E. x e. A ch ) ) $=
      ( wi cv wcel a1d reximdvai ) ABCDEABCGDHEIFJK $.
  $}

  ${
    $d x ph $.
    reximdva.1 $e |- ( ( ph /\ x e. A ) -> ( ps -> ch ) ) $.
    $( Deduction quantifying both antecedent and consequent, based on Theorem
       19.22 of [Margaris] p. 90.  (Contributed by NM, 22-May-1999.) $)
    reximdva $p |- ( ph -> ( E. x e. A ps -> E. x e. A ch ) ) $=
      ( cv wcel wi ex reximdvai ) ABCDEADGEHBCIFJK $.
  $}

  ${
    $d x y $.  $d y A $.  $d x B $.
    $( Theorem 19.12 of [Margaris] p. 89 with restricted quantifiers.
       (Contributed by NM, 15-Oct-2003.)  (Proof shortened by Andrew Salmon,
       30-May-2011.) $)
    r19.12 $p |- ( E. x e. A A. y e. B ph -> A. y e. B E. x e. A ph ) $=
      ( wral wrex nfcv nfra1 nfrexxy cv wcel ax-1 ralrimi rsp reximdv ralimia syl
      com12 ) ACEFZBDGZUACEFABDGZCEFUAUACETCBDCDHACEIJUACKELZMNUAUBCEUCTABDTUCA
      ACEOSPQR $.
  $}

  $( Closed theorem form of ~ r19.23 .  (Contributed by NM, 4-Mar-2013.)
     (Revised by Mario Carneiro, 8-Oct-2016.) $)
  r19.23t $p |- ( F/ x ps ->
    ( A. x e. A ( ph -> ps ) <-> ( E. x e. A ph -> ps ) ) ) $=
    ( wnf cv wcel wa wal wex wral wrex 19.23t df-ral impexp albii bitr4i df-rex
    wi imbi1i 3bitr4g ) BCECFDGZAHZBSZCIZUCCJZBSABSZCDKZACDLZBSUCBCMUHUBUGSZCIU
    EUGCDNUDUJCUBABOPQUIUFBACDRTUA $.

  ${
    r19.23.1 $e |- F/ x ps $.
    $( Theorem 19.23 of [Margaris] p. 90 with restricted quantifiers.
       (Contributed by NM, 22-Oct-2010.)  (Proof shortened by Mario Carneiro,
       8-Oct-2016.) $)
    r19.23 $p |- ( A. x e. A ( ph -> ps ) <-> ( E. x e. A ph -> ps ) ) $=
      ( wnf wi wral wrex wb r19.23t ax-mp ) BCFABGCDHACDIBGJEABCDKL $.
  $}

  ${
    $d x ps $.
    $( Theorem 19.23 of [Margaris] p. 90 with restricted quantifiers.
       (Contributed by NM, 31-Aug-1999.) $)
    r19.23v $p |- ( A. x e. A ( ph -> ps ) <-> ( E. x e. A ph -> ps ) ) $=
      ( nfv r19.23 ) ABCDBCEF $.
  $}

  ${
    rexlimi.1 $e |- F/ x ps $.
    rexlimi.2 $e |- ( x e. A -> ( ph -> ps ) ) $.
    $( Inference from Theorem 19.21 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 30-Nov-2003.)  (Proof
       shortened by Andrew Salmon, 30-May-2011.) $)
    rexlimi $p |- ( E. x e. A ph -> ps ) $=
      ( wi wral wrex rgen r19.23 mpbi ) ABGZCDHACDIBGMCDFJABCDEKL $.
  $}

  ${
    $d x ps $.
    rexlimiv.1 $e |- ( x e. A -> ( ph -> ps ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 20-Nov-1994.) $)
    rexlimiv $p |- ( E. x e. A ph -> ps ) $=
      ( nfv rexlimi ) ABCDBCFEG $.
  $}

  ${
    $d x ps $.
    rexlimiva.1 $e |- ( ( x e. A /\ ph ) -> ps ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 18-Dec-2006.) $)
    rexlimiva $p |- ( E. x e. A ph -> ps ) $=
      ( cv wcel ex rexlimiv ) ABCDCFDGABEHI $.
  $}

  ${
    $d ps x $.
    rexlimivw.1 $e |- ( ph -> ps ) $.
    $( Weaker version of ~ rexlimiv .  (Contributed by FL, 19-Sep-2011.) $)
    rexlimivw $p |- ( E. x e. A ph -> ps ) $=
      ( wi cv wcel a1i rexlimiv ) ABCDABFCGDHEIJ $.
  $}

  ${
    rexlimd.1 $e |- F/ x ph $.
    rexlimd.2 $e |- F/ x ch $.
    rexlimd.3 $e |- ( ph -> ( x e. A -> ( ps -> ch ) ) ) $.
    $( Deduction from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 27-May-1998.)  (Proof shortened by Andrew
       Salmon, 30-May-2011.) $)
    rexlimd $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( wi wral wrex ralrimi r19.23 sylib ) ABCIZDEJBDEKCIAODEFHLBCDEGMN $.
  $}

  ${
    rexlimd2.1 $e |- F/ x ph $.
    rexlimd2.2 $e |- ( ph -> F/ x ch ) $.
    rexlimd2.3 $e |- ( ph -> ( x e. A -> ( ps -> ch ) ) ) $.
    $( Version of ~ rexlimd with deduction version of second hypothesis.
       (Contributed by NM, 21-Jul-2013.)  (Revised by Mario Carneiro,
       8-Oct-2016.) $)
    rexlimd2 $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( wi wral wrex ralrimi wnf wb r19.23t syl mpbid ) ABCIZDEJZBDEKCIZARDEFHL
      ACDMSTNGBCDEOPQ $.
  $}

  ${
    $d x ph $.  $d x ch $.
    rexlimdv.1 $e |- ( ph -> ( x e. A -> ( ps -> ch ) ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 14-Nov-2002.)  (Proof shortened by Eric
       Schmidt, 22-Dec-2006.) $)
    rexlimdv $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( nfv rexlimd ) ABCDEADGCDGFH $.
  $}

  ${
    $d x ph $.  $d x ch $.
    rexlimdva.1 $e |- ( ( ph /\ x e. A ) -> ( ps -> ch ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 20-Jan-2007.) $)
    rexlimdva $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( cv wcel wi ex rexlimdv ) ABCDEADGEHBCIFJK $.
  $}

  ${
    $d x ph $.  $d x ch $.
    rexlimdvaa.1 $e |- ( ( ph /\ ( x e. A /\ ps ) ) -> ch ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by Mario Carneiro, 15-Jun-2016.) $)
    rexlimdvaa $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( cv wcel expr rexlimdva ) ABCDEADGEHBCFIJ $.
  $}

  ${
    $d x ph $.  $d x ch $.
    rexlimdv3a.1 $e |- ( ( ph /\ x e. A /\ ps ) -> ch ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  Frequently-used variant of ~ rexlimdv .  (Contributed by NM,
       7-Jun-2015.) $)
    rexlimdv3a $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( cv wcel 3exp rexlimdv ) ABCDEADGEHBCFIJ $.
  $}

  ${
    $d x ph $.  $d x ch $.
    rexlimdvw.1 $e |- ( ph -> ( ps -> ch ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 18-Jun-2014.) $)
    rexlimdvw $p |- ( ph -> ( E. x e. A ps -> ch ) ) $=
      ( wi cv wcel a1d rexlimdv ) ABCDEABCGDHEIFJK $.
  $}

  ${
    $d x ph $.  $d x ch $.
    rexlimddv.1 $e |- ( ph -> E. x e. A ps ) $.
    rexlimddv.2 $e |- ( ( ph /\ ( x e. A /\ ps ) ) -> ch ) $.
    $( Restricted existential elimination rule of natural deduction.
       (Contributed by Mario Carneiro, 15-Jun-2016.) $)
    rexlimddv $p |- ( ph -> ch ) $=
      ( wrex rexlimdvaa mpd ) ABDEHCFABCDEGIJ $.
  $}

  ${
    $d x y ps $.  $d y A $.
    rexlimivv.1 $e |- ( ( x e. A /\ y e. B ) -> ( ph -> ps ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90 (restricted quantifier
       version).  (Contributed by NM, 17-Feb-2004.) $)
    rexlimivv $p |- ( E. x e. A E. y e. B ph -> ps ) $=
      ( wrex cv wcel rexlimdva rexlimiv ) ADFHBCECIEJABDFGKL $.
  $}

  ${
    $d x y ph $.  $d x y ch $.  $d y A $.
    rexlimdvv.1 $e |- ( ph -> ( ( x e. A /\ y e. B ) -> ( ps -> ch ) ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 22-Jul-2004.) $)
    rexlimdvv $p |- ( ph -> ( E. x e. A E. y e. B ps -> ch ) ) $=
      ( wrex cv wcel wa wi expdimp rexlimdv rexlimdva ) ABEGICDFADJFKZLBCEGAQEJ
      GKBCMHNOP $.
  $}

  ${
    $d x y ph $.  $d x y ch $.  $d y A $.
    rexlimdvva.1 $e |- ( ( ph /\ ( x e. A /\ y e. B ) ) -> ( ps -> ch ) ) $.
    $( Inference from Theorem 19.23 of [Margaris] p. 90.  (Restricted
       quantifier version.)  (Contributed by NM, 18-Jun-2014.) $)
    rexlimdvva $p |- ( ph -> ( E. x e. A E. y e. B ps -> ch ) ) $=
      ( cv wcel wa wi ex rexlimdvv ) ABCDEFGADIFJEIGJKBCLHMN $.
  $}

  $( Theorem 19.26 of [Margaris] p. 90 with restricted quantifiers.
     (Contributed by NM, 28-Jan-1997.)  (Proof shortened by Andrew Salmon,
     30-May-2011.) $)
  r19.26 $p |- ( A. x e. A ( ph /\ ps ) <->
               ( A. x e. A ph /\ A. x e. A ps ) ) $=
    ( wa wral simpl ralimi simpr jca pm3.2 ral2imi imp impbii ) ABEZCDFZACDFZBC
    DFZEPQROACDABGHOBCDABIHJQRPABOCDABKLMN $.

  $( Theorem 19.26 of [Margaris] p. 90 with 2 restricted quantifiers.
     (Contributed by NM, 10-Aug-2004.) $)
  r19.26-2 $p |- ( A. x e. A A. y e. B ( ph /\ ps ) <->
               ( A. x e. A A. y e. B ph /\ A. x e. A A. y e. B ps ) ) $=
    ( wa wral r19.26 ralbii bitri ) ABGDFHZCEHADFHZBDFHZGZCEHMCEHNCEHGLOCEABDFI
    JMNCEIK $.

  $( Theorem 19.26 of [Margaris] p. 90 with 3 restricted quantifiers.
     (Contributed by FL, 22-Nov-2010.) $)
  r19.26-3 $p |- ( A. x e. A ( ph /\ ps /\ ch ) <->
               ( A. x e. A ph /\ A. x e. A ps /\ A. x e. A ch ) ) $=
    ( w3a wral wa df-3an ralbii r19.26 anbi1i bitr4i 3bitri ) ABCFZDEGABHZCHZDE
    GPDEGZCDEGZHZADEGZBDEGZSFZOQDEABCIJPCDEKTUAUBHZSHUCRUDSABDEKLUAUBSIMN $.

  $( Theorem 19.26 of [Margaris] p. 90 with mixed quantifiers.  (Contributed by
     NM, 22-Feb-2004.) $)
  r19.26m $p |- ( A. x ( ( x e. A -> ph ) /\ ( x e. B -> ps ) ) <->
               ( A. x e. A ph /\ A. x e. B ps ) ) $=
    ( cv wcel wi wa wal wral 19.26 df-ral anbi12i bitr4i ) CFZDGAHZPEGBHZICJQCJ
    ZRCJZIACDKZBCEKZIQRCLUASUBTACDMBCEMNO $.

  $( Distribute a restricted universal quantifier over a biconditional.
     Theorem 19.15 of [Margaris] p. 90 with restricted quantification.
     (Contributed by NM, 6-Oct-2003.) $)
  ralbi $p |- ( A. x e. A ( ph <-> ps ) ->
               ( A. x e. A ph <-> A. x e. A ps ) ) $=
    ( wb wral nfra1 cv wcel rsp imp ralbida ) ABEZCDFZABCDMCDGNCHDIMMCDJKL $.

  $( Split a biconditional and distribute quantifier.  (Contributed by NM,
     3-Jun-2012.) $)
  ralbiim $p |- ( A. x e. A ( ph <-> ps ) <->
             ( A. x e. A ( ph -> ps ) /\ A. x e. A ( ps -> ph ) ) ) $=
    ( wb wral wi wa dfbi2 ralbii r19.26 bitri ) ABEZCDFABGZBAGZHZCDFNCDFOCDFHMP
    CDABIJNOCDKL $.

  ${
    $d x ps $.
    $( Restricted version of one direction of Theorem 19.27 of [Margaris]
       p. 90.  (The other direction doesn't hold when ` A ` is empty.)
       (Contributed by NM, 3-Jun-2004.)  (Proof shortened by Andrew Salmon,
       30-May-2011.) $)
    r19.27av $p |- ( ( A. x e. A ph /\ ps ) -> A. x e. A ( ph /\ ps ) ) $=
      ( wral wa cv wcel ax-1 ralrimiv anim2i r19.26 sylibr ) ACDEZBFNBCDEZFABFC
      DEBONBBCDBCGDHIJKABCDLM $.
  $}

  ${
    $d x ph $.
    $( Restricted version of one direction of Theorem 19.28 of [Margaris]
       p. 90.  (The other direction doesn't hold when ` A ` is empty.)
       (Contributed by NM, 2-Apr-2004.) $)
    r19.28av $p |- ( ( ph /\ A. x e. A ps ) -> A. x e. A ( ph /\ ps ) ) $=
      ( wral wa r19.27av ancom ralbii 3imtr4i ) BCDEZAFBAFZCDEAKFABFZCDEBACDGAK
      HMLCDABHIJ $.
  $}

  $( Theorem 19.29 of [Margaris] p. 90 with restricted quantifiers.
     (Contributed by NM, 31-Aug-1999.)  (Proof shortened by Andrew Salmon,
     30-May-2011.) $)
  r19.29 $p |- ( ( A. x e. A ph /\ E. x e. A ps ) ->
               E. x e. A ( ph /\ ps ) ) $=
    ( wral wrex wa wi pm3.2 ralimi rexim syl imp ) ACDEZBCDFZABGZCDFZNBPHZCDEOQ
    HARCDABIJBPCDKLM $.

  $( Variation of Theorem 19.29 of [Margaris] p. 90 with restricted
     quantifiers.  (Contributed by NM, 31-Aug-1999.) $)
  r19.29r $p |- ( ( E. x e. A ph /\ A. x e. A ps ) ->
                E. x e. A ( ph /\ ps ) ) $=
    ( wral wrex wa r19.29 ancom rexbii 3imtr4i ) BCDEZACDFZGBAGZCDFMLGABGZCDFBA
    CDHMLIONCDABIJK $.

  ${
    r19.29af2.p $e |- F/ x ph $.
    r19.29af2.c $e |- F/ x ch $.
    r19.29af2.1 $e |- ( ( ( ph /\ x e. A ) /\ ps ) -> ch ) $.
    r19.29af2.2 $e |- ( ph -> E. x e. A ps ) $.
    $( A commonly used pattern based on ~ r19.29 (Contributed by Thierry
       Arnoux, 17-Dec-2017.) $)
    r19.29af2 $p |- ( ph -> ch ) $=
      ( wrex wi wral wa cv wcel exp31 ralrimi jca r19.29r pm3.35 rexlimi 3syl
      a1i ) ABDEJZBCKZDELZMBUEMZDEJCAUDUFIAUEDEFADNEOZBCHPQRBUEDESUGCDEGUGCKUHB
      CTUCUAUB $.
  $}

  ${
    $d x ch $.
    r19.29af.0 $e |- F/ x ph $.
    r19.29af.1 $e |- ( ( ( ph /\ x e. A ) /\ ps ) -> ch ) $.
    r19.29af.2 $e |- ( ph -> E. x e. A ps ) $.
    $( A commonly used pattern based on ~ r19.29 (Contributed by Thierry
       Arnoux, 29-Nov-2017.) $)
    r19.29af $p |- ( ph -> ch ) $=
      ( nfv r19.29af2 ) ABCDEFCDIGHJ $.
  $}

  ${
    $d x ch $.  $d x ph $.
    r19.29a.1 $e |- ( ( ( ph /\ x e. A ) /\ ps ) -> ch ) $.
    r19.29a.2 $e |- ( ph -> E. x e. A ps ) $.
    $( A commonly used pattern based on ~ r19.29 (Contributed by Thierry
       Arnoux, 22-Nov-2017.) $)
    r19.29a $p |- ( ph -> ch ) $=
      ( nfv r19.29af ) ABCDEADHFGI $.
  $}

  ${
    r19.29d2r.1 $e |- ( ph -> A. x e. A A. y e. B ps ) $.
    r19.29d2r.2 $e |- ( ph -> E. x e. A E. y e. B ch ) $.
    $( Theorem 19.29 of [Margaris] p. 90 with two restricted quantifiers,
       deduction version (Contributed by Thierry Arnoux, 30-Jan-2017.) $)
    r19.29d2r $p |- ( ph -> E. x e. A E. y e. B ( ps /\ ch ) ) $=
      ( wral wrex wa r19.29 syl2anc reximi syl ) ABEGJZCEGKZLZDFKZBCLEGKZDFKAQD
      FJRDFKTHIQRDFMNSUADFBCEGMOP $.
  $}

  ${
    $d y A $.  $d x y ch $.  $d x y ph $.
    r19.29_2a.1 $e |- ( ( ( ( ph /\ x e. A ) /\ y e. B ) /\ ps ) -> ch ) $.
    r19.29_2a.2 $e |- ( ph -> E. x e. A E. y e. B ps ) $.
    $( A commonly used pattern based on ~ r19.29 , version with two restricted
       quantifiers (Contributed by Thierry Arnoux, 26-Nov-2017.) $)
    r19.29_2a $p |- ( ph -> ch ) $=
      ( wi wa wrex wral cv wcel ex ralrimiva r19.29d2r pm3.35 rexlimivw ancoms
      syl ) ABCJZBKZEGLZDFLCAUCBDEFGAUCEGMDFADNFOKZUCEGUFENGOKBCHPQQIRUECDFUDCE
      GBUCCBCSUATTUB $.
  $}

  ${
    $d x ph $.
    $( Theorem 19.32 of [Margaris] p. 90 with restricted quantifiers, where
       ` ph ` is decidable.  (Contributed by Jim Kingdon, 4-Jun-2018.) $)
    r19.32vdc $p |- ( DECID ph ->
        ( A. x e. A ( ph \/ ps ) <-> ( ph \/ A. x e. A ps ) ) ) $=
      ( wdc wn wi wral wo wb r19.21v a1i dfordc ralbidv 3bitr4d ) AEZAF
      ZBGZCDHZQBCDHZGZABIZCDHATISUAJPQBCDKLPUBRCDABMNATMO $.
  $}

  $( Restricted quantifier version of ~ 19.35-1 .  (Contributed by Jim Kingdon,
     4-Jun-2018.) $)
  r19.35-1 $p |- ( E. x e. A ( ph -> ps ) ->
      ( A. x e. A ph -> E. x e. A ps ) ) $=
    ( wral wi wrex wa r19.29 pm3.35 reximi syl expcom ) ACDEZABFZCDGZ
    BCDGZNPHAOHZCDGQAOCDIRBCDABJKLM $.

  ${
    $d x ps $.
    $( One direction of a restricted quantifier version of Theorem 19.36 of
       [Margaris] p. 90.  (Contributed by NM, 22-Oct-2003.) $)
    r19.36av $p |- ( E. x e. A ( ph -> ps ) -> ( A. x e. A ph -> ps ) ) $=
      ( wi wrex wral r19.35-1 cv wcel idd rexlimiv imim2i syl ) ABECD
      FACDGZBCDFZEOBEABCDHPBOBBCDCIDJBKLMN $.
  $}

  ${
    r19.37.1 $e |- F/ x ph $.
    $( Restricted version of one direction of Theorem 19.37 of [Margaris]
       p. 90.  (Contributed by FL, 13-May-2012.)  (Revised by Mario Carneiro,
       11-Dec-2016.) $)
    r19.37 $p |- ( E. x e. A ( ph -> ps ) -> ( ph -> E. x e. A ps ) ) $=
      ( wral wi wrex cv wcel ax-1 ralrimi r19.35-1 syl5 ) AACDFABGCDH
      BCDHAACDEACIDJKLABCDMN $.
  $}

  ${
    $d x ph $.
    $( Restricted version of one direction of Theorem 19.37 of [Margaris]
       p. 90.  (The other direction doesn't hold when ` A ` is empty.)
       (Contributed by NM, 2-Apr-2004.) $)
    r19.37av $p |- ( E. x e. A ( ph -> ps ) -> ( ph -> E. x e. A ps ) ) $=
      ( nfv r19.37 ) ABCDACEF $.
  $}

  $( Restricted quantifier version of Theorem 19.40 of [Margaris] p. 90.
     (Contributed by NM, 2-Apr-2004.) $)
  r19.40 $p |- ( E. x e. A ( ph /\ ps ) ->
               ( E. x e. A ph /\ E. x e. A ps ) ) $=
    ( wa wrex simpl reximi simpr jca ) ABEZCDFACDFBCDFKACDABGHKBCDABIHJ $.

  ${
    r19.41.1 $e |- F/ x ps $.
    $( Restricted quantifier version of Theorem 19.41 of [Margaris] p. 90.
       (Contributed by NM, 1-Nov-2010.) $)
    r19.41 $p |- ( E. x e. A ( ph /\ ps ) <-> ( E. x e. A ph /\ ps ) ) $=
      ( cv wcel wa wex wrex anass exbii 19.41 bitr3i df-rex anbi1i 3bitr4i ) CF
      DGZABHZHZCIZRAHZCIZBHZSCDJACDJZBHUAUBBHZCIUDUFTCRABKLUBBCEMNSCDOUEUCBACDO
      PQ $.
  $}

  ${
    $d x ps $.
    $( Restricted quantifier version of Theorem 19.41 of [Margaris] p. 90.
       (Contributed by NM, 17-Dec-2003.) $)
    r19.41v $p |- ( E. x e. A ( ph /\ ps ) <-> ( E. x e. A ph /\ ps ) ) $=
      ( nfv r19.41 ) ABCDBCEF $.
  $}

  ${
    $d x ph $.
    $( Restricted version of Theorem 19.42 of [Margaris] p. 90.  (Contributed
       by NM, 27-May-1998.) $)
    r19.42v $p |- ( E. x e. A ( ph /\ ps ) <-> ( ph /\ E. x e. A ps ) ) $=
      ( wa wrex r19.41v ancom rexbii 3bitr4i ) BAEZCDFBCDFZAEABEZCDFALEBACDGMKC
      DABHIALHJ $.
  $}

  $( Restricted version of Theorem 19.43 of [Margaris] p. 90.  (Contributed by
     NM, 27-May-1998.)  (Proof rewritten by Jim Kingdon, 5-Jun-2018.) $)
  r19.43 $p |- ( E. x e. A ( ph \/ ps ) <->
               ( E. x e. A ph \/ E. x e. A ps ) ) $=
    ( wo wrex cv wcel wa df-rex andi exbii bitri 19.43 orbi12i bitr4i
    wex ) ABEZCDFZCGDHZAIZCQZTBIZCQZEZACDFZBCDFZESUAUCEZCQZUESTRIZCQU
    IRCDJUJUHCTABKLMUAUCCNMUFUBUGUDACDJBCDJOP $.

  ${
    $d x ps $.
    $( One direction of a restricted quantifier version of Theorem 19.44 of
       [Margaris] p. 90.  The other direction doesn't hold when ` A ` is
       empty.  (Contributed by NM, 2-Apr-2004.) $)
    r19.44av $p |- ( E. x e. A ( ph \/ ps ) -> ( E. x e. A ph \/ ps ) ) $=
      ( wo wrex r19.43 cv wcel idd rexlimiv orim2i sylbi ) ABECDFACDFZBCDFZENBE
      ABCDGOBNBBCDCHDIBJKLM $.
  $}

  ${
    $d x ph $.
    $( Restricted version of one direction of Theorem 19.45 of [Margaris]
       p. 90.  (The other direction doesn't hold when ` A ` is empty.)
       (Contributed by NM, 2-Apr-2004.) $)
    r19.45av $p |- ( E. x e. A ( ph \/ ps ) -> ( ph \/ E. x e. A ps ) ) $=
      ( wo wrex r19.43 cv wcel idd rexlimiv orim1i sylbi ) ABECDFACDFZBCDFZEAOE
      ABCDGNAOAACDCHDIAJKLM $.
  $}

  ${
    $d x y $.
    ralcomf.1 $e |- F/_ y A $.
    ralcomf.2 $e |- F/_ x B $.
    $( Commutation of restricted quantifiers.  (Contributed by Mario Carneiro,
       14-Oct-2016.) $)
    ralcomf $p |- ( A. x e. A A. y e. B ph <-> A. y e. B A. x e. A ph ) $=
      ( cv wcel wa wi wal wral ancomsimp 2albii alcom bitri r2alf 3bitr4i ) BHD
      IZCHEIZJAKZCLBLZUATJAKZBLCLZACEMBDMABDMCEMUCUDCLBLUEUBUDBCTUAANOUDBCPQABC
      DEFRACBEDGRS $.

    $( Commutation of restricted quantifiers.  (Contributed by Mario Carneiro,
       14-Oct-2016.) $)
    rexcomf $p |- ( E. x e. A E. y e. B ph <-> E. y e. B E. x e. A ph ) $=
      ( cv wcel wa wex wrex ancom anbi1i 2exbii excom bitri r2exf 3bitr4i ) BHD
      IZCHEIZJZAJZCKBKZUATJZAJZBKCKZACELBDLABDLCELUDUFCKBKUGUCUFBCUBUEATUAMNOUF
      BCPQABCDEFRACBEDGRS $.
  $}

  ${
    $d x y $.  $d x B $.  $d y A $.
    $( Commutation of restricted quantifiers.  (Contributed by NM,
       13-Oct-1999.)  (Revised by Mario Carneiro, 14-Oct-2016.) $)
    ralcom $p |- ( A. x e. A A. y e. B ph <-> A. y e. B A. x e. A ph ) $=
      ( nfcv ralcomf ) ABCDECDFBEFG $.

    $( Commutation of restricted quantifiers.  (Contributed by NM,
       19-Nov-1995.)  (Revised by Mario Carneiro, 14-Oct-2016.) $)
    rexcom $p |- ( E. x e. A E. y e. B ph <-> E. y e. B E. x e. A ph ) $=
      ( nfcv rexcomf ) ABCDECDFBEFG $.
  $}

  ${
    $d y z A $.  $d x z B $.  $d x y C $.
    $( Swap 1st and 3rd restricted existential quantifiers.  (Contributed by
       NM, 8-Apr-2015.) $)
    rexcom13 $p |- ( E. x e. A E. y e. B E. z e. C ph
         <-> E. z e. C E. y e. B E. x e. A ph ) $=
      ( wrex rexcom rexbii 3bitri ) ADGHZCFHBEHLBEHZCFHABEHZDGHZCFHNCFHDGHLBCEF
      IMOCFABDEGIJNCDFGIK $.
  $}

  ${
    $d w z A $.  $d w z B $.  $d w x y C $.  $d x y z D $.
    $( Rotate existential restricted quantifiers twice.  (Contributed by NM,
       8-Apr-2015.) $)
    rexrot4 $p |- ( E. x e. A E. y e. B E. z e. C E. w e. D ph
        <-> E. z e. C E. w e. D E. x e. A E. y e. B ph ) $=
      ( wrex rexcom13 rexbii bitri ) AEIJDHJCGJZBFJACGJZDHJEIJZBFJOBFJEIJDHJNPB
      FACDEGHIKLOBEDFIHKM $.
  $}

  ${
    $( A commutative law for restricted quantifiers that swaps the domain of
       the restriction.  (Contributed by NM, 22-Feb-2004.) $)
    ralcom3 $p |- ( A. x e. A ( x e. B -> ph ) <->
                    A. x e. B ( x e. A -> ph ) ) $=
      ( cv wcel wi wral pm2.04 ralimi2 impbii ) BEZDFZAGZBCHLCFZAGZBDHNPBCDOMAI
      JPNBDCMOAIJK $.
  $}

  ${
    $d y A $.  $d x B $.  $d x y $.
    reean.1 $e |- F/ y ph $.
    reean.2 $e |- F/ x ps $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 27-Oct-2010.)
       (Proof shortened by Andrew Salmon, 30-May-2011.) $)
    reean $p |- ( E. x e. A E. y e. B ( ph /\ ps ) <->
                 ( E. x e. A ph /\ E. y e. B ps ) ) $=
      ( cv wcel wa wex wrex an4 2exbii nfv nfan eean bitri df-rex r2ex anbi12i
      3bitr4i ) CIEJZDIFJZKABKZKZDLCLZUDAKZCLZUEBKZDLZKZUFDFMCEMACEMZBDFMZKUHUI
      UKKZDLCLUMUGUPCDUDUEABNOUIUKCDUDADUDDPGQUEBCUECPHQRSUFCDEFUAUNUJUOULACETB
      DFTUBUC $.
  $}

  ${
    $d y ph $.  $d x ps $.  $d x y $.  $d y A $.  $d x B $.
    $( Rearrange existential quantifiers.  (Contributed by NM, 9-May-1999.) $)
    reeanv $p |- ( E. x e. A E. y e. B ( ph /\ ps ) <->
                 ( E. x e. A ph /\ E. y e. B ps ) ) $=
      ( nfv reean ) ABCDEFADGBCGH $.
  $}

  ${
    $d ph y z $.  $d ps x z $.  $d ch x y $.  $d A y $.  $d B x z $.
    $d C x y $.
    $( Rearrange three existential quantifiers.  (Contributed by Jeff Madsen,
       11-Jun-2010.) $)
    3reeanv $p |- ( E. x e. A E. y e. B E. z e. C ( ph /\ ps /\ ch )
                      <-> ( E. x e. A ph /\ E. y e. B ps /\ E. z e. C ch ) ) $=
      ( wa wrex w3a r19.41v reeanv anbi1i bitri df-3an 2rexbii rexbii 3bitr4i )
      ABJZEHKZCFIKZJZDGKZADGKZBEHKZJZUCJZABCLZFIKEHKZDGKUFUGUCLUEUBDGKZUCJUIUBU
      CDGMULUHUCABDEGHNOPUKUDDGUKUACJZFIKEHKUDUJUMEFHIABCQRUACEFHINPSUFUGUCQT
      $.
  $}

  $( ` x ` is not free in ` E! x e. A ph ` .  (Contributed by NM,
     19-Mar-1997.) $)
  nfreu1 $p |- F/ x E! x e. A ph $=
    ( wreu cv wcel wa weu df-reu nfeu1 nfxfr ) ABCDBECFAGZBHBABCILBJK $.

  $( ` x ` is not free in ` E* x e. A ph ` .  (Contributed by NM,
     16-Jun-2017.) $)
  nfrmo1 $p |- F/ x E* x e. A ph $=
    ( wrmo cv wcel wa wmo df-rmo nfmo1 nfxfr ) ABCDBECFAGZBHBABCILBJK $.

  ${
    $d x y z $.  $d A z $.  $d ph z $.
    nfreudxy.1 $e |- F/ y ph $.
    nfreudxy.2 $e |- ( ph -> F/_ x A ) $.
    nfreudxy.3 $e |- ( ph -> F/ x ps ) $.
    $( Not-free deduction for restricted uniqueness.  This is a version where
       ` x ` and ` y ` are distinct.  (Contributed by Jim Kingdon,
       6-Jun-2018.) $)
    nfreudxy $p |- ( ph -> F/ x E! y e. A ps ) $=
      ( cv wcel wa weu wnf wreu wnfc nfcv a1i nfeld nfand nfeud nfbii
      df-reu sylibr ) ADIZEJZBKZDLZCMBDENZCMAUFCDFAUEBCACUDECUDOACUDP
      QGRHSTUHUGCBDEUBUAUC $.
  $}

  ${
    $d x y $.
    nfreuxy.1 $e |- F/_ x A $.
    nfreuxy.2 $e |- F/ x ph $.
    $( Not-free for restricted uniqueness.  This is a version where ` x ` and
       ` y ` are distinct.  (Contributed by Jim Kingdon, 6-Jun-2018.) $)
    nfreuxy $p |- F/ x E! y e. A ph $=
      ( wreu wnf wtru nftru wnfc a1i nfreudxy trud ) ACDGBHIABCDCJBDKIELABHIFLMN
      $.
  $}

  $( An "identity" law of concretion for restricted abstraction.  Special case
     of Definition 2.1 of [Quine] p. 16.  (Contributed by NM, 9-Oct-2003.) $)
  rabid $p |- ( x e. { x e. A | ph } <-> ( x e. A /\ ph ) ) $=
    ( cv wcel wa crab df-rab abeq2i ) BDCEAFBABCGABCHI $.

  ${
    $d x A $.
    $( An "identity" law for restricted class abstraction.  (Contributed by NM,
       9-Oct-2003.)  (Proof shortened by Andrew Salmon, 30-May-2011.) $)
    rabid2 $p |- ( A = { x e. A | ph } <-> A. x e. A ph ) $=
      ( cv wcel wa cab wceq wi wal crab abeq2 pm4.71 albii bitr4i df-rab eqeq2i
      wral wb df-ral 3bitr4i ) CBDCEZAFZBGZHZUBAIZBJZCABCKZHABCRUEUBUCSZBJUGUCB
      CLUFUIBUBAMNOUHUDCABCPQABCTUA $.
  $}

  ${
    $( Equivalent wff's correspond to equal restricted class abstractions.
       Closed theorem form of ~ rabbidva .  (Contributed by NM,
       25-Nov-2013.) $)
    rabbi $p |- ( A. x e. A ( ps <-> ch )
         <-> { x e. A | ps } = { x e. A | ch } ) $=
      ( cv wcel wa wb wal cab wceq wral crab abbi wi df-ral pm5.32 albii df-rab
      bitri eqeq12i 3bitr4i ) CEDFZAGZUCBGZHZCIZUDCJZUECJZKABHZCDLZACDMZBCDMZKU
      DUECNUKUCUJOZCIUGUJCDPUNUFCUCABQRTULUHUMUIACDSBCDSUAUB $.
  $}

  $( Swap with a membership relation in a restricted class abstraction.
     (Contributed by NM, 4-Jul-2005.) $)
  rabswap $p |- { x e. A | x e. B } = { x e. B | x e. A } $=
    ( cv wcel wa cab crab ancom abbii df-rab 3eqtr4i ) ADZBEZMCEZFZAGONFZAGOABH
    NACHPQANOIJOABKNACKL $.

  ${
    $d x y $.
    $( The abstraction variable in a restricted class abstraction isn't free.
       (Contributed by NM, 19-Mar-1997.) $)
    nfrab1 $p |- F/_ x { x e. A | ph } $=
      ( crab cv wcel wa cab df-rab nfab1 nfcxfr ) BABCDBECFAGZBHABCILBJK $.
  $}

  ${
    reubida.1 $e |- F/ x ph $.
    reubida.2 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by Mario Carneiro, 19-Nov-2016.) $)
    reubida $p |- ( ph -> ( E! x e. A ps <-> E! x e. A ch ) ) $=
      ( cv wcel wa weu wreu pm5.32da eubid df-reu 3bitr4g ) ADHEIZBJZDKQCJZDKBD
      ELCDELARSDFAQBCGMNBDEOCDEOP $.
  $}

  ${
    $d x ph $.
    reubidva.1 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 13-Nov-2004.) $)
    reubidva $p |- ( ph -> ( E! x e. A ps <-> E! x e. A ch ) ) $=
      ( nfv reubida ) ABCDEADGFH $.
  $}

  ${
    $d x ph $.
    reubidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 17-Oct-1996.) $)
    reubidv $p |- ( ph -> ( E! x e. A ps <-> E! x e. A ch ) ) $=
      ( wb cv wcel adantr reubidva ) ABCDEABCGDHEIFJK $.
  $}

  ${
    reubiia.1 $e |- ( x e. A -> ( ph <-> ps ) ) $.
    $( Formula-building rule for restricted existential quantifier (inference
       rule).  (Contributed by NM, 14-Nov-2004.) $)
    reubiia $p |- ( E! x e. A ph <-> E! x e. A ps ) $=
      ( cv wcel wa weu wreu pm5.32i eubii df-reu 3bitr4i ) CFDGZAHZCIOBHZCIACDJ
      BCDJPQCOABEKLACDMBCDMN $.
  $}

  ${
    reubii.1 $e |- ( ph <-> ps ) $.
    $( Formula-building rule for restricted existential quantifier (inference
       rule).  (Contributed by NM, 22-Oct-1999.) $)
    reubii $p |- ( E! x e. A ph <-> E! x e. A ps ) $=
      ( wb cv wcel a1i reubiia ) ABCDABFCGDHEIJ $.
  $}

  ${
    rmobida.1 $e |- F/ x ph $.
    rmobida.2 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 16-Jun-2017.) $)
    rmobida $p |- ( ph -> ( E* x e. A ps <-> E* x e. A ch ) ) $=
      ( cv wcel wa wmo wrmo pm5.32da mobid df-rmo 3bitr4g ) ADHEIZBJZDKQCJZDKBD
      ELCDELARSDFAQBCGMNBDEOCDEOP $.
  $}

  ${
    $d x ph $.
    rmobidva.1 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 16-Jun-2017.) $)
    rmobidva $p |- ( ph -> ( E* x e. A ps <-> E* x e. A ch ) ) $=
      ( nfv rmobida ) ABCDEADGFH $.
  $}

  ${
    $d x ph $.
    rmobidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Formula-building rule for restricted existential quantifier (deduction
       rule).  (Contributed by NM, 16-Jun-2017.) $)
    rmobidv $p |- ( ph -> ( E* x e. A ps <-> E* x e. A ch ) ) $=
      ( wb cv wcel adantr rmobidva ) ABCDEABCGDHEIFJK $.
  $}

  ${
    rmobiia.1 $e |- ( x e. A -> ( ph <-> ps ) ) $.
    $( Formula-building rule for restricted existential quantifier (inference
       rule).  (Contributed by NM, 16-Jun-2017.) $)
    rmobiia $p |- ( E* x e. A ph <-> E* x e. A ps ) $=
      ( cv wcel wa wmo wrmo pm5.32i mobii df-rmo 3bitr4i ) CFDGZAHZCIOBHZCIACDJ
      BCDJPQCOABEKLACDMBCDMN $.
  $}

  ${
    rmobii.1 $e |- ( ph <-> ps ) $.
    $( Formula-building rule for restricted existential quantifier (inference
       rule).  (Contributed by NM, 16-Jun-2017.) $)
    rmobii $p |- ( E* x e. A ph <-> E* x e. A ps ) $=
      ( wb cv wcel a1i rmobiia ) ABCDABFCGDHEIJ $.
  $}

  ${
    $d y A $.  $d y B $.
    raleq1f.1 $e |- F/_ x A $.
    raleq1f.2 $e |- F/_ x B $.
    $( Equality theorem for restricted universal quantifier, with
       bound-variable hypotheses instead of distinct variable restrictions.
       (Contributed by NM, 7-Mar-2004.)  (Revised by Andrew Salmon,
       11-Jul-2011.) $)
    raleqf $p |- ( A = B -> ( A. x e. A ph <-> A. x e. B ph ) ) $=
      ( wceq cv wcel wi wal wral nfeq eleq2 imbi1d albid df-ral 3bitr4g ) CDGZB
      HZCIZAJZBKTDIZAJZBKABCLABDLSUBUDBBCDEFMSUAUCACDTNOPABCQABDQR $.

    $( Equality theorem for restricted existential quantifier, with
       bound-variable hypotheses instead of distinct variable restrictions.
       (Contributed by NM, 9-Oct-2003.)  (Revised by Andrew Salmon,
       11-Jul-2011.) $)
    rexeqf $p |- ( A = B -> ( E. x e. A ph <-> E. x e. B ph ) ) $=
      ( wceq cv wcel wa wex wrex nfeq eleq2 anbi1d exbid df-rex 3bitr4g ) CDGZB
      HZCIZAJZBKTDIZAJZBKABCLABDLSUBUDBBCDEFMSUAUCACDTNOPABCQABDQR $.

    $( Equality theorem for restricted uniqueness quantifier, with
       bound-variable hypotheses instead of distinct variable restrictions.
       (Contributed by NM, 5-Apr-2004.)  (Revised by Andrew Salmon,
       11-Jul-2011.) $)
    reueq1f $p |- ( A = B -> ( E! x e. A ph <-> E! x e. B ph ) ) $=
      ( wceq cv wcel wa weu wreu nfeq eleq2 anbi1d eubid df-reu 3bitr4g ) CDGZB
      HZCIZAJZBKTDIZAJZBKABCLABDLSUBUDBBCDEFMSUAUCACDTNOPABCQABDQR $.

    $( Equality theorem for restricted uniqueness quantifier, with
       bound-variable hypotheses instead of distinct variable restrictions.
       (Contributed by Alexander van der Vekens, 17-Jun-2017.) $)
    rmoeq1f $p |- ( A = B -> ( E* x e. A ph <-> E* x e. B ph ) ) $=
      ( wceq cv wcel wa wmo wrmo nfeq eleq2 anbi1d mobid df-rmo 3bitr4g ) CDGZB
      HZCIZAJZBKTDIZAJZBKABCLABDLSUBUDBBCDEFMSUAUCACDTNOPABCQABDQR $.
  $}

  ${
    $d x y A $.  $d x y B $.
    $( Equality theorem for restricted universal quantifier.  (Contributed by
       NM, 16-Nov-1995.) $)
    raleq $p |- ( A = B -> ( A. x e. A ph <-> A. x e. B ph ) ) $=
      ( nfcv raleqf ) ABCDBCEBDEF $.

    $( Equality theorem for restricted existential quantifier.  (Contributed by
       NM, 29-Oct-1995.) $)
    rexeq $p |- ( A = B -> ( E. x e. A ph <-> E. x e. B ph ) ) $=
      ( nfcv rexeqf ) ABCDBCEBDEF $.

    $( Equality theorem for restricted uniqueness quantifier.  (Contributed by
       NM, 5-Apr-2004.) $)
    reueq1 $p |- ( A = B -> ( E! x e. A ph <-> E! x e. B ph ) ) $=
      ( nfcv reueq1f ) ABCDBCEBDEF $.

    $( Equality theorem for restricted uniqueness quantifier.  (Contributed by
       Alexander van der Vekens, 17-Jun-2017.) $)
    rmoeq1 $p |- ( A = B -> ( E* x e. A ph <-> E* x e. B ph ) ) $=
      ( nfcv rmoeq1f ) ABCDBCEBDEF $.
  $}

  ${
    $d A x $.  $d B x $.
    raleq1i.1 $e |- A = B $.
    $( Equality inference for restricted universal qualifier.  (Contributed by
       Paul Chapman, 22-Jun-2011.) $)
    raleqi $p |- ( A. x e. A ph <-> A. x e. B ph ) $=
      ( wceq wral wb raleq ax-mp ) CDFABCGABDGHEABCDIJ $.

    $( Equality inference for restricted existential qualifier.  (Contributed
       by Mario Carneiro, 23-Apr-2015.) $)
    rexeqi $p |- ( E. x e. A ph <-> E. x e. B ph ) $=
      ( wceq wrex wb rexeq ax-mp ) CDFABCGABDGHEABCDIJ $.
  $}

  ${
    $d x A $.  $d x B $.
    raleq1d.1 $e |- ( ph -> A = B ) $.
    $( Equality deduction for restricted universal quantifier.  (Contributed by
       NM, 13-Nov-2005.) $)
    raleqdv $p |- ( ph -> ( A. x e. A ps <-> A. x e. B ps ) ) $=
      ( wceq wral wb raleq syl ) ADEGBCDHBCEHIFBCDEJK $.

    $( Equality deduction for restricted existential quantifier.  (Contributed
       by NM, 14-Jan-2007.) $)
    rexeqdv $p |- ( ph -> ( E. x e. A ps <-> E. x e. B ps ) ) $=
      ( wceq wrex wb rexeq syl ) ADEGBCDHBCEHIFBCDEJK $.
  $}

  ${
    $d x A $.  $d x B $.
    raleqd.1 $e |- ( A = B -> ( ph <-> ps ) ) $.
    $( Equality deduction for restricted universal quantifier.  (Contributed by
       NM, 16-Nov-1995.) $)
    raleqbi1dv $p |- ( A = B -> ( A. x e. A ph <-> A. x e. B ps ) ) $=
      ( wceq wral raleq ralbidv bitrd ) DEGZACDHACEHBCEHACDEILABCEFJK $.

    $( Equality deduction for restricted existential quantifier.  (Contributed
       by NM, 18-Mar-1997.) $)
    rexeqbi1dv $p |- ( A = B -> ( E. x e. A ph <-> E. x e. B ps ) ) $=
      ( wceq wrex rexeq rexbidv bitrd ) DEGZACDHACEHBCEHACDEILABCEFJK $.

    $( Equality deduction for restricted uniqueness quantifier.  (Contributed
       by NM, 5-Apr-2004.) $)
    reueqd $p |- ( A = B -> ( E! x e. A ph <-> E! x e. B ps ) ) $=
      ( wceq wreu reueq1 reubidv bitrd ) DEGZACDHACEHBCEHACDEILABCEFJK $.

    $( Equality deduction for restricted uniqueness quantifier.  (Contributed
       by Alexander van der Vekens, 17-Jun-2017.) $)
    rmoeqd $p |- ( A = B -> ( E* x e. A ph <-> E* x e. B ps ) ) $=
      ( wceq wrmo rmoeq1 rmobidv bitrd ) DEGZACDHACEHBCEHACDEILABCEFJK $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ph $.
    raleqbidv.1 $e |- ( ph -> A = B ) $.
    raleqbidv.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Equality deduction for restricted universal quantifier.  (Contributed by
       NM, 6-Nov-2007.) $)
    raleqbidv $p |- ( ph -> ( A. x e. A ps <-> A. x e. B ch ) ) $=
      ( wral raleqdv ralbidv bitrd ) ABDEIBDFICDFIABDEFGJABCDFHKL $.

    $( Equality deduction for restricted universal quantifier.  (Contributed by
       NM, 6-Nov-2007.) $)
    rexeqbidv $p |- ( ph -> ( E. x e. A ps <-> E. x e. B ch ) ) $=
      ( wrex rexeqdv rexbidv bitrd ) ABDEIBDFICDFIABDEFGJABCDFHKL $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ph $.
    raleqbidva.1 $e |- ( ph -> A = B ) $.
    raleqbidva.2 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Equality deduction for restricted universal quantifier.  (Contributed by
       Mario Carneiro, 5-Jan-2017.) $)
    raleqbidva $p |- ( ph -> ( A. x e. A ps <-> A. x e. B ch ) ) $=
      ( wral ralbidva raleqdv bitrd ) ABDEICDEICDFIABCDEHJACDEFGKL $.

    $( Equality deduction for restricted universal quantifier.  (Contributed by
       Mario Carneiro, 5-Jan-2017.) $)
    rexeqbidva $p |- ( ph -> ( E. x e. A ps <-> E. x e. B ch ) ) $=
      ( wrex rexbidva rexeqdv bitrd ) ABDEICDEICDFIABCDEHJACDEFGKL $.
  $}

  $( Restricted uniqueness in terms of "at most one."  (Contributed by NM,
     23-May-1999.)  (Revised by NM, 16-Jun-2017.) $)
  reu5 $p |- ( E! x e. A ph <-> ( E. x e. A ph /\ E* x e. A ph ) ) $=
    ( cv wcel wa weu wex wmo wreu wrex eu5 df-reu df-rex df-rmo anbi12i 3bitr4i
    wrmo ) BDCEAFZBGSBHZSBIZFABCJABCKZABCRZFSBLABCMUBTUCUAABCNABCOPQ $.

  $( Restricted unique existence implies restricted existence.  (Contributed by
     NM, 19-Aug-1999.) $)
  reurex $p |- ( E! x e. A ph -> E. x e. A ph ) $=
    ( wreu wrex wrmo reu5 simplbi ) ABCDABCEABCFABCGH $.

  $( Restricted existential uniqueness implies restricted "at most one."
     (Contributed by NM, 16-Jun-2017.) $)
  reurmo $p |- ( E! x e. A ph -> E* x e. A ph ) $=
    ( wreu wrex wrmo reu5 simprbi ) ABCDABCEABCFABCGH $.

  $( Restricted "at most one" in term of uniqueness.  (Contributed by NM,
     16-Jun-2017.) $)
  rmo5 $p |- ( E* x e. A ph <-> ( E. x e. A ph -> E! x e. A ph ) ) $=
    ( cv wcel wa wmo wex weu wrmo wrex wreu df-mo df-rmo df-rex imbi12i 3bitr4i
    wi df-reu ) BDCEAFZBGTBHZTBIZRABCJABCKZABCLZRTBMABCNUCUAUDUBABCOABCSPQ $.

  $( Nonexistence implies restricted "at most one".  (Contributed by NM,
     17-Jun-2017.) $)
  nrexrmo $p |- ( -. E. x e. A ph -> E* x e. A ph ) $=
    ( wrex wn wreu wi wrmo pm2.21 rmo5 sylibr ) ABCDZELABCFZGABCHLMIABCJK $.

  ${
    $d x z $.  $d y z $.  $d z A $.  $d z ps $.  $d z ph $.
    cbvralf.1 $e |- F/_ x A $.
    cbvralf.2 $e |- F/_ y A $.
    cbvralf.3 $e |- F/ y ph $.
    cbvralf.4 $e |- F/ x ps $.
    cbvralf.5 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 7-Mar-2004.)  (Revised by Mario Carneiro,
       9-Oct-2016.) $)
    cbvralf $p |- ( A. x e. A ph <-> A. y e. A ps ) $=
      ( vz cv wcel wi wal wral wsb nfv nfcri nfim nfs1v weq eleq1 sbequ12 cbval
      imbi12d nfsb sbequ sbie syl6bb bitri df-ral 3bitr4i ) CLZEMZANZCOZDLZEMZB
      NZDOZACEPBDEPUQKLZEMZACKQZNZKOVAUPVECKUPKRVCVDCCKEFSACKUATCKUBUOVCAVDUNVB
      EUCACKUDUFUEVEUTKDVCVDDDKEGSACKDHUGTUTKRKDUBZVCUSVDBVBUREUCVFVDACDQBAKDCU
      HABCDIJUIUJUFUEUKACEULBDEULUM $.

    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by FL, 27-Apr-2008.)  (Revised by Mario Carneiro,
       9-Oct-2016.)  (Proof rewritten by Jim Kingdon, 10-Jun-2018.) $)
    cbvrexf $p |- ( E. x e. A ph <-> E. y e. A ps ) $=
      ( vz cv wcel wa wex wrex wsbc nfv nfcri nfan nfs1v wceq sbequ12
      eleq1 anbi12d cbvex nfsb sbequ sbie syl6bb bitri df-rex 3bitr4i
      ) CLZEMZANZCOZDLZEMZBNZDOZACEPBDEPUQKLZEMZACVBQZNZKOVAUPVECKUPK
      RVCVDCCKEFSACKUATUNVBUBUOVCAVDUNVBEUDACKUCUEUFVEUTKDVCVDDDKEGSA
      CKDHUGTUTKRVBURUBZVCUSVDBVBUREUDVFVDACURQBAKDCUHABCDIJUIUJUEUFU
      KACEULBDEULUM $.
  $}

  ${
    $d x z A $.  $d y z A $.  $d z ph $.  $d z ps $.
    cbvral.1 $e |- F/ y ph $.
    cbvral.2 $e |- F/ x ps $.
    cbvral.3 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 31-Jul-2003.) $)
    cbvral $p |- ( A. x e. A ph <-> A. y e. A ps ) $=
      ( nfcv cbvralf ) ABCDECEIDEIFGHJ $.

    $( Rule used to change bound variables, using implicit substitution.
       (Contributed by NM, 31-Jul-2003.)  (Proof shortened by Andrew Salmon,
       8-Jun-2011.) $)
    cbvrex $p |- ( E. x e. A ph <-> E. y e. A ps ) $=
      ( nfcv cbvrexf ) ABCDECEIDEIFGHJ $.

    $( Change the bound variable of a restricted uniqueness quantifier using
       implicit substitution.  (Contributed by Mario Carneiro, 15-Oct-2016.) $)
    cbvreu $p |- ( E! x e. A ph <-> E! y e. A ps ) $=
      ( vz cv wcel wa weu wreu wsb nfv sb8eu sban eubii df-reu anbi1i nfsb nfan
      clelsb3 weq eleq1 sbequ sbie syl6bb anbi12d cbveu bitri 3bitri 3bitr4i )
      CJEKZALZCMZDJZEKZBLZDMZACENBDENUQUPCIOZIMUOCIOZACIOZLZIMZVAUPCIUPIPQVBVEI
      UOACIRSVFIJZEKZVDLZIMVAVEVIIVCVHVDICEUDUASVIUTIDVHVDDVHDPACIDFUBUCUTIPIDU
      EZVHUSVDBVGUREUFVJVDACDOBAIDCUGABCDGHUHUIUJUKULUMACETBDETUN $.

    $( Change the bound variable of restricted "at most one" using implicit
       substitution.  (Contributed by NM, 16-Jun-2017.) $)
    cbvrmo $p |- ( E* x e. A ph <-> E* y e. A ps ) $=
      ( wrex wreu wi wrmo cbvrex cbvreu imbi12i rmo5 3bitr4i ) ACEIZACEJZKBDEIZ
      BDEJZKACELBDELRTSUAABCDEFGHMABCDEFGHNOACEPBDEPQ $.
  $}

  ${
    $d z x A $.  $d y A $.  $d z y ph $.  $d z x ps $.
    cbvralv.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Change the bound variable of a restricted universal quantifier using
       implicit substitution.  (Contributed by NM, 28-Jan-1997.) $)
    cbvralv $p |- ( A. x e. A ph <-> A. y e. A ps ) $=
      ( nfv cbvral ) ABCDEADGBCGFH $.

    $( Change the bound variable of a restricted existential quantifier using
       implicit substitution.  (Contributed by NM, 2-Jun-1998.) $)
    cbvrexv $p |- ( E. x e. A ph <-> E. y e. A ps ) $=
      ( nfv cbvrex ) ABCDEADGBCGFH $.

    $( Change the bound variable of a restricted uniqueness quantifier using
       implicit substitution.  (Contributed by NM, 5-Apr-2004.)  (Revised by
       Mario Carneiro, 15-Oct-2016.) $)
    cbvreuv $p |- ( E! x e. A ph <-> E! y e. A ps ) $=
      ( nfv cbvreu ) ABCDEADGBCGFH $.

    $( Change the bound variable of a restricted uniqueness quantifier using
       implicit substitution.  (Contributed by Alexander van der Vekens,
       17-Jun-2017.) $)
    cbvrmov $p |- ( E* x e. A ph <-> E* y e. A ps ) $=
      ( nfv cbvrmo ) ABCDEADGBCGFH $.
  $}

  ${
    $d A y $.  $d ps y $.  $d B x $.  $d ch x $.  $d x ph y $.
    cbvraldva2.1 $e |- ( ( ph /\ x = y ) -> ( ps <-> ch ) ) $.
    cbvraldva2.2 $e |- ( ( ph /\ x = y ) -> A = B ) $.
    $( Rule used to change the bound variable in a restricted universal
       quantifier with implicit substitution which also changes the quantifier
       domain.  Deduction form.  (Contributed by David Moews, 1-May-2017.) $)
    cbvraldva2 $p |- ( ph -> ( A. x e. A ps <-> A. y e. B ch ) ) $=
      ( cv wcel wi wal wral weq wa simpr eleq12d imbi12d df-ral cbvaldva
      3bitr4g ) ADJZFKZBLZDMEJZGKZCLZEMBDFNCEGNAUEUHDEADEOZPZUDUGBCUJUCUFFGAUIQ
      IRHSUABDFTCEGTUB $.

    $( Rule used to change the bound variable in a restricted existential
       quantifier with implicit substitution which also changes the quantifier
       domain.  Deduction form.  (Contributed by David Moews, 1-May-2017.) $)
    cbvrexdva2 $p |- ( ph -> ( E. x e. A ps <-> E. y e. B ch ) ) $=
      ( cv wcel wa wex wrex weq simpr eleq12d anbi12d cbvexdva df-rex 3bitr4g )
      ADJZFKZBLZDMEJZGKZCLZEMBDFNCEGNAUDUGDEADEOZLZUCUFBCUIUBUEFGAUHPIQHRSBDFTC
      EGTUA $.
  $}

  ${
    $d ps y $.  $d ch x $.  $d A x y $.  $d x ph y $.
    cbvraldva.1 $e |- ( ( ph /\ x = y ) -> ( ps <-> ch ) ) $.
    $( Rule used to change the bound variable in a restricted universal
       quantifier with implicit substitution.  Deduction form.  (Contributed by
       David Moews, 1-May-2017.) $)
    cbvraldva $p |- ( ph -> ( A. x e. A ps <-> A. y e. A ch ) ) $=
      ( weq wa eqidd cbvraldva2 ) ABCDEFFGADEHIFJK $.

    $( Rule used to change the bound variable in a restricted existential
       quantifier with implicit substitution.  Deduction form.  (Contributed by
       David Moews, 1-May-2017.) $)
    cbvrexdva $p |- ( ph -> ( E. x e. A ps <-> E. y e. A ch ) ) $=
      ( weq wa eqidd cbvrexdva2 ) ABCDEFFGADEHIFJK $.
  $}

  ${
    $d x A $.  $d z A $.  $d x y B $.  $d z y B $.  $d w B $.  $d z ph $.
    $d y ps $.  $d x ch $.  $d w ch $.
    cbvral2v.1 $e |- ( x = z -> ( ph <-> ch ) ) $.
    cbvral2v.2 $e |- ( y = w -> ( ch <-> ps ) ) $.
    $( Change bound variables of double restricted universal quantification,
       using implicit substitution.  (Contributed by NM, 10-Aug-2004.) $)
    cbvral2v $p |- ( A. x e. A A. y e. B ph <-> A. z e. A A. w e. B ps ) $=
      ( wral weq ralbidv cbvralv ralbii bitri ) AEILZDHLCEILZFHLBGILZFHLRSDFHDF
      MACEIJNOSTFHCBEGIKOPQ $.
  $}

  ${
    $d A x $.  $d A z $.  $d B w $.  $d B x y $.  $d B z y $.  $d ch w $.
    $d ch x $.  $d ph z $.  $d ps y $.
    cbvrex2v.1 $e |- ( x = z -> ( ph <-> ch ) ) $.
    cbvrex2v.2 $e |- ( y = w -> ( ch <-> ps ) ) $.
    $( Change bound variables of double restricted universal quantification,
       using implicit substitution.  (Contributed by FL, 2-Jul-2012.) $)
    cbvrex2v $p |- ( E. x e. A E. y e. B ph <-> E. z e. A E. w e. B ps ) $=
      ( wrex weq rexbidv cbvrexv rexbii bitri ) AEILZDHLCEILZFHLBGILZFHLRSDFHDF
      MACEIJNOSTFHCBEGIKOPQ $.
  $}

  ${
    $d w ph $.  $d z ps $.  $d x ch $.  $d v ch $.  $d y u th $.  $d x A $.
    $d w A $.  $d x y B $.  $d w y B $.  $d v B $.  $d x y z C $.
    $d w y z C $.  $d v z C $.  $d z y C $.  $d z C $.  $d u C $.
    cbvral3v.1 $e |- ( x = w -> ( ph <-> ch ) ) $.
    cbvral3v.2 $e |- ( y = v -> ( ch <-> th ) ) $.
    cbvral3v.3 $e |- ( z = u -> ( th <-> ps ) ) $.
    $( Change bound variables of triple restricted universal quantification,
       using implicit substitution.  (Contributed by NM, 10-May-2005.) $)
    cbvral3v $p |- ( A. x e. A A. y e. B A. z e. C ph <->
                     A. w e. A A. v e. B A. u e. C ps ) $=
      ( wral weq 2ralbidv cbvralv cbvral2v ralbii bitri ) AGMQFLQZEKQCGMQFLQZHK
      QBJMQILQZHKQUDUEEHKEHRACFGLMNSTUEUFHKCBDFGIJLMOPUAUBUC $.
  $}

  ${
    $d z x A $.  $d y A $.  $d z y ph $.
    $( Change bound variable by using a substitution.  (Contributed by NM,
       20-Nov-2005.)  (Revised by Andrew Salmon, 11-Jul-2011.) $)
    cbvralsv $p |- ( A. x e. A ph <-> A. y e. A [ y / x ] ph ) $=
      ( vz wral wsb nfv nfs1v sbequ12 cbvral nfsb sbequ bitri ) ABDFABEGZEDFABC
      GZCDFAOBEDAEHABEIABEJKOPECDABECACHLPEHAECBMKN $.
  $}

  ${
    $d z x A $.  $d y z ph $.  $d y A $.
    $( Change bound variable by using a substitution.  (Contributed by NM,
       2-Mar-2008.)  (Revised by Andrew Salmon, 11-Jul-2011.) $)
    cbvrexsv $p |- ( E. x e. A ph <-> E. y e. A [ y / x ] ph ) $=
      ( vz wrex wsb nfv nfs1v sbequ12 cbvrex nfsb sbequ bitri ) ABDFABEGZEDFABC
      GZCDFAOBEDAEHABEIABEJKOPECDABECACHLPEHAECBMKN $.
  $}

  ${
    $d x y z $.  $d y z ph $.  $d x z ps $.
    sbralie.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Implicit to explicit substitution that swaps variables in a quantified
       expression.  (Contributed by NM, 5-Sep-2004.) $)
    sbralie $p |- ( [ x / y ] A. x e. y ph <-> A. y e. x ps ) $=
      ( vz cv wral wsb cbvralsv sbbii nfv raleq sbie bitri sbco2 ralbii ) ACDGZ
      HZDCIZACFIZFCGZHZBDUBHZTUAFRHZDCIUCSUEDCACFRJKUEUCDCUCDLUAFRUBMNOUCUAFDIZ
      DUBHUDUAFDUBJUFBDUBUFACDIBACDFAFLPABCDBCLENOQOO $.
  $}

  ${
    rabbiia.1 $e |- ( x e. A -> ( ph <-> ps ) ) $.
    $( Equivalent wff's yield equal restricted class abstractions (inference
       rule).  (Contributed by NM, 22-May-1999.) $)
    rabbiia $p |- { x e. A | ph } = { x e. A | ps } $=
      ( cv wcel wa cab crab pm5.32i abbii df-rab 3eqtr4i ) CFDGZAHZCIOBHZCIACDJ
      BCDJPQCOABEKLACDMBCDMN $.
  $}

  ${
    $d x ph $.
    rabbidva.1 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Equivalent wff's yield equal restricted class abstractions (deduction
       rule).  (Contributed by NM, 28-Nov-2003.) $)
    rabbidva $p |- ( ph -> { x e. A | ps } = { x e. A | ch } ) $=
      ( wb wral crab wceq ralrimiva rabbi sylib ) ABCGZDEHBDEICDEIJANDEFKBCDELM
      $.
  $}

  ${
    $d x ph $.
    rabbidv.1 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Equivalent wff's yield equal restricted class abstractions (deduction
       rule).  (Contributed by NM, 10-Feb-1995.) $)
    rabbidv $p |- ( ph -> { x e. A | ps } = { x e. A | ch } ) $=
      ( wb cv wcel adantr rabbidva ) ABCDEABCGDHEIFJK $.
  $}

  ${
    $d y A $.  $d y B $.
    rabeqf.1 $e |- F/_ x A $.
    rabeqf.2 $e |- F/_ x B $.
    $( Equality theorem for restricted class abstractions, with bound-variable
       hypotheses instead of distinct variable restrictions.  (Contributed by
       NM, 7-Mar-2004.) $)
    rabeqf $p |- ( A = B -> { x e. A | ph } = { x e. B | ph } ) $=
      ( wceq cv wcel wa cab crab nfeq eleq2 anbi1d abbid df-rab 3eqtr4g ) CDGZB
      HZCIZAJZBKTDIZAJZBKABCLABDLSUBUDBBCDEFMSUAUCACDTNOPABCQABDQR $.
  $}

  ${
    $d x y A $.  $d x y B $.
    $( Equality theorem for restricted class abstractions.  (Contributed by NM,
       15-Oct-2003.) $)
    rabeq $p |- ( A = B -> { x e. A | ph } = { x e. B | ph } ) $=
      ( nfcv rabeqf ) ABCDBCEBDEF $.
  $}

  ${
    $d A x $.  $d B x $.  $d ph x $.
    rabeqbidv.1 $e |- ( ph -> A = B ) $.
    rabeqbidv.2 $e |- ( ph -> ( ps <-> ch ) ) $.
    $( Equality of restricted class abstractions.  (Contributed by Jeff Madsen,
       1-Dec-2009.) $)
    rabeqbidv $p |- ( ph -> { x e. A | ps } = { x e. B | ch } ) $=
      ( crab wceq rabeq syl rabbidv eqtrd ) ABDEIZBDFIZCDFIAEFJOPJGBDEFKLABCDFH
      MN $.
  $}

  ${
    $d A x $.  $d B x $.  $d ph x $.
    rabeqbidva.1 $e |- ( ph -> A = B ) $.
    rabeqbidva.2 $e |- ( ( ph /\ x e. A ) -> ( ps <-> ch ) ) $.
    $( Equality of restricted class abstractions.  (Contributed by Mario
       Carneiro, 26-Jan-2017.) $)
    rabeqbidva $p |- ( ph -> { x e. A | ps } = { x e. B | ch } ) $=
      ( crab rabbidva wceq rabeq syl eqtrd ) ABDEICDEIZCDFIZABCDEHJAEFKOPKGCDEF
      LMN $.
  $}

  ${
    rabeqi.1 $e |- A = { x e. B | ph } $.
    $( Inference rule from equality of a class variable and a restricted class
       abstraction.  (Contributed by NM, 16-Feb-2004.) $)
    rabeq2i $p |- ( x e. A <-> ( x e. B /\ ph ) ) $=
      ( cv wcel crab wa eleq2i rabid bitri ) BFZCGMABDHZGMDGAICNMEJABDKL $.
  $}

  ${
    $d x z $.  $d y z $.  $d A z $.  $d ph z $.  $d ps z $.
    cbvrab.1 $e |- F/_ x A $.
    cbvrab.2 $e |- F/_ y A $.
    cbvrab.3 $e |- F/ y ph $.
    cbvrab.4 $e |- F/ x ps $.
    cbvrab.5 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule to change the bound variable in a restricted class abstraction,
       using implicit substitution.  This version has bound-variable hypotheses
       in place of distinct variable conditions.  (Contributed by Andrew
       Salmon, 11-Jul-2011.)  (Revised by Mario Carneiro, 9-Oct-2016.) $)
    cbvrab $p |- { x e. A | ph } = { y e. A | ps } $=
      ( vz cv wcel wa cab crab wsb nfv nfcri nfan nfs1v weq eleq1 sbequ12 cbvab
      anbi12d nfsb sbequ sbie syl6bb eqtri df-rab 3eqtr4i ) CLZEMZANZCOZDLZEMZB
      NZDOZACEPBDEPUQKLZEMZACKQZNZKOVAUPVECKUPKRVCVDCCKEFSACKUATCKUBUOVCAVDUNVB
      EUCACKUDUFUEVEUTKDVCVDDDKEGSACKDHUGTUTKRKDUBZVCUSVDBVBUREUCVFVDACDQBAKDCU
      HABCDIJUIUJUFUEUKACEULBDEULUM $.
  $}

  ${
    $d x y z A $.  $d y ph $.  $d x ps $.
    cbvrabv.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Rule to change the bound variable in a restricted class abstraction,
       using implicit substitution.  (Contributed by NM, 26-May-1999.) $)
    cbvrabv $p |- { x e. A | ph } = { y e. A | ps } $=
      ( nfcv nfv cbvrab ) ABCDECEGDEGADHBCHFI $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        The universal class
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Declare the symbol for the universal class. $)
  $c _V $. $( Letter V (for the universal class) $)

  $( Extend class notation to include the universal class symbol. $)
  cvv $a class _V $.

  ${
    $d z x $.  $d z y $.
    $( Soundness justification theorem for ~ df-v .  (Contributed by Rodolfo
       Medina, 27-Apr-2010.) $)
    vjust $p |- { x | x = x } = { y | y = y } $=
      ( vz weq cab wsb cv wcel equid sbt 2th df-clab 3bitr4i eqriv ) CAADZAEZBB
      DZBEZOACFZQBCFZCGZPHUARHSTOACAIJQBCBIJKOCALQCBLMN $.
  $}

  $( Define the universal class.  Definition 5.20 of [TakeutiZaring] p. 21.
     Also Definition 2.9 of [Quine] p. 19.  (Contributed by NM, 5-Aug-1993.) $)
  df-v $a |- _V = { x | x = x } $.

  $( All set variables are sets (see ~ isset ).  Theorem 6.8 of [Quine] p. 43.
     (Contributed by NM, 5-Aug-1993.) $)
  vex $p |- x e. _V $=
    ( cv cvv wcel weq equid df-v abeq2i mpbir ) ABCDAAEZAFJACAGHI $.

  ${
    $d x A $.
    $( Two ways to say " ` A ` is a set":  A class ` A ` is a member of the
       universal class ` _V ` (see ~ df-v ) if and only if the class ` A `
       exists (i.e. there exists some set ` x ` equal to class ` A ` ).
       Theorem 6.9 of [Quine] p. 43. _Notational convention_:  We will use the
       notational device " ` A e. _V ` " to mean " ` A ` is a set" very
       frequently, for example in uniex .  Note the when ` A ` is not a set, it
       is called a proper class.  In some theorems, such as uniexg , in order
       to shorten certain proofs we use the more general antecedent ` A e. V `
       instead of ` A e. _V ` to mean " ` A ` is a set."

       Note that a constant is implicitly considered distinct from all
       variables.  This is why ` _V ` is not included in the distinct variable
       list, even though ~ df-clel requires that the expression substituted for
       ` B ` not contain ` x ` .  (Also, the Metamath spec does not allow
       constants in the distinct variable list.)  (Contributed by NM,
       5-Aug-1993.) $)
    isset $p |- ( A e. _V <-> E. x x = A ) $=
      ( cvv wcel cv wceq wa wex df-clel vex biantru exbii bitr4i ) BCDAEZBFZNCD
      ZGZAHOAHABCIOQAPOAJKLM $.
  $}

  ${
    $d A y $.  $d x y $.
    issetf.1 $e |- F/_ x A $.
    $( A version of isset that does not require x and A to be distinct.
       (Contributed by Andrew Salmon, 6-Jun-2011.)  (Revised by Mario Carneiro,
       10-Oct-2016.) $)
    issetf $p |- ( A e. _V <-> E. x x = A ) $=
      ( vy cvv wcel cv wceq wex isset nfeq2 nfv eqeq1 cbvex bitri ) BEFDGZBHZDI
      AGZBHZAIDBJQSDAAPBCKSDLPRBMNO $.
  $}

  ${
    $d x A $.
    isseti.1 $e |- A e. _V $.
    $( A way to say " ` A ` is a set" (inference rule).  (Contributed by NM,
       5-Aug-1993.) $)
    isseti $p |- E. x x = A $=
      ( cvv wcel cv wceq wex isset mpbi ) BDEAFBGAHCABIJ $.
  $}

  ${
    $d x A $.
    issetri.1 $e |- E. x x = A $.
    $( A way to say " ` A ` is a set" (inference rule).  (Contributed by NM,
       5-Aug-1993.) $)
    issetri $p |- A e. _V $=
      ( cvv wcel cv wceq wex isset mpbir ) BDEAFBGAHCABIJ $.
  $}

  ${
    $d x A $.  $d x B $.
    $( If a class is a member of another class, it is a set.  Theorem 6.12 of
       [Quine] p. 44.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by
       Andrew Salmon, 8-Jun-2011.) $)
    elex $p |- ( A e. B -> A e. _V ) $=
      ( vx cv wceq wcel wa wex cvv exsimpl df-clel isset 3imtr4i ) CDZAEZNBFZGC
      HOCHABFAIFOPCJCABKCALM $.
  $}

  ${
    elisseti.1 $e |- A e. B $.
    $( If a class is a member of another class, it is a set.  (Contributed by
       NM, 11-Jun-1994.) $)
    elexi $p |- A e. _V $=
      ( wcel cvv elex ax-mp ) ABDAEDCABFG $.
  $}

  ${
    $d x A $.
    $( An element of a class exists.  (Contributed by NM, 1-May-1995.) $)
    elisset $p |- ( A e. V -> E. x x = A ) $=
      ( wcel cvv cv wceq wex elex isset sylib ) BCDBEDAFBGAHBCIABJK $.
  $}

  ${
    $d x A $.  $d x B $.  $d x C $.
    $( If two classes each contain another class, then both contain some set.
       (Contributed by Alan Sare, 24-Oct-2011.) $)
    elex22 $p |- ( ( A e. B /\ A e. C ) -> E. x ( x e. B /\ x e. C ) ) $=
      ( wcel wa cv wceq wi wal eleq1a anim12ii alrimiv elisset adantr exim sylc
      wex ) BCEZBDEZFZAGZBHZUBCEZUBDEZFZIZAJUCARZUFARUAUGASUCUDTUEBCUBKBDUBKLMS
      UHTABCNOUCUFAPQ $.
  $}

  ${
    $d x A $.  $d x B $.
    $( If a class contains another class, then it contains some set.
       (Contributed by Alan Sare, 25-Sep-2011.) $)
    elex2 $p |- ( A e. B -> E. x x e. B ) $=
      ( wcel cv wceq wi wal wex eleq1a alrimiv elisset exim sylc ) BCDZAEZBFZPC
      DZGZAHQAIRAIOSABCPJKABCLQRAMN $.
  $}

  $( A universal quantifier restricted to the universe is unrestricted.
     (Contributed by NM, 26-Mar-2004.) $)
  ralv $p |- ( A. x e. _V ph <-> A. x ph ) $=
    ( cvv wral cv wcel wi wal df-ral vex a1bi albii bitr4i ) ABCDBECFZAGZBHABHA
    BCIAOBNABJKLM $.

  $( An existential quantifier restricted to the universe is unrestricted.
     (Contributed by NM, 26-Mar-2004.) $)
  rexv $p |- ( E. x e. _V ph <-> E. x ph ) $=
    ( cvv wrex cv wcel wa wex df-rex vex biantrur exbii bitr4i ) ABCDBECFZAGZBH
    ABHABCIAOBNABJKLM $.

  $( A uniqueness quantifier restricted to the universe is unrestricted.
     (Contributed by NM, 1-Nov-2010.) $)
  reuv $p |- ( E! x e. _V ph <-> E! x ph ) $=
    ( cvv wreu cv wcel wa weu df-reu vex biantrur eubii bitr4i ) ABCDBECFZAGZBH
    ABHABCIAOBNABJKLM $.

  $( A uniqueness quantifier restricted to the universe is unrestricted.
     (Contributed by Alexander van der Vekens, 17-Jun-2017.) $)
  rmov $p |- ( E* x e. _V ph <-> E* x ph ) $=
    ( cvv wrmo cv wcel wa wmo df-rmo vex biantrur mobii bitr4i ) ABCDBECFZAGZBH
    ABHABCIAOBNABJKLM $.

  $( A class abstraction restricted to the universe is unrestricted.
     (Contributed by NM, 27-Dec-2004.)  (Proof shortened by Andrew Salmon,
     8-Jun-2011.) $)
  rabab $p |- { x e. _V | ph } = { x | ph } $=
    ( cvv crab cv wcel wa cab df-rab vex biantrur abbii eqtr4i ) ABCDBECFZAGZBH
    ABHABCIAOBNABJKLM $.

  ${
    $d x y $.  $d y A $.
    $( Commutation of restricted and unrestricted universal quantifiers.
       (Contributed by NM, 26-Mar-2004.)  (Proof shortened by Andrew Salmon,
       8-Jun-2011.) $)
    ralcom4 $p |- ( A. x e. A A. y ph <-> A. y A. x e. A ph ) $=
      ( cvv wral wal ralcom ralv ralbii 3bitr3i ) ACEFZBDFABDFZCEFACGZBDFMCGABC
      DEHLNBDACIJMCIK $.

    $( Commutation of restricted and unrestricted existential quantifiers.
       (Contributed by NM, 12-Apr-2004.)  (Proof shortened by Andrew Salmon,
       8-Jun-2011.) $)
    rexcom4 $p |- ( E. x e. A E. y ph <-> E. y E. x e. A ph ) $=
      ( cvv wrex wex rexcom rexv rexbii 3bitr3i ) ACEFZBDFABDFZCEFACGZBDFMCGABC
      DEHLNBDACIJMCIK $.
  $}

  ${
    $d A x $.  $d x y $.  $d ph x $.
    $( Specialized existential commutation lemma.  (Contributed by Jeff Madsen,
       1-Jun-2011.) $)
    rexcom4a $p |- ( E. x E. y e. A ( ph /\ ps )
                          <-> E. y e. A ( ph /\ E. x ps ) ) $=
      ( wa wrex wex rexcom4 19.42v rexbii bitr3i ) ABFZDEGCHMCHZDEGABCHFZDEGMDC
      EINODEABCJKL $.

    $d B x $.
    rexcom4b.1 $e |- B e. _V $.
    $( Specialized existential commutation lemma.  (Contributed by Jeff Madsen,
       1-Jun-2011.) $)
    rexcom4b $p |- ( E. x E. y e. A ( ph /\ x = B ) <-> E. y e. A ph ) $=
      ( cv wceq wa wrex wex rexcom4a isseti biantru rexbii bitr4i ) ABGEHZICDJB
      KAQBKZIZCDJACDJAQBCDLASCDRABEFMNOP $.
  $}

  ${
    $d x A $.
    $( Closed theorem version of ~ ceqsalg .  (Contributed by NM,
       28-Feb-2013.)  (Revised by Mario Carneiro, 10-Oct-2016.) $)
    ceqsalt $p |- ( ( F/ x ps /\ A. x ( x = A -> ( ph <-> ps ) ) /\ A e. V )
         -> ( A. x ( x = A -> ph ) <-> ps ) ) $=
      ( wnf cv wceq wb wi wal wcel w3a wex elisset 3ad2ant3 bi1 imim3i 3ad2ant2
      3ad2ant1 al2imi 19.23t sylibd mpid imim2i com23 alimi 19.21t mpbid impbid
      bi2 ) BCFZCGDHZABIZJZCKZDELZMZUMAJZCKZBURUTUMCNZBUQULVAUPCDEOPURUTUMBJZCK
      ZVABJZUPULUTVCJUQUOUSVBCUNABUMABQRUASULUPVCVDIUQUMBCUBTUCUDURBUSJZCKZBUTJ
      ZUPULVFUQUOVECUOUMBAUNBAJUMABUKUEUFUGSULUPVFVGIUQBUSCUHTUIUJ $.
  $}

  ${
    $d x A $.  $d x B $.
    $( Restricted quantifier version of ~ ceqsalt .  (Contributed by NM,
       28-Feb-2013.)  (Revised by Mario Carneiro, 10-Oct-2016.) $)
    ceqsralt $p |- ( ( F/ x ps
              /\ A. x ( x = A -> ( ph <-> ps ) ) /\ A e. B )
         -> ( A. x e. B ( x = A -> ph ) <-> ps ) ) $=
      ( wnf cv wceq wb wi wal wcel w3a wral df-ral eleq1 pm5.32ri imbi1i impexp
      wa 3bitr3i albii a1i syl5bb 19.21v syl6bb biimt 3ad2ant3 ceqsalt 3bitr2d
      ) BCFZCGZDHZABIJCKZDELZMZUMAJZCENZUOUQCKZJZUSBUPURUOUQJZCKZUTURULELZUQJZC
      KZUPVBUQCEOVEVBIUPVDVACVCUMTZAJUOUMTZAJVDVAVFVGAUMVCUOULDEPQRVCUMASUOUMAS
      UAUBUCUDUOUQCUEUFUOUKUSUTIUNUOUSUGUHABCDEUIUJ $.
  $}

  ${
    $d x A $.
    ceqsalg.1 $e |- F/ x ps $.
    ceqsalg.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( A representation of explicit substitution of a class for a variable,
       inferred from an implicit substitution hypothesis.  (Contributed by NM,
       29-Oct-2003.)  (Proof shortened by Andrew Salmon, 8-Jun-2011.) $)
    ceqsalg $p |- ( A e. V -> ( A. x ( x = A -> ph ) <-> ps ) ) $=
      ( wcel cv wceq wi wal wex elisset nfa1 biimpd a2i sps exlimd syl5com
      biimprcd alrimi impbid1 ) DEHZCIDJZAKZCLZBUDUECMUGBCDENUGUEBCUFCOFUFUEBKC
      UEABUEABGPQRSTBUFCFUEABGUAUBUC $.
  $}

  ${
    $d x A $.
    ceqsal.1 $e |- F/ x ps $.
    ceqsal.2 $e |- A e. _V $.
    ceqsal.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( A representation of explicit substitution of a class for a variable,
       inferred from an implicit substitution hypothesis.  (Contributed by NM,
       18-Aug-1993.) $)
    ceqsal $p |- ( A. x ( x = A -> ph ) <-> ps ) $=
      ( cvv wcel cv wceq wi wal wb ceqsalg ax-mp ) DHICJDKALCMBNFABCDHEGOP $.
  $}

  ${
    $d x A $.  $d x ps $.
    ceqsalv.1 $e |- A e. _V $.
    ceqsalv.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( A representation of explicit substitution of a class for a variable,
       inferred from an implicit substitution hypothesis.  (Contributed by NM,
       18-Aug-1993.) $)
    ceqsalv $p |- ( A. x ( x = A -> ph ) <-> ps ) $=
      ( nfv ceqsal ) ABCDBCGEFH $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ps $.
    ceqsralv.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Restricted quantifier version of ~ ceqsalv .  (Contributed by NM,
       21-Jun-2013.) $)
    ceqsralv $p |- ( A e. B -> ( A. x e. B ( x = A -> ph ) <-> ps ) ) $=
      ( wnf cv wceq wb wi wal wcel wral nfv ax-gen ceqsralt mp3an12 ) BCGCHDIZA
      BJKZCLDEMSAKCENBJBCOTCFPABCDEQR $.
  $}

  ${
    $d x ps $.
    gencl.1 $e |- ( th <-> E. x ( ch /\ A = B ) ) $.
    gencl.2 $e |- ( A = B -> ( ph <-> ps ) ) $.
    gencl.3 $e |- ( ch -> ph ) $.
    $( Implicit substitution for class with embedded variable.  (Contributed by
       NM, 17-May-1996.) $)
    gencl $p |- ( th -> ps ) $=
      ( wceq wa wex syl5ib impcom exlimiv sylbi ) DCFGKZLZEMBHSBERCBCARBJINOPQ
      $.
  $}

  ${
    $d x y $.  $d x R $.  $d x ps $.  $d y C $.  $d y S $.  $d y ch $.
    2gencl.1 $e |- ( C e. S <-> E. x e. R A = C ) $.
    2gencl.2 $e |- ( D e. S <-> E. y e. R B = D ) $.
    2gencl.3 $e |- ( A = C -> ( ph <-> ps ) ) $.
    2gencl.4 $e |- ( B = D -> ( ps <-> ch ) ) $.
    2gencl.5 $e |- ( ( x e. R /\ y e. R ) -> ph ) $.
    $( Implicit substitution for class with embedded variable.  (Contributed by
       NM, 17-May-1996.) $)
    2gencl $p |- ( ( C e. S /\ D e. S ) -> ch ) $=
      ( wcel wi cv wceq wrex wa wex df-rex bitri imbi2d ex gencl com12 impcom )
      IKQZHKQZCULBRULCRESJQZUKEGIUKGITZEJUAUMUNUBEUCMUNEJUDUEUNBCULOUFULUMBUMAR
      UMBRDSJQZULDFHULFHTZDJUAUOUPUBDUCLUPDJUDUEUPABUMNUFUOUMAPUGUHUIUHUJ $.
  $}

  ${
    $d x y z $.  $d y z D $.  $d z F $.  $d x y R $.  $d y z S $.  $d x ps $.
    $d y ch $.  $d z th $.
    3gencl.1 $e |- ( D e. S <-> E. x e. R A = D ) $.
    3gencl.2 $e |- ( F e. S <-> E. y e. R B = F ) $.
    3gencl.3 $e |- ( G e. S <-> E. z e. R C = G ) $.
    3gencl.4 $e |- ( A = D -> ( ph <-> ps ) ) $.
    3gencl.5 $e |- ( B = F -> ( ps <-> ch ) ) $.
    3gencl.6 $e |- ( C = G -> ( ch <-> th ) ) $.
    3gencl.7 $e |- ( ( x e. R /\ y e. R /\ z e. R ) -> ph ) $.
    $( Implicit substitution for class with embedded variable.  (Contributed by
       NM, 17-May-1996.) $)
    3gencl $p |- ( ( D e. S /\ F e. S /\ G e. S ) -> th ) $=
      ( wcel wa wi wceq wrex wex df-rex bitri imbi2d 3expia 2gencl com12 3impia
      cv gencl ) KMUCZNMUCZOMUCZDUTURUSUDZDVACUEVADUEGUPLUCZUTGJOUTJOUFZGLUGVBV
      CUDGUHRVCGLUIUJVCCDVAUAUKVAVBCVBAUEVBBUEVBCUEEFHIKNLMPQHKUFABVBSUKINUFBCV
      BTUKEUPLUCFUPLUCVBAUBULUMUNUQUNUO $.
  $}

  ${
    $d x A $.  $d x ps $.
    cgsexg.1 $e |- ( x = A -> ch ) $.
    cgsexg.2 $e |- ( ch -> ( ph <-> ps ) ) $.
    $( Implicit substitution inference for general classes.  (Contributed by
       NM, 26-Aug-2007.) $)
    cgsexg $p |- ( A e. V ->
                     ( E. x ( ch /\ ph ) <-> ps ) ) $=
      ( wcel wa wex biimpa exlimiv cv wceq elisset eximi syl biimprcd ancld
      eximdv syl5com impbid2 ) EFIZCAJZDKZBUEBDCABHLMUDCDKZBUFUDDNEOZDKUGDEFPUH
      CDGQRBCUEDBCACABHSTUAUBUC $.
  $}

  ${
    $d x y ps $.  $d x y A $.  $d x y B $.
    cgsex2g.1 $e |- ( ( x = A /\ y = B ) -> ch ) $.
    cgsex2g.2 $e |- ( ch -> ( ph <-> ps ) ) $.
    $( Implicit substitution inference for general classes.  (Contributed by
       NM, 26-Jul-1995.) $)
    cgsex2g $p |- ( ( A e. V /\ B e. W ) ->
                     ( E. x E. y ( ch /\ ph ) <-> ps ) ) $=
      ( wcel wa wex biimpa exlimivv cv wceq elisset anim12i eeanv sylibr 2eximi
      syl biimprcd ancld 2eximdv syl5com impbid2 ) FHLZGILZMZCAMZENDNZBUMBDECAB
      KOPULCENDNZBUNULDQFRZEQGRZMZENDNZUOULUPDNZUQENZMUSUJUTUKVADFHSEGISTUPUQDE
      UAUBURCDEJUCUDBCUMDEBCACABKUEUFUGUHUI $.
  $}

  ${
    $d x y z w A $.  $d x y z w B $.  $d x y z w C $.  $d x y z w D $.
    $d x y z w ps $.
    cgsex4g.1 $e |- ( ( ( x = A /\ y = B ) /\ ( z = C /\ w = D ) ) -> ch ) $.
    cgsex4g.2 $e |- ( ch -> ( ph <-> ps ) ) $.
    $( An implicit substitution inference for 4 general classes.  (Contributed
       by NM, 5-Aug-1995.) $)
    cgsex4g $p |- ( ( ( A e. R /\ B e. S ) /\ ( C e. R /\ D e. S ) ) ->
                    ( E. x E. y E. z E. w ( ch /\ ph ) <-> ps ) ) $=
      ( wcel wa wex cv wceq biimpa exlimivv elisset anim12i eeanv sylibr ee4anv
      2eximi syl biimprcd ancld 2eximdv syl5com impbid2 ) HLPZIMPZQZJLPZKMPZQZQ
      ZCAQZGRFRZERDRZBVCBDEVBBFGCABOUAUBUBVACGRFRZERDRZBVDVADSHTZESITZQZFSJTZGS
      KTZQZQZGRFRZERDRZVFVAVIERDRZVLGRFRZQVOUQVPUTVQUQVGDRZVHERZQVPUOVRUPVSDHLU
      CEIMUCUDVGVHDEUEUFUTVJFRZVKGRZQVQURVTUSWAFJLUCGKMUCUDVJVKFGUEUFUDVIVLDEFG
      UGUFVNVEDEVMCFGNUHUHUIBVEVCDEBCVBFGBCACABOUJUKULULUMUN $.
  $}

  ${
    $d x A $.
    ceqsex.1 $e |- F/ x ps $.
    ceqsex.2 $e |- A e. _V $.
    ceqsex.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Elimination of an existential quantifier, using implicit substitution.
       (Contributed by NM, 2-Mar-1995.)  (Revised by Mario Carneiro,
       10-Oct-2016.) $)
    ceqsex $p |- ( E. x ( x = A /\ ph ) <-> ps ) $=
      ( cv wceq wa wex biimpa exlimi wi wal biimprcd alrimi isseti exintr ee10
      impbii ) CHDIZAJZCKZBUCBCEUBABGLMBUBANZCOUBCKUDBUECEUBABGPQCDFRUBACSTUA
      $.
  $}

  ${
    $d x A $.  $d x ps $.
    ceqsexv.1 $e |- A e. _V $.
    ceqsexv.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Elimination of an existential quantifier, using implicit substitution.
       (Contributed by NM, 2-Mar-1995.) $)
    ceqsexv $p |- ( E. x ( x = A /\ ph ) <-> ps ) $=
      ( nfv ceqsex ) ABCDBCGEFH $.
  $}

  ${
    $d x y A $.  $d x y B $.
    ceqsex2.1 $e |- F/ x ps $.
    ceqsex2.2 $e |- F/ y ch $.
    ceqsex2.3 $e |- A e. _V $.
    ceqsex2.4 $e |- B e. _V $.
    ceqsex2.5 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsex2.6 $e |- ( y = B -> ( ps <-> ch ) ) $.
    $( Elimination of two existential quantifiers, using implicit
       substitution.  (Contributed by Scott Fenton, 7-Jun-2006.) $)
    ceqsex2 $p |- ( E. x E. y ( x = A /\ y = B /\ ph ) <-> ch ) $=
      ( cv wceq w3a wex wa exbii ceqsex 3anass 19.42v nfan anbi2d exbidv 3bitri
      bitri nfv nfex ) DNFOZENGOZAPZEQZDQUJUKARZEQZRZDQUKBRZEQZCUMUPDUMUJUNRZEQ
      UPULUSEUJUKAUASUJUNEUBUGSUOURDFUQDEUKBDUKDUHHUCUIJUJUNUQEUJABUKLUDUETBCEG
      IKMTUF $.
  $}

  ${
    $d x y A $.  $d x y B $.  $d x ps $.  $d y ch $.
    ceqsex2v.1 $e |- A e. _V $.
    ceqsex2v.2 $e |- B e. _V $.
    ceqsex2v.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsex2v.4 $e |- ( y = B -> ( ps <-> ch ) ) $.
    $( Elimination of two existential quantifiers, using implicit
       substitution.  (Contributed by Scott Fenton, 7-Jun-2006.) $)
    ceqsex2v $p |- ( E. x E. y ( x = A /\ y = B /\ ph ) <-> ch ) $=
      ( nfv ceqsex2 ) ABCDEFGBDLCELHIJKM $.
  $}

  ${
    $d x y z A $.  $d x y z B $.  $d x y z C $.  $d x ps $.  $d y ch $.
    $d z th $.
    ceqsex3v.1 $e |- A e. _V $.
    ceqsex3v.2 $e |- B e. _V $.
    ceqsex3v.3 $e |- C e. _V $.
    ceqsex3v.4 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsex3v.5 $e |- ( y = B -> ( ps <-> ch ) ) $.
    ceqsex3v.6 $e |- ( z = C -> ( ch <-> th ) ) $.
    $( Elimination of three existential quantifiers, using implicit
       substitution.  (Contributed by NM, 16-Aug-2011.) $)
    ceqsex3v $p |- ( E. x E. y E. z ( ( x = A /\ y = B /\ z = C ) /\ ph )
                 <-> th ) $=
      ( cv wceq wa wex anass 3anass anbi1i df-3an anbi2i 3bitr4i 2exbii 19.42vv
      w3a bitri exbii 3anbi3d 2exbidv ceqsexv ceqsex2v ) EQHRZFQIRZGQJRZUIZASZG
      TFTZETUPUQURAUIZGTFTZSZETZDVAVDEVAUPVBSZGTFTVDUTVFFGUPUQURSZSZASUPVGASZSU
      TVFUPVGAUAUSVHAUPUQURUBUCVBVIUPUQURAUDUEUFUGUPVBFGUHUJUKVEUQURBUIZGTFTZDV
      CVKEHKUPVBVJFGUPABUQURNULUMUNBCDFGIJLMOPUOUJUJ $.
  $}

  ${
    $d x y z w A $.  $d x y z w B $.  $d x y z w C $.  $d x y z w D $.
    $d x ps $.  $d y ch $.  $d z th $.  $d w ta $.
    ceqsex4v.1 $e |- A e. _V $.
    ceqsex4v.2 $e |- B e. _V $.
    ceqsex4v.3 $e |- C e. _V $.
    ceqsex4v.4 $e |- D e. _V $.
    ceqsex4v.7 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsex4v.8 $e |- ( y = B -> ( ps <-> ch ) ) $.
    ceqsex4v.9 $e |- ( z = C -> ( ch <-> th ) ) $.
    ceqsex4v.10 $e |- ( w = D -> ( th <-> ta ) ) $.
    $( Elimination of four existential quantifiers, using implicit
       substitution.  (Contributed by NM, 23-Sep-2011.) $)
    ceqsex4v $p |- ( E. x E. y E. z E. w
          ( ( x = A /\ y = B ) /\ ( z = C /\ w = D ) /\ ph ) <-> ta ) $=
      ( wceq w3a wex 19.42vv 3anass df-3an anbi2i bitr4i 2exbii 3bitr4i 3anbi3d
      cv wa 2exbidv ceqsex2v 3bitri ) FUMJUBZGUMKUBZUNZHUMLUBZIUMMUBZUNZAUCZIUD
      HUDZGUDFUDURUSVAVBAUCZIUDHUDZUCZGUDFUDVAVBCUCZIUDHUDZEVEVHFGUTVFUNZIUDHUD
      UTVGUNVEVHUTVFHIUEVDVKHIVDUTVCAUNZUNVKUTVCAUFVFVLUTVAVBAUGUHUIUJURUSVGUGU
      KUJVGVAVBBUCZIUDHUDVJFGJKNOURVFVMHIURABVAVBRULUOUSVMVIHIUSBCVAVBSULUOUPCD
      EHILMPQTUAUPUQ $.
  $}

  ${
    $d x y z w v u A $.  $d x y z w v u B $.  $d x y z w v u C $.
    $d x y z w v u D $.  $d x y z w v u E $.  $d x y z w v u F $.  $d x ps $.
    $d y ch $.  $d z th $.  $d w ta $.  $d v et $.  $d u ze $.
    ceqsex6v.1 $e |- A e. _V $.
    ceqsex6v.2 $e |- B e. _V $.
    ceqsex6v.3 $e |- C e. _V $.
    ceqsex6v.4 $e |- D e. _V $.
    ceqsex6v.5 $e |- E e. _V $.
    ceqsex6v.6 $e |- F e. _V $.
    ceqsex6v.7 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsex6v.8 $e |- ( y = B -> ( ps <-> ch ) ) $.
    ceqsex6v.9 $e |- ( z = C -> ( ch <-> th ) ) $.
    ceqsex6v.10 $e |- ( w = D -> ( th <-> ta ) ) $.
    ceqsex6v.11 $e |- ( v = E -> ( ta <-> et ) ) $.
    ceqsex6v.12 $e |- ( u = F -> ( et <-> ze ) ) $.
    $( Elimination of six existential quantifiers, using implicit
       substitution.  (Contributed by NM, 21-Sep-2011.) $)
    ceqsex6v $p |- ( E. x E. y E. z E. w E. v E. u
          ( ( x = A /\ y = B /\ z = C ) /\ ( w = D /\ v = E /\ u = F ) /\ ph )
                 <-> ze ) $=
      ( cv wceq w3a wex wa 3anass 3exbii 19.42vvv bitri anbi2d 3exbidv ceqsex3v
      ) HULNUMZIULOUMZJULPUMZUNZKULQUMLULRUMMULSUMUNZAUNZMUOLUOKUOZJUOIUOHUOVGV
      HAUPZMUOLUOKUOZUPZJUOIUOHUOZGVJVMHIJVJVGVKUPZMUOLUOKUOVMVIVOKLMVGVHAUQURV
      GVKKLMUSUTURVNVHDUPZMUOLUOKUOZGVLVHBUPZMUOLUOKUOVHCUPZMUOLUOKUOVQHIJNOPTU
      AUBVDVKVRKLMVDABVHUFVAVBVEVRVSKLMVEBCVHUGVAVBVFVSVPKLMVFCDVHUHVAVBVCDEFGK
      LMQRSUCUDUEUIUJUKVCUTUT $.
  $}

  ${
    $d x y z w v u t s A $.  $d x y z w v u t s B $.  $d x y z w v u t s C $.
    $d x y z w v u t s D $.  $d x y z w v u t s E $.  $d x y z w v u t s F $.
    $d x y z w v u t s G $.  $d x y z w v u t s H $.  $d x ps $.  $d y ch $.
    $d z th $.  $d w ta $.  $d v et $.  $d u ze $.  $d t si $.  $d s rh $.
    ceqsex8v.1 $e |- A e. _V $.
    ceqsex8v.2 $e |- B e. _V $.
    ceqsex8v.3 $e |- C e. _V $.
    ceqsex8v.4 $e |- D e. _V $.
    ceqsex8v.5 $e |- E e. _V $.
    ceqsex8v.6 $e |- F e. _V $.
    ceqsex8v.7 $e |- G e. _V $.
    ceqsex8v.8 $e |- H e. _V $.
    ceqsex8v.9 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsex8v.10 $e |- ( y = B -> ( ps <-> ch ) ) $.
    ceqsex8v.11 $e |- ( z = C -> ( ch <-> th ) ) $.
    ceqsex8v.12 $e |- ( w = D -> ( th <-> ta ) ) $.
    ceqsex8v.13 $e |- ( v = E -> ( ta <-> et ) ) $.
    ceqsex8v.14 $e |- ( u = F -> ( et <-> ze ) ) $.
    ceqsex8v.15 $e |- ( t = G -> ( ze <-> si ) ) $.
    ceqsex8v.16 $e |- ( s = H -> ( si <-> rh ) ) $.
    $( Elimination of eight existential quantifiers, using implicit
       substitution.  (Contributed by NM, 23-Sep-2011.) $)
    ceqsex8v $p |- ( E. x E. y E. z E. w E. v E. u E. t E. s
              ( ( ( x = A /\ y = B ) /\ ( z = C /\ w = D ) )
         /\ ( ( v = E /\ u = F ) /\ ( t = G /\ s = H ) ) /\ ph ) <-> rh ) $=
      ( cv wceq wa w3a 19.42vv 2exbii bitri 3anass df-3an anbi2i bitr4i 3bitr4i
      wex 3anbi3d 4exbidv ceqsex4v ) JVBQVCZKVBRVCZVDZLVBSVCZMVBTVCZVDZVDZNVBUA
      VCOVBUBVCVDZPVBUCVCUEVBUDVCVDZVDZAVEZUEVNPVNZOVNNVNZMVNLVNZKVNJVNVTWCWEWF
      AVEZUEVNPVNZOVNNVNZVEZMVNLVNZKVNJVNZIWKWPJKWJWOLMWDWLVDZUEVNPVNZOVNNVNZWD
      WNVDZWJWOWTWDWMVDZOVNNVNXAWSXBNOWDWLPUEVFVGWDWMNOVFVHWIWSNOWHWRPUEWHWDWGA
      VDZVDWRWDWGAVIWLXCWDWEWFAVJVKVLVGVGVTWCWNVJVMVGVGWQWEWFEVEZUEVNPVNOVNNVNZ
      IWNWEWFBVEZUEVNPVNOVNNVNWEWFCVEZUEVNPVNOVNNVNWEWFDVEZUEVNPVNOVNNVNXEJKLMQ
      RSTUFUGUHUIVRWLXFNOPUEVRABWEWFUNVOVPVSXFXGNOPUEVSBCWEWFUOVOVPWAXGXHNOPUEW
      ACDWEWFUPVOVPWBXHXDNOPUEWBDEWEWFUQVOVPVQEFGHINOPUEUAUBUCUDUJUKULUMURUSUTV
      AVQVHVH $.
  $}

  ${
    $d x ps $.  $d y ph $.  $d x th $.  $d y ch $.  $d y A $.
    gencbvex.1 $e |- A e. _V $.
    gencbvex.2 $e |- ( A = y -> ( ph <-> ps ) ) $.
    gencbvex.3 $e |- ( A = y -> ( ch <-> th ) ) $.
    gencbvex.4 $e |- ( th <-> E. x ( ch /\ A = y ) ) $.
    $( Change of bound variable using implicit substitution.  (Contributed by
       NM, 17-May-1996.)  (Proof shortened by Andrew Salmon, 8-Jun-2011.) $)
    gencbvex $p |- ( E. x ( ch /\ ph ) <-> E. y ( th /\ ps ) ) $=
      ( cv wceq wa wex excom wb anbi12d bicomd exbii eqcoms ceqsexv simpr eqcom
      19.41v biimpi adantl eximi sylbi adantr ancri impbii bitri 3bitr3i ) FLZG
      MZDBNZNZFOZEOUREOZFOCANZEOUQFOUREFPUSVAEUQVAFGHUQVAQGUOGUOMZVAUQVBCDABJIR
      SUAUBTUTUQFUTUPEOZUQNZUQUPUQEUEVDUQVCUQUCUQVCDVCBDCVBNZEOVCKVEUPEVBUPCVBU
      PGUOUDUFUGUHUIUJUKULUMTUN $.
  $}

  ${
    $d x ps $.  $d y ph $.  $d x th $.  $d y ch $.  $d y A $.
    gencbvex2.1 $e |- A e. _V $.
    gencbvex2.2 $e |- ( A = y -> ( ph <-> ps ) ) $.
    gencbvex2.3 $e |- ( A = y -> ( ch <-> th ) ) $.
    gencbvex2.4 $e |- ( th -> E. x ( ch /\ A = y ) ) $.
    $( Restatement of ~ gencbvex with weaker hypotheses.  (Contributed by
       Jeffrey Hankins, 6-Dec-2006.) $)
    gencbvex2 $p |- ( E. x ( ch /\ ph ) <-> E. y ( th /\ ps ) ) $=
      ( cv wceq wa wex biimpac exlimiv impbii gencbvex ) ABCDEFGHIJDCGFLMZNZEOK
      UADETCDJPQRS $.
  $}

  ${
    $d x ps $.  $d y ph $.  $d x th $.  $d y ch $.  $d y A $.
    gencbval.1 $e |- A e. _V $.
    gencbval.2 $e |- ( A = y -> ( ph <-> ps ) ) $.
    gencbval.3 $e |- ( A = y -> ( ch <-> th ) ) $.
    gencbval.4 $e |- ( th <-> E. x ( ch /\ A = y ) ) $.
    $( Change of bound variable using implicit substitution.  (Contributed by
       NM, 17-May-1996.)  (Proof rewritten by Jim Kingdon, 20-Jun-2018.) $)
    gencbval $p |- ( A. x ( ch -> ph ) <-> A. y ( th -> ps ) ) $=
      ( cv wceq wi wal alcom wb imbi12d albii wex bicomd eqcoms 19.23v wa eqcom
      ceqsalv biimpi adantl eximi sylbi pm2.04 mpdi ax-1 impbii bitri 3bitr3i )
      FLZGMZDBNZNZFOZEOUTEOZFOCANZEOUSFOUTEFPVAVCEUSVCFGHUSVCQGUQGUQMZVCUSVDCDA
      BJIRUAUBUFSVBUSFVBURETZUSNZUSURUSEUCVFUSVFDVEBDCVDUDZETVEKVGUREVDURCVDURG
      UQUEUGUHUIUJVEDBUKULUSVEUMUNUOSUP $.
  $}

  ${
    $d A x $.  $d x y $.
    sbhypf.1 $e |- F/ x ps $.
    sbhypf.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Introduce an explicit substitution into an implicit substitution
       hypothesis.  See also csbhypf .  (Contributed by Raph Levien,
       10-Apr-2004.) $)
    sbhypf $p |- ( y = A -> ( [ y / x ] ph <-> ps ) ) $=
      ( cv wceq wa wex wsb wb vex eqeq1 ceqsexv nfs1v nfbi sbequ12 bicomd
      sylan9bb exlimi sylbir ) DHZEIZCHZUDIZUFEIZJZCKACDLZBMZUHUECUDDNUFUDEOPUI
      UKCUJBCACDQFRUGUJAUHBUGAUJACDSTGUAUBUC $.
  $}

  ${
    $d y z A $.  $d x z $.  $d y z $.
    $( Closed theorem form of ~ vtoclgf .  (Contributed by NM, 17-Feb-2013.)
       (Revised by Mario Carneiro, 12-Oct-2016.) $)
    vtoclgft $p |- ( ( ( F/_ x A /\ F/ x ps )
                  /\ ( A. x ( x = A -> ( ph <-> ps ) )
                     /\ A. x ph ) /\ A e. V ) -> ps ) $=
      ( vz wcel wnfc wnf wa cv wceq wb wi wal cvv elex w3a wex mpbid elisset id
      3ad2ant3 nfnfc1 nfcvd nfeqd eqeq1 a1i cbvexd 3adant3 bi1 imim2i com23 imp
      ad2antrr alanimi 3ad2ant2 simp1r 19.23t syl mpd syl3an3 ) DEGCDHZBCIZJZCK
      ZDLZABMZNZCOACOJZDPGZBDEQVEVJVKRZVGCSZBVLFKZDLZFSZVMVKVEVPVJFDPUAUCVEVJVP
      VMMZVKVCVQVDVJVCVOVGFCCDUDVCCVNDVCCVNUEVCUBUFVNVFLVOVGMNVCVNVFDUGUHUIUOUJ
      TVLVGBNZCOZVMBNZVJVEVSVKVIAVRCVIAVRVIVGABVHABNVGABUKULUMUNUPUQVLVDVSVTMVC
      VDVJVKURVGBCUSUTTVAVB $.
  $}

  ${
    vtocld.1 $e |- ( ph -> A e. V ) $.
    vtocld.2 $e |- ( ( ph /\ x = A ) -> ( ps <-> ch ) ) $.
    vtocld.3 $e |- ( ph -> ps ) $.
    ${
      vtocldf.4 $e |- F/ x ph $.
      vtocldf.5 $e |- ( ph -> F/_ x A ) $.
      vtocldf.6 $e |- ( ph -> F/ x ch ) $.
      $( Implicit substitution of a class for a set variable.  (Contributed by
         Mario Carneiro, 15-Oct-2016.) $)
      vtocldf $p |- ( ph -> ch ) $=
        ( wnfc wnf cv wceq wb wi wal alrimi wcel ex vtoclgft syl221anc ) ADEMCD
        NDOEPZBCQZRZDSBDSEFUACKLAUGDJAUEUFHUBTABDJITGBCDEFUCUD $.
    $}

    $d x A $.  $d x ph $.  $d x ch $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       Mario Carneiro, 15-Oct-2016.) $)
    vtocld $p |- ( ph -> ch ) $=
      ( nfv nfcvd nfvd vtocldf ) ABCDEFGHIADJADEKACDLM $.
  $}

  ${
    $d x A $.
    vtoclf.1 $e |- F/ x ps $.
    vtoclf.2 $e |- A e. _V $.
    vtoclf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtoclf.4 $e |- ph $.
    $( Implicit substitution of a class for a set variable.  This is a
       generalization of ~ chvar .  (Contributed by NM, 30-Aug-1993.) $)
    vtoclf $p |- ps $=
      ( cv wceq wi isseti biimpd eximii 19.36i mpg ) ABCABCECIDJZABKCCDFLQABGMN
      OHP $.
  $}

  ${
    $d x A $.  $d x ps $.
    vtocl.1 $e |- A e. _V $.
    vtocl.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl.3 $e |- ph $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 30-Aug-1993.) $)
    vtocl $p |- ps $=
      ( nfv vtoclf ) ABCDBCHEFGI $.
  $}

  ${
    $d x y A $.  $d x y B $.  $d x y ps $.
    vtocl2.1 $e |- A e. _V $.
    vtocl2.2 $e |- B e. _V $.
    vtocl2.3 $e |- ( ( x = A /\ y = B ) -> ( ph <-> ps ) ) $.
    vtocl2.4 $e |- ph $.
    $( Implicit substitution of classes for set variables.  (Contributed by NM,
       26-Jul-1995.)  (Proof shortened by Andrew Salmon, 8-Jun-2011.) $)
    vtocl2 $p |- ps $=
      ( wal wi wex cv wceq isseti wa eeanv biimpd 2eximi mp2an 19.36-1 19.36aiv
      sylbir nfv eximii ax-gen mpg ) ADKZBCUIBCABLZDMZUIBLCCNEOZCMZDNFOZDMZUKCM
      ZCEGPDFHPUMUOQULUNQZDMCMUPULUNCDRUQUJCDUQABISTUDUAABDBDUEUBUFUCADJUGUH $.
  $}

  ${
    $d x y z A $.  $d x y z B $.  $d x y z C $.  $d x y z ps $.
    vtocl3.1 $e |- A e. _V $.
    vtocl3.2 $e |- B e. _V $.
    vtocl3.3 $e |- C e. _V $.
    vtocl3.4 $e |- ( ( x = A /\ y = B /\ z = C ) -> ( ph <-> ps ) ) $.
    vtocl3.5 $e |- ph $.
    $( Implicit substitution of classes for set variables.  (Contributed by NM,
       3-Jun-1995.)  (Proof shortened by Andrew Salmon, 8-Jun-2011.) $)
    vtocl3 $p |- ps $=
      ( wal wi wex cv wceq isseti w3a eeeanv biimpd 2eximi sylbir nfv
      eximi mp3an 19.36-1 ax-mp eximii 19.36aiv gen2 mpg ) AENZDNZBCU
      OBCUNBOZDPZUOBOCABOZEPZDPCPZUQCPCQFRZCPZDQGRZDPZEQHRZEPZUTCFISD
      GJSEHKSVBVDVFTVAVCVETZEPZDPCPUTVAVCVECDEUAVHUSCDVGUREVGABLUBUFU
      CUDUGUSUPCDABEBEUEUHUCUIUNBDBDUEUHUJUKADEMULUM $.
  $}

  ${
    $d x A $.  $d x ch $.  $d x th $.
    vtoclb.1 $e |- A e. _V $.
    vtoclb.2 $e |- ( x = A -> ( ph <-> ch ) ) $.
    vtoclb.3 $e |- ( x = A -> ( ps <-> th ) ) $.
    vtoclb.4 $e |- ( ph <-> ps ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 23-Dec-1993.) $)
    vtoclb $p |- ( ch <-> th ) $=
      ( wb cv wceq bibi12d vtocl ) ABKCDKEFGELFMACBDHINJO $.
  $}

  ${
    vtoclgf.1 $e |- F/_ x A $.
    vtoclgf.2 $e |- F/ x ps $.
    vtoclgf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtoclgf.4 $e |- ph $.
    $( Implicit substitution of a class for a set variable, with bound-variable
       hypotheses in place of distinct variable restrictions.  (Contributed by
       NM, 21-Sep-2003.)  (Proof shortened by Mario Carneiro, 10-Oct-2016.) $)
    vtoclgf $p |- ( A e. V -> ps ) $=
      ( wcel cvv elex cv wceq wex issetf mpbii exlimi sylbi syl ) DEJDKJZBDELUA
      CMDNZCOBCDFPUBBCGUBABIHQRST $.
  $}

  ${
    $d x A $.  $d x ps $.
    vtoclg.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtoclg.2 $e |- ph $.
    $( Implicit substitution of a class expression for a set variable.
       (Contributed by NM, 17-Apr-1995.) $)
    vtoclg $p |- ( A e. V -> ps ) $=
      ( nfcv nfv vtoclgf ) ABCDECDHBCIFGJ $.
  $}

  ${
    $d x A $.  $d x ch $.  $d x th $.
    vtoclbg.1 $e |- ( x = A -> ( ph <-> ch ) ) $.
    vtoclbg.2 $e |- ( x = A -> ( ps <-> th ) ) $.
    vtoclbg.3 $e |- ( ph <-> ps ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 29-Apr-1994.) $)
    vtoclbg $p |- ( A e. V -> ( ch <-> th ) ) $=
      ( wb cv wceq bibi12d vtoclg ) ABKCDKEFGELFMACBDHINJO $.
  $}

  ${
    vtocl2gf.1 $e |- F/_ x A $.
    vtocl2gf.2 $e |- F/_ y A $.
    vtocl2gf.3 $e |- F/_ y B $.
    vtocl2gf.4 $e |- F/ x ps $.
    vtocl2gf.5 $e |- F/ y ch $.
    vtocl2gf.6 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl2gf.7 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl2gf.8 $e |- ph $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 25-Apr-1995.) $)
    vtocl2gf $p |- ( ( A e. V /\ B e. W ) -> ch ) $=
      ( wcel cvv wi elex nfel1 nfim cv wceq imbi2d vtoclgf mpan9 ) FHRFSRZGIRCF
      HUAUIBTUICTEGILUICEEFSKUBNUCEUDGUEBCUIPUFABDFSJMOQUGUGUH $.
  $}

  ${
    $d w A $.  $d w B $.  $d w C $.  $d w y $.  $d w z $.
    vtocl3gf.a $e |- F/_ x A $.
    vtocl3gf.b $e |- F/_ y A $.
    vtocl3gf.c $e |- F/_ z A $.
    vtocl3gf.d $e |- F/_ y B $.
    vtocl3gf.e $e |- F/_ z B $.
    vtocl3gf.f $e |- F/_ z C $.
    vtocl3gf.1 $e |- F/ x ps $.
    vtocl3gf.2 $e |- F/ y ch $.
    vtocl3gf.3 $e |- F/ z th $.
    vtocl3gf.4 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl3gf.5 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl3gf.6 $e |- ( z = C -> ( ch <-> th ) ) $.
    vtocl3gf.7 $e |- ph $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 10-Aug-2013.)  (Revised by Mario Carneiro, 10-Oct-2016.) $)
    vtocl3gf $p |- ( ( A e. V /\ B e. W /\ C e. X ) -> th ) $=
      ( wcel cvv wa elex wi nfel1 nfim wceq imbi2d vtoclgf vtocl2gf mpan9 3impb
      cv ) HKUGZILUGZJMUGZDVAHUHUGZVBVCUIDHKUJVDBUKVDCUKVDDUKFGIJLMQRSVDCFFHUHO
      ULUAUMVDDGGHUHPULUBUMFUTIUNBCVDUDUOGUTJUNCDVDUEUOABEHUHNTUCUFUPUQURUS $.
  $}

  ${
    $d w x A $.  $d y A $.  $d w y B $.  $d x ps $.  $d y ch $.
    vtocl2g.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl2g.2 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl2g.3 $e |- ph $.
    $( Implicit substitution of 2 classes for 2 set variables.  (Contributed by
       NM, 25-Apr-1995.) $)
    vtocl2g $p |- ( ( A e. V /\ B e. W ) -> ch ) $=
      ( nfcv nfv vtocl2gf ) ABCDEFGHIDFMEFMEGMBDNCENJKLO $.
  $}

  ${
    $d y A $.  $d x B z $.
    vtoclgaf.1 $e |- F/_ x A $.
    vtoclgaf.2 $e |- F/ x ps $.
    vtoclgaf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtoclgaf.4 $e |- ( x e. B -> ph ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 17-Feb-2006.)  (Revised by Mario Carneiro, 10-Oct-2016.) $)
    vtoclgaf $p |- ( A e. B -> ps ) $=
      ( wcel cv wi nfel1 nfim wceq eleq1 imbi12d vtoclgf pm2.43i ) DEJZBCKZEJZA
      LTBLCDEFTBCCDEFMGNUADOUBTABUADEPHQIRS $.
  $}

  ${
    $d x y A $.  $d x y B $.  $d x ps $.
    vtoclga.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtoclga.2 $e |- ( x e. B -> ph ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 20-Aug-1995.) $)
    vtoclga $p |- ( A e. B -> ps ) $=
      ( nfcv nfv vtoclgaf ) ABCDECDHBCIFGJ $.
  $}

  ${
    $d x y C $.  $d x y D $.
    vtocl2gaf.a $e |- F/_ x A $.
    vtocl2gaf.b $e |- F/_ y A $.
    vtocl2gaf.c $e |- F/_ y B $.
    vtocl2gaf.1 $e |- F/ x ps $.
    vtocl2gaf.2 $e |- F/ y ch $.
    vtocl2gaf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl2gaf.4 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl2gaf.5 $e |- ( ( x e. C /\ y e. D ) -> ph ) $.
    $( Implicit substitution of 2 classes for 2 set variables.  (Contributed by
       NM, 10-Aug-2013.) $)
    vtocl2gaf $p |- ( ( A e. C /\ B e. D ) -> ch ) $=
      ( wcel wa wi cv nfel1 nfan nfim wceq eleq1 anbi1d imbi12d anbi2d vtocl2gf
      nfv pm2.43i ) FHRZGIRZSZCDUAZHRZEUAZIRZSZATUMUSSZBTUOCTDEFGHIJKLVABDUMUSD
      DFHJUBUSDUKUCMUDUOCEUMUNEEFHKUBEGILUBUCNUDUPFUEZUTVAABVBUQUMUSUPFHUFUGOUH
      URGUEZVAUOBCVCUSUNUMURGIUFUIPUHQUJUL $.
  $}

  ${
    $d w x y A $.  $d w y B $.  $d w x y C $.  $d w x y D $.  $d x ps $.
    $d y ch $.
    vtocl2ga.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl2ga.2 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl2ga.3 $e |- ( ( x e. C /\ y e. D ) -> ph ) $.
    $( Implicit substitution of 2 classes for 2 set variables.  (Contributed by
       NM, 20-Aug-1995.) $)
    vtocl2ga $p |- ( ( A e. C /\ B e. D ) -> ch ) $=
      ( nfcv nfv vtocl2gaf ) ABCDEFGHIDFMEFMEGMBDNCENJKLO $.
  $}

  ${
    $d w A $.  $d w B $.  $d w C $.  $d w x y z R $.  $d w x y z S $.
    $d w x y z T $.
    vtocl3gaf.a $e |- F/_ x A $.
    vtocl3gaf.b $e |- F/_ y A $.
    vtocl3gaf.c $e |- F/_ z A $.
    vtocl3gaf.d $e |- F/_ y B $.
    vtocl3gaf.e $e |- F/_ z B $.
    vtocl3gaf.f $e |- F/_ z C $.
    vtocl3gaf.1 $e |- F/ x ps $.
    vtocl3gaf.2 $e |- F/ y ch $.
    vtocl3gaf.3 $e |- F/ z th $.
    vtocl3gaf.4 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl3gaf.5 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl3gaf.6 $e |- ( z = C -> ( ch <-> th ) ) $.
    vtocl3gaf.7 $e |- ( ( x e. R /\ y e. S /\ z e. T ) -> ph ) $.
    $( Implicit substitution of 3 classes for 3 set variables.  (Contributed by
       NM, 10-Aug-2013.)  (Revised by Mario Carneiro, 11-Oct-2016.) $)
    vtocl3gaf $p |- ( ( A e. R /\ B e. S /\ C e. T ) -> th ) $=
      ( wcel w3a cv nfel1 nf3an nfim wceq eleq1 3anbi1d imbi12d 3anbi2d 3anbi3d
      wi nfv vtocl3gf pm2.43i ) HKUGZILUGZJMUGZUHZDEUIZKUGZFUIZLUGZGUIZMUGZUHZA
      USVCVJVLUHZBUSVCVDVLUHZCUSVFDUSEFGHIJKLMNOPQRSVNBEVCVJVLEEHKNUJVJEUTVLEUT
      UKTULVOCFVCVDVLFFHKOUJFILQUJVLFUTUKUAULVFDGVCVDVEGGHKPUJGILRUJGJMSUJUKUBU
      LVGHUMZVMVNABVPVHVCVJVLVGHKUNUOUCUPVIIUMZVNVOBCVQVJVDVCVLVIILUNUQUDUPVKJU
      MZVOVFCDVRVLVEVCVDVKJMUNURUEUPUFVAVB $.
  $}

  ${
    $d w x y z A $.  $d w y z B $.  $d w z C $.  $d w x y z D $.
    $d w x y z R $.  $d w x y z S $.  $d x ps $.  $d y ch $.  $d z th $.
    vtocl3ga.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtocl3ga.2 $e |- ( y = B -> ( ps <-> ch ) ) $.
    vtocl3ga.3 $e |- ( z = C -> ( ch <-> th ) ) $.
    vtocl3ga.4 $e |- ( ( x e. D /\ y e. R /\ z e. S ) -> ph ) $.
    $( Implicit substitution of 3 classes for 3 set variables.  (Contributed by
       NM, 20-Aug-1995.) $)
    vtocl3ga $p |- ( ( A e. D /\ B e. R /\ C e. S ) -> th ) $=
      ( nfcv nfv vtocl3gaf ) ABCDEFGHIJKLMEHRFHRGHRFIRGIRGJRBESCFSDGSNOPQT $.
  $}

  ${
    $d x A $.  $d x ph $.
    vtocleg.1 $e |- ( x = A -> ph ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 10-Jan-2004.) $)
    vtocleg $p |- ( A e. V -> ph ) $=
      ( wcel cv wceq wex elisset exlimiv syl ) CDFBGCHZBIABCDJMABEKL $.
  $}

  ${
    $d x A $.
    $( Implicit substitution of a class for a set variable.  (Closed theorem
       version of ~ vtoclef .)  (Contributed by NM, 7-Nov-2005.)  (Revised by
       Mario Carneiro, 11-Oct-2016.) $)
    vtoclegft $p |- ( ( A e. B /\ F/ x ph /\
                   A. x ( x = A -> ph ) ) -> ph ) $=
      ( wcel wnf cv wceq wi wal w3a wex elisset mpan9 3adant2 wb 19.9t 3ad2ant2
      exim mpbid ) CDEZABFZBGCHZAIBJZKABLZAUAUDUEUBUAUCBLUDUEBCDMUCABSNOUBUAUEA
      PUDABQRT $.
  $}

  ${
    $d x A $.
    vtoclef.1 $e |- F/ x ph $.
    vtoclef.2 $e |- A e. _V $.
    vtoclef.3 $e |- ( x = A -> ph ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 18-Aug-1993.) $)
    vtoclef $p |- ph $=
      ( cv wceq wex isseti exlimi ax-mp ) BGCHZBIABCEJMABDFKL $.
  $}

  ${
    $d x A $.  $d x ph $.
    vtocle.1 $e |- A e. _V $.
    vtocle.2 $e |- ( x = A -> ph ) $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 9-Sep-1993.) $)
    vtocle $p |- ph $=
      ( cvv wcel vtocleg ax-mp ) CFGADABCFEHI $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ps $.
    vtoclri.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    vtoclri.2 $e |- A. x e. B ph $.
    $( Implicit substitution of a class for a set variable.  (Contributed by
       NM, 21-Nov-1994.) $)
    vtoclri $p |- ( A e. B -> ps ) $=
      ( rspec vtoclga ) ABCDEFACEGHI $.
  $}

  ${
    spcimgft.1 $e |- F/ x ps $.
    spcimgft.2 $e |- F/_ x A $.
    $( A closed version of ~ spcimgf .  (Contributed by Mario Carneiro,
       4-Jan-2017.) $)
    spcimgft $p |- ( A. x ( x = A -> ( ph -> ps ) ) -> ( A e. B ->
                      ( A. x ph -> ps ) ) ) $=
      ( wcel cvv cv wceq wal elex wex issetf exim syl5bi 19.36-1 syl6
      wi syl5 ) DEHDIHZCJDKZABTZTCLZACLBTZDEMUEUBUDCNZUFUBUCCNUEUGCDG
      OUCUDCPQABCFRSUA $.

    $( A closed version of ~ spcgf .  (Contributed by Andrew Salmon,
       6-Jun-2011.)  (Revised by Mario Carneiro, 4-Jan-2017.) $)
    spcgft $p |- ( A. x ( x = A -> ( ph <-> ps ) ) -> ( A e. B ->
                      ( A. x ph -> ps ) ) ) $=
      ( cv wceq wb wi wal wcel bi1 imim2i alimi spcimgft syl ) CHDIZABJZKZCLSAB
      KZKZCLDEMACLBKKUAUCCTUBSABNOPABCDEFGQR $.

    $( A closed version of ~ spcimegf .  (Contributed by Mario Carneiro,
       4-Jan-2017.) $)
    spcimegft $p |- ( A. x ( x = A -> ( ps -> ph ) ) -> ( A e. B ->
                      ( ps -> E. x ph ) ) ) $=
      ( wcel cvv cv wceq wal wex elex issetf exim syl5bi 19.37-1 syl6
      wi syl5 ) DEHDIHZCJDKZBATZTCLZBACMTZDENUEUBUDCMZUFUBUCCMUEUGCDGOU
      CUDCPQBACFRSUA $.

    $( A closed version of ~ spcegf .  (Contributed by Jim Kingdon,
       22-Jun-2018.) $)
    spcegft $p |- ( A. x ( x = A -> ( ph <-> ps ) ) -> ( A e. B ->
                      ( ps -> E. x ph ) ) ) $=
      ( cv wceq wb wi wal wcel wex bi2 imim2i alimi spcimegft syl ) CHD
      IZABJZKZCLTBAKZKZCLDEMBACNKKUBUDCUAUCTABOPQABCDEFGRS $.
  $}

  ${
    spcimgf.1 $e |- F/_ x A $.
    spcimgf.2 $e |- F/ x ps $.
    ${
      spcimgf.3 $e |- ( x = A -> ( ph -> ps ) ) $.
      $( Rule of specialization, using implicit substitution.  Compare Theorem
         7.3 of [Quine] p. 44.  (Contributed by Mario Carneiro, 4-Jan-2017.) $)
      spcimgf $p |- ( A e. V -> ( A. x ph -> ps ) ) $=
        ( cv wceq wi wcel wal spcimgft mpg ) CIDJABKKDELACMBKKCABCDEGFNHO $.
    $}

    spcimegf.3 $e |- ( x = A -> ( ps -> ph ) ) $.
    $( Existential specialization, using implicit substitution.  (Contributed
       by Mario Carneiro, 4-Jan-2017.) $)
    spcimegf $p |- ( A e. V -> ( ps -> E. x ph ) ) $=
      ( cv wceq wi wcel wex spcimegft mpg ) CIDJBAKKDELBACMKKCABCDEGF
      NHO $.
  $}

  ${
    $d y A z $.  $d x z $.
    spcgf.1 $e |- F/_ x A $.
    spcgf.2 $e |- F/ x ps $.
    spcgf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Rule of specialization, using implicit substitution.  Compare Theorem
       7.3 of [Quine] p. 44.  (Contributed by NM, 2-Feb-1997.)  (Revised by
       Andrew Salmon, 12-Aug-2011.) $)
    spcgf $p |- ( A e. V -> ( A. x ph -> ps ) ) $=
      ( cv wceq wb wi wcel wal spcgft mpg ) CIDJABKLDEMACNBLLCABCDEGFOHP $.

    $( Existential specialization, using implicit substitution.  (Contributed
       by NM, 2-Feb-1997.) $)
    spcegf $p |- ( A e. V -> ( ps -> E. x ph ) ) $=
      ( cv wceq wb wi wcel wex spcegft mpg ) CIDJABKLDEMBACNLLCABCDEG
      FOHP $.
  $}

  ${
    $d x A $.  $d x ph $.  $d x ch $.
    spcimdv.1 $e |- ( ph -> A e. B ) $.
    ${
      spcimdv.2 $e |- ( ( ph /\ x = A ) -> ( ps -> ch ) ) $.
      $( Restricted specialization, using implicit substitution.  (Contributed
         by Mario Carneiro, 4-Jan-2017.) $)
      spcimdv $p |- ( ph -> ( A. x ps -> ch ) ) $=
        ( cv wceq wi wal wcel ex alrimiv nfv nfcv spcimgft sylc ) ADIEJZBCKZKZD
        LEFMBDLCKAUBDATUAHNOGBCDEFCDPDEQRS $.
    $}

    ${
      spcdv.2 $e |- ( ( ph /\ x = A ) -> ( ps <-> ch ) ) $.
      $( Rule of specialization, using implicit substitution.  Analogous to
         ~ rspcdv .  (Contributed by David Moews, 1-May-2017.) $)
      spcdv $p |- ( ph -> ( A. x ps -> ch ) ) $=
        ( cv wceq wa biimpd spcimdv ) ABCDEFGADIEJKBCHLM $.
    $}

    spcimedv.2 $e |- ( ( ph /\ x = A ) -> ( ch -> ps ) ) $.
    $( Restricted existential specialization, using implicit substitution.
       (Contributed by Mario Carneiro, 4-Jan-2017.) $)
    spcimedv $p |- ( ph -> ( ch -> E. x ps ) ) $=
      ( cv wceq wi wal wcel wex ex alrimiv nfv nfcv spcimegft sylc )
      ADIEJZCBKZKZDLEFMCBDNKAUCDAUAUBHOPGBCDEFCDQDERST $.
  $}

  ${
    $d x ps $.  $d x y A $.
    spcgv.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Rule of specialization, using implicit substitution.  Compare Theorem
       7.3 of [Quine] p. 44.  (Contributed by NM, 22-Jun-1994.) $)
    spcgv $p |- ( A e. V -> ( A. x ph -> ps ) ) $=
      ( nfcv nfv spcgf ) ABCDECDGBCHFI $.

    $( Existential specialization, using implicit substitution.  (Contributed
       by NM, 14-Aug-1994.) $)
    spcegv $p |- ( A e. V -> ( ps -> E. x ph ) ) $=
      ( nfcv nfv spcegf ) ABCDECDGBCHFI $.
  $}

  ${
    $d x y A $.  $d x y B $.  $d x y ps $.
    spc2egv.1 $e |- ( ( x = A /\ y = B ) -> ( ph <-> ps ) ) $.
    $( Existential specialization with 2 quantifiers, using implicit
       substitution.  (Contributed by NM, 3-Aug-1995.) $)
    spc2egv $p |- ( ( A e. V /\ B e. W ) -> ( ps -> E. x E. y ph ) ) $=
      ( wcel wa cv wceq wex elisset anim12i eeanv sylibr biimprcd 2eximdv
      syl5com ) EGJZFHJZKZCLEMZDLFMZKZDNCNZBADNCNUDUECNZUFDNZKUHUBUIUCUJCEGODFH
      OPUEUFCDQRBUGACDUGABISTUA $.

    $( Specialization with 2 quantifiers, using implicit substitution.
       (Contributed by NM, 27-Apr-2004.) $)
    spc2gv $p |- ( ( A e. V /\ B e. W ) -> ( A. x A. y ph -> ps ) ) $=
      ( wcel wa cv wceq wex wal elisset anim12i wi exim 19.9v biimpcd
      eeanv sylibr 2alimi alimi 3syl bitri syl6ib syl5com ) EGJZFHJZK
      ZCLEMZDLFMZKZDNZCNZADOCOZBULUMCNZUNDNZKUQUJUSUKUTCEGPDFHPQUMUNC
      DUBUCURUQBDNZCNZBURUOBRZDOZCOUPVARZCOUQVBRAVCCDUOABIUAUDVDVECUO
      BDSUEUPVACSUFVBVABVACTBDTUGUHUI $.
  $}

  ${
    $d x y z A $.  $d x y z B $.  $d x y z C $.  $d x y z ps $.
    spc3egv.1 $e |- ( ( x = A /\ y = B /\ z = C ) -> ( ph <-> ps ) ) $.
    $( Existential specialization with 3 quantifiers, using implicit
       substitution.  (Contributed by NM, 12-May-2008.) $)
    spc3egv $p |- ( ( A e. V /\ B e. W /\ C e. X ) ->
               ( ps -> E. x E. y E. z ph ) ) $=
      ( wcel w3a cv wceq wex elisset 3anim123i eeeanv biimprcd 2eximdv syl5com
      sylibr eximdv ) FIMZGJMZHKMZNZCOFPZDOGPZEOHPZNZEQZDQCQZBAEQZDQCQUIUJCQZUK
      DQZULEQZNUOUFUQUGURUHUSCFIRDGJREHKRSUJUKULCDETUDBUNUPCDBUMAEUMABLUAUEUBUC
      $.

    $( Specialization with 3 quantifiers, using implicit substitution.
       (Contributed by NM, 12-May-2008.) $)
    spc3gv $p |- ( ( A e. V /\ B e. W /\ C e. X ) ->
               ( A. x A. y A. z ph -> ps ) ) $=
      ( wcel w3a cv wceq wex wal elisset wi 3anim123i eeeanv sylibr 2alimi exim
      biimpcd alimi syl 3syl 19.9v 3bitri syl6ib syl5com ) FIMZGJMZHKMZNZCOFPZD
      OGPZEOHPZNZEQZDQZCQZAERDRZCRZBUQURCQZUSDQZUTEQZNVDUNVGUOVHUPVICFISDGJSEHK
      SUAURUSUTCDEUBUCVFVDBEQZDQZCQZBVFVBVJTZDRZCRZVCVKTZCRVDVLTVFVABTZERZDRZCR
      VOVEVSCAVQDEVAABLUFUDUGVRVMCDVABEUEUDUHVNVPCVBVJDUEUGVCVKCUEUIVLVKVJBVKCU
      JVJDUJBEUJUKULUM $.
  $}

  ${
    $d x A $.  $d x ps $.
    spcv.1 $e |- A e. _V $.
    spcv.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Rule of specialization, using implicit substitution.  (Contributed by
       NM, 22-Jun-1994.) $)
    spcv $p |- ( A. x ph -> ps ) $=
      ( cvv wcel wal wi spcgv ax-mp ) DGHACIBJEABCDGFKL $.

    $( Existential specialization, using implicit substitution.  (Contributed
       by NM, 31-Dec-1993.)  (Proof shortened by Eric Schmidt, 22-Dec-2006.) $)
    spcev $p |- ( ps -> E. x ph ) $=
      ( cvv wcel wex wi spcegv ax-mp ) DGHBACIJEABCDGFKL $.
  $}

  ${
    $d x y A $.  $d x y B $.  $d x y ps $.
    spc2ev.1 $e |- A e. _V $.
    spc2ev.2 $e |- B e. _V $.
    spc2ev.3 $e |- ( ( x = A /\ y = B ) -> ( ph <-> ps ) ) $.
    $( Existential specialization, using implicit substitution.  (Contributed
       by NM, 3-Aug-1995.) $)
    spc2ev $p |- ( ps -> E. x E. y ph ) $=
      ( cvv wcel wex wi spc2egv mp2an ) EJKFJKBADLCLMGHABCDEFJJINO $.
  $}

  ${
    $d x A $.  $d x B $.
    rspct.1 $e |- F/ x ps $.
    $( A closed version of ~ rspc .  (Contributed by Andrew Salmon,
       6-Jun-2011.) $)
    rspct $p |- ( A. x ( x = A -> ( ph <-> ps ) ) -> ( A e. B ->
                   ( A. x e. B ph -> ps ) ) ) $=
      ( cv wceq wb wi wal wcel wral df-ral wa eleq1 adantr simpr imbi12d ex a2i
      alimi nfv nfim nfcv spcgft syl syl7bi com34 pm2.43d ) CGZDHZABIZJZCKZDELZ
      ACEMZBJUOUPUQUPBUQUKELZAJZCKZUOUPUPBJZACENUOULUSVAIZJZCKUPUTVAJJUNVCCULUM
      VBULUMVBULUMOURUPABULURUPIUMUKDEPQULUMRSTUAUBUSVACDEUPBCUPCUCFUDCDUEUFUGU
      HUIUJ $.
  $}

  ${
    $d x y A $.  $d x B $.
    rspc.1 $e |- F/ x ps $.
    rspc.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Restricted specialization, using implicit substitution.  (Contributed by
       NM, 19-Apr-2005.)  (Revised by Mario Carneiro, 11-Oct-2016.) $)
    rspc $p |- ( A e. B -> ( A. x e. B ph -> ps ) ) $=
      ( wral cv wcel wi wal df-ral nfcv nfv nfim wceq eleq1 imbi12d spcgf
      pm2.43a syl5bi ) ACEHCIZEJZAKZCLZDEJZBACEMUFUGBUEUGBKCDECDNUGBCUGCOFPUCDQ
      UDUGABUCDERGSTUAUB $.

    $( Restricted existential specialization, using implicit substitution.
       (Contributed by NM, 26-May-1998.)  (Revised by Mario Carneiro,
       11-Oct-2016.) $)
    rspce $p |- ( ( A e. B /\ ps ) -> E. x e. B ph ) $=
      ( wcel wa cv wex wrex nfcv nfv nfan wceq eleq1 anbi12d spcegf anabsi5
      df-rex sylibr ) DEHZBIZCJZEHZAIZCKZACELUCBUHUGUDCDECDMUCBCUCCNFOUEDPUFUCA
      BUEDEQGRSTACEUAUB $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ps $.
    rspcv.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Restricted specialization, using implicit substitution.  (Contributed by
       NM, 26-May-1998.) $)
    rspcv $p |- ( A e. B -> ( A. x e. B ph -> ps ) ) $=
      ( nfv rspc ) ABCDEBCGFH $.

    $( Restricted specialization, using implicit substitution.  (Contributed by
       NM, 2-Feb-2006.) $)
    rspccv $p |- ( A. x e. B ph -> ( A e. B -> ps ) ) $=
      ( wcel wral rspcv com12 ) DEGACEHBABCDEFIJ $.

    $( Restricted specialization, using implicit substitution.  (Contributed by
       NM, 13-Sep-2005.) $)
    rspcva $p |- ( ( A e. B /\ A. x e. B ph ) -> ps ) $=
      ( wcel wral rspcv imp ) DEGACEHBABCDEFIJ $.

    $( Restricted specialization, using implicit substitution.  (Contributed by
       NM, 26-Jul-2006.)  (Proof shortened by Andrew Salmon, 8-Jun-2011.) $)
    rspccva $p |- ( ( A. x e. B ph /\ A e. B ) -> ps ) $=
      ( wcel wral rspcv impcom ) DEGACEHBABCDEFIJ $.

    $( Restricted existential specialization, using implicit substitution.
       (Contributed by NM, 26-May-1998.) $)
    rspcev $p |- ( ( A e. B /\ ps ) -> E. x e. B ph ) $=
      ( nfv rspce ) ABCDEBCGFH $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ph $.  $d x ch $.
    rspcimdv.1 $e |- ( ph -> A e. B ) $.
    ${
      rspcimdv.2 $e |- ( ( ph /\ x = A ) -> ( ps -> ch ) ) $.
      $( Restricted specialization, using implicit substitution.  (Contributed
         by Mario Carneiro, 4-Jan-2017.) $)
      rspcimdv $p |- ( ph -> ( A. x e. B ps -> ch ) ) $=
        ( wral cv wcel wi wal df-ral wceq wa simpr eleq1d biimprd imim12d mpid
        spcimdv syl5bi ) BDFIDJZFKZBLZDMZACBDFNAUGEFKZCGAUFUHCLDEFGAUDEOZPZUHUE
        BCUJUEUHUJUDEFAUIQRSHTUBUAUC $.
    $}

    rspcimedv.2 $e |- ( ( ph /\ x = A ) -> ( ch -> ps ) ) $.
    $( Restricted existential specialization, using implicit substitution.
       (Contributed by Mario Carneiro, 4-Jan-2017.) $)
    rspcimedv $p |- ( ph -> ( ch -> E. x e. B ps ) ) $=
      ( cv wcel wa wex wrex wceq simpr biimprd anim12d spcimedv mpand
      eleq1d df-rex syl6ibr ) ACDIZFJZBKZDLZBDFMAEFJZCUFGAUEUGCKDEFGA
      UCENZKZUGUDCBUIUDUGUIUCEFAUHOTPHQRSBDFUAUB $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ph $.  $d x ch $.
    rspcdv.1 $e |- ( ph -> A e. B ) $.
    rspcdv.2 $e |- ( ( ph /\ x = A ) -> ( ps <-> ch ) ) $.
    $( Restricted specialization, using implicit substitution.  (Contributed by
       NM, 17-Feb-2007.)  (Revised by Mario Carneiro, 4-Jan-2017.) $)
    rspcdv $p |- ( ph -> ( A. x e. B ps -> ch ) ) $=
      ( cv wceq wa biimpd rspcimdv ) ABCDEFGADIEJKBCHLM $.

    $( Restricted existential specialization, using implicit substitution.
       (Contributed by FL, 17-Apr-2007.)  (Revised by Mario Carneiro,
       4-Jan-2017.) $)
    rspcedv $p |- ( ph -> ( ch -> E. x e. B ps ) ) $=
      ( cv wceq wa biimprd rspcimedv ) ABCDEFGADIEJKBCHLM $.
  $}

  ${
    $d x y A $.  $d y B $.  $d x C $.  $d x y D $.
    rspc2.1 $e |- F/ x ch $.
    rspc2.2 $e |- F/ y ps $.
    rspc2.3 $e |- ( x = A -> ( ph <-> ch ) ) $.
    rspc2.4 $e |- ( y = B -> ( ch <-> ps ) ) $.
    $( 2-variable restricted specialization, using implicit substitution.
       (Contributed by NM, 9-Nov-2012.) $)
    rspc2 $p |- ( ( A e. C /\ B e. D ) -> ( A. x e. C A. y e. D ph ->
                  ps ) ) $=
      ( wcel wral nfcv nfralxy cv wceq rspc ralbidv sylan9 ) FHNAEIOZDHOCEIOZGINB
      UCUDDFHCDEIDIPJQDRFSACEILUATCBEGIKMTUB $.
  $}

  ${
    $d x y A $.  $d y B $.  $d x C $.  $d x y D $.  $d x ch $.  $d y ps $.
    rspc2v.1 $e |- ( x = A -> ( ph <-> ch ) ) $.
    rspc2v.2 $e |- ( y = B -> ( ch <-> ps ) ) $.
    $( 2-variable restricted specialization, using implicit substitution.
       (Contributed by NM, 13-Sep-1999.) $)
    rspc2v $p |- ( ( A e. C /\ B e. D ) -> ( A. x e. C A. y e. D ph ->
                  ps ) ) $=
      ( nfv rspc2 ) ABCDEFGHICDLBELJKM $.

    $( 2-variable restricted specialization, using implicit substitution.
       (Contributed by NM, 18-Jun-2014.) $)
    rspc2va $p |- ( ( ( A e. C /\ B e. D ) /\ A. x e. C A. y e. D ph ) ->
                  ps ) $=
      ( wcel wa wral rspc2v imp ) FHLGILMAEINDHNBABCDEFGHIJKOP $.

    $( 2-variable restricted existential specialization, using implicit
       substitution.  (Contributed by NM, 16-Oct-1999.) $)
    rspc2ev $p |- ( ( A e. C /\ B e. D /\ ps ) -> E. x e. C E. y e. D ph ) $=
      ( wcel w3a wrex wa rspcev anim2i 3impb cv wceq rexbidv syl ) FHLZGILZBMUC
      CEINZOZAEINZDHNUCUDBUFUDBOUEUCCBEGIKPQRUGUEDFHDSFTACEIJUAPUB $.
  $}

  ${
    $d z ps $.  $d x ch $.  $d y th $.  $d x y z A $.  $d y z B $.  $d z C $.
    $d x R $.  $d x y S $.  $d x y z T $.
    rspc3v.1 $e |- ( x = A -> ( ph <-> ch ) ) $.
    rspc3v.2 $e |- ( y = B -> ( ch <-> th ) ) $.
    rspc3v.3 $e |- ( z = C -> ( th <-> ps ) ) $.
    $( 3-variable restricted specialization, using implicit substitution.
       (Contributed by NM, 10-May-2005.) $)
    rspc3v $p |- ( ( A e. R /\ B e. S /\ C e. T ) ->
                  ( A. x e. R A. y e. S A. z e. T ph -> ps ) ) $=
      ( wcel wral cv wceq wi wa ralbidv rspc2v rspcv sylan9 3impa ) HKQZILQZJMQ
      ZAGMRZFLREKRZBUAUHUIUBULDGMRZUJBUKUMCGMREFHIKLESHTACGMNUCFSITCDGMOUCUDDBG
      JMPUEUFUG $.

    $( 3-variable restricted existentional specialization, using implicit
       substitution.  (Contributed by NM, 25-Jul-2012.) $)
    rspc3ev $p |- ( ( ( A e. R /\ B e. S /\ C e. T ) /\ ps ) ->
                  E. x e. R E. y e. S E. z e. T ph ) $=
      ( wcel wrex cv wceq w3a wa simpl1 simpl2 rspcev 3ad2antl3 rexbidv rspc2ev
      syl3anc ) HKQZILQZJMQZUABUBUJUKDGMRZAGMRZFLREKRUJUKULBUCUJUKULBUDULUJBUMU
      KDBGJMPUEUFUNUMCGMREFHIKLESHTACGMNUGFSITCDGMOUGUHUI $.
  $}

  ${
    $d x A y z $.  $d x B y z $.
    eqvinc.1 $e |- A e. _V $.
    $( A variable introduction law for class equality.  (Contributed by NM,
       14-Apr-1995.)  (Proof shortened by Andrew Salmon, 8-Jun-2011.) $)
    eqvinc $p |- ( A = B <-> E. x ( x = A /\ x = B ) ) $=
      ( wceq cv wa wex wi isseti ax-1 eqtr jca eximi pm3.43 mp2b 19.37aiv eqtr2
      ex exlimiv impbii ) BCEZAFZBEZUCCEZGZAHUBUFAUDAHUBUDIZUBUEIZGZAHUBUFIZAHA
      BDJUDUIAUDUGUHUDUBKUDUBUEUCBCLSMNUIUJAUBUDUEONPQUFUBAUCBCRTUA $.
  $}

  ${
    $d A y $.  $d B y $.  $d x y $.
    eqvincf.1 $e |- F/_ x A $.
    eqvincf.2 $e |- F/_ x B $.
    eqvincf.3 $e |- A e. _V $.
    $( A variable introduction law for class equality, using bound-variable
       hypotheses instead of distinct variable conditions.  (Contributed by NM,
       14-Sep-2003.) $)
    eqvincf $p |- ( A = B <-> E. x ( x = A /\ x = B ) ) $=
      ( vy wceq cv wa wex eqvinc nfeq2 nfan nfv eqeq1 anbi12d cbvex bitri ) BCH
      GIZBHZTCHZJZGKAIZBHZUDCHZJZAKGBCFLUCUGGAUAUBAATBDMATCEMNUGGOTUDHUAUEUBUFT
      UDBPTUDCPQRS $.
  $}

  ${
    $d x A y $.  $d ph y $.
    alexeq.1 $e |- A e. _V $.
    $( Two ways to express substitution of ` A ` for ` x ` in ` ph ` .
       (Contributed by NM, 2-Mar-1995.) $)
    alexeq $p |- ( A. x ( x = A -> ph ) <-> E. x ( x = A /\ ph ) ) $=
      ( vy cv wceq wa wex wi wal anbi1d exbidv imbi1d albidv sb56 vtoclb bicomi
      eqeq2 ) BFZCGZAHZBIZUAAJZBKZTEFZGZAHZBIUGAJZBKUCUEECDUFCGZUHUBBUJUGUAAUFC
      TSZLMUJUIUDBUJUGUAAUKNOABEPQR $.
  $}

  ${
    $d x A y $.  $d ph y $.
    $( Equality implies equivalence with substitution.  (Contributed by NM,
       2-Mar-1995.) $)
    ceqex $p |- ( x = A -> ( ph <-> E. x ( x = A /\ ph ) ) ) $=
      ( vy cvv wcel cv wceq wa wex wb 19.8a isset sylibr wi eqeq2 anbi1d exbidv
      bibi2d imbi12d ex wal vex alexeq sp com12 syl5bir impbid vtoclg mpcom ) C
      EFZBGZCHZAUMAIZBJZKZUMUMBJUKUMBLBCMNULDGZHZAURAIZBJZKZOUMUPODCEUQCHZURUMV
      AUPUQCULPZVBUTUOAVBUSUNBVBURUMAVCQRSTURAUTURAUTUSBLUAUTURAOZBUBZURAABUQDU
      CUDVEURAVDBUEUFUGUHUIUJ $.
  $}

  ${
    $d x y A $.
    ceqsexg.1 $e |- F/ x ps $.
    ceqsexg.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( A representation of explicit substitution of a class for a variable,
       inferred from an implicit substitution hypothesis.  (Contributed by NM,
       11-Oct-2004.) $)
    ceqsexg $p |- ( A e. V -> ( E. x ( x = A /\ ph ) <-> ps ) ) $=
      ( wb cv wceq wa wex nfcv nfe1 nfbi ceqex bibi12d biid vtoclgf ) AAHCIDJZA
      KZCLZBHCDECDMUBBCUACNFOTAUBABACDPGQARS $.
  $}

  ${
    $d x y A $.  $d x ps $.
    ceqsexgv.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Elimination of an existential quantifier, using implicit substitution.
       (Contributed by NM, 29-Dec-1996.) $)
    ceqsexgv $p |- ( A e. V -> ( E. x ( x = A /\ ph ) <-> ps ) ) $=
      ( nfv ceqsexg ) ABCDEBCGFH $.
  $}

  ${
    $d x A $.  $d x B $.  $d x ps $.
    ceqsrexv.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Elimination of a restricted existential quantifier, using implicit
       substitution.  (Contributed by NM, 30-Apr-2004.) $)
    ceqsrexv $p |- ( A e. B -> ( E. x e. B ( x = A /\ ph ) <-> ps ) ) $=
      ( cv wceq wa wrex wcel wex df-rex an12 exbii bitr4i eleq1 anbi12d bianabs
      ceqsexgv syl5bb ) CGZDHZAIZCEJZUCUBEKZAIZIZCLZDEKZBUEUFUDIZCLUIUDCEMUHUKC
      UCUFANOPUJUIBUGUJBICDEUCUFUJABUBDEQFRTSUA $.

    $( Elimination of a restricted existential quantifier, using implicit
       substitution.  (Contributed by Mario Carneiro, 14-Mar-2014.) $)
    ceqsrexbv $p |- ( E. x e. B ( x = A /\ ph ) <-> ( A e. B /\ ps ) ) $=
      ( wcel cv wceq wa wrex r19.42v eleq1 adantr pm5.32ri bicomi baib ceqsrexv
      wb rexbiia pm5.32i 3bitr3i ) DEGZCHZDIZAJZJZCEKUCUFCEKZJUHUCBJUCUFCELUGUF
      CEUGUDEGZUFUIUFJUGUFUIUCUEUIUCSAUDDEMNOPQTUCUHBABCDEFRUAUB $.
  $}

  ${
    $d x y A $.  $d x y B $.  $d x C $.  $d x y D $.  $d x ps $.  $d y ch $.
    ceqsrex2v.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    ceqsrex2v.2 $e |- ( y = B -> ( ps <-> ch ) ) $.
    $( Elimination of a restricted existential quantifier, using implicit
       substitution.  (Contributed by NM, 29-Oct-2005.) $)
    ceqsrex2v $p |- ( ( A e. C /\ B e. D ) ->
      ( E. x e. C E. y e. D ( ( x = A /\ y = B ) /\ ph ) <-> ch ) ) $=
      ( wcel cv wceq wa wrex anass rexbii r19.42v ceqsrexv bitri anbi2d rexbidv
      syl5bb sylan9bb ) FHLZDMFNZEMGNZOAOZEIPZDHPZUHBOZEIPZGILCUKUGUHAOZEIPZOZD
      HPUFUMUJUPDHUJUGUNOZEIPUPUIUQEIUGUHAQRUGUNEISUARUOUMDFHUGUNULEIUGABUHJUBU
      CTUDBCEGIKTUE $.
  $}

  ${
    $d x A $.  $d x B $.
    clel2.1 $e |- A e. _V $.
    $( An alternate definition of class membership when the class is a set.
       (Contributed by NM, 18-Aug-1993.) $)
    clel2 $p |- ( A e. B <-> A. x ( x = A -> x e. B ) ) $=
      ( cv wceq wcel wi wal eleq1 ceqsalv bicomi ) AEZBFMCGZHAIBCGZNOABDMBCJKL
      $.
  $}

  ${
    $d x A $.  $d x B $.
    $( An alternate definition of class membership when the class is a set.
       (Contributed by NM, 13-Aug-2005.) $)
    clel3g $p |- ( B e. V -> ( A e. B <-> E. x ( x = B /\ A e. x ) ) ) $=
      ( wcel cv wceq wa wex eleq2 ceqsexgv bicomd ) CDEAFZCGBMEZHAIBCEZNOACDMCB
      JKL $.
  $}

  ${
    $d x A $.  $d x B $.
    clel3.1 $e |- B e. _V $.
    $( An alternate definition of class membership when the class is a set.
       (Contributed by NM, 18-Aug-1993.) $)
    clel3 $p |- ( A e. B <-> E. x ( x = B /\ A e. x ) ) $=
      ( cvv wcel cv wceq wa wex wb clel3g ax-mp ) CEFBCFAGZCHBNFIAJKDABCELM $.
  $}

  ${
    $d x A $.  $d x B $.
    clel4.1 $e |- B e. _V $.
    $( An alternate definition of class membership when the class is a set.
       (Contributed by NM, 18-Aug-1993.) $)
    clel4 $p |- ( A e. B <-> A. x ( x = B -> A e. x ) ) $=
      ( cv wceq wcel wi wal eleq2 ceqsalv bicomi ) AEZCFBMGZHAIBCGZNOACDMCBJKL
      $.
  $}

  ${
    $d y A z $.  $d y B z $.
    $( Compare theorem *13.183 in [WhiteheadRussell] p. 178.  Only ` A ` is
       required to be a set.  (Contributed by Andrew Salmon, 3-Jun-2011.) $)
    pm13.183 $p |- ( A e. V -> ( A = B <-> A. z ( z = A <-> z = B ) ) ) $=
      ( vy cv wceq wal eqeq1 eqeq2 bibi1d albidv alrimiv wsb stdpc4 sbbi bibi2i
      wb eqsb3 sylbi equsb1 bi1 mpi syl impbii vtoclbg ) EFZCGZAFZUGGZUICGZRZAH
      ZBCGUIBGZUKRZAHEBDUGBCIUGBGZULUOAUPUJUNUKUGBUIJKLUHUMUHULAUGCUIJMUMULAENZ
      UHULAEOUQUJAENZUKAENZRZUHUJUKAEPUTURUHRZUHUSUHUREACSQVAURUHAEUAURUHUBUCTT
      UDUEUF $.
  $}

  ${
    $d y A $.  $d x y $.  $d y ph $.
    $( Restricted quantifier version of Theorem 19.3 of [Margaris] p. 89.
       (Contributed by NM, 25-Oct-2012.) $)
    rr19.3v $p |- ( A. x e. A A. y e. A ph <-> A. x e. A ph ) $=
      ( wral cv weq biidd rspcv ralimia wcel ax-1 ralrimiv ralimi impbii ) ACDE
      ZBDEABDEPABDAACBFDCBGAHIJAPBDAACDACFDKLMNO $.

    $( Restricted quantifier version of Theorem 19.28 of [Margaris] p. 90.
       (Contributed by NM, 29-Oct-2012.) $)
    rr19.28v $p |- ( A. x e. A A. y e. A ( ph /\ ps )
                      <-> A. x e. A ( ph /\ A. y e. A ps ) ) $=
      ( wa wral cv wcel simpl ralimi weq biidd rspcv syl5 wi simpr jcad ralimia
      a1i r19.28av impbii ) ABFZDEGZCEGABDEGZFZCEGUDUFCECHZEIZUDAUEUDADEGUHAUCA
      DEABJKAADUGEDCLAMNOUDUEPUHUCBDEABQKTRSUFUDCEABDEUAKUB $.
  $}

  ${
    $d x y A $.  $d y ph $.  $d x ps $.
    $( Membership in a class abstraction, using implicit substitution.  (Closed
       theorem version of ~ elabg .)  (Contributed by NM, 7-Nov-2005.)  (Proof
       shortened by Andrew Salmon, 8-Jun-2011.) $)
    elabgt $p |- ( ( A e. B /\ A. x ( x = A -> ( ph <-> ps ) ) ) ->
                 ( A e. { x | ph } <-> ps ) ) $=
      ( cv wceq wb wal wcel cab abid eleq1 syl5bbr bibi1d biimpd a2i alimi nfcv
      wi nfab1 nfel2 nfv nfbi pm5.5 spcgf imp sylan2 ) CFZDGZABHZTZCIDEJZUJDACK
      ZJZBHZTZCIZUPULUQCUJUKUPUJUKUPUJAUOBAUIUNJUJUOACLUIDUNMNOPQRUMURUPUQUPCDE
      CDSUOBCCDUNACUAUBBCUCUDUJUPUEUFUGUH $.
  $}

  ${
    elabgf.1 $e |- F/_ x A $.
    elabgf.2 $e |- F/ x ps $.
    elabgf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction, using implicit substitution.  Compare
       Theorem 6.13 of [Quine] p. 44.  This version has bound-variable
       hypotheses in place of distinct variable restrictions.  (Contributed by
       NM, 21-Sep-2003.)  (Revised by Mario Carneiro, 12-Oct-2016.) $)
    elabgf $p |- ( A e. B -> ( A e. { x | ph } <-> ps ) ) $=
      ( cv cab wcel wb nfab1 nfel nfbi wceq eleq1 bibi12d abid vtoclgf ) CIZACJ
      ZKZALDUBKZBLCDEFUDBCCDUBFACMNGOUADPUCUDABUADUBQHRACST $.
  $}

  ${
    $d ps y $.  $d x A y $.  $d y ph $.
    elabf.1 $e |- F/ x ps $.
    elabf.2 $e |- A e. _V $.
    elabf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction, using implicit substitution.
       (Contributed by NM, 1-Aug-1994.)  (Revised by Mario Carneiro,
       12-Oct-2016.) $)
    elabf $p |- ( A e. { x | ph } <-> ps ) $=
      ( cvv wcel cab wb nfcv elabgf ax-mp ) DHIDACJIBKFABCDHCDLEGMN $.
  $}

  ${
    $d x ps $.  $d x A $.
    elab.1 $e |- A e. _V $.
    elab.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction, using implicit substitution.  Compare
       Theorem 6.13 of [Quine] p. 44.  (Contributed by NM, 1-Aug-1994.) $)
    elab $p |- ( A e. { x | ph } <-> ps ) $=
      ( nfv elabf ) ABCDBCGEFH $.
  $}

  ${
    $d x ps $.  $d x y A $.
    elabg.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction, using implicit substitution.  Compare
       Theorem 6.13 of [Quine] p. 44.  (Contributed by NM, 14-Apr-1995.) $)
    elabg $p |- ( A e. V -> ( A e. { x | ph } <-> ps ) ) $=
      ( nfcv nfv elabgf ) ABCDECDGBCHFI $.
  $}

  ${
    $d x ps $.  $d x A $.
    elab2g.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    elab2g.2 $e |- B = { x | ph } $.
    $( Membership in a class abstraction, using implicit substitution.
       (Contributed by NM, 13-Sep-1995.) $)
    elab2g $p |- ( A e. V -> ( A e. B <-> ps ) ) $=
      ( wcel cab eleq2i elabg syl5bb ) DEIDACJZIDFIBENDHKABCDFGLM $.
  $}

  ${
    $d x ps $.  $d x A $.
    elab2.1 $e |- A e. _V $.
    elab2.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    elab2.3 $e |- B = { x | ph } $.
    $( Membership in a class abstraction, using implicit substitution.
       (Contributed by NM, 13-Sep-1995.) $)
    elab2 $p |- ( A e. B <-> ps ) $=
      ( cvv wcel wb elab2g ax-mp ) DIJDEJBKFABCDEIGHLM $.
  $}

  ${
    $d x ps $.  $d x A $.
    elab4g.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    elab4g.2 $e |- B = { x | ph } $.
    $( Membership in a class abstraction, using implicit substitution.
       (Contributed by NM, 17-Oct-2012.) $)
    elab4g $p |- ( A e. B <-> ( A e. _V /\ ps ) ) $=
      ( wcel cvv elex elab2g biadan2 ) DEHDIHBDEJABCDEIFGKL $.
  $}

  ${
    $d y A $.
    elab3gf.1 $e |- F/_ x A $.
    elab3gf.2 $e |- F/ x ps $.
    elab3gf.3 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction, with a weaker antecedent than
       ~ elabgf .  (Contributed by NM, 6-Sep-2011.) $)
    elab3gf $p |- ( ( ps -> A e. B ) -> ( A e. { x | ph } <-> ps ) ) $=
      ( wcel wi cab elabgf ibi wb imim2i bi2 syli impbid2 ) BDEIZJZDACKZIZBUBBA
      BCDUAFGHLMBTUBBNZUBSUCBABCDEFGHLOUBBPQR $.
  $}

  ${
    $d x ps $.  $d x y A $.
    elab3g.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction, with a weaker antecedent than
       ~ elabg .  (Contributed by NM, 29-Aug-2006.) $)
    elab3g $p |- ( ( ps -> A e. B ) -> ( A e. { x | ph } <-> ps ) ) $=
      ( nfcv nfv elab3gf ) ABCDECDGBCHFI $.
  $}

  ${
    $d x ps $.  $d x A $.
    elab3.1 $e |- ( ps -> A e. _V ) $.
    elab3.2 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a class abstraction using implicit substitution.
       (Contributed by NM, 10-Nov-2000.) $)
    elab3 $p |- ( A e. { x | ph } <-> ps ) $=
      ( cvv wcel wi cab wb elab3g ax-mp ) BDGHIDACJHBKEABCDGFLM $.
  $}

  ${
    $d A x $.  $d V x $.
    $( Implication for the membership in a restricted class abstraction.
       (Contributed by Alexander van der Vekens, 31-Dec-2017.) $)
    elrabi $p |- ( A e. { x e. V | ph } -> A e. V ) $=
      ( wcel cv wa cab crab wceq wex clelab eleq1 anbi1d simprbda exlimiv sylbi
      df-rab eleq2s ) CDEZCBFZDEZAGZBHZABDICUDEUACJZUCGZBKTUCBCLUFTBUEUCTAUEUBT
      AUACDMNOPQABDRS $.
  $}

  ${
    elrabf.1 $e |- F/_ x A $.
    elrabf.2 $e |- F/_ x B $.
    elrabf.3 $e |- F/ x ps $.
    elrabf.4 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a restricted class abstraction, using implicit
       substitution.  This version has bound-variable hypotheses in place of
       distinct variable restrictions.  (Contributed by NM, 21-Sep-2003.) $)
    elrabf $p |- ( A e. { x e. B | ph } <-> ( A e. B /\ ps ) ) $=
      ( crab wcel cvv wa elex adantr cv cab df-rab eleq2i nfel nfan wceq elabgf
      eleq1 anbi12d syl5bb pm5.21nii ) DACEJZKZDLKZDEKZBMZDUHNUKUJBDENOUIDCPZEK
      ZAMZCQZKUJULUHUPDACERSUOULCDLFUKBCCDEFGTHUAUMDUBUNUKABUMDEUDIUEUCUFUG $.
  $}

  ${
    $d x ps $.  $d x y A $.  $d x y B $.
    elrab.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    $( Membership in a restricted class abstraction, using implicit
       substitution.  (Contributed by NM, 21-May-1999.) $)
    elrab $p |- ( A e. { x e. B | ph } <-> ( A e. B /\ ps ) ) $=
      ( nfcv nfv elrabf ) ABCDECDGCEGBCHFI $.

    $( Membership in a restricted class abstraction, using implicit
       substitution.  (Contributed by NM, 5-Oct-2006.) $)
    elrab3 $p |- ( A e. B -> ( A e. { x e. B | ph } <-> ps ) ) $=
      ( crab wcel elrab baib ) DACEGHDEHBABCDEFIJ $.
  $}

  ${
    $d x ps $.  $d x y A $.  $d x y B $.
    elrab2.1 $e |- ( x = A -> ( ph <-> ps ) ) $.
    elrab2.2 $e |- C = { x e. B | ph } $.
    $( Membership in a class abstraction, using implicit substitution.
       (Contributed by NM, 2-Nov-2006.) $)
    elrab2 $p |- ( A e. C <-> ( A e. B /\ ps ) ) $=
      ( wcel crab wa eleq2i elrab bitri ) DFIDACEJZIDEIBKFODHLABCDEGMN $.
  $}

  ${
    $d x y $.  $d y A $.  $d y ps $.
    ralab.1 $e |- ( y = x -> ( ph <-> ps ) ) $.
    $( Universal quantification over a class abstraction.  (Contributed by Jeff
       Madsen, 10-Jun-2010.) $)
    ralab $p |- ( A. x e. { y | ph } ch <-> A. x ( ps -> ch ) ) $=
      ( cab wral cv wcel wi wal df-ral vex elab imbi1i albii bitri ) CDAEGZHDIZ
      SJZCKZDLBCKZDLCDSMUBUCDUABCABETDNFOPQR $.

    $( Universal quantification over a restricted class abstraction.
       (Contributed by Jeff Madsen, 10-Jun-2010.) $)
    ralrab $p |- ( A. x e. { y e. A | ph } ch <-> A. x e. A ( ps -> ch ) ) $=
      ( wi crab cv wcel wa elrab imbi1i impexp bitri ralbii2 ) CBCHZDAEFIZFDJZS
      KZCHTFKZBLZCHUBRHUAUCCABETFGMNUBBCOPQ $.

    $( Existential quantification over a class abstraction.  (Contributed by
       Mario Carneiro, 23-Jan-2014.)  (Revised by Mario Carneiro,
       3-Sep-2015.) $)
    rexab $p |- ( E. x e. { y | ph } ch <-> E. x ( ps /\ ch ) ) $=
      ( cab wrex cv wcel wa wex df-rex vex elab anbi1i exbii bitri ) CDAEGZHDIZ
      SJZCKZDLBCKZDLCDSMUBUCDUABCABETDNFOPQR $.

    $( Existential quantification over a class abstraction.  (Contributed by
       Jeff Madsen, 17-Jun-2011.)  (Revised by Mario Carneiro, 3-Sep-2015.) $)
    rexrab $p |- ( E. x e. { y e. A | ph } ch <-> E. x e. A ( ps /\ ch ) ) $=
      ( wa crab cv wcel elrab anbi1i anass bitri rexbii2 ) CBCHZDAEFIZFDJZRKZCH
      SFKZBHZCHUAQHTUBCABESFGLMUABCNOP $.
  $}

  ${
    $d x y $.  $d x A $.  $d x ch $.  $d x ph $.  $d y ps $.
    ralab2.1 $e |- ( x = y -> ( ps <-> ch ) ) $.
    $( Universal quantification over a class abstraction.  (Contributed by
       Mario Carneiro, 3-Sep-2015.) $)
    ralab2 $p |- ( A. x e. { y | ph } ps <-> A. y ( ph -> ch ) ) $=
      ( cab wral cv wcel wi wal df-ral nfsab1 nfv nfim weq eleq1 abid syl6bb
      imbi12d cbval bitri ) BDAEGZHDIZUDJZBKZDLACKZELBDUDMUGUHDEUFBEAEDNBEOPUHD
      ODEQZUFABCUIUFEIZUDJAUEUJUDRAESTFUAUBUC $.

    $( Universal quantification over a restricted class abstraction.
       (Contributed by Mario Carneiro, 3-Sep-2015.) $)
    ralrab2 $p |- ( A. x e. { y e. A | ph } ps <-> A. y e. A ( ph -> ch ) ) $=
      ( crab wral cv wcel wa cab wi wal df-rab raleqi ralab2 impexp albii
      df-ral bitr4i 3bitri ) BDAEFHZIBDEJFKZALZEMZIUFCNZEOZACNZEFIZBDUDUGAEFPQU
      FBCDEGRUIUEUJNZEOUKUHULEUEACSTUJEFUAUBUC $.

    $( Existential quantification over a class abstraction.  (Contributed by
       Mario Carneiro, 3-Sep-2015.) $)
    rexab2 $p |- ( E. x e. { y | ph } ps <-> E. y ( ph /\ ch ) ) $=
      ( cab wrex cv wcel wa wex df-rex nfsab1 nfv nfan weq eleq1 abid syl6bb
      anbi12d cbvex bitri ) BDAEGZHDIZUDJZBKZDLACKZELBDUDMUGUHDEUFBEAEDNBEOPUHD
      ODEQZUFABCUIUFEIZUDJAUEUJUDRAESTFUAUBUC $.

    $( Existential quantification over a class abstraction.  (Contributed by
       Mario Carneiro, 3-Sep-2015.) $)
    rexrab2 $p |- ( E. x e. { y e. A | ph } ps <-> E. y e. A ( ph /\ ch ) ) $=
      ( crab wrex cv wcel wa cab wex df-rab rexeqi rexab2 anass exbii df-rex
      bitr4i 3bitri ) BDAEFHZIBDEJFKZALZEMZIUECLZENZACLZEFIZBDUCUFAEFOPUEBCDEGQ
      UHUDUILZENUJUGUKEUDACRSUIEFTUAUB $.
  $}

  ${
    $d w y A $.  $d w x z $.  $d x y $.  $d A z $.
    $( Identity used to create closed-form versions of bound-variable
       hypothesis builders for class expressions.  (Contributed by NM,
       10-Nov-2005.)  (Proof shortened by Mario Carneiro, 12-Oct-2016.) $)
    abidnf $p |- ( F/_ x A -> { z | A. x z e. A } = A ) $=
      ( wnfc cv wcel wal sp nfcr nfrd impbid2 abbi1dv ) ACDZBECFZAGZBCMONNAHMNA
      ABCIJKL $.
  $}

  ${
    $d y A $.  $d x z $.  $d x y $.  $d z A $.
    dedhb.1 $e |- ( A = { z | A. x z e. A } -> ( ph <-> ps ) ) $.
    dedhb.2 $e |- ps $.
    $( A deduction theorem for converting the inference ` |- F/_ x A ` =>
       ` |- ph ` into a closed theorem.  Use ~ nfa1 and ~ nfab to eliminate the
       hypothesis of the substitution instance ` ps ` of the inference.  For
       converting the inference form into a deduction form, ~ abidnf is
       useful.  (Contributed by NM, 8-Dec-2006.) $)
    dedhb $p |- ( F/_ x A -> ph ) $=
      ( wnfc cv wcel wal cab wceq wb abidnf eqcomd syl mpbiri ) CEHZABGSEDIEJCK
      DLZMABNSTECDEOPFQR $.
  $}

$(
###############################################################################
                            CLASSICAL LOGIC
###############################################################################

   There are a variety of theorems that only hold for decidable propositions,
   for example ~ df-dc , ~ notnotdc , or ~ condc , and we have stated and
   proved them for decidable propositions.

   As a historical note, however, the Intuitionistic Logic Explorer originated
   as a fork of the non-intuitionistic Metamath Proof Explorer, and the
   project of adding decidability conditions everywhere they are needed (or
   replacing non-intuitionistic proofs entirely) is not yet complete.

   Therefore, this section also (for now) contains the non-intuitionistic
   ~ ax-3 and additional theorems which rely on ~ ax-3 . As we replace
   classical proofs with intuitionistic ones, remove classical proofs which
   are unused and not especially important to contrast classical and
   intuitionistic results, or add decidability conditions to make proofs not
   rely on ~ ax-3 , we plan on reducing use of ~ ax-3 , moving ~ ax-3 still
   later in the file, and eventually removing it entirely.
$)

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                         Classical logic theorems
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

  $( Axiom _Transp_.  Axiom A3 of [Margaris] p. 49.

     Unconditional form of ~ condc .  We state this as an axiom for the benefit
     of theorems which have not yet been converted over to having appropriate
     decidability conditions added.  We could also transform intuitionistic
     logic to classical logic by adding unconditional forms of ~ exmiddc ,
     ~ peirce , or ~ notnot2dc .

     This axiom swaps or "transposes" the order of the consequents when
     negation is removed.  An informal example is that the statement "if there
     are no clouds in the sky, it is not raining" implies the statement "if it
     is raining, there are clouds in the sky."  This axiom is called _Transp_
     or "the principle of transposition" in _Principia Mathematica_ (Theorem
     *2.17 of [WhiteheadRussell] p. 103).  We will also use the term
     "contraposition" for this principle, although the reader is advised that
     in the field of philosophical logic, "contraposition" has a different
     technical meaning.  (Contributed by NM, 5-Aug-1993.)
     (New usage is discouraged.) $)
  ax-3 $a |- ( ( -. ph -> -. ps ) -> ( ps -> ph ) ) $.

  ${
    con4d.1 $e |- ( ph -> ( -. ps -> -. ch ) ) $.
    $( Deduction derived from axiom ~ ax-3 .  (Contributed by NM,
       26-Mar-1995.) $)
    con4d $p |- ( ph -> ( ch -> ps ) ) $=
      ( wn wi ax-3 syl ) ABECEFCBFDBCGH $.
  $}

  ${
    con1d.1 $e |- ( ph -> ( -. ps -> ch ) ) $.
    $( A contraposition deduction.  (Contributed by NM, 5-Aug-1993.)  (Revised
       by NM, 12-Feb-2013.) $)
    con1d $p |- ( ph -> ( -. ch -> ps ) ) $=
      ( wn notnot1 syl6 con4d ) ABCEZABECIEDCFGH $.
  $}

  $( Proof by contradiction.  Theorem *2.18 of [WhiteheadRussell] p. 103.  Also
     called the Law of Clavius.  This is not valid intuitionistically, but
     compare with ~ pm2.01 which is.  (Contributed by NM, 5-Aug-1993.) $)
  pm2.18 $p |- ( ( -. ph -> ph ) -> ph ) $=
    ( wn wi pm2.21 a2i con4d pm2.43i ) ABZACZAIAIHAIBZAJDEFG $.

  ${
    pm2.18d.1 $e |- ( ph -> ( -. ps -> ps ) ) $.
    $( Deduction based on reductio ad absurdum.  (Contributed by FL,
       12-Jul-2009.)  (Proof shortened by Andrew Salmon, 7-May-2011.) $)
    pm2.18d $p |- ( ph -> ps ) $=
      ( wn wi pm2.18 syl ) ABDBEBCBFG $.
  $}

  ${
    pm2.61d.1 $e |- ( ph -> ( ps -> ch ) ) $.
    pm2.61d.2 $e |- ( ph -> ( -. ps -> ch ) ) $.
    $( Deduction eliminating an antecedent.  (Contributed by NM, 27-Apr-1994.)
       (Proof shortened by Wolf Lammen, 12-Sep-2013.) $)
    pm2.61d $p |- ( ph -> ch ) $=
      ( wn con1d syld pm2.18d ) ACACFBCABCEGDHI $.
  $}

  ${
    pm2.61d1.1 $e |- ( ph -> ( ps -> ch ) ) $.
    pm2.61d1.2 $e |- ( -. ps -> ch ) $.
    $( Inference eliminating an antecedent.  (Contributed by NM,
       15-Jul-2005.) $)
    pm2.61d1 $p |- ( ph -> ch ) $=
      ( wn wi a1i pm2.61d ) ABCDBFCGAEHI $.
  $}

  ${
    pm2.61d2.1 $e |- ( ph -> ( -. ps -> ch ) ) $.
    pm2.61d2.2 $e |- ( ps -> ch ) $.
    $( Inference eliminating an antecedent.  (Contributed by NM,
       18-Aug-1993.) $)
    pm2.61d2 $p |- ( ph -> ch ) $=
      ( wi a1i pm2.61d ) ABCBCFAEGDH $.
  $}

  ${
    ja.1 $e |- ( -. ph -> ch ) $.
    ja.2 $e |- ( ps -> ch ) $.
    $( Inference joining the antecedents of two premises.  (Contributed by NM,
       5-Aug-1993.)  (Proof shortened by O'Cat, 19-Feb-2008.) $)
    ja $p |- ( ( ph -> ps ) -> ch ) $=
      ( wi imim2i pm2.61d1 ) ABFACBCAEGDH $.
  $}

  ${
    pm2.61i.1 $e |- ( ph -> ps ) $.
    pm2.61i.2 $e |- ( -. ph -> ps ) $.
    $( Inference eliminating an antecedent.  (Contributed by NM, 5-Apr-1994.)
       (Proof shortened by Wolf Lammen, 12-Sep-2013.) $)
    pm2.61i $p |- ps $=
      ( wi id ja ax-mp ) AAEBAFAABDCGH $.
  $}

  $( Double negation elimination.  Theorem *2.14 of [WhiteheadRussell] p. 102.
     This does not hold intuitionistically, although its coverse, ~ notnot1 ,
     does.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by David Harvey,
     5-Sep-1999.)  (Proof shortened by Josh Purinton, 29-Dec-2000.) $)
  notnot2 $p |- ( -. -. ph -> ph ) $=
    ( wn pm2.21 pm2.18d ) ABZBAEACD $.

  $( Double negation.  Theorem *4.13 of [WhiteheadRussell] p. 117.
     (Contributed by NM, 5-Aug-1993.) $)
  notnot $p |- ( ph <-> -. -. ph ) $=
    ( wn notnot1 notnot2 impbii ) AABBACADE $.

  ${
    impcon4bid.1 $e |- ( ph -> ( ps -> ch ) ) $.
    impcon4bid.2 $e |- ( ph -> ( -. ps -> -. ch ) ) $.
    $( A variation on ~ impbid with contraposition.  (Contributed by Jeff
       Hankins, 3-Jul-2009.) $)
    impcon4bid $p |- ( ph -> ( ps <-> ch ) ) $=
      ( con4d impbid ) ABCDABCEFG $.
  $}

  ${
    con4bid.1 $e |- ( ph -> ( -. ps <-> -. ch ) ) $.
    $( A contraposition deduction.  (Contributed by NM, 21-May-1994.)  (Revised
       by NM, 17-Sep-2013.) $)
    con4bid $p |- ( ph -> ( ps <-> ch ) ) $=
      ( wn biimprd con4d biimpd impcon4bid ) ABCACBABEZCEZDFGAJKDHI $.
  $}

  $( Contraposition.  Theorem *4.11 of [WhiteheadRussell] p. 117.  (Contributed
     by NM, 21-May-1994.)  (Proof shortened by Wolf Lammen, 12-Jun-2013.) $)
  notbi $p |- ( ( ph <-> ps ) <-> ( -. ph <-> -. ps ) ) $=
    ( wb wn id notbid con4bid impbii ) ABCZADBDCZIABIEFJABJEGH $.

  ${
    con1bii.1 $e |- ( -. ph <-> ps ) $.
    $( A contraposition inference.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by Wolf Lammen, 13-Oct-2012.) $)
    con1bii $p |- ( -. ps <-> ph ) $=
      ( wn notnot xchbinx bicomi ) ABDAADBAECFG $.
  $}

  ${
    con4bii.1 $e |- ( -. ph <-> -. ps ) $.
    $( A contraposition inference.  (Contributed by NM, 21-May-1994.) $)
    con4bii $p |- ( ph <-> ps ) $=
      ( wb wn notbi mpbir ) ABDAEBEDCABFG $.
  $}

  ${
    con2bii.1 $e |- ( ph <-> -. ps ) $.
    $( A contraposition inference.  (Contributed by NM, 5-Aug-1993.) $)
    con2bii $p |- ( ps <-> -. ph ) $=
      ( wn bicomi con1bii ) ADBBAABDCEFE $.
  $}

  $( Express implication in terms of conjunction.  Theorem 3.4(27) of [Stoll]
     p. 176.  Only the forward direction, ~ imanim , is valid
     intuitionistically.  See ~ imandc for a version which holds
     intuitionistically, by adding a decidability condition.  (Contributed by
     NM, 5-Aug-1993.)  (Proof shortened by Wolf Lammen, 30-Oct-2012.) $)
  iman $p |- ( ( ph -> ps ) <-> -. ( ph /\ -. ps ) ) $=
    ( wi wn wa notnot imbi2i imnan bitri ) ABCABDZDZCAJEDBKABFGAJHI $.

  $( Express conjunction in terms of implication.  Only the forward direction,
     ~ annimim , is valid intuitionistically.  See ~ annimdc for a version
     which holds intuitionistically, by adding a decidability condition.
     (Contributed by NM, 2-Aug-1994.) $)
  annim $p |- ( ( ph /\ -. ps ) <-> -. ( ph -> ps ) ) $=
    ( wi wn wa iman con2bii ) ABCABDEABFG $.

  $( Theorem *2.54 of [WhiteheadRussell] p. 107.  This does not hold
     intuitionistically, although its converse, ~ pm2.53 , does.  See
     ~ pm2.54dc for a version which holds intuitionistically, by restricting
     itself to decidable propositions.  (Contributed by NM, 3-Jan-2005.) $)
  pm2.54 $p |- ( ( -. ph -> ps ) -> ( ph \/ ps ) ) $=
    ( wn wo notnot2 orc syl olc ja ) ACZBABDZJCAKAEABFGBAHI $.

  $( Definition of 'or' in terms of negation and implication (classical).  See
     ~ dfordc for a version which holds intuitionistically, by restricting
     itself to decidable propositions.  Definition of [Margaris] p. 49.
     (Contributed by NM, 31-Jan-2015.) $)
  df-or $p |- ( ( ph \/ ps ) <-> ( -. ph -> ps ) ) $=
    ( wo wn wi pm2.53 pm2.54 impbii ) ABCADBEABFABGH $.

  $( Implication in terms of disjunction.  Theorem *4.6 of [WhiteheadRussell]
     p. 120.  See ~ imordc for a version which holds intuitionistically, by
     restricting itself to decidable propositions.  (Contributed by NM,
     5-Aug-1993.) $)
  imor $p |- ( ( ph -> ps ) <-> ( -. ph \/ ps ) ) $=
    ( wi wn wo notnot imbi1i df-or bitr4i ) ABCADZDZBCJBEAKBAFGJBHI $.

  ${
    orri.1 $e |- ( -. ph -> ps ) $.
    $( Infer implication from disjunction.  This is a classical, not an
       intuitionistic, result.  See ~ pm2.54dc for a version which holds
       intuitionistically, by restricting itself to decidable propositions.
       (Contributed by NM, 11-Jun-1994.) $)
    orri $p |- ( ph \/ ps ) $=
      ( wo wn wi df-or mpbir ) ABDAEBFCABGH $.
  $}

  $( Classical definition of existential quantification.  This does not hold
     intuitionistically, so it depends on ~ ax-3 for its proof.  Definition of
     [Margaris] p. 49.  (Contributed by NM, 2-Feb-2015.)  (Revised by Mario
     Carneiro, 12-May-2015.) $)
  df-ex $p |- ( E. x ph <-> -. A. x -. ph ) $=
    ( wn wal wex alnex con2bii ) ACBDABEABFG $.

  $( Theorem 19.6 of [Margaris] p. 89.  (Contributed by NM, 5-Aug-1993.) $)
  alex $p |- ( A. x ph <-> -. E. x -. ph ) $=
    ( wal wn wex notnot albii alnex bitri ) ABCADZDZBCJBEDAKBAFGJBHI $.

  ${
    mt3d.1 $e |- ( ph -> -. ch ) $.
    mt3d.2 $e |- ( ph -> ( -. ps -> ch ) ) $.
    $( Modus tollens deduction.  (Contributed by NM, 26-Mar-1995.) $)
    mt3d $p |- ( ph -> ps ) $=
      ( wn con1d mpd ) ACFBDABCEGH $.
  $}

  ${
    nsyl2.1 $e |- ( ph -> -. ps ) $.
    nsyl2.2 $e |- ( -. ch -> ps ) $.
    $( A negated syllogism inference.  (Contributed by NM, 26-Jun-1994.)
       (Revised by NM, 19-Jun-2013.) $)
    nsyl2 $p |- ( ph -> ch ) $=
      ( wn wi a1i mt3d ) ACBDCFBGAEHI $.
  $}

  ${
    con1i.a $e |- ( -. ph -> ps ) $.
    $( A contraposition inference.  (Contributed by NM, 5-Aug-1993.)  (Proof
       shortened by O'Cat, 28-Nov-2008.)  (Proof shortened by Wolf Lammen,
       19-Jun-2013.) $)
    con1i $p |- ( -. ps -> ph ) $=
      ( wn id nsyl2 ) BDZBAGECF $.
  $}

  $( Simplification.  Similar to Theorem *3.26 (Simp) of [WhiteheadRussell]
     p. 112.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Wolf
     Lammen, 21-Jul-2012.) $)
  simplim $p |- ( -. ( ph -> ps ) -> ph ) $=
    ( wi pm2.21 con1i ) AABCABDE $.

  $( Peirce's axiom.  This odd-looking theorem is the "difference" between an
     intuitionistic system of propositional calculus and a classical system and
     is not accepted by intuitionists.  When Peirce's axiom is added to an
     intuitionistic system, the system becomes equivalent to our classical
     system ~ ax-1 through ~ ax-3 .  A curious fact about this theorem is that
     it requires ~ ax-3 for its proof even though the result has no negation
     connectives in it.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by
     Wolf Lammen, 9-Oct-2012.) $)
  peirce $p |- ( ( ( ph -> ps ) -> ph ) -> ph ) $=
    ( wi simplim id ja ) ABCAAABDAEF $.

  ${
    19.32.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.32 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
    19.32 $p |- ( A. x ( ph \/ ps ) <-> ( ph \/ A. x ps ) ) $=
      ( wn wi wal wo hbn 19.21h df-or albii 3bitr4i ) AEZBFZCGNBCGZFABHZCGAPHNBC
      ACDIJQOCABKLAPKM $.
  $}

  ${
    19.31.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.31 of [Margaris] p. 90.  Only the reverse direction is valid
       intuitionistically.  (Contributed by NM, 5-Aug-1993.) $)
    19.31 $p |- ( A. x ( ph \/ ps ) <-> ( A. x ph \/ ps ) ) $=
      ( wo wal 19.32 orcom albii 3bitr4i ) BAEZCFBACFZEABEZCFLBEBACDGMKCABHILBH
      J $.
  $}

  $( Theorem 19.35 of [Margaris] p. 90.  In classical logic, this theorem is
     useful for moving an implication (in the form of the right-hand side) into
     the scope of a single existential quantifier.  The forward direction,
     ~ 19.35-1 , holds intuitionistically.  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by Wolf Lammen, 27-Jun-2014.) $)
  19.35 $p |- ( E. x ( ph -> ps ) <-> ( A. x ph -> E. x ps ) ) $=
    ( wi wex wal wn wa 19.26 annim albii alnex anbi2i 3bitr3i con4bii ) ABDZCEZ
    ACFZBCEZDZPGZCFZRSGZHZQGTGABGZHZCFRUECFZHUBUDAUECIUFUACABJKUGUCRBCLMNPCLRSJ
    NO $.

  ${
    19.37.1 $e |- ( ph -> A. x ph ) $.
    $( Theorem 19.37 of [Margaris] p. 90.  The forward direction is valid
       intuitionistically (it could be proved from ~ 19.35-1 ), but the reverse
       direction is not.  (Contributed by NM, 5-Aug-1993.) $)
    19.37 $p |- ( E. x ( ph -> ps ) <-> ( ph -> E. x ps ) ) $=
      ( wi wex wal 19.35 19.3h imbi1i bitri ) ABECFACGZBCFZEAMEABCHLAMACDIJK $.
  $}

  ${
    $d x ph $.
    $( Special case of Theorem 19.37 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.37v $p |- ( E. x ( ph -> ps ) <-> ( ph -> E. x ps ) ) $=
      ( ax-17 19.37 ) ABCACDE $.
  $}

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        Existential uniqueness (supplemental)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   This section contains the theorems on existential uniqueness which have
   not yet been moved to the main section on existential uniqueness
   in the predicate logic section. Some of them do not rely on ~ ax-3 and
   are ready to move as-is, while others will require changes to remove
   the use of ~ ax-3 .

$)

  ${
    $d x y z $.  $d ph z $.
    mo.1 $e |- ( ph -> A. y ph ) $.
    $( Equivalent definitions of "there exists at most one."  (Contributed by
       NM, 7-Aug-1994.) $)
    mo $p |- ( E. y A. x ( ph -> x = y ) <->
               A. x A. y ( ( ph /\ [ y / x ] ph ) -> x = y ) ) $=
      ( vz weq wi wal wex wsb wa ax-17 hbim hbal cbv3h syl sylbir alimi wn hbn
      equequ2 imbi2d albidv cbvexh hbs1 sbequ2 ax-8 imim12d ancli aaan prth syl6
      sylibr equtr2 2alimi exlimiv impexp bi2.04 bitri 2albii eximi a7s syl5com
      alim exim syl5bi alnex sbequ1 equcoms con3d pm2.21 19.8a 3syl a1d pm2.61i
      impbii ) ABCFZGZBHZCIZAABCJZKZVQGZCHBHZVTABEFZGZBHZEIWDWGVSECWFCBAWECDWEC
      LMZNVSELECFZWFVRBWIWEVQAECBUAUBUCUDWGWDEWGWFWACEFZGZKZCHBHZWDWGWGWKCHZKWM
      WGWNWFWKBCWHWAWJBABCUEZWJBLMZVQWAAWEWJABCUFBCEUGUHOUIWFWKBCWHWPUJUMWLWCBC
      WLWBWEWJKVQAWEWAWJUKBCEUNULUOPUPQWACIZWDVTGWDWAVRGZCHBHZWQVTWCWRBCWCAWAVQ
      GGWRAWAVQUQAWAVQURUSUTWQWABHZCIZWSVTWAWTCWOVAWSWTVSGZCHZXAVTGWRXCCBWRBHXB
      CWAVRBVDRVBWTVSCVEPVCVFWQSZVTWDXDWASZCHZVTWACVGXFASZBHVSVTXEXGCBWABWOTACD
      TCBFAWAAWAGBCABCVHVIVJOXGVRBAVQVKRVSCVLVMQVNVOVP $.
  $}

  ${
    $d x y $.
    mo2.1 $e |- ( ph -> A. y ph ) $.
    $( Alternate definition of "at most one."  (Contributed by NM,
       8-Mar-1995.) $)
    mo2 $p |- ( E* x ph <-> E. y A. x ( ph -> x = y ) ) $=
      ( wmo wex weu wi weq wal df-mo alnex pm2.21 alimi 19.8a syl sylbir eumo0
      wn ja eu3 simplbi2com impbii bitri ) ABEABFZABGZHZABCIZHZBJZCFZABKUGUKUEU
      FUKUESASZBJZUKABLUMUJUKULUIBAUHMNUJCOPQABCDRTUFUEUKABCDUAUBUCUD $.
  $}

  ${
    $d w x z $.  $d w y z $.  $d w ph $.
    $( Substitution into "at most one".  (Contributed by Jeff Madsen,
       2-Sep-2009.) $)
    sbmo $p |- ( [ y / x ] E* z ph <-> E* z [ y / x ] ph ) $=
      ( vw cv wceq wi wal wex wsbc wmo sbex ax-17 sblim sbalv exbii bitri sbbii
      mo2 3bitr4i ) ADFEFGZHZDIZEJZBCFZKZABUFKZUBHZDIZEJZADLZBUFKUHDLUGUDBUFKZE
      JUKUDEBCMUMUJEUCUIBCDAUBBCUBBNOPQRULUEBCADEAENTSUHDEUHENTUA $.
  $}

  ${
    $d x y $.  $d y ph $.
    mo4f.1 $e |- ( ps -> A. x ps ) $.
    mo4f.2 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( "At most one" expressed using implicit substitution.  (Contributed by
       NM, 10-Apr-2004.) $)
    mo4f $p |- ( E* x ph <-> A. x A. y ( ( ph /\ ps ) -> x = y ) ) $=
      ( wmo wsb wa weq wi wal ax-17 mo3 sbieh anbi2i imbi1i 2albii bitri ) ACGAA
      CDHZIZCDJZKZDLCLABIZUBKZDLCLACDADMNUCUECDUAUDUBTBAABCDEFOPQRS $.
  $}

  ${
    $d x y $.  $d y ph $.  $d x ps $.
    mo4.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( "At most one" expressed using implicit substitution.  (Contributed by
       NM, 26-Jul-1995.) $)
    mo4 $p |- ( E* x ph <-> A. x A. y ( ( ph /\ ps ) -> x = y ) ) $=
      ( ax-17 mo4f ) ABCDBCFEG $.
  $}

  ${
    $d x y $.  $d y ph $.  $d x ps $.
    eu4.1 $e |- ( x = y -> ( ph <-> ps ) ) $.
    $( Uniqueness using implicit substitution.  (Contributed by NM,
       26-Jul-1995.) $)
    eu4 $p |- ( E! x ph <-> ( E. x ph /\
             A. x A. y ( ( ph /\ ps ) -> x = y ) ) ) $=
      ( weu wex wmo wa weq wi wal eu5 mo4 anbi2i bitri ) ACFACGZACHZIQABICDJKDL
      CLZIACMRSQABCDENOP $.
  $}

  $( Existence in terms of "at most one" and uniqueness.  (Contributed by NM,
     5-Apr-2004.) $)
  exmoeu $p |- ( E. x ph <-> ( E* x ph -> E! x ph ) ) $=
    ( wex wmo weu wi df-mo biimpi com12 biimpri euex imim12i peirce syl impbii
    ) ABCZABDZABEZFZQPRQPRFZABGZHISTPFPTQRPQTUAJABKLPRMNO $.

  $( Something exists or at most one exists.  (Contributed by NM,
     8-Mar-1995.) $)
  exmo $p |- ( E. x ph \/ E* x ph ) $=
    ( wex wmo wn weu wi pm2.21 df-mo sylibr orri ) ABCZABDZLELABFZGMLNHABIJK $.

  ${
    $d x y $.  $d y ph $.  $d y ps $.
    $( "At most one" is preserved through implication (notice wff reversal).
       (Contributed by NM, 22-Apr-1995.) $)
    moim $p |- ( A. x ( ph -> ps ) -> ( E* x ps -> E* x ph ) ) $=
      ( vy wi wal cv wsbc wa wceq wmo nfa1 ax-4 a4sbim anim12d imim1d
      alimdv alrimi ax-17 mo3 ax-5 syl 3imtr4g ) ABEZCFZBBCDGZHZIZCGU
      FJZEZDFZCFZAACUFHZIZUIEZDFZCFZBCKACKUEUKUPEZCFULUQEUEURCUDCLUEU
      JUODUEUNUHUIUEABUMUGUDCMABCDNOPQRUKUPCUAUBBCDBDSTACDADSTUC $.
  $}

  ${
    moimi.1 $e |- ( ph -> ps ) $.
    $( "At most one" is preserved through implication (notice wff reversal).
       (Contributed by NM, 15-Feb-2006.) $)
    moimi $p |- ( E* x ps -> E* x ph ) $=
      ( wi wmo moim mpg ) ABEBCFACFECABCGDH $.
  $}

  ${
    $d x y $.  $d x y ph $.  $d y ps $.
    $( Move antecedent outside of "at most one."  (Contributed by NM,
       28-Jul-1995.) $)
    moimv $p |- ( E* x ( ph -> ps ) -> ( ph -> E* x ps ) ) $=
      ( vy wi wmo wsb weq wal ax-1 a1i sbimi nfv sbf sbim 3imtr3i anim12d ax-17
      wa mo3 imim1d 2alimdv 3imtr4g com12 ) AABEZCFZBCFZAUEUECDGZSZCDHZEZDICIBB
      CDGZSZUJEZDICIUFUGAUKUNCDAUMUIUJABUEULUHBUEEZABAJKZACDGUOCDGAULUHEAUOCDUP
      LACDACMNBUECDOPQUAUBUECDUEDRTBCDBDRTUCUD $.
  $}

  $( Uniqueness implies "at most one" through implication.  (Contributed by NM,
     22-Apr-1995.) $)
  euimmo $p |- ( A. x ( ph -> ps ) -> ( E! x ps -> E* x ph ) ) $=
    ( weu wmo wi wal eumo moim syl5 ) BCDBCEABFCGACEBCHABCIJ $.

  $( Add existential uniqueness quantifiers to an implication.  Note the
     reversed implication in the antecedent.  (Contributed by NM,
     19-Oct-2005.)  (Proof shortened by Andrew Salmon, 14-Jun-2011.) $)
  euim $p |- ( ( E. x ph /\ A. x ( ph -> ps ) ) -> ( E! x ps -> E! x ph ) ) $=
    ( wex wi wal wa weu wmo ax-1 euimmo anim12ii eu5 syl6ibr ) ACDZABECFZGBCHZO
    ACIZGACHOQOPROQJABCKLACMN $.

  $( "At most one" is still the case when a conjunct is added.  (Contributed by
     NM, 22-Apr-1995.) $)
  moan $p |- ( E* x ph -> E* x ( ps /\ ph ) ) $=
    ( wa simpr moimi ) BADACBAEF $.

  ${
    moani.1 $e |- E* x ph $.
    $( "At most one" is still true when a conjunct is added.  (Contributed by
       NM, 9-Mar-1995.) $)
    moani $p |- E* x ( ps /\ ph ) $=
      ( wmo wa moan ax-mp ) ACEBAFCEDABCGH $.
  $}

  $( "At most one" is still the case when a disjunct is removed.  (Contributed
     by NM, 5-Apr-2004.) $)
  moor $p |- ( E* x ( ph \/ ps ) -> E* x ph ) $=
    ( wo orc moimi ) AABDCABEF $.

  $( "At most one" imports disjunction to conjunction.  (Contributed by NM,
     5-Apr-2004.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
  mooran1 $p |- ( ( E* x ph \/ E* x ps ) -> E* x ( ph /\ ps ) ) $=
    ( wmo wa simpl moimi moan jaoi ) ACDABEZCDBCDJACABFGBACHI $.

  $( "At most one" exports disjunction to conjunction.  (Contributed by NM,
     5-Apr-2004.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
  mooran2 $p |- ( E* x ( ph \/ ps ) -> ( E* x ph /\ E* x ps ) ) $=
    ( wo wmo moor olc moimi jca ) ABDZCEACEBCEABCFBJCBAGHI $.

  ${
    $d x y $.  $d y ph $.  $d y ps $.
    moanim.1 $e |- ( ph -> A. x ph ) $.
    $( Introduction of a conjunct into "at most one" quantifier.  (Contributed
       by NM, 3-Dec-2001.) $)
    moanim $p |- ( E* x ( ph /\ ps ) <-> ( ph -> E* x ps ) ) $=
      ( vy wa weq wi wal wex impexp albii 19.21h bitri exbii ax-17 imbi2i 19.37v
      wmo mo2 bitr4i 3bitr4i ) ABFZCEGZHZCIZEJABUDHZCIZHZEJZUCCSABCSZHZUFUIEUFA
      UGHZCIUIUEUMCABUDKLAUGCDMNOUCCEUCEPTULAUHEJZHUJUKUNABCEBEPTQAUHERUAUB $.
  $}

  ${
    $d x y ph $.  $d y ps $.
    $( Introduction of a conjunct into "at most one" quantifier.  (Contributed
       by NM, 23-Mar-1995.) $)
    moanimv $p |- ( E* x ( ph /\ ps ) <-> ( ph -> E* x ps ) ) $=
      ( ax-17 moanim ) ABCACDE $.
  $}

  $( Nested "at most one" and uniqueness quantifiers.  (Contributed by NM,
     25-Jan-2006.) $)
  moaneu $p |- E* x ( ph /\ E! x ph ) $=
    ( weu wa wmo wi eumo hbeu1 moanim mpbir ancom mobii ) AABCZDZBEMADZBEZPMABE
    FABGMABABHIJNOBAMKLJ $.

  $( Nested "at most one" quantifiers.  (Contributed by NM, 25-Jan-2006.) $)
  moanmo $p |- E* x ( ph /\ E* x ph ) $=
    ( wmo wa wi id hbmo1 moanim mpbir ancom mobii ) AABCZDZBCLADZBCZOLLELFLABAB
    GHIMNBALJKI $.

  ${
    $d x y $.  $d y ph $.  $d y ps $.
    $( "At most one" picks a variable value, eliminating an existential
       quantifier.  (Contributed by NM, 27-Jan-1997.) $)
    mopick $p |- ( ( E* x ph /\ E. x ( ph /\ ps ) ) -> ( ph -> ps ) ) $=
      ( vy wa wex wmo wi wsb ax-17 hbs1 hban weq sbequ12 anbi12d cbvexh wal ax-4
      mo3 sylbi sps sbequ2 imim2i exp3a com4t imp syl5 exlimiv impcom ) ABEZCFZ
      ACGZABHZUKACDIZBCDIZEZDFULUMHZUJUPCDUJDJUNUOCACDKBCDKLCDMZAUNBUOACDNBCDNO
      PUPUQDULAUNEZURHZUPUMULUTDQZCQUTACDADJSVAUTCUTDRUATUNUOUTUMHUTAUNUOBUTAUN
      UOBHZURVBUSBCDUBUCUDUEUFUGUHTUI $.
  $}

  $( Existential uniqueness "picks" a variable value for which another wff is
     true.  If there is only one thing ` x ` such that ` ph ` is true, and
     there is also an ` x ` (actually the same one) such that ` ph ` and ` ps `
     are both true, then ` ph ` implies ` ps ` regardless of ` x ` .  This
     theorem can be useful for eliminating existential quantifiers in a
     hypothesis.  Compare Theorem *14.26 in [WhiteheadRussell] p. 192.
     (Contributed by NM, 10-Jul-1994.) $)
  eupick $p |- ( ( E! x ph /\ E. x ( ph /\ ps ) ) -> ( ph -> ps ) ) $=
    ( weu wmo wa wex wi eumo mopick sylan ) ACDACEABFCGABHACIABCJK $.

  $( Version of ~ eupick with closed formulas.  (Contributed by NM,
     6-Sep-2008.) $)
  eupicka $p |- ( ( E! x ph /\ E. x ( ph /\ ps ) ) -> A. x ( ph -> ps ) ) $=
    ( weu wa wex wi hbeu1 hbe1 hban eupick alrimih ) ACDZABEZCFZEABGCMOCACHNCIJA
    BCKL $.

  $( Existential uniqueness "pick" showing wff equivalence.  (Contributed by
     NM, 25-Nov-1994.) $)
  eupickb $p |- ( ( E! x ph /\ E! x ps /\ E. x ( ph /\ ps ) ) ->
               ( ph <-> ps ) ) $=
    ( weu wa wex w3a wi eupick 3adant2 3simpc pm3.22 eximi anim2i 3syl impbid )
    ACDZBCDZABEZCFZGZABQTABHRABCIJUARTERBAEZCFZEBAHQRTKTUCRSUBCABLMNBACIOP $.

  $( Theorem *14.26 in [WhiteheadRussell] p. 192.  (Contributed by Andrew
     Salmon, 11-Jul-2011.) $)
  eupickbi $p |- ( E! x ph -> ( E. x ( ph /\ ps ) <-> A. x ( ph -> ps ) ) ) $=
    ( weu wa wex wi wal eupicka ex hba1 wb ancl simpl impbid1 eubidh euex syl6bi
    sps com12 impbid ) ACDZABEZCFZABGZCHZUBUDUFABCIJUFUBUDUFUBUCCDUDUFAUCCUECKU
    EAUCLCUEAUCABMABNOSPUCCQRTUA $.

  $( "At most one" can show the existence of a common value.  In this case we
     can infer existence of conjunction from a conjunction of existence, and it
     is one way to achieve the converse of ~ 19.40 .  (Contributed by NM,
     5-Apr-2004.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
  mopick2 $p |- ( ( E* x ph /\ E. x ( ph /\ ps ) /\ E. x ( ph /\ ch ) ) ->
                E. x ( ph /\ ps /\ ch ) ) $=
    ( wmo wa wex w3a hbmo1 hbe1 mopick ancld anim1d df-3an syl6ibr eximdh 3impia
    hban ) ADEZABFZDGZACFZDGABCHZDGSUAFZUBUCDSUADADITDJRUDUBTCFUCUDATCUDABABDKL
    MABCNOPQ $.

  ${
    moexex.1 $e |- ( ph -> A. y ph ) $.
    $( "At most one" double quantification.  (Contributed by NM,
       3-Dec-2001.) $)
    moexex $p |- ( ( E* x ph /\ A. x E* y ps ) -> E* y E. x ( ph /\ ps ) ) $=
      ( wmo wal wa wex wi hbmo1 hba1 hbe1 hbmo hbim mopick ex exlimih wn a1d ori
      com3r alrimdh moim spsd syl6 hbex exsimpl con3i exmo syl pm2.61i imp ) ACF
      ZBDFZCGZABHZCIZDFZACIZUNUPUSJZJZAVBCUNVACACKUPUSCUOCLURCDUQCMNOOAUNURBJZD
      GZVAAUNVCDEADCENUNURABUNURABJABCPQUBUCVDUOUSCURBDUDUEUFRUTSZVAUNVEUSUPVEU
      RDIZSUSVFUTURUTDADCEUGABCUHRUIVFUSURDUJUAUKTTULUM $.
  $}

  ${
    $d y ph $.
    $( "At most one" double quantification.  (Contributed by NM,
       26-Jan-1997.) $)
    moexexv $p |- ( ( E* x ph /\ A. x E* y ps ) -> E* y E. x ( ph /\ ps ) ) $=
      ( ax-17 moexex ) ABCDADEF $.
  $}

  $( Double quantification with "at most one."  (Contributed by NM,
     3-Dec-2001.) $)
  2moex $p |- ( E* x E. y ph -> A. y E* x ph ) $=
    ( wex wmo hbe1 hbmo 19.8a moimi alrimih ) ACDZBEABECKCBACFGAKBACHIJ $.

  $( Double quantification with existential uniqueness.  (Contributed by NM,
     3-Dec-2001.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
  2euex $p |- ( E! x E. y ph -> E. y E! x ph ) $=
    ( wex weu wmo wa eu5 excom hbe1 19.8a moimi df-mo sylib eximdh syl5bi impcom
    hbmo wi sylbi ) ACDZBEUABDZUABFZGABEZCDZUABHUCUBUEUBABDZCDUCUEABCIUCUFUDCUA
    CBACJRUCABFUFUDSAUABACKLABMNOPQT $.

  $( Double quantification with existential uniqueness and "at most one."
     (Contributed by NM, 3-Dec-2001.) $)
  2eumo $p |- ( E! x E* y ph -> E* x E! y ph ) $=
    ( weu wmo wi euimmo eumo mpg ) ACDZACEZFKBDJBEFBJKBGACHI $.

  $( A condition allowing swap of "at most one" and existential quantifiers.
     (Contributed by NM, 10-Apr-2004.) $)
  2moswap $p |- ( A. x E* y ph -> ( E* x E. y ph -> E* y E. x ph ) ) $=
    ( wmo wal wex wa hbe1 moexex expcom 19.8a pm4.71ri exbii mobii syl6ibr ) AC
    DBEZACFZBDZQAGZBFZCDZABFZCDRPUAQABCACHIJUBTCASBAQACKLMNO $.

  $( A condition allowing swap of uniqueness and existential quantifiers.
     (Contributed by NM, 10-Apr-2004.) $)
  2euswap $p |- ( A. x E* y ph -> ( E! x E. y ph -> E! y E. x ph ) ) $=
    ( wmo wal wex wa weu wi excomim a1i 2moswap anim12d eu5 3imtr4g ) ACDBEZACF
    ZBFZQBDZGABFZCFZTCDZGQBHTCHPRUASUBRUAIPABCJKABCLMQBNTCNO $.

  $( Double existential uniqueness implies double uniqueness quantification.
     (Contributed by NM, 3-Dec-2001.) $)
  2exeu $p |- ( ( E! x E. y ph /\ E! y E. x ph ) -> E! x E! y ph ) $=
    ( wex wmo weu excom hbe1 19.41h 19.8a moimi anim2i eximi sylbir sylanb simpl
    wa hbmo eu5 anbi12i adantl anim12i ancoms exbii mobii bitri 3imtr4i ) ACDZB
    DZUHBEZQZABDZCDZULCEZQZQUHACEZQZBDZUQBEZQZUHBFZULCFZQACFZBFZUOUKUTUOURUKUSU
    MUIUNURACBGUIUNQUHUNQZBDURUHUNBULBCABHRIVEUQBUNUPUHAULCABJKLMNOUJUSUIUQUHBU
    HUPPKUAUBUCVAUKVBUOUHBSULCSTVDVCBDZVCBEZQUTVCBSVFURVGUSVCUQBACSZUDVCUQBVHUE
    TUFUG $.

  ${
    $d x y z w v u $.  $d z w v u ph $.
    $( Two equivalent expressions for double "at most one."  (Contributed by
       NM, 2-Feb-2005.) $)
    2mo $p |- ( E. z E. w A. x A. y ( ph -> ( x = z /\ y = w ) ) <->
              A. x A. y A. z A. w ( ( ph /\ [ z / x ] [ w / y ] ph ) ->
                   ( x = z /\ y = w ) ) ) $=
      ( vv vu weq wa wi wal wex wsb equequ2 bi2anan9 ax-17 albii bitri 2alimi
      wn imbi2d 2albidv cbvex2v hbs1 hbim hbsb sbequ12 sylan9bbr equequ1 cbval2
      imbi12d biimpi ancli alcom aaan hbal sylibr prth equtr2 anim12i an4s syl6
      syl exlimivv sylbir impexp bi2.04 2albii alrimih 2eximi alrot4 alim al2imi
      sylbi exim alimi syl5com syl5bi alnex notbid biimpri pm2.21 19.8a 19.23bi
      3syl hbn a1d pm2.61i impbii ) ABDHZCEHZIZJZCKZBKZELZDLZAACEMZBDMZIZWLJZEK
      DKZCKBKZWQABFHZCGHZIZJZCKZBKZGLFLXCXIWOFGDEFDHZGEHZIZXGWMBCXLXFWLAXJXDWJX
      KXEWKFDBNGECNOUAUBUCXIXCFGXIXGWSDFHZEGHZIZJZIZEKZDKZCKZBKZXCXIXIXPEKZDKZI
      ZYAXIYCXIYCXGXPBCDEXGDPXGEPZWSXOBWRBDUDZXOBPUEZWSXOCWRBDCACEUDUFZXOCPUEZW
      LAWSXFXOWKAWRWJWSACEUGWRBDUGUHZWJXDXMWKXEXNBDFUICEGUIOUKUJULUMYAXHYBIZDKZ
      BKYDXTYLBXTXRCKZDKYLXRCDUNYMYKDXGXPCEYEYIUOQRQXHYBBDXHDPXPBEYGUPUORUQXSXB
      BCXQXADEXQWTXFXOIWLAXFWSXOURXDXMXEXNWLXDXMIWJXEXNIWKBDFUSCEGUSUTVAVBSSVCV
      DVEWSELZDLZXCWQJXCWSWMJZEKDKZCKBKZYOWQXBYQBCXAYPDEXAAWSWLJJYPAWSWLVFAWSWL
      VGRVHVHYOWSCKZBKZELZDLZYRWQWSYTDEWSYSBYFYHVIVJYRYTWOJZEKZDKZUUAWPJZDKUUBW
      QJYRYPCKZBKZEKDKUUEYPBCDEVKUUHUUCDEUUGYSWNBWSWMCVLVMSVNUUDUUFDYTWOEVOVPUU
      AWPDVOWEVQVRYOTZWQXCUUIWSTZEKZDKZWQUULYNTZDKUUIUUKUUMDWSEVSQYNDVSRUULATZC
      KBKZWOWQUUOUULUUNUUJBCDEUUNDPUUNEPWSBYFWFWSCYHWFWLAWSYJVTUJWAUUNWMBCAWLWB
      SWOWQEWPDWCWDWEVEWGWHWI $.
  $}

  ${
    $d z w ph $.  $d x y ps $.  $d x y z w $.
    2mos.1 $e |- ( ( x = z /\ y = w ) -> ( ph <-> ps ) ) $.
    $( Double "exists at most one", using implicit substitition.  (Contributed
       by NM, 10-Feb-2005.) $)
    2mos $p |- ( E. z E. w A. x A. y ( ph -> ( x = z /\ y = w ) ) <->
             A. x A. y A. z A. w ( ( ph /\ ps ) -> ( x = z /\ y = w ) ) ) $=
      ( weq wa wi wal wex wsb 2mo ax-17 sbrim wb expcom sbieh 2albii pm5.74ri
      pm5.74d bitr3i anbi2i imbi1i bitri ) ACEHZDFHZIZJDKCKFLELAADFMZCEMZIZUIJZ
      FKEKZDKCKABIZUIJZFKEKZDKCKACDEFNUNUQCDUMUPEFULUOUIUKBAUJBCEBCOUGUJBUGUJJU
      GAJZDFMUGBJZUGADFUGDOPURUSDFUSDOUHUGABUGUHABQGRUBSUCUASUDUETTUF $.
  $}

  $( Double existential uniqueness.  This theorem shows a condition under which
     a "naive" definition matches the correct one.  (Contributed by NM,
     3-Dec-2001.) $)
  2eu1 $p |- ( A. x E* y ph ->
        ( E! x E! y ph <-> ( E! x E. y ph /\ E! y E. x ph ) ) ) $=
    ( wmo wal weu wex wa wi eu5 exbii mobii anbi12i bitri simprbi anim2i ancoms
    ax-4 sylib com12 moimi hba1 moanim ancrd 2moswap imdistani syl 2eu2ex excom
    syl6 jca jctild an4 syl6ibr 2exeu impbid1 ) ACDZBEZACFZBFZACGZBFZABGZCFZHZU
    TURVEUTURVABGZVCCGZHZVABDZVCCDZHZHZVEUTURVKVHUTVAUQHZBDZURVKIUTVMBGZVNUTUSB
    GZUSBDZHVOVNHUSBJVPVOVQVNUSVMBACJZKUSVMBVRLMNOVNURVIURHVKVNURVIVNURVAHZBDUR
    VIIVSVMBVAURVMURUQVAUQBRPQUAURVABUQBUBUCSUDVIURVJURVIVJABCUETUFUJUGUTVFVGAB
    CUHZUTVFVGVTABCUISUKULVEVFVIHZVGVJHZHVLVBWAVDWBVABJVCCJMVFVIVGVJUMNUNTABCUO
    UP $.

  $( Double existential uniqueness.  (Contributed by NM, 3-Dec-2001.) $)
  2eu2 $p |- ( E! y E. x ph -> ( E! x E! y ph <-> E! x E. y ph ) ) $=
    ( wex weu wmo wal wi eumo 2moex 2eu1 simpl syl6bi 3syl 2exeu expcom impbid
    wa ) ABDZCEZACEBEZACDBEZTSCFACFBGZUAUBHSCIACBJUCUAUBTRUBABCKUBTLMNUBTUAABCO
    PQ $.


  $( Double existential uniqueness.  (Contributed by NM, 3-Dec-2001.) $)
  2eu3 $p |- ( A. x A. y ( E* x ph \/ E* y ph ) ->
 ( ( E! x E! y ph /\ E! y E! x ph ) <-> ( E! x E. y ph /\ E! y E. x ph ) ) ) $=
    ( wmo wo wal weu wa wex wb hbmo1 19.31 albii hbal 19.32 bitri wi 2eu1 2exeu
    biimpd ancom syl6ib adantld adantrd jaoi ancoms jca impbid1 sylbi ) ABDZACD
    ZECFZBFZUJCFZUKBFZEZACGBGZABGCGZHZACIBGZABICGZHZJUMUNUKEZBFUPULVCBUJUKCACKL
    MUNUKBUJBCABKNOPUPUSVBUNUSVBQUOUNURVBUQUNURVAUTHZVBUNURVDACBRTVAUTUAUBUCUOU
    QVBURUOUQVBABCRTUDUEVBUQURABCSVAUTURACBSUFUGUHUI $.

  ${
    $d x y z w $.  $d z w ph $.
    $( This theorem provides us with a definition of double existential
       uniqueness ("exactly one ` x ` and exactly one ` y ` ").  Naively one
       might think (incorrectly) that it could be defined by
       ` E! x E! y ph ` .  See ~ 2eu1 for a condition under which the naive
       definition holds and ~ 2exeu for a one-way implication.  See ~ 2eu5 and
       ~ 2eu8 for alternate definitions.  (Contributed by NM, 3-Dec-2001.) $)
    2eu4 $p |- ( ( E! x E. y ph /\ E! y E. x ph ) <->
      ( E. x E. y ph /\ E. z E. w A. x A. y ( ph -> ( x = z /\ y = w ) ) ) ) $=
      ( wex weu wa weq wal ax-17 eu3 anbi12i anbi2i bitri hba1 19.3h 19.26 albii
      wi an4 excom anidm jcab 3bitr4ri alcom bitr4i 19.23v 2albii 3bitri 2exbii
      hbe1 hbim aaan eeanv bitr2i ) ACFZBGZABFZCGZHUQBFZUQBDIZTZBJZDFZHZUSCFZUS
      CEIZTZCJZEFZHZHVAVGHZVEVKHZHVAAVBVHHTZCJZBJZEFDFZHURVFUTVLUQBDUQDKLUSCEUS
      EKLMVAVEVGVKUAVMVAVNVRVMVAVAHVAVGVAVAACBUBNVAUCOVRVDVJHZEFDFVNVQVSDEVQAVB
      TZCJZAVHTZBJZHZCJZBJZVCVIHZCJBJVSVQWAWBCJZBJZHZBJZWFWABJZWIBJZHWLWIHZWKVQ
      WMWIWLWIBWHBPQNWAWIBRVQWAWHHZBJWNVPWOBVPVTWBHZCJWOVOWPCAVBVHUDSVTWBCROSWA
      WHBROUEWEWJBWEWACJZWCCJZHWJWAWCCRWQWAWRWIWACVTCPQWBCBUFMOSUGWDWGBCWAVCWCV
      IAVBCUHAVHBUHMUIVCVIBCUQVBCACULVBCKUMUSVHBABULVHBKUMUNUJUKVDVJDEUOUPMUJ
      $.

    $( An alternate definition of double existential uniqueness (see ~ 2eu4 ).
       A mistake sometimes made in the literature is to use ` E! x E! y ` to
       mean "exactly one ` x ` and exactly one ` y ` ."  (For example, see
       Proposition 7.53 of [TakeutiZaring] p. 53.)  It turns out that this is
       actually a weaker assertion, as can be seen by expanding out the formal
       definitions.  This theorem shows that the erroneous definition can be
       repaired by conjoining ` A. x E* y ph ` as an additional condition.  The
       correct definition apparently has never been published.  ( ` E* ` means
       "exists at most one.") (Contributed by NM, 26-Oct-2003.) $)
    2eu5 $p |- ( ( E! x E! y ph /\ A. x E* y ph ) <->
      ( E. x E. y ph /\ E. z E. w A. x A. y ( ph -> ( x = z /\ y = w ) ) ) ) $=
      ( weu wmo wal wa wex weq 2eu1 pm5.32ri eumo adantl 2moex syl pm4.71i 2eu4
      wi 3bitr2i ) ACFBFZACGBHZIACJZBFZABJZCFZIZUCIUHUDBJABDKCEKITCHBHEJDJIUCUB
      UHABCLMUHUCUHUFCGZUCUGUIUEUFCNOACBPQRABCDESUA $.
  $}

  ${
    $d x y z w v u $.  $d z w v u ph $.
    $( Two equivalent expressions for double existential uniqueness.
       (Contributed by NM, 2-Feb-2005.) $)
    2eu6 $p |- ( ( E! x E. y ph /\ E! y E. x ph ) <->
               E. z E. w A. x A. y ( ph <-> ( x = z /\ y = w ) ) ) $=
      ( vu vv wex wa weq wi wal ax-17 hbsb sbequ12 equequ2 bi2anan9 hbim 2exbii
      wsb weu 2eu4 19.29r2 hbs1 sylan9bbr cbvex2 imbi2d 2albidv cbvex2v equequ1
      wb imbi12d cbval2 3bitri anbi12i 2albiim ancom bitri equcom imbi2i impexp
      2mo 2albii hban sbco2h sbcom2 sbbii 3bitr3ri syl6bb anbi2d 19.21-2 3bitr3i
      anbi2i abai 2sb6 anbi1i 3bitr2i bitr4i 3imtr4i 2alimi 2eximi 2exsb sylibr
      bi2 bi1 jca impbii ) ACHZBUAABHCUAIWHBHZABDJZCEJZIZKZCLBLZEHDHZIZAWLUKZCL
      BLZEHDHZABCDEUBWPWSACETZBDTZEHDHZXAXAEFTZDGTZIZDGJZEFJZIZKZFLGLZELDLZIXAX
      JIZEHDHZWPWSXAXJDEUCWIXBWOXKAXABCDEADMAEMZWTBDUDZWTBDCACEUDNZWKAWTWJXAACE
      OWTBDOUEZUFWOABGJZCFJZIZKZCLBLZFHGHXAXHKZELDLZFHGHXKWNYBDEGFXHWMYABCXHWLX
      TAXFWJXRXGWKXSDGBPEFCPQUGUHUIYBYDGFYAYCBCDEYADMYAEMXAXHBXOXHBMZRXAXHCXPXH
      CMZRWLAXAXTXHXQWJXRXFWKXSXGBDGUJCEFUJQULUMSXADEGFVBUNUOWSWLAKZCLBLZWNIZEH
      DHXMWRYIDEWRWNYHIYIAWLBCUPWNYHUQURSXLYIDEXLXAXAWNKZIXAWNIYIXJYJXAXAAIZDBJ
      ZECJZIZKZCLBLXAWMKZCLBLXJYJYOYPBCYOYKWLKYPYNWLYKYLWJYMWKDBUSECUSUOUTXAAWL
      VAURVCYOXIBCGFYOGMYOFMXEXHBXAXDBXOXCDGBXAEFBXONNVDYERXEXHCXAXDCXPXCDGCXAE
      FCXPNNVDYFRXTYKXEYNXHXTAXDXAXTAACFTZBGTZXDXSAYQXRYRACFOYQBGOUEWTEFTZBDTZD
      GTYSBGTXDYRYSBGDYSDMVEYTXCDGWTEFBDVFVGYSYQBGACFEXNVEVGVHVIVJXRYLXFXSYMXGB
      GDPCFEPQULUMXAWMBCXOXPVKVLVMXAWNVNXAYHWNABCDEVOVPVQSVRVSWSWIWOWSYHEHDHWIW
      RYHDEWQYGBCAWLWDVTWAABCDEWBWCWRWNDEWQWMBCAWLWEVTWAWFWGUR $.
  $}

  $( Two equivalent expressions for double existential uniqueness.  Curiously,
     we can put ` E! ` on either of the internal conjuncts but not both.  We
     can also commute ` E! x E! y ` using ~ 2eu7 .  (Contributed by NM,
     20-Feb-2005.) $)
  2eu8 $p |- ( E! x E! y ( E. x ph /\ E. y ph ) <->
                E! x E! y ( E! x ph /\ E. y ph ) ) $=
    ( wex wa 2eu2 pm5.32i hbeu1 hbeu euan ancom eubii hbe1 3bitri 3bitr4ri 2eu7
    weu 3bitr3ri ) ACDZBQZABQZCQZEZTABDZCQZEUASEZCQZBQZUDSECQBQTUBUEACBFGUBSEZB
    QUBTEUHUCUBSBUABCABHIJUGUIBUGSUAEZCQSUBEUIUFUJCUASKLSUACACMJSUBKNLTUBKOABCP
    R $.

  ${
    $d x y z $.
    $( Equality has existential uniqueness.  (Contributed by Stefan Allan,
       4-Dec-2008.) $)
    euequ1 $p |- E! x x = y $=
      ( vz weq weu wex wa wi wal a9e equtr2 gen2 equequ1 eu4 mpbir2an ) ABDZAEP
      AFPCBDZGACDHZCIAIABJRACACBKLPQACACBMNO $.
  $}

  ${
    $d x y $.
    $( A condition implying that at least two things exist.  (Contributed by
       NM, 10-Apr-2004.)  (Proof shortened by Andrew Salmon, 9-Jul-2011.) $)
    exists2 $p |- ( ( E. x ph /\ E. x -. ph ) -> -. E! x x = x ) $=
      ( vy wex wn cv wceq weu wal hbeu1 hba1 wi exists1 sylbi exlimdh
      ax16 com12 alexim syl6 con2d imp ) ABDZAEBDZBFZUDGZBHZEUBUFUCUB
      UFABIZUCEUFUBUGUFAUGBUEBJABKUFUDCFGBIAUGLBCMABCPNOQABRSTUA $.
  $}

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
Classical (not intuitionistic) results
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

  $( Theorem *4.81 of [WhiteheadRussell] p. 122.  This one does not hold
     intuitionistically, but compare with ~ pm4.8 which does.  (Contributed by
     NM, 3-Jan-2005.) $)
  pm4.81 $p |- ( ( -. ph -> ph ) <-> ph ) $=
    ( wn wi pm2.18 pm2.24 impbii ) ABACAADAAEF $.

  $( Theorem *4.52 of [WhiteheadRussell] p. 120.  (Contributed by NM,
     3-Jan-2005.)  (Proof shortened by Wolf Lammen, 5-Nov-2012.) $)
  pm4.52 $p |- ( ( ph /\ -. ps ) <-> -. ( -. ph \/ ps ) ) $=
    ( wn wa wi wo annim imor xchbinx ) ABCDABEACBFABGABHI $.

  $( Theorem *4.53 of [WhiteheadRussell] p. 120.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.53 $p |- ( -. ( ph /\ -. ps ) <-> ( -. ph \/ ps ) ) $=
    ( wn wo wa pm4.52 con2bii bicomi ) ACBDZABCEZCJIABFGH $.

  $( Disjunction in terms of conjunction (DeMorgan's law).  Compare Theorem
     *4.57 of [WhiteheadRussell] p. 120.  As an equivalence, this does not hold
     intuitionistically, but it would be possible to prove the forward
     direction.  (Contributed by NM, 5-Aug-1993.)  (Proof shortened by Andrew
     Salmon, 7-May-2011.) $)
  oran $p |- ( ( ph \/ ps ) <-> -. ( -. ph /\ -. ps ) ) $=
    ( wn wa wo pm4.56 con2bii ) ACBCDABEABFG $.

  $( Theorem *4.57 of [WhiteheadRussell] p. 120.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.57 $p |- ( -. ( -. ph /\ -. ps ) <-> ( ph \/ ps ) ) $=
    ( wo wn wa oran bicomi ) ABCADBDEDABFG $.

  $( Theorem *4.61 of [WhiteheadRussell] p. 120.  Only the reverse direction,
     ~ annimim , is valid intuitionistically.  (Contributed by NM,
     3-Jan-2005.) $)
  pm4.61 $p |- ( -. ( ph -> ps ) <-> ( ph /\ -. ps ) ) $=
    ( wn wa wi annim bicomi ) ABCDABECABFG $.

  $( Theorem *4.65 of [WhiteheadRussell] p. 120.  The reverse direction is an
     instance of ~ annimim .  (Contributed by NM, 3-Jan-2005.) $)
  pm4.65 $p |- ( -. ( -. ph -> ps ) <-> ( -. ph /\ -. ps ) ) $=
    ( wn pm4.61 ) ACBD $.

  $( Implication distributes over disjunction.  Theorem *4.78 of
     [WhiteheadRussell] p. 121.  We have an intuitionistic proof of one
     direction at ~ pm4.78i .  (Contributed by NM, 3-Jan-2005.)  (Proof
     shortened by Wolf Lammen, 19-Nov-2012.) $)
  pm4.78 $p |- ( ( ( ph -> ps ) \/ ( ph -> ch ) ) <->
                ( ph -> ( ps \/ ch ) ) ) $=
    ( wn wo wi orordi imor orbi12i 3bitr4ri ) ADZBCEZEKBEZKCEZEALFABFZACFZEKBCG
    ALHOMPNABHACHIJ $.

  $( The Inversion Axiom of the infinite-valued sentential logic (L-infinity)
     of Lukasiewicz.  Using ~ dfor2dc , we can see that this (classically)
     expresses "disjunction commutes."  Theorem *2.69 of [WhiteheadRussell]
     p. 108.  Our proof of ~ looinv is a classical, rather than intuitionistic,
     result.  (Contributed by NM, 12-Aug-2004.) $)
  looinv $p |- ( ( ( ph -> ps ) -> ps ) -> ( ( ps -> ph ) -> ph ) ) $=
    ( wi imim1 peirce syl6 ) ABCZBCBACGACAGBADABEF $.

  ${
    19.36.1 $e |- ( ps -> A. x ps ) $.
    $( Theorem 19.36 of [Margaris] p. 90.  The forward direction, ~ 19.36i , is
       valid intuitionistically, but the reverse direction is not.
       (Contributed by NM, 5-Aug-1993.) $)
    19.36 $p |- ( E. x ( ph -> ps ) <-> ( A. x ph -> ps ) ) $=
      ( wi wex wal 19.35 19.9h imbi2i bitri ) ABECFACGZBCFZELBEABCHMBLBCDIJK $.
  $}

  ${
    $d x ps $.
    $( Special case of Theorem 19.36 of [Margaris] p. 90.  (Contributed by NM,
       18-Aug-1993.) $)
    19.36v $p |- ( E. x ( ph -> ps ) <-> ( A. x ph -> ps ) ) $=
      ( ax-17 19.36 ) ABCBCDE $.
  $}

  $( Theorem 19.39 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  19.39 $p |- ( ( E. x ph -> E. x ps ) -> E. x ( ph -> ps ) ) $=
    ( wex wi wal 19.2 imim1i 19.35 sylibr ) ACDZBCDZEACFZLEABECDMKLACCGHABCIJ
    $.

  $( Theorem 19.24 of [Margaris] p. 90.  It does not hold in intuitionistic
     logic.  (Contributed by NM, 5-Aug-1993.) $)
  19.24 $p |- ( ( A. x ph -> A. x ps ) -> E. x ( ph -> ps ) ) $=
    ( wal wi wex 19.2 imim2i 19.35 sylibr ) ACDZBCDZEKBCFZEABECFLMKBCCGHABCIJ
    $.

  ${
    $d x ps $.  $d y ph $.
    $( Special case of ~ 19.12 where its converse holds.  (Contributed by NM,
       18-Jul-2001.)  (Revised by Andrew Salmon, 11-Jul-2011.) $)
    19.12vv $p |- ( E. x A. y ( ph -> ps ) <-> A. y E. x ( ph -> ps ) ) $=
      ( wal wex 19.21v exbii ax-17 hbal 19.36 19.36v albii 19.21h bitr2i 3bitri
      wi ) ABQZDEZCFABDEZQZCFACEZTQZRCFZDEZSUACABDGHATCBCDBCIJKUEUBBQZDEUCUDUFD
      ABCLMUBBDADCADIJNOP $.
  $}

  $( Theorem 19.14 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.) $)
  exnal $p |- ( E. x -. ph <-> -. A. x ph ) $=
    ( wal wn wex alex con2bii ) ABCADBEABFG $.

  $( Part of theorem *11.5 in [WhiteheadRussell] p. 164.  (Contributed by
     Andrew Salmon, 24-May-2011.) $)
  2nalexn $p |- ( -. A. x A. y ph <-> E. x E. y -. ph ) $=
    ( wn wex wal df-ex alex albii xchbinxr bicomi ) ADCEZBEZACFZBFZDMLDZBFOLBGN
    PBACHIJK $.

  $( A relationship between two quantifiers and negation.  (Contributed by NM,
     18-Aug-1993.) $)
  alexn $p |- ( A. x E. y -. ph <-> -. E. x A. y ph ) $=
    ( wn wex wal exnal albii alnex bitri ) ADCEZBFACFZDZBFLBEDKMBACGHLBIJ $.

  $( Theorem *11.51 in [WhiteheadRussell] p. 164.  (Contributed by Andrew
     Salmon, 24-May-2011.)  (Proof shortened by Wolf Lammen, 25-Sep-2014.) $)
  2exnexn $p |- ( E. x A. y ph <-> -. A. x E. y -. ph ) $=
    ( wn wex wal alexn con2bii ) ADCEBFACFBEABCGH $.

  $( A transformation of quantifiers and logical connectives.  (Contributed by
     NM, 25-Mar-1996.)  (Proof shortened by Wolf Lammen, 4-Sep-2014.) $)
  exanali $p |- ( E. x ( ph /\ -. ps ) <-> -. A. x ( ph -> ps ) ) $=
    ( wn wa wex wi wal annim exbii exnal bitri ) ABDEZCFABGZDZCFNCHDMOCABIJNCKL
    $.

  $( Theorem 19.30 of [Margaris] p. 90.  (Contributed by NM, 5-Aug-1993.)
     (Proof shortened by Andrew Salmon, 25-May-2011.) $)
  19.30 $p |- ( A. x ( ph \/ ps ) -> ( A. x ph \/ E. x ps ) ) $=
    ( wn wi wal wex wo exnal exim syl5bir df-or albii 3imtr4i ) ADZBEZCFZACFZDZ
    BCGZEABHZCFRTHSOCGQTACIOBCJKUAPCABLMRTLN $.

  ${
    19.35ri.1 $e |- ( A. x ph -> E. x ps ) $.
    $( Inference from Theorem 19.35 of [Margaris] p. 90.  (Contributed by NM,
       5-Aug-1993.) $)
    19.35ri $p |- E. x ( ph -> ps ) $=
      ( wi wex wal 19.35 mpbir ) ABECFACGBCFEDABCHI $.
  $}

  $( Quantified "excluded middle."  Exercise 9.2a of Boolos, p. 111,
     _Computability and Logic_.  (Contributed by NM, 10-Dec-2000.) $)
  qexmid $p |- E. x ( ph -> A. x ph ) $=
    ( wal 19.8a 19.35ri ) AABCZBFBDE $.

  $( Variable ` x ` is effectively not free in ` ph ` iff ` ph ` is always true
     or always false.  This is a classical result.  (Contributed by Mario
     Carneiro, 24-Sep-2016.) $)
  nf4 $p |- ( F/ x ph <-> ( A. x ph \/ A. x -. ph ) ) $=
    ( wnf wex wal wi wn wo nf2 imor orcom alnex orbi2i bitr4i 3bitri ) ABCABDZA
    BEZFPGZQHZQAGBEZHZABIPQJSQRHUARQKTRQABLMNO $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
             Additional substitution theorems (classical)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

We define substitution via ~ df-sb (and also have theorems such
as ~ dfsb7 or ~ dfsb7a ), and most of the substitution theorems such as
~ sbim , ~ sbequ12 , or ~ sbidm have been proven intuitionistically.

Here we collect substitution theorems which have not been proven
intuitionistically, most of which probably do not have intuitionistic
proofs.
$)

  $( A classical (not intuitionistic) alternate definition of proper
     substitution that, like ~ df-sb , mixes free and bound variables to avoid
     distinct variable requirements.  (Contributed by NM, 17-Feb-2005.) $)
  dfsb2 $p |- ( [ y / x ] ph <->
              ( ( x = y /\ ph ) \/ A. x ( x = y -> ph ) ) ) $=
    ( wsb weq wa wi wal wo sbequ2 sps ax-4 jctild orc wn sb4 olc pm2.61i sbequ1
    syl6 imp sb2 jaoi impbii ) ABCDZBCEZAFZUFAGBHZIZUFBHZUEUIGUJUEUGUIUJUEAUFUF
    UEAGBABCJKUFBLMUGUHNTUJOUEUHUIABCPUHUGQTRUGUEUHUFAUEABCSUAABCUBUCUD $.

  $( A classical (not intuitionistic) alternate definition of proper
     substitution ~ df-sb that uses only connectives on the right-hand side
     which are, in classical logic, primitive rather than defined.
     (Contributed by NM, 6-Mar-2007.) $)
  dfsb3 $p |- ( [ y / x ] ph <->
              ( ( x = y -> -. ph ) -> A. x ( x = y -> ph ) ) ) $=
    ( weq wa wi wal wo wn wsb df-or dfsb2 imnan imbi1i 3bitr4i ) BCDZAEZPAFBGZH
    QIZRFABCJPAIFZRFQRKABCLTSRPAMNO $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                  Exclusive or and related theorems (classical)
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Most exclusive-or theorems are covered in ~ df-xor and related theorems
(such as ~ xornbi ). Here we have one remaining theorem which depends on
~ ax-3 .

$)

  $( Conjunction distributes over exclusive-or, using ` -. ( ph <-> ps ) ` to
     express exclusive-or.  This is one way to interpret the distributive law
     of multiplication over addition in modulo 2 arithmetic.  (Contributed by
     NM, 3-Oct-2008.) $)
  xordi $p |- ( ( ph /\ -. ( ps <-> ch ) ) <->
                -. ( ( ph /\ ps ) <-> ( ph /\ ch ) ) ) $=
    ( wb wn wa wi annim pm5.32 xchbinx ) ABCDZEFAKGABFACFDAKHABCIJ $.

$(
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
       Appendix:  Typesetting definitions for the tokens in this file
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
$)

$( $t

/* The '$ t' (no space between '$' and 't') token indicates the beginning
    of the typesetting definition section, embedded in a Metamath
    comment.  There may only be one per source file, and the typesetting
    section ends with the end of the Metamath comment.  The typesetting
    section uses C-style comment delimiters.  Todo:  Allow multiple
    typesetting comments */

/* These are the LaTeX and HTML definitions in the order the tokens are
    introduced in $c or $v statements.  See HELP TEX or HELP HTML in the
    Metamath program. */


/******* Web page format settings *******/

/* Page title, home page link */
htmltitle "Intuitionistic Logic Explorer";
htmlhome '<A HREF="mmil.html"><FONT SIZE=-2 FACE=sans-serif>' +
    '<IMG SRC="_icon-il.gif" BORDER=0 ALT=' +
    '"Home" HEIGHT=32 WIDTH=32 ALIGN=MIDDLE>' +
    'Home</FONT></A>';
/* Optional file where bibliographic references are kept */
/* If specified, e.g. "mmset.html", Metamath will hyperlink all strings of the
   form "[rrr]" (where "rrr" has no whitespace) to "mmset.html#rrr" */
/* A warning will be given if the file "mmset.html" with the bibliographical
   references is not present.  It is read in order to check correctness of
   the references. */
htmlbibliography "mmil.html";

/* Variable color key at the bottom of each proof table */
htmlvarcolor '<FONT COLOR="#0000FF">wff</FONT> '
    + '<FONT COLOR="#FF0000">set</FONT> '
    + '<FONT COLOR="#CC33CC">class</FONT>';

/* GIF and Unicode HTML directories - these are used for the GIF version to
   crosslink to the Unicode version and vice-versa */
htmldir "../ilegif/";
althtmldir "../ileuni/";


/******* Symbol definitions *******/

htmldef "(" as "<IMG SRC='lp.gif' WIDTH=5 HEIGHT=19 TITLE='(' ALIGN=TOP>";
  althtmldef "(" as "(";
  latexdef "(" as "(";
htmldef ")" as "<IMG SRC='rp.gif' WIDTH=5 HEIGHT=19 TITLE=')' ALIGN=TOP>";
  althtmldef ")" as ")";
  latexdef ")" as ")";
htmldef "->" as
    " <IMG SRC='to.gif' WIDTH=15 HEIGHT=19 TITLE='-&gt;' ALIGN=TOP> ";
  althtmldef "->" as ' &rarr; ';
  latexdef "->" as "\rightarrow";
htmldef "-." as
    "<IMG SRC='lnot.gif' WIDTH=10 HEIGHT=19 TITLE='-.' ALIGN=TOP> ";
  althtmldef "-." as '&not; ';
  latexdef "-." as "\lnot";
htmldef "wff" as
    "<IMG SRC='_wff.gif' WIDTH=24 HEIGHT=19 TITLE='wff' ALIGN=TOP> ";
  althtmldef "wff" as '<FONT COLOR="#808080">wff </FONT>'; /* was #00CC00 */
  latexdef "wff" as "{\rm wff}";
htmldef "|-" as
    "<IMG SRC='_vdash.gif' WIDTH=10 HEIGHT=19 TITLE='|-' ALIGN=TOP> ";
  althtmldef "|-" as
    '<FONT COLOR="#808080" FACE=sans-serif>&#8866; </FONT>'; /* &vdash; */
    /* Without sans-serif, way too big in FF3 */
  latexdef "|-" as "\vdash";
htmldef "ph" as
    "<IMG SRC='_varphi.gif' WIDTH=11 HEIGHT=19 TITLE='ph' ALIGN=TOP>";
  althtmldef "ph" as '<FONT COLOR="#0000FF"><I>&phi;</I></FONT>';
  latexdef "ph" as "\varphi";
htmldef "ps" as "<IMG SRC='_psi.gif' WIDTH=12 HEIGHT=19 TITLE='ps' ALIGN=TOP>";
  althtmldef "ps" as '<FONT COLOR="#0000FF"><I>&psi;</I></FONT>';
  latexdef "ps" as "\psi";
htmldef "ch" as "<IMG SRC='_chi.gif' WIDTH=12 HEIGHT=19 TITLE='ch' ALIGN=TOP>";
  althtmldef "ch" as '<FONT COLOR="#0000FF"><I>&chi;</I></FONT>';
  latexdef "ch" as "\chi";
htmldef "th" as
    "<IMG SRC='_theta.gif' WIDTH=8 HEIGHT=19 TITLE='th' ALIGN=TOP>";
  althtmldef "th" as '<FONT COLOR="#0000FF"><I>&theta;</I></FONT>';
  latexdef "th" as "\theta";
htmldef "ta" as "<IMG SRC='_tau.gif' WIDTH=10 HEIGHT=19 TITLE='ta' ALIGN=TOP>";
  althtmldef "ta" as '<FONT COLOR="#0000FF"><I>&tau;</I></FONT>';
  latexdef "ta" as "\tau";
htmldef "et" as "<IMG SRC='_eta.gif' WIDTH=9 HEIGHT=19 TITLE='et' ALIGN=TOP>";
  althtmldef "et" as '<FONT COLOR="#0000FF"><I>&eta;</I></FONT>';
  latexdef "et" as "\eta";
htmldef "ze" as "<IMG SRC='_zeta.gif' WIDTH=9 HEIGHT=19 TITLE='ze' ALIGN=TOP>";
  althtmldef "ze" as '<FONT COLOR="#0000FF"><I>&zeta;</I></FONT>';
  latexdef "ze" as "\zeta";
htmldef "si" as
    "<IMG SRC='_sigma.gif' WIDTH=10 HEIGHT=19 TITLE='si' ALIGN=TOP>";
  althtmldef "si" as '<FONT COLOR="#0000FF"><I>&sigma;</I></FONT>';
  latexdef "si" as "\sigma";
htmldef "rh" as "<IMG SRC='_rho.gif' WIDTH=9 HEIGHT=19 TITLE='rh' ALIGN=TOP>";
  althtmldef "rh" as '<FONT COLOR="#0000FF"><I>&rho;</I></FONT>';
  latexdef "rh" as "\rho";
htmldef "mu" as "<IMG SRC='_mu.gif' WIDTH=10 HEIGHT=19 TITLE='mu' ALIGN=TOP>";
  althtmldef "mu" as '<FONT COLOR="#0000FF"><I>&mu;</I></FONT>';
  latexdef "mu" as "\rho";
htmldef "la" as
    "<IMG SRC='_lambda.gif' WIDTH=9 HEIGHT=19 TITLE='la' ALIGN=TOP>";
  althtmldef "la" as '<FONT COLOR="#0000FF"><I>&lambda;</I></FONT>';
  latexdef "la" as "\rho";
htmldef "ka" as
    "<IMG SRC='_kappa.gif' WIDTH=9 HEIGHT=19 TITLE='ka' ALIGN=TOP>";
  althtmldef "ka" as '<FONT COLOR="#0000FF"><I>&kappa;</I></FONT>';
  latexdef "ka" as "\rho";
htmldef "<->" as " <IMG SRC='leftrightarrow.gif' WIDTH=15 HEIGHT=19 " +
    "TITLE='&lt;-&gt;' ALIGN=TOP> ";
  althtmldef "<->" as ' &harr; ';
  latexdef "<->" as "\leftrightarrow";
htmldef "\/" as
     " <IMG SRC='vee.gif' WIDTH=11 HEIGHT=19 TITLE='\/' ALIGN=TOP> ";
  althtmldef "\/" as ' <FONT FACE=sans-serif> &or;</FONT> ' ;
    /* althtmldef "\/" as ' <FONT FACE=sans-serif>&#8897;</FONT> ' ; */
    /* was &or; - changed to match font of &and; replacement */
    /* Changed back 6-Mar-2012 NM */
  latexdef "\/" as "\vee";
htmldef "/\" as
    " <IMG SRC='wedge.gif' WIDTH=11 HEIGHT=19 TITLE='/\' ALIGN=TOP> ";
  althtmldef "/\" as ' <FONT FACE=sans-serif>&and;</FONT> ';
    /* althtmldef "/\" as ' <FONT FACE=sans-serif>&#8896;</FONT> '; */
    /* was &and; which is circle in Mozilla on WinXP Pro (but not Home) */
    /* Changed back 6-Mar-2012 NM */
  latexdef "/\" as "\wedge";
htmldef "A." as
    "<IMG SRC='forall.gif' WIDTH=10 HEIGHT=19 TITLE='A.' ALIGN=TOP>";
  althtmldef "A." as '<FONT FACE=sans-serif>&forall;</FONT>'; /* &#8704; */
  latexdef "A." as "\forall";
htmldef "set" as
    "<IMG SRC='_set.gif' WIDTH=20 HEIGHT=19 TITLE='set' ALIGN=TOP> ";
  althtmldef "set" as '<FONT COLOR="#808080">set </FONT>';
  latexdef "set" as "{\rm set}";
htmldef "x" as "<IMG SRC='_x.gif' WIDTH=10 HEIGHT=19 TITLE='x' ALIGN=TOP>";
  althtmldef "x" as '<I><FONT COLOR="#FF0000">x</FONT></I>';
  latexdef "x" as "x";
htmldef "y" as "<IMG SRC='_y.gif' WIDTH=9 HEIGHT=19 TITLE='y' ALIGN=TOP>";
  althtmldef "y" as '<I><FONT COLOR="#FF0000">y</FONT></I>';
  latexdef "y" as "y";
htmldef "z" as "<IMG SRC='_z.gif' WIDTH=9 HEIGHT=19 TITLE='z' ALIGN=TOP>";
  althtmldef "z" as '<I><FONT COLOR="#FF0000">z</FONT></I>';
  latexdef "z" as "z";
htmldef "w" as "<IMG SRC='_w.gif' WIDTH=12 HEIGHT=19 TITLE='w' ALIGN=TOP>";
  althtmldef "w" as '<I><FONT COLOR="#FF0000">w</FONT></I>';
  latexdef "w" as "w";
htmldef "v" as "<IMG SRC='_v.gif' WIDTH=9 HEIGHT=19 TITLE='v' ALIGN=TOP>";
  althtmldef "v" as '<I><FONT COLOR="#FF0000">v</FONT></I>';
  latexdef "v" as "v";
htmldef "u" as "<IMG SRC='_u.gif' WIDTH=10 HEIGHT=19 TITLE='u' ALIGN=TOP>";
  althtmldef "u" as '<I><FONT COLOR="#FF0000">u</FONT></I>';
  latexdef "u" as "u";
htmldef "t" as "<IMG SRC='_t.gif' WIDTH=7 HEIGHT=19 ALT=' t' TITLE='t'>";
  althtmldef "t" as '<SPAN CLASS=set STYLE="color:red">&#x1D461;</SPAN>';
  latexdef "t" as "t";
htmldef "E." as
    "<IMG SRC='exists.gif' WIDTH=9 HEIGHT=19 TITLE='E.' ALIGN=TOP>";
  althtmldef "E." as '<FONT FACE=sans-serif>&exist;</FONT>'; /* &#8707; */
    /* Without sans-serif, bad in Opera and way too big in FF3 */
  latexdef "E." as "\exists";
htmldef "F/" as
    "<IMG SRC='finv.gif' WIDTH=9 HEIGHT=19 ALT=' F/' TITLE='F/'>";
  althtmldef "F/" as "&#8498;";
  latexdef "F/" as "\Finv";
htmldef "=" as " <IMG SRC='eq.gif' WIDTH=12 HEIGHT=19 TITLE='=' ALIGN=TOP> ";
  althtmldef "=" as ' = '; /* &equals; */
  latexdef "=" as "=";
htmldef "e." as " <IMG SRC='in.gif' WIDTH=10 HEIGHT=19 TITLE='e.' ALIGN=TOP> ";
  althtmldef "e." as ' <FONT FACE=sans-serif>&isin;</FONT> ';
  latexdef "e." as "\in";
htmldef "[" as "<IMG SRC='lbrack.gif' WIDTH=5 HEIGHT=19 TITLE='[' ALIGN=TOP>";
  althtmldef "[" as '['; /* &lsqb; */
  latexdef "[" as "[";
htmldef "/" as
    " <IMG SRC='solidus.gif' WIDTH=6 HEIGHT=19 TITLE='/' ALIGN=TOP> ";
  althtmldef "/" as ' / '; /* &sol; */
  latexdef "/" as "/";
htmldef "]" as "<IMG SRC='rbrack.gif' WIDTH=5 HEIGHT=19 TITLE=']' ALIGN=TOP>";
  althtmldef "]" as ']'; /* &rsqb; */
  latexdef "]" as "]";
htmldef "E!" as "<IMG SRC='_e1.gif' WIDTH=12 HEIGHT=19 TITLE='E!' ALIGN=TOP>";
  althtmldef "E!" as '<FONT FACE=sans-serif>&exist;!</FONT>';
  latexdef "E!" as "\exists{!}";
htmldef "E*" as "<IMG SRC='_em1.gif' WIDTH=15 HEIGHT=19 TITLE='E*' ALIGN=TOP>";
  althtmldef "E*" as '<FONT FACE=sans-serif>&exist;*</FONT>';
  latexdef "E*" as "\exists^\ast";
htmldef "{" as "<IMG SRC='lbrace.gif' WIDTH=6 HEIGHT=19 ALT=' {' TITLE='{'>";
  althtmldef "{" as '{'; /* &lcub; */
  latexdef "{" as "\{";
htmldef "|" as " <IMG SRC='vert.gif' WIDTH=3 HEIGHT=19 ALT=' |' TITLE='|'> ";
  althtmldef "|" as ' &#8739; '; /* &vertbar; */
    /* 2-Jan-2016 reverted sans-serif */
  latexdef "|" as "|";
htmldef "}" as "<IMG SRC='rbrace.gif' WIDTH=6 HEIGHT=19 ALT=' }' TITLE='}'>";
  althtmldef "}" as '}'; /* &rcub; */
  latexdef "}" as "\}";
htmldef "F/_" as
    "<IMG SRC='_finvbar.gif' WIDTH=9 HEIGHT=19 ALT=' F/_' TITLE='F/_'>";
  althtmldef "F/_" as "<U>&#8498;</U>";
  latexdef "F/_" as "\underline{\Finv}";

htmldef "./\" as
    " <IMG SRC='_.wedge.gif' WIDTH=11 HEIGHT=19 ALT=' ./\' TITLE='./\'> ";
  althtmldef "./\" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&and;</SPAN> ';
  latexdef "./\" as "\wedge";
htmldef ".\/" as
    " <IMG SRC='_.vee.gif' WIDTH=11 HEIGHT=19 ALT=' .\/' TITLE='.\/'> ";
  althtmldef ".\/" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&or;</SPAN> ';
  latexdef ".\/" as "\vee";
htmldef ".<_" as
    " <IMG SRC='_.le.gif' WIDTH=11 HEIGHT=19 ALT=' .&lt;_' TITLE='.&lt;_'> ";
  althtmldef ".<_" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&le;</SPAN> ';
  latexdef ".<_" as "\le";
htmldef ".<" as     /* Symbol as variable */
    " <IMG SRC='_.lt.gif' WIDTH=11 HEIGHT=19 ALT=' .&lt;' TITLE='.&lt;'> ";
  althtmldef ".<" as
    /* This is how to put a dotted box around the symbol: */
    /* border means box around symbol; border-bottom underlines symbol */
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&lt;</SPAN> ';
    /* Todo: can this STYLE sequence be done with a CLASS? */
    /* Move the underline down 3px so it isn't too close to symbol */
    /*
    ' <SPAN STYLE="vertical-align:-3px">' +
    '<SPAN CLASS=symvar STYLE="text-decoration:underline dotted;color:#C3C">' +
    '<SPAN STYLE="vertical-align:3px">&lt;</SPAN></SPAN></SPAN> ';
    */
  latexdef ".<" as "<";
htmldef ".+" as
    " <IMG SRC='_.plus.gif' WIDTH=13 HEIGHT=19 ALT=' .+' TITLE='.+'> ";
  althtmldef ".+" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '+</SPAN> ';
  latexdef ".+" as "+";
htmldef ".-" as
    " <IMG SRC='_.minus.gif' WIDTH=11 HEIGHT=19 ALT=' .-' TITLE='.-'> ";
  althtmldef ".-" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&minus;</SPAN> ';
  latexdef ".-" as "-";
htmldef ".X." as
    " <IMG SRC='_.times.gif' WIDTH=9 HEIGHT=19 ALT=' .X.' TITLE='.X.'> ";
  althtmldef ".X." as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&times;</SPAN> ';
  latexdef ".X." as "\times";
htmldef "./" as
    " <IMG SRC='_.solidus.gif' WIDTH=8 HEIGHT=19 ALT=' ./' TITLE='./'> ";
  althtmldef "./" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '/</SPAN> ';
  latexdef "./" as "/";
htmldef ".^" as
    " <IMG SRC='_.uparrow.gif' WIDTH=7 HEIGHT=19 ALT=' .^' TITLE='.^'> ";
  althtmldef ".^" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&uarr;</SPAN> ';
  latexdef ".^" as "\uparrow";
htmldef ".0." as
    " <IMG SRC='_.0.gif' WIDTH=8 HEIGHT=19 ALT=' .0.' TITLE='.0.'> ";
  althtmldef ".0." as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '0</SPAN> ';
  latexdef ".0." as "0";
htmldef ".1." as
    " <IMG SRC='_.1.gif' WIDTH=7 HEIGHT=19 ALT=' .1.' TITLE='.1.'> ";
  althtmldef ".1." as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '1</SPAN> ';
  latexdef ".1." as "1";
htmldef ".||" as
    " <IMG SRC='_.parallel.gif' WIDTH=5 HEIGHT=19 ALT=' .||' TITLE='.||'> ";
  althtmldef ".||" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#8741;</SPAN> ';
  latexdef ".||" as "\parallel";
htmldef ".~" as
    " <IMG SRC='_.sim.gif' WIDTH=13 HEIGHT=19 ALT=' .~' TITLE='.~'> ";
  althtmldef ".~" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x223C;</SPAN> ';
  latexdef ".~" as "\sim";
htmldef "._|_" as
    " <IMG SRC='_.perp.gif' WIDTH=11 HEIGHT=19 ALT=' ._|_' TITLE='._|_'> ";
  althtmldef "._|_" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#8869;</SPAN> ';
  latexdef "._|_" as "\perp";
htmldef ".+^" as
    " <IMG SRC='_.plushat.gif' WIDTH=11 HEIGHT=19 ALT=' .+^' TITLE='.+^'> ";
  althtmldef ".+^" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x2A23;</SPAN> ';       /* &plusacir; */
  latexdef ".+^" as "\hat{+}";
htmldef ".+b" as
    " <IMG SRC='_.plusb.gif' WIDTH=14 HEIGHT=19 ALT=' .+b' TITLE='.+b'> ";
  althtmldef ".+b" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x271A;</SPAN> ';
  latexdef ".+b" as "\boldsymbol{+}";
htmldef ".(+)" as
    " <IMG SRC='_.oplus.gif' WIDTH=13 HEIGHT=19 ALT=' .(+)' TITLE='.(+)'> ";
  althtmldef ".(+)" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x2295;</SPAN> ';
  latexdef ".(+)" as "\oplus";
htmldef ".*" as
    " <IMG SRC='_.ast.gif' WIDTH=7 HEIGHT=19 ALT=' .*' TITLE='.*'> ";
  althtmldef ".*" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&lowast;</SPAN> ';
  latexdef ".*" as "\ast";
htmldef ".x." as
    " <IMG SRC='_.cdot.gif' WIDTH=4 HEIGHT=19 ALT=' .x.' TITLE='.x.'> ";
  althtmldef ".x." as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&middot;</SPAN> ';
  latexdef ".x." as "\cdot";
htmldef ".xb" as
    " <IMG SRC='_.bullet.gif' WIDTH=8 HEIGHT=19 ALT=' .xb' TITLE='.xb'> ";
  althtmldef ".xb" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x2219;</SPAN> ';
  latexdef ".xb" as "\bullet";
htmldef ".," as
    " <IMG SRC='_.comma.gif' WIDTH=4 HEIGHT=19 ALT=' .,' TITLE='.,'> ";
  althtmldef ".," as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    ',</SPAN> ';
  latexdef ".," as ",";
htmldef ".(x)" as
    " <IMG SRC='_.otimes.gif' WIDTH=13 HEIGHT=19 ALT=' .(x)' TITLE='.(x)'> ";
  althtmldef ".(x)" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x2297;</SPAN> ';
  latexdef ".(x)" as "\otimes";
htmldef ".0b" as
    " <IMG SRC='_.bf0.gif' WIDTH=9 HEIGHT=19 ALT=' .0b' TITLE='.0b'> ";
  althtmldef ".0b" as
    ' <SPAN CLASS=symvar STYLE="border-bottom:1px dotted;color:#C3C">' +
    '&#x1D7CE</SPAN> ';
  latexdef ".0b" as "\mbox{\boldmath$0$}";

/* "~P" was deleted from above section in set.mm. */
/* The ones below should have been in the above section in set.mm. */
htmldef "class" as
    "<IMG SRC='_class.gif' WIDTH=32 HEIGHT=19 TITLE='class' ALIGN=TOP> ";
  althtmldef "class" as '<FONT COLOR="#808080">class </FONT>';
  latexdef "class" as "{\rm class}";
htmldef "A" as "<IMG SRC='_ca.gif' WIDTH=11 HEIGHT=19 TITLE='A' ALIGN=TOP>";
  althtmldef "A" as '<I><FONT COLOR="#CC33CC">A</FONT></I>';
  latexdef "A" as "A";
htmldef "B" as "<IMG SRC='_cb.gif' WIDTH=12 HEIGHT=19 TITLE='B' ALIGN=TOP>";
  althtmldef "B" as '<I><FONT COLOR="#CC33CC">B</FONT></I>';
  latexdef "B" as "B";
htmldef "C" as "<IMG SRC='_cc.gif' WIDTH=12 HEIGHT=19 ALT=' C' TITLE='C'>";
  althtmldef "C" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D436;</SPAN>';
  latexdef "C" as "C";
htmldef "D" as "<IMG SRC='_cd.gif' WIDTH=12 HEIGHT=19 ALT=' D' TITLE='D'>";
  althtmldef "D" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D437;</SPAN>';
  latexdef "D" as "D";
htmldef "P" as "<IMG SRC='_cp.gif' WIDTH=12 HEIGHT=19 ALT=' P' TITLE='P'>";
  althtmldef "P" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D443;</SPAN>';
  latexdef "P" as "P";
htmldef "Q" as "<IMG SRC='_cq.gif' WIDTH=12 HEIGHT=19 ALT=' Q' TITLE='Q'>";
  althtmldef "Q" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D444;</SPAN>';
  latexdef "Q" as "Q";
htmldef "R" as "<IMG SRC='_cr.gif' WIDTH=12 HEIGHT=19 ALT=' R' TITLE='R'>";
  althtmldef "R" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D445;</SPAN>';
  latexdef "R" as "R";
htmldef "S" as "<IMG SRC='_cs.gif' WIDTH=11 HEIGHT=19 ALT=' S' TITLE='S'>";
  althtmldef "S" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D446;</SPAN>';
  latexdef "S" as "S";
htmldef "T" as "<IMG SRC='_ct.gif' WIDTH=12 HEIGHT=19 ALT=' T' TITLE='T'>";
  althtmldef "T" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D447;</SPAN>';
  latexdef "T" as "T";
htmldef "U" as "<IMG SRC='_cu.gif' WIDTH=12 HEIGHT=19 ALT=' U' TITLE='U'>";
  althtmldef "U" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D448;</SPAN>';
  latexdef "U" as "U";
htmldef "e" as "<IMG SRC='_e.gif' WIDTH=8 HEIGHT=19 ALT=' e' TITLE='e'>";
  althtmldef "e" as '<SPAN CLASS=set STYLE="color:red">&#x1D452;</SPAN>';
  latexdef "e" as "e";
htmldef "f" as "<IMG SRC='_f.gif' WIDTH=9 HEIGHT=19 TITLE='f' ALIGN=TOP>";
  althtmldef "f" as '<I><FONT COLOR="#FF0000">f</FONT></I>';
  latexdef "f" as "f";
htmldef "g" as "<IMG SRC='_g.gif' WIDTH=9 HEIGHT=19 TITLE='g' ALIGN=TOP>";
  althtmldef "g" as '<I><FONT COLOR="#FF0000">g</FONT></I>';
  latexdef "g" as "g";
htmldef "h" as "<IMG SRC='_h.gif' WIDTH=10 HEIGHT=19 ALT=' h' TITLE='h'>";
  althtmldef "h" as '<SPAN CLASS=set STYLE="color:red">&#x210E;</SPAN>';
  latexdef "h" as "h";
htmldef "i" as "<IMG SRC='_i.gif' WIDTH=6 HEIGHT=19 ALT=' i' TITLE='i'>";
  althtmldef "i" as '<SPAN CLASS=set STYLE="color:red">&#x1D456;</SPAN>';
  latexdef "i" as "i";
htmldef "j" as "<IMG SRC='_j.gif' WIDTH=7 HEIGHT=19 ALT=' j' TITLE='j'>";
  althtmldef "j" as '<SPAN CLASS=set STYLE="color:red">&#x1D457;</SPAN>';
  latexdef "j" as "j";
htmldef "k" as "<IMG SRC='_k.gif' WIDTH=9 HEIGHT=19 ALT=' k' TITLE='k'>";
  althtmldef "k" as '<SPAN CLASS=set STYLE="color:red">&#x1D458;</SPAN>';
  latexdef "k" as "k";
htmldef "m" as "<IMG SRC='_m.gif' WIDTH=14 HEIGHT=19 ALT=' m' TITLE='m'>";
  althtmldef "m" as '<SPAN CLASS=set STYLE="color:red">&#x1D45A;</SPAN>';
  latexdef "m" as "m";
htmldef "n" as "<IMG SRC='_n.gif' WIDTH=10 HEIGHT=19 ALT=' n' TITLE='n'>";
  althtmldef "n" as '<SPAN CLASS=set STYLE="color:red">&#x1D45B;</SPAN>';
  latexdef "n" as "n";
htmldef "o" as "<IMG SRC='_o.gif' WIDTH=8 HEIGHT=19 ALT=' o' TITLE='o'>";
  althtmldef "o" as '<SPAN CLASS=set STYLE="color:red">&#x1D45C;</SPAN>';
  latexdef "o" as "o";
htmldef "E" as "<IMG SRC='_ce.gif' WIDTH=13 HEIGHT=19 ALT=' E' TITLE='E'>";
  althtmldef "E" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D438;</SPAN>';
  latexdef "E" as "E";
htmldef "F" as "<IMG SRC='_cf.gif' WIDTH=13 HEIGHT=19 ALT=' F' TITLE='F'>";
  althtmldef "F" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D439;</SPAN>';
  latexdef "F" as "F";
htmldef "G" as "<IMG SRC='_cg.gif' WIDTH=12 HEIGHT=19 ALT=' G' TITLE='G'>";
  althtmldef "G" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D43A;</SPAN>';
  latexdef "G" as "G";
htmldef "H" as "<IMG SRC='_ch.gif' WIDTH=14 HEIGHT=19 ALT=' H' TITLE='H'>";
  althtmldef "H" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D43B;</SPAN>';
  latexdef "H" as "H";
htmldef "I" as "<IMG SRC='_ci.gif' WIDTH=8 HEIGHT=19 ALT=' I' TITLE='I'>";
  althtmldef "I" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D43C;</SPAN>';
  latexdef "I" as "I";
htmldef "J" as "<IMG SRC='_cj.gif' WIDTH=10 HEIGHT=19 ALT=' J' TITLE='J'>";
  althtmldef "J" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D43D;</SPAN>';
  latexdef "J" as "J";
htmldef "K" as "<IMG SRC='_ck.gif' WIDTH=14 HEIGHT=19 ALT=' K' TITLE='K'>";
  althtmldef "K" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D43E;</SPAN>';
  latexdef "K" as "K";
htmldef "L" as "<IMG SRC='_cl.gif' WIDTH=10 HEIGHT=19 ALT=' L' TITLE='L'>";
  althtmldef "L" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D43F;</SPAN>';
  latexdef "L" as "L";
htmldef "M" as "<IMG SRC='_cm.gif' WIDTH=15 HEIGHT=19 ALT=' M' TITLE='M'>";
  althtmldef "M" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D440;</SPAN>';
  latexdef "M" as "M";
htmldef "N" as "<IMG SRC='_cn.gif' WIDTH=14 HEIGHT=19 ALT=' N' TITLE='N'>";
  althtmldef "N" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D441;</SPAN>';
  latexdef "N" as "N";
htmldef "V" as "<IMG SRC='_cv.gif' WIDTH=12 HEIGHT=19 ALT=' V' TITLE='V'>";
  althtmldef "V" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D449;</SPAN>';
  latexdef "V" as "V";
htmldef "W" as "<IMG SRC='_cw.gif' WIDTH=16 HEIGHT=19 ALT=' W' TITLE='W'>";
  althtmldef "W" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D44A;</SPAN>';
  latexdef "W" as "W";
htmldef "X" as "<IMG SRC='_cx.gif' WIDTH=13 HEIGHT=19 ALT=' X' TITLE='X'>";
  althtmldef "X" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D44B;</SPAN>';
  latexdef "X" as "X";
htmldef "Y" as "<IMG SRC='_cy.gif' WIDTH=12 HEIGHT=19 ALT=' Y' TITLE='Y'>";
  althtmldef "Y" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D44C;</SPAN>';
  latexdef "Y" as "Y";
htmldef "Z" as "<IMG SRC='_cz.gif' WIDTH=11 HEIGHT=19 ALT=' Z' TITLE='Z'>";
  althtmldef "Z" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D44D;</SPAN>';
  latexdef "Z" as "Z";
htmldef "O" as "<IMG SRC='_co.gif' WIDTH=12 HEIGHT=19 ALT=' O' TITLE='O'>";
  althtmldef "O" as '<SPAN CLASS=class STYLE="color:#C3C">&#x1D442;</SPAN>';
  latexdef "O" as "O";
htmldef "s" as "<IMG SRC='_s.gif' WIDTH=7 HEIGHT=19 ALT=' s' TITLE='s'>";
  althtmldef "s" as '<SPAN CLASS=set STYLE="color:red">&#x1D460;</SPAN>';
  latexdef "s" as "s";
htmldef "r" as "<IMG SRC='_r.gif' WIDTH=8 HEIGHT=19 ALT=' r' TITLE='r'>";
  althtmldef "r" as '<SPAN CLASS=set STYLE="color:red">&#x1D45F;</SPAN>';
  latexdef "r" as "r";
htmldef "q" as "<IMG SRC='_q.gif' WIDTH=8 HEIGHT=19 ALT=' q' TITLE='q'>";
  althtmldef "q" as '<SPAN CLASS=set STYLE="color:red">&#x1D45E;</SPAN>';
  latexdef "q" as "q";
htmldef "p" as "<IMG SRC='_p.gif' WIDTH=10 HEIGHT=19 ALT=' p' TITLE='p'>";
  althtmldef "p" as '<SPAN CLASS=set STYLE="color:red">&#x1D45D;</SPAN>';
  latexdef "p" as "p";
htmldef "a" as "<IMG SRC='_a.gif' WIDTH=9 HEIGHT=19 ALT=' a' TITLE='a'>";
  althtmldef "a" as '<SPAN CLASS=set STYLE="color:red">&#x1D44E;</SPAN>';
  latexdef "a" as "a";
htmldef "b" as "<IMG SRC='_b.gif' WIDTH=8 HEIGHT=19 ALT=' b' TITLE='b'>";
  althtmldef "b" as '<SPAN CLASS=set STYLE="color:red">&#x1D44F;</SPAN>';
  latexdef "b" as "b";
htmldef "c" as "<IMG SRC='_c.gif' WIDTH=7 HEIGHT=19 ALT=' c' TITLE='c'>";
  althtmldef "c" as '<SPAN CLASS=set STYLE="color:red">&#x1D450;</SPAN>';
  latexdef "c" as "c";
htmldef "d" as "<IMG SRC='_d.gif' WIDTH=9 HEIGHT=19 ALT=' d' TITLE='d'>";
  althtmldef "d" as '<SPAN CLASS=set STYLE="color:red">&#x1D451;</SPAN>';
  latexdef "d" as "d";
htmldef "l" as "<IMG SRC='_l.gif' WIDTH=6 HEIGHT=19 ALT=' l' TITLE='l'>";
  althtmldef "l" as '<SPAN CLASS=set STYLE="color:red">&#x1D459;</SPAN>';
  latexdef "l" as "l";
htmldef "=/=" as
    " <IMG SRC='ne.gif' WIDTH=12 HEIGHT=19 ALT=' =/=' TITLE='=/='> ";
  althtmldef "=/=" as ' &ne; ';
  latexdef "=/=" as "\ne";
htmldef "e/" as
    " <IMG SRC='notin.gif' WIDTH=10 HEIGHT=19 ALT=' e/' TITLE='e/'> ";
  althtmldef "e/" as ' &notin; ';
    /* 2-Jan-2016 reverted sans-serif */
  latexdef "e/" as "\notin";
htmldef "_V" as "<IMG SRC='rmcv.gif' WIDTH=10 HEIGHT=19 ALT=' _V' TITLE='_V'>";
  althtmldef "_V" as 'V';
  latexdef "_V" as "{\rm V}";
htmldef "\/_" as
    " <IMG SRC='veebar.gif' WIDTH=9 HEIGHT=19 ALT=' \/_' TITLE='\/_'> ";
  althtmldef "\/_" as " &#8891; ";
    /* 2-Jan-2016 reverted sans-serif */
  latexdef "\/_" as "\veebar";
htmldef "T." as
    " <IMG SRC='top.gif' WIDTH=11 HEIGHT=19 TITLE='T.' ALIGN=TOP> ";
  althtmldef "T." as ' &#x22A4; ';
  latexdef "T." as "\top";
htmldef "F." as
    " <IMG SRC='perp.gif' WIDTH=11 HEIGHT=19 TITLE='F.' ALIGN=TOP> ";
  althtmldef "F." as ' &perp; ';
  latexdef "F." as "\bot";
htmldef "DECID" as "<SMALL>DECID</SMALL> ";
  althtmldef "DECID" as "<SMALL>DECID</SMALL> ";
  latexdef "DECID" as "\mathrm{DECID} ";

/* End of typesetting definition section */

$)

