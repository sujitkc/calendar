Lecture Plan Generation

Required:
Ocaml compiler for compilation.
Csv

Compiling the program along with the lecture example:
make

Modified on: 25 August 2022
---------------------------
Method for Ad-hoc Lecture Plan Generation
-----------------------------------------
METHOD 1:
- If calendar.cmo doesn't exist, compile calendar.ml
  ocamlc -c calendar.ml
- Open REPL
- #load "calendar.cmo";;
- #use "lecture.ml";;

METHOD 2:
- Make lecture
  make lecture
- In case of any issue, clean the build by:
  make clean
- Run lecture
  ./lecture
- 
