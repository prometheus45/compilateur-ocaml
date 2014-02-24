{
  open Lexing
  open Printf
  open Parser
  open Error
  
   let update_loc lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- { pos with
      pos_lnum = pos.pos_lnum + 1;
      pos_bol = pos.pos_cnum;
    }
}

let digit = ['0'-'9']
let letter = ['A'-'Z' 'a'-'z']
let identifier = letter (letter | digit)*
let integer = digit+
let newline = ('\010'|'\013'|"\013\010")
let ws = [' ' '\t']

rule token = parse

(* Premier TOKEN pour un programme vide PASCAL *)
(* ordre extrement important !!!!! *)

newline {update_loc lexbuf; token lexbuf}
|ws+ {token lexbuf}
| "program" { PROGRAM }
| "begin" { BEGIN }
| "end" { END }
|":" { COLON }
| ";" { SEMICOLON }
| "." { DOT }
|"record" { RECORD }
|"array" { ARRAY }
|"integer" { INTEGER }
|"boolean" { BOOLEAN }
|"nil" { NIL }
|"of" { OF }
|"case" { CASE }
|"+" {PLUS}
|"-" {MINUS}
|identifier as id { ID id }
|integer as i { try INTC (Int32.of_string i) with Failure _ -> Error.error lexbuf "integer cast failed"}
|"'" {SIMPLECOTE}
|"," {COMA}
|"(" { LPAR }
|")" { RPAR }
|".." {DOUBLEDOT}
|"[" { LBR }
|"]" { RBR }

(* Token pour ajouter des VAR aux programmes *)

|eof {failwith "I tried"}
|_ {failwith "Oh my"}
