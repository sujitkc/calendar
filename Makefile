lecture : lecture.cmo calendar.cmo
	ocamlc -o lecture lecture.cmo calendar.cmo

lecture.cmo : lecture.ml calendar.cmi
	ocamlc -c lecture.ml

calendar.cmo : calendar.ml calendar.mli
	ocaml -c calendar.ml

clean:
	rm lecture
	rm *.cmo
	rm *.cmi
