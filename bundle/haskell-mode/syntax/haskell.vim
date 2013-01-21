" Vim syntax file
" Language:         Haskell
" Maintainer:       David Terei <davidterei@gmail.com>
" Homepage:         http://github.com/haskell/vim-haskell-mode
" Last Change:      2013 Jan 6
" Original Author:  John Williams <jrw@pobox.com>
"
" Thanks to Ryan Crumley for suggestions and John Meacham for
" pointing out bugs. Also thanks to Ian Lynagh and Donald Bruce Stewart
" for providing the inspiration for the inclusion of the handling
" of C preprocessor directives, and for pointing out a bug in the
" end-of-line comment handling.
"
" Options-assign a value to these variables to turn the option on:
"
" hs_highlight_delimiters - Highlight delimiter characters--users
"                           with a light-colored background will
"                           probably want to turn this on.
" hs_highlight_boolean    - Treat True and False as keywords.
" hs_highlight_types      - Treat names of primitive types as keywords.
" hs_highlight_more_types - Treat names of other common types as keywords.
" hs_highlight_debug      - Highlight names of debugging functions.
" hs_allow_hash_operator  - Don't highlight seemingly incorrect C
"                           preprocessor directives but assume them to be
"                           operators
" hs_highlight_classes    - Highlight some prelude type classes
" hs_highlight_functions  - Highlight fuction type declarations
" hs_highlight_prelude    - Highlight the names of standard prelude functions
" hs_minlines             - Syntax sync minlines settings
" hs_maxlines             - Syntax sync maxlines settings
"
" 2004 Feb 19: Added C preprocessor directive handling, corrected eol comments
"              cleaned away literate haskell support (should be entirely in
"              lhaskell.vim)
" 2004 Feb 20: Cleaned up C preprocessor directive handling, fixed single \
"              in eol comment character class
" 2004 Feb 23: Made the leading comments somewhat clearer where it comes
"              to attribution of work.
" 2008 Dec 15: Added comments as contained element in import statements
" 2010 Jun 18: Added in highlighting of function type declarations and
"              extended some of the existing highlight classes to increase
"              coverage.
" 2011 Sep 08: Added in support for FFI as of Haskell 2010 language standard.
"              Added in hs_highlight_prelude setting to highlight all prelude
"              function names.


" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

" (Qualified) identifiers (no default highlighting)
syn match ConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>"
syn match VarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>"

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
syn match hsVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match hsConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match hsVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match hsConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Reserved symbols--cannot be overloaded.
syn match hsDelimiter  "(\|)\|\[\|\]\|,\|;\|_\|{\|}"

" Strings and constants
syn match  hsSpecialChar      contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match  hsSpecialChar      contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match  hsSpecialCharError contained "\\&\|'''\+"
syn region hsString           start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar
syn match  hsCharacter        "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match  hsCharacter        "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
syn match  hsNumber           "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match  hsFloat            "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

" Keyword definitions. These must be patters instead of keywords
" because otherwise they would match as keywords at the start of a
" "literate" comment (see lhs.vim).
syn match hsModule      "\<module\>"
syn match hsImport      "\<import\>.*"he=s+6 contains=hsImportMod,hsLineComment,hsBlockComment
syn match hsImport      "\<import\>.*"he=s+6 contains=hsImportMod,hsString,hsType,hsFunction
syn match hsImportMod   contained "\<\(as\|qualified\|hiding\)\>"
syn match hsInfix       "\<\(infix\|infixl\|infixr\)\>"
syn match hsStructure   "\<\(class\|data\|deriving\|instance\|default\|where\)\>"
syn match hsTypedef     "\<\(type\|newtype\)\>"
syn match hsStatement   "\<\(do\|return\|case\|of\|let\|in\)\>"

" We also include CPP ones here
syn match hsConditional "\<\(if\|then\|else\|endif\|when\|ifndef\|ifdef\|elif\|defined\)\>"

" Haskell 2010 keywords
syn match hsForeign     "\<foreign\>"
syn match hsForeignType "\<\(Int8\|Int16\|Int32\|Int64\|Word8\|Word16\|Word32\|Word64\|Ptr\|FunPtr\|StablePtr\)\>"

" Function type defenitions
if exists("hs_highlight_functions")
  syn match hsFunDef    "^\zs\l\w*'\=\%(\_s*,\_s*\l\w*'\=\)*\ze\_s*::"
  syn match hsFunDefSub "\s\+\zs\l\w*'\=\%(\_s*,\_s*\l\w*'\=\)*\ze\_s*::"
endif

" Not real keywords, but close.
if exists("hs_highlight_boolean")
  syn match hsBoolean   "\<\(True\|False\)\>"
  syn match hsFunction  "\<\(not\|otherwise\)\>"
endif

" Primitive types from the standard prelude and libraries.
if exists("hs_highlight_types")
  syn match hsType      "\<\(Int\|Integer\|Char\|Bool\|Float\|Double\|IO\|Void\|Addr\|Array\|String\|Rational\)\>"
endif

" Types from the standard prelude libraries.
if exists("hs_highlight_more_types")
  syn match hsType      "\<\(Maybe\|Either\|Ratio\|Complex\|Ordering\|FilePath\|IOError\|IOResult\|ExitCode\)\>"
  syn match hsMaybe     "\<\(Nothing\|Just\|Left\|Right\)\>"
  syn match hsExitCode  "\<\(ExitSuccess\)\>"
  syn match hsOrdering  "\<\(GT\|LT\|EQ\)\>"
endif

" highlight some common type clases
if exists("hs_highlight_classes")
  syn match hsClasses   "\<\(Show\|Read\|Eq\|Ord\|Enum\|Bounded\|Num\|Real\|Integral\|Fractional\|Floating\|RealFrac\|RealFloat\|Monad\|Functor\|ReadS\|ShowS\)\>"
endif

" Debugging functions from the standard prelude.
if exists("hs_highlight_debug")
  syn match hsDebug     "\<\(undefined\|error\|trace\|fail\|ioError\|userError\|catch\)\>"
endif

" Functions from the standard prelude.
if exists("hs_highlight_prelude")
  syn match hsFunction  "\<\(compare\|max\|min\)\>"
  syn match hsFunction  "\<\(succ\|pred\|toEnum\|fromEnum\|enumFrom\|enumFromThen\|enumFromTo\|enumFromThenTo\)\>"
  syn match hsFunction  "\<\(minBound\|maxBound\)\>"
  syn match hsFunction  "\<\(negate\|abs\|signum\|fromInteger\)\>"
  syn match hsFunction  "\<toRational\>"
  syn match hsFunction  "\<\(quot\|rem\|div\|mod\|quotRem\|divMod\|toInteger\)\>"
  syn match hsFunction  "\<\(recip\|fromRational\)\>"
  syn match hsFunction  "\<\(pi\|exp\|log\|sqrt\|logBase\|sin\|cos\|tan\|asin\|acos\|atan\|sinh\|cosh\|tanh\|asinh\|acosh\|atanh\)\>"
  syn match hsFunction  "\<\(properFraction\|truncate\|round\|ceiling\|floor\)\>"
  syn match hsFunction  "\<\(floatRadix\|floatDigits\|floatRange\|decodeFloat\|encodeFloat\|exponent\|significand\|scaleFloat\|isNaN\|isInfinite\|isDenormalized\|isIEEE\|isNegativeZero\|atan2\)\>"
  syn match hsFunction  "\<\(return\|fail\)\>"
  syn match hsFunction  "\<\(fmap\)\>"
  syn match hsFunction  "\<\(mapM\|mapM_\|sequence\|sequence_\)\>"
  syn match hsFunction  "\<\(maybe\|either\)\>"
  syn match hsFunction  "\<\(not\|otherwise\)\>"
  syn match hsFunction  "\<\(subtract\|even\|odd\|gcd\|lcm\)\>"
  syn match hsFunction  "\<\(fromIntegral\|realToFrac\)\>"
  syn match hsFunction  "\<\(fst\|snd\|curry\|uncurry\|id\|const\|flip\|until\)\>"
  syn match hsFunction  "\<\(asTypeOf\|error\|undefined\)\>"
  syn match hsFunction  "\<\(seq\)\>"
  syn match hsFunction  "\<\(map\|filter\|concat\|concatMap\)\>"
  syn match hsFunction  "\<\(head\|last\|tail\|init\|null\|length\)\>"
  syn match hsFunction  "\<\(foldl\|foldl1\|scanl\|scanl1\|foldr\|foldr1\|scanr\|scanr1\)\>"
  syn match hsFunction  "\<\(iterate\|repeat\|replicate\|cycle\)\>"
  syn match hsFunction  "\<\(take\|drop\|splitAt\|takeWhile\|dropWhile\|span\|break\)\>"
  syn match hsFunction  "\<\(lines\|words\|unlines\|unwords\|reverse\|and\|or\)\>"
  syn match hsFunction  "\<\(any\|all\|elem\|notElem\|lookup\)\>"
  syn match hsFunction  "\<\(sum\|product\|maximum\|minimum\)\>"
  syn match hsFunction  "\<\(zip\|zip3\|zipWith\|zipWith3\|unzip\|unzip3\)\>"
  syn match hsFunction  "\<\(readsPrec\|readList\)\>"
  syn match hsFunction  "\<\(showsPrec\|show\|showList\)\>"
  syn match hsFunction  "\<\(reads\|shows\|read\|lex\)\>"
  syn match hsFunction  "\<\(showChar\|showString\|readParen\|showParen\)\>"
  syn match hsFunction  "\<\(ioError\|userError\|catch\)\>"
  syn match hsFunction  "\<\(putChar\|putStr\|putStrLn\|print\)\>"
  syn match hsFunction  "\<\(getChar\|getLine\|getContents\|interact\)\>"
  syn match hsFunction  "\<\(readFile\|writeFile\|appendFile\|readIO\|readLn\)\>"
endif

" Comments
syn match  hsLineComment  "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
syn region hsBlockComment start="{-"  end="-}" contains=hsBlockComment
syn region hsPragma       start="{-#" end="#-}"

" C Preprocessor directives. Shamelessly ripped from c.vim and trimmed
" First, see whether to flag directive-like lines or not
if (!exists("hs_allow_hash_operator"))
  syn match cError display "^\s*\(%:\|#\).*$"
endif
" Accept %: for # (C99)
syn region  cPreCondit    start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=cComment,cCppString,cCommentError
syn match   cPreCondit    display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn region  cCppOut       start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=cCppOut2
syn region  cCppOut2      contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=cCppSkip
syn region  cCppSkip      contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cCppSkip
syn region  cIncluded     display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match   cIncluded     display contained "<[^>]*>"
syn match   cInclude      display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
syn cluster cPreProcGroup contains=cPreCondit,cIncluded,cInclude,cDefine,cCppOut,cCppOut2,cCppSkip,cCommentStartError
syn region  cDefine       matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$"
syn region  cPreProc      matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend

syn region cComment           matchgroup=cCommentStart start="/\*" end="\*/" contains=cCommentStartError,cSpaceError contained
syn match  cCommentError      display "\*/" contained
syn match  cCommentStartError display "/\*"me=e-1 contained
syn region cCppString         start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial contained

" Set syntax sync mode
if !exists("hs_minlines")
  let hs_minlines = 50
endif
if !exists("hs_maxlines")
  let hs_maxlines = 500
  if hs_maxlines < hs_minlines
    let hs_maxlines = hs_maxlines + hs_minlines
  endif
endif
exec "syn sync minlines=" . hs_minlines . " maxlines=" . hs_maxlines . " linebreaks=15"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_hs_syntax_inits")
  if version < 508
    let did_hs_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink hsModule              hsStructure
  HiLink hsImport              Include
  HiLink hsImportMod           hsImport
  HiLink hsForeign             hsImport
  HiLink hsInfix               PreProc
  HiLink hsStructure           Structure
  HiLink hsStatement           Statement
  HiLink hsConditional         Conditional
  HiLink hsSpecialChar         SpecialChar
  HiLink hsTypedef             Typedef
  HiLink hsVarSym              hsOperator
  HiLink hsConSym              hsOperator
  HiLink hsOperator            Operator
  if exists("hs_highlight_delimiters")
    " Some people find this highlighting distracting.
    HiLink hsDelimiter         Delimiter
  endif
  HiLink hsSpecialCharError    Error
  HiLink hsString              String
  HiLink hsCharacter           Character
  HiLink hsNumber              Number
  HiLink hsFloat               Float
  HiLink hsConditional         Conditional
  HiLink hsLiterateComment     hsComment
  HiLink hsBlockComment        hsComment
  HiLink hsLineComment         hsComment
  HiLink hsComment             Comment
  HiLink hsPragma              SpecialComment
  HiLink hsBoolean             Boolean
  HiLink hsType                Type
  HiLink hsForeignType         Type
  HiLink hsMaybe               hsEnumConst
  HiLink hsOrdering            hsEnumConst
  HiLink hsEnumConst           Constant
  HiLink hsDebug               Debug

  HiLink hsClasses             hsType
  HiLink hsFunDef              Identifier
  HiLink hsFunction            Function

  HiLink cCppString            hsString
  HiLink cCommentStart         hsComment
  HiLink cCommentError         hsError
  HiLink cCommentStartError    hsError
  HiLink cInclude              Include
  HiLink cPreProc              PreProc
  HiLink cDefine               Macro
  HiLink cIncluded             hsString
  HiLink cError                Error
  HiLink cPreCondit            PreCondit
  HiLink cComment              Comment
  HiLink cCppSkip              cCppOut
  HiLink cCppOut2              cCppOut
  HiLink cCppOut               Comment

  delcommand HiLink
endif

let b:current_syntax = "haskell"
" Options for vi: ts=8 sw=2 sts=2 nowrap noexpandtab ft=vim
