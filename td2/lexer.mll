{
  open Lexing
  open Printf
}

let digit = ['0'-'9']
let letter = ['A'-'Z' 'a'-'z']
let identifier = letter (letter | digit)*
let integer = digit+
let newline = ('\010'|'\013'|"\013\010")
let ws = [' ' '\t']

rule token = parse
|newline {token lexbuf}
|ws+ {token lexbuf}
|integer as i {try printf "%s" i with _ -> failwith "fuck"}
|identifier as id { ID(*try printf "%s" (Lexing.lexeme lexbuf) with _ -> failwith "I tried..."*)}
|"true" { BOOLC true}
|"false" { BOOLC false }
|"var" { VAR }
|"program" { PROGRAM }
|"begin" { BEGIN }
|"end" { END }
|"+" { PLUS }
|"-" { MINUS }
|"*" { TIMES }
|"div" { DIV }
|"mod" { MOD }
|"not" { NOT }
|"and" { AND }
|"or" { OR }
|"<" { LT }
|">" { GT }
|"<=" { LE }
|">=" { GE }
|"=" { EQ }
|":=" { COLONEQ }
|"::=" { CCOLONEQ }
|"<>" { NEQ }
|"if" { IF }
|"else" { ELSE }
|"then" { THEN }
|"(" { LPAR }
|")" { RPAR }
|"writeln" { WRITELN }
|"integer" { INTEGER }
|"boolean" { BOOLEAN }
|"array" { ARRAY }
|":" { COLON }
|";" { SEMICOLON }
|"." { DOT }
|"," { COMMA }
|"[" { LBR }
|"]" { RBR }
|"nil" { NIL }
|"case" { CASE }
|"of" { OF }
|"record" { RECORD }
|"repeat" { REPEAT }
|"until" { UNTIL }
|"for" { FOR }
|"do" { DO }
|"to" { TO }
|"downto" { DOWNTO }
|"while" { WHILE }
|"function" { FUNCTION }
|"procedure" { PROCEDURE } 
|"'" {stringc lexbuf}
|eof {failwith "I tried"}
|_ {failwith "Oh my"}

and stringc = parse
|'\'' {()}
|(letter | digit | ws | newline)+ as content {try printf "%s" content with _ -> failwith "I dun goofed"}