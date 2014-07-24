lecture : lecture.cmo calendar.cmo
	ocamlc -o lecture calendar.cmo lecture.cmo

lecture.cmo : lecture.ml calendar.cmi
	ocamlc -c lecture.ml

calendar.cmo : calendar.ml calendar.mli
	ocamlc -c calendar.ml

calendar.cmi : calendar.mli
	ocamlc -c calendar.mli

clean:
	rm lecture
	rm *.cmo
	rm *.cmi
