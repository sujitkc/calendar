OCAMLC=ocamlc
OCAMLOPT = ocamlopt
CSV=/home/sujitkc/.opam/default/lib/csv
timetable : lecture.cmx calendar.cmx timetable.cmx timetable_impl.cmx ttparser.cmx lexer.cmx
	$(OCAMLOPT) -o timetable $(CSV)/csv.cmxa str.cmxa calendar.cmx lecture.cmx timetable.cmx ttparser.cmx lexer.cmx timetable_impl.cmx 

test_tt : test_timetable.ml timetable.cmx timetable.cmi timetable_impl.cmx timetable_impl.cmi ttparser.cmx
	$(OCAMLOPT) -o test_timetable $(CSV)/csv.cmxa str.cmxa calendar.cmx lexer.cmx ttparser.cmx lecture.cmx timetable.cmx timetable_impl.cmx test_timetable.cmx

test_ttparser : lexer.cmx ttparser.cmx test_ttparser.cmx calendar.cmx timetable.cmx
	$(OCAMLOPT) -o $@ str.cmxa calendar.cmx lecture.cmx timetable.cmx lexer.cmx ttparser.cmx test_ttparser.cmx

test_dateparser : lexer.cmx ttparser.cmx test_dateparser.cmx calendar.cmx
	$(OCAMLOPT) -o $@ calendar.cmx lecture.cmx lexer.cmx ttparser.cmx test_dateparser.cmx

lecture : calendar.cmo lecture.cmo
	$(OCAMLC) calendar.cmo lecture.cmo -o lecture

calendar.cmo : calendar.cmi calendar.ml
	$(OCAMLC) -c calendar.ml

calendar.cmi :  calendar.mli
	$(OCAMLC) -c calendar.mli

lecture.cmo : calendar.cmi lecture.cmi lecture.ml
	$(OCAMLC) -c lecture.ml

depend:
	ocamldep *.ml *.mli > .depend

clean:
	rm *.cmx *.cmi lecture timetable test_tt test_ttparser lexer.ml lexer.mli ttparser.ml ttparser.mli  test_dateparser
.SUFFIXES: .ml .mli .mll .mly .cmx .cmi

.ml.cmx:
	$(OCAMLOPT) -I $(CSV) -c $<

.mli.cmi:
	$(OCAMLC) -c $<

.mll.ml:
	ocamllex $<

.mly.ml:
	ocamlyacc $<

.mly.mli:
	ocamlyacc $<

include .depend
