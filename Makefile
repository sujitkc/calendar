CC=ocamlc
CSV=/home/sujit/My-Downloads/source/csv-1.3.3/src/

timetable : lecture.cmo calendar.cmo timetable.cmo timetable_impl.cmo ttparser.cmo lexer.cmo
	$(CC) -ccopt -L$(CSV) -o timetable str.cma $(CSV)csv.cmo calendar.cmo lecture.cmo timetable.cmo ttparser.cmo lexer.cmo timetable_impl.cmo 

timetable.cmo : timetable.ml timetable.cmi lecture.cmo calendar.cmo
	$(CC) -I $(CSV) -c timetable.ml

timetable.cmi : timetable.mli calendar.cmi lecture.cmi
	$(CC) -c timetable.mli

timetable_impl.cmo : timetable_impl.ml timetable_impl.cmi timetable.cmi lexer.cmo lecture.cmi calendar.cmi ttparser.cmi
	$(CC) -I $(CSV) -c timetable_impl.ml

timetable_impl.cmi : timetable_impl.mli timetable.mli calendar.cmi lecture.cmi lexer.cmo ttparser.cmi
	$(CC) -c timetable_impl.mli

lecture.cmo : lecture.ml lecture.cmi calendar.cmo
	$(CC) -c lecture.ml

lecture.cmi : lecture.mli calendar.cmi
	$(CC) -c lecture.mli

calendar.cmo : calendar.ml calendar.cmi
	$(CC) -c calendar.ml

calendar.cmi : calendar.mli
	$(CC) -c calendar.mli

test_tt : test_timetable.ml timetable.cmo timetable.cmi timetable_impl.cmo timetable_impl.cmi ttparser.cmo
	$(CC) -c test_timetable.ml
	$(CC) -ccopt -L$(CSV) -o test_timetable str.cma $(CSV)csv.cmo calendar.cmo lexer.cmo ttparser.cmo lecture.cmo timetable.cmo timetable_impl.cmo test_timetable.cmo

test_ttparser : lexer.cmo ttparser.cmo test_ttparser.cmo calendar.cmo timetable.cmo
	ocamlc -o $@ str.cma $(CSV)csv.cmo calendar.cmo lecture.cmo timetable.cmo lexer.cmo ttparser.cmo test_ttparser.cmo

lexer.cmo : lexer.ml ttparser.cmi
	ocamlc -c lexer.ml

lexer.ml: ttparser.mli lexer.mll
	ocamllex lexer.mll

ttparser.cmi : ttparser.mli
	ocamlc -c ttparser.mli

ttparser.cmo : ttparser.ml
	ocamlc -c ttparser.ml

ttparser.mli : ttparser.mly calendar.cmi timetable.cmi
	ocamlyacc ttparser.mly

ttparser.ml : ttparser.mly calendar.cmi timetable.cmi
	ocamlyacc ttparser.mly

test_ttparser.cmo : test_ttparser.ml ttparser.cmi
	ocamlc -c test_ttparser.ml

test_dateparser : lexer.cmo ttparser.cmo test_dateparser.cmo calendar.cmo
	ocamlc -o $@ calendar.cmo lecture.cmo lexer.cmo ttparser.cmo test_dateparser.cmo

test_dateparser.cmo : test_dateparser.ml ttparser.cmi
	ocamlc -c test_dateparser.ml

clean:
	rm *.cmo;
	rm *.cmi;
	rm lecture;
	rm timetable;
	rm test_tt;
	rm test_ttparser;
	rm lexer.ml;
	rm lexer.mli;
	rm ttparser.ml;
	rm ttparser.mli
	rm test_dateparser;
