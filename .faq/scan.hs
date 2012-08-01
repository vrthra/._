{------------------------------------------------------------------------------
http://www.cs.bris.ac.uk/Teaching/Resources/COMS30122/haskell/Scan.hs
                                Haskell Scanner
-------------------------------------------------------------------------------
The scan function provides a lexical analyser for Haskell 1.4.  It chops up
the source text into tokens, each with its classification and its position in
the source.  It supports 8-bit ISO characters, but not 16-bit Unicode ones.

The scanner returns tokens as exact substrings of the source text, and includes
pragma comments {-# ... #-} as tokens.  Qualified names are returned as three
separate tokens, but with the first classified as a Qualifier.  Reserved words
and symbols are classified as Keywords.

The scanner is guaranteed not to fail.  In the case of a lexical error, an
error token is produced which contains the legal initial part of the token and
an error message.  Lexing then continues on the rest of the text.  An empty
last token is returned to record the position of the end of the source text.

Ian Holyer
------------------------------------------------------------------------------}

module Scan (Token(..), TokenClass(..), scan, display) where

import Array

{------------------------------------------------------------------------------
A token is a substring of the source text, with its position described using
line and column numbers (after expansion of tabs), and its classification.
------------------------------------------------------------------------------}

data Token = Tok String !Int !Int TokenClass
   deriving Show

data TokenClass =
   Varid |              -- a name starting with a lower case letter
   Conid |              -- a name starting with an upper case letter
   Varsym |             -- an operator symbol not starting with ':'
   Consym |             -- an operator symbol starting with ':'
   Qualifier |          -- a module name (preceding a dot and one of the above)
   Literal |            -- number, character or string constant
   Implicit |           -- added by layout conventions (not generated here)
   Keyword |            -- reserved word or symbol
   Comment |            -- one-line or nested comment, possibly pragma
   ErrorToken String |  -- lex error, with message
   EndToken             -- end of file, empty string
   deriving (Eq,Show)

{------------------------------------------------------------------------------
A list of tokens can be displayed with or without extra spaces which show how
the tokens have been broken up.
------------------------------------------------------------------------------}

display :: Bool -> [Token] -> String
display space ts = loop 1 1 ts where
   loop row col [] = ""
   loop row col (Tok s1 r c Qualifier : Tok "." _ _ _ : Tok s2 _ _ k : ts) =
      loop row col (Tok (s1++"."++s2) r c k : ts)
   loop row col ts @ (Tok s r c k : ts1) =
      if r>row then "\n" ++ loop (row+1) 1 ts else
      if c>col then take (c-col) (repeat ' ') ++ s ++ loop r1 c1 ts1 else
      (if col>1 && space then " " else "") ++ s ++ loop r1 c1 ts1
      where
      (r1,c1) =
         if k == Literal || k == Comment then skip s r c else (r, c + length s)

{------------------------------------------------------------------------------
The scan function takes a source text and returns a list of tokens.  Reserved
words and symbols are looked up.  The processing is divided into passes which
can be used separately, eg for language sensitive editing.
------------------------------------------------------------------------------}

scan :: String -> [Token]
scan cs = decomment (keys (toks 1 1 cs))

-- The toks function is the main loop which tracks line and column numbers.  It
-- returns all non-space text as tokens; the result can be used to reproduce
-- the input exactly.

toks :: Int -> Int -> String -> [Token]
toks row col "" = [Tok "" row col EndToken]
toks row col cs@(c:_) =
   case kind c of
      Large ->
         let id = identifier cs in
         let rest = drop (length id) cs in
         if null rest || head rest /= '.' then tok id Conid else
         let cs1@(c:_) = tail rest in
         case kind c of
            Large -> qtok id (identifier cs1) Conid
            Small -> qtok id (identifier cs1) Varid
            Sign -> qtok id (operator cs1) (if c==':' then Consym else Varsym)
            _ -> tok id Conid
      Small -> tok (identifier cs) Varid
      Digit ->
         if floating cs then lit (float cs) Literal else
         lit (integer cs) Literal
      Sign  ->
         if take 2 cs == "--" then lit (comment cs) Comment else
         let t = operator cs in
         if head t == ':' then tok t Consym else tok t Varsym
      Punctuation ->
         if c == '\'' then lit (char cs) Literal else
         if c == '\"' then lit (string cs) Literal else
         if take 2 cs == "{-" then lit (ncomment cs) Comment else
         tok [c] Keyword
      Layout -> case c of
         ' '  -> toks row (col+1) (tail cs)
         '\t' -> toks row (tab col) (tail cs)
         '\n' -> toks (row+1) 1 (tail cs)
         '\v' -> toks row (col+1) (tail cs)
         '\f' -> toks row (col+1) (tail cs)
         '\r' -> toks row 1 (tail cs)
         '\160' -> toks row (col+1) (tail cs)
      Control ->
         Tok [c] row col (ErrorToken "there is an illegal control character") :
         toks row (col+1) (drop 1 cs)
   where
   tok s k = Tok s row col k : toks row (col+n) (drop n cs) where n = length s
   qtok m s k =
      Tok m row col Qualifier :
      Tok "." row (col + n1) Keyword :
      Tok s row (col + n1 + 1) k :
      toks row (col + n2) (drop n2 cs) where
      n1 = length m
      n2 = n1 + 1 + length s
   lit (s,e) k = Tok s row col k1 : toks r1 c1 (drop (length s) cs) where
      k1 = if null e then k else ErrorToken e
      (r1,c1) = skip s row col

-- The skip function finds the new line and column after a literal or comment.

skip :: String -> Int -> Int -> (Int,Int)
skip "" row col = (row,col)
skip (c:cs) row col = case c of
   '\n' -> skip cs (row+1) 1
   '\t' -> skip cs row (tab col)
   '\r' -> skip cs row 1
   _    -> skip cs row (col+1)

-- The tab function moves to the next tab position.

tab :: Int -> Int
tab col = col + 8 - (col-1) `mod` 8

keys :: [Token] -> [Token]
keys [] = []
keys (t@(Tok s r c k) : ts) = Tok s r c k1 : keys ts where
   k1 = case k of
      Varid -> if elem s keywords then Keyword else k
      Varsym -> if elem s keyops then Keyword else k
      Consym -> if s == "::" then Keyword else k
      _ -> k

keywords :: [String]
keywords = [
   "case", "class", "data", "default", "deriving", "do", "else",
   "if", "import", "in", "infix", "infixl", "infixr", "instance",
   "let", "module", "newtype", "of", "then", "type", "where"]

keyops :: [String]
keyops = [
   "..", "=", "\\", "|", "<-", "->", "@", "~", "=>", "::"]

decomment :: [Token] -> [Token]
decomment [] = []
decomment (t@(Tok s r c k) : ts) =
   if k /= Comment then t : decomment ts else
   if take 3 s == "{-#" && drop (length s - 3) s == "#-}"
   then t : decomment ts else
   decomment ts

{------------------------------------------------------------------------------
Functions for simple tokens which cannot fail once the first character is
recognised, ie identifiers and operators, take the remainder of the source text
as argument and return a prefix of it representing the token.
------------------------------------------------------------------------------}

-- The identifier function recognises any name or keyword beginning with a
-- lower case letter.  It can also be used for unqualified upper case names.

identifier :: String -> String
identifier (c:cs) = takeWhile ok (c:cs) where
   ok c1 = case kind c1 of
      Large -> True
      Small -> True
      Digit -> True
      Punctuation -> (c1=='\'') || (c1=='_')
      _ -> False

-- The operator function recognises a varsym, consym, reservedop or specialop.

operator :: String -> String
operator (c:cs) =
   c : loop cs where
   loop "" = ""
   loop ('-':'-':_) = ""
   loop (c:cs) = if kind c /= Sign then "" else c : loop cs

{------------------------------------------------------------------------------
Functions for comments and literals return a pair of strings; the first
represents the token or maximal legal prefix, and the second is a possibly
empty error message.  The comment and ncomment functions find one-line or
nested comments.
------------------------------------------------------------------------------}

comment :: String -> (String, String)
comment cs =
   if take 1 cs2 `elem` ["\n","\r"] then (cs1,"") else
   (cs1, "the comment contains an illegal control character")
   where
   (cs1,cs2) = span ok cs
   ok c = case kind c of
      Control -> False
      Layout -> (c==' ') || (c=='\t') || (c == toEnum 160)
      _ -> True

ncomment :: String -> (String, String)
ncomment cs =
   if depth == 0 then (com,"") else
   if null (drop len cs)
   then (com, "the nested comment is incomplete") else
   (com, "the nested comment contains an illegal control character '" ++ 
      show (head (drop len cs)) ++ "'")
   where
   (len,depth) = nest 0 0 cs
   com = take len cs
   nest :: Int -> Int -> String -> (Int,Int)
   nest n d ('-':'}':cs1) = if d == 1 then (n+2,0) else nest (n+2) (d-1) cs1
   nest n d ('{':'-':cs1) = nest (n+2) (d+1) cs1
   nest n d (c:cs1) | kind c /= Control = nest (n+1) d cs1
   nest n d _ = (n,d)

{------------------------------------------------------------------------------
The floating function tests whether its input begins with a float.  The
integer and float functions find a numeric literal token.
------------------------------------------------------------------------------}

floating   :: String -> Bool
floating cs = case (dropWhile isDec cs) of
   ('.':d:cs1) -> isDec d
   _ -> False

integer :: String -> (String, String)
integer cs =
   case cs of
      '0':'o':cs -> prefix "0o" (digits isOct cs)
      '0':'O':cs -> prefix "0O" (digits isOct cs)
      '0':'x':cs -> prefix "0x" (digits isHex cs)
      '0':'X':cs -> prefix "0X" (digits isHex cs)
      cs -> digits isDec cs
   where
   prefix p (s,e) = (p++s, e)
   digits test cs =
      let ds = takeWhile test cs in
      if null ds then (ds, "the integer literal is badly formed")
      else (ds,"")

float :: String -> (String, String)
float cs =
   if null whole
      then ("", "the float literal has no integer part") else
   if null dot || null fraction
      then (whole, "the float literal has no fractional part") else
   if not (null e) && null exponent
      then (whole++dot++fraction++e++sign,
         "the float literal has a badly formed exponent") else
   (whole++dot++fraction++e++sign++exponent,"")
   where
   (whole,cs1) = span isDec cs
   (dot,cs2) = case cs1 of ('.':d:cs) | isDec d -> (".",d:cs); _ -> ("",cs1)
   (fraction,cs3) = span isDec cs2
   (e,cs4) =
      if take 1 cs3 `elem` ["e","E"] then (take 1 cs3, tail cs3) else ("",cs3)
   (sign,cs5) =
      if take 1 cs4 `elem` ["+","-"] then (take 1 cs4, tail cs4) else ("",cs4)
   (exponent,rest) = span isDec cs5

isDec, isOct, isHex :: Char -> Bool
isDec c = c >= '0' && c <= '9'
isOct c = c >= '0' && c <= '7'
isHex c = isDec c || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f'

{------------------------------------------------------------------------------
The char function finds a character literal.
------------------------------------------------------------------------------}

char :: String -> (String, String)
char cs =
   let err = "the character literal is badly formed" in
   case cs of
      ('\'':c:cs1) | (graphic c && c/='\\' && c/='\'') ->
         if take 1 cs1 == "'" then (['\'',c,'\''], "")
         else (['\'',c], err)
      ('\'':' ':cs1) ->
         if take 1 cs1 == "'" then (['\'',' ','\''], "")
         else (['\'',' '], err)
      ('\'':'\\':cs1) ->
         case escape ('\\':cs1) of
            (esc, "") ->
               if esc /= "\\&" &&
                  kind (head (tail esc)) /= Layout &&
                  take 1 (drop (length esc - 1) cs1) == "'"
               then ("'" ++ esc ++ "'", "") else ("'" ++ esc, err)
            (esc, mess) -> ("'" ++ esc, mess)
      ('\'':_) -> ("'", err)
      _ -> ("", err)
   where graphic c = not (elem (kind c) [Layout, Control] )

{------------------------------------------------------------------------------
The string function finds a string literal.
------------------------------------------------------------------------------}

string :: String -> (String, String)
string cs =
   let err = "the string literal is badly formed" in
   if take 1 cs /= "\"" then ("", err) else
   let (str,cs1) = span (\c -> graphic c && c /= '\\' && c /= '"') (tail cs) in
   if take 1 cs1 == "\"" then ("\"" ++ str ++ "\"", "") else
   if take 1 cs1 /= "\\" then ("\"" ++ str, err) else
   case escape cs1 of
      (esc, "") ->
         case string ("\"" ++ drop (length esc) cs1) of
            (str1, "") ->
               ("\"" ++ str ++ esc ++ tail str1, "")
            (str1, mess) -> ("\"" ++ str ++ esc ++ tail str1, mess)
      (esc, mess) -> ("\"" ++ str ++ esc, mess)
   where graphic c = c == ' ' || not (elem (kind c) [Layout, Control] )

{------------------------------------------------------------------------------
The escape function finds an escape sequence.  The form \& and string gaps are
recognised.
------------------------------------------------------------------------------}

escape :: String -> (String, String)
escape ('\\':cs) = case cs of
   ('&':cs1)           -> ("\\&", "")
   ('^':cs1)           -> ctrl cs1
   ('o':cs1)           -> octal cs1
   ('x':cs1)           -> hexadecimal cs1
   (c:cs1) | isDec c   -> decimal cs
   (c:cs1) | kind c == Large  -> ascii cs
   (c:cs1) | kind c == Layout -> gap cs
   (c:cs1)             -> charesc c
   _                   -> ("\\", "the escape sequence is badly formed")

ctrl :: String -> (String, String)
ctrl "" = (['\\','^'], "the escape sequence is badly formed")
ctrl (c:_) =
   if '@'<=c && c<='_' then (['\\','^',c], "")
   else (['\\','^'], "the escape sequence is badly formed")

octal :: String -> (String, String)
octal cs =
   if not (null ds) && num 8 ds < 256 then ('\\':'o':ds, "")
   else ('\\' : 'o' : init ds, "the escape sequence is badly formed")
   where ds = takeWhile isOct cs

hexadecimal :: String -> (String, String)
hexadecimal cs =
   if not (null ds) && num 16 ds < 256 then ('\\':'x':ds, "")
   else ('\\' : 'x' : init ds, "the escape sequence is badly formed")
   where ds = takeWhile isHex cs

decimal :: String -> (String, String)
decimal cs =
   if num 10 ds < 256 then ('\\':ds, "")
   else ('\\' : init ds, "the escape sequence is badly formed")
   where ds = takeWhile isDec cs

num :: Integral a => Int -> String -> a
num radix [] = 0
num radix ds =
   num radix (init ds) * fromInt radix + fromInt (val (last ds)) where
   val d =
      if '0' <= d && d <= '9' then ord d - ord '0' else
      if 'A' <= d && d <= 'F' then 10 + ord d - ord 'A' else
      10 + ord d - ord 'a'
   ord = fromEnum
   fromInt = fromIntegral

ascii :: String -> (String, String)
ascii cs =
   if code3 >= 0 then ('\\':first3, "") else
   if code2 >= 0 then ('\\':first2, "") else
   (['\\', head cs], "the escape sequence is badly formed")
   where
   (first3, code3) = (take 3 cs, find 0 table first3)
   (first2, code2) = (take 2 cs, find 0 table first2)
   find :: Int -> [String] -> String -> Int
   find n [] x = if x == "DEL" then 127 else -1
   find n (y:ys) x = if y==x then n else find (n+1) ys x
   table =
      [  "NUL", "SOH", "STX", "ETX", "EOT", "ENQ", "ACK", "BEL",
         "BS",  "HT",  "LF",  "VT",  "FF",  "CR",  "SO",  "SI",
         "DLE", "DC1", "DC2", "DC3", "DC4", "NAK", "SYN", "ETB",
         "CAN", "EM",  "SUB", "ESC", "FS",  "GS",  "RS",  "US", "SP"
      ]

charesc :: Char -> (String, String)
charesc c = case c of
   'a'  -> ("\\a", "");   'b'  -> ("\\b", "")
   'f'  -> ("\\f", "");   'n'  -> ("\\n", "")
   'r'  -> ("\\r", "");   't'  -> ("\\t", "")
   'v'  -> ("\\v", "");   '\\' -> ("\\\\", "")
   '\"' -> ("\\\"", "");  '\'' -> ("\\\'", "")
   _    -> ("\\", "the escape sequence is badly formed")

gap :: String -> (String, String)
gap cs =
   let (cs1,cs2) = span (\c -> kind c == Layout) cs in
   if take 1 cs2 == "\\" then ("\\"++cs1++"\\", "")
   else ("\\"++cs1, "the gap is badly formed")

{------------------------------------------------------------------------------
The kind function classifies characters according to the Kind type.  A
Punctuation character is a `special' character, or a single or double quote.  A
Sign character is a `symbol' character or a colon.  A Control character is any
character which isn't a graphic or layout character.  The upper half of the ISO
Latin-1 character set is included (see `man iso_8859_1').
------------------------------------------------------------------------------}

data Kind =
   Large | Small | Digit | Sign | Punctuation | Layout | Control
   deriving (Eq,Show)

kind :: Char -> Kind
kind c = kindArray ! c

kindArray :: Array Char Kind
kindArray = array (toEnum 0, toEnum 255) (
   [(c, Large) | c <- ['A'..'Z'] ++ ['\192'..'\214'] ++ ['\216'..'\222']] ++
   [(c, Small) | c <- ['a'..'z'] ++ map toEnum ([223..246] ++ [248..255])] ++
   [(c, Digit) | c <- ['0'..'9']] ++
   [(c, Layout) | c <- " \t\n\v\f\r" ++ [toEnum 160]] ++
   [(c, Punctuation) | c <- "()[]{},;`_'\""] ++
   [(c, Sign) | c <- "!#$%&*+./<=>?@\\^|:-~"] ++
   [(c, Sign) | c <- map toEnum ([161..191]++[215,247])] ++
   [(c, Control) | c <- map toEnum ([0..8]++[14..31])] ++
   [(c, Control) | c <- map toEnum [127..159]])
