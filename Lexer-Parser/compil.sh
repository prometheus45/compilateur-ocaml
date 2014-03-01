set -e -u

rm -f module/*.cmi module/*.cmo
rm *.dot
ocamlc AST.mli
ocamlc -c error.ml
ocamlc -c astprinter.ml
menhir -v --graph --infer --explain --dump parserHELIX.mly 
ocamllex lexer.mll 
ocamlc -c parserHELIX.mli 
ocamlc -c lexer.ml 
ocamlc -c parserHELIX.ml 
ocamlc -c main.ml 
mv *.cm* module
ocamlc -o main -I module error.cmo astprinter.cmo lexer.cmo parserHELIX.cmo main.cmo
