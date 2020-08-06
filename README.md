This directory contains various utilities for helping in course management activities.
Lecture Plan Generation
Project Team Formation: py/teams.py prepares project teams of class project given a class list CSV file and the required size of the teams.

Required:
Ocaml compiler for compilation.

Compiling the program along with the lecture example:
make

Running the lecture example program
./lecture

Date: 19 August 2016
---------------------
Method for Ad-hoc Lecture Plan Generation
-----------------------------------------
- If calendar.cmo doesn't exist, compile calendar.ml
  ocamlc -c calendar.ml
- Open REPL
- #load "calendar.cmo";;
- #use "lecture.ml";;
- 
