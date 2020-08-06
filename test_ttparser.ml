let test_ttparser () =
  let string_of_slot sl =
    let wd, d = sl.Timetable.weekday, sl.Timetable.timespan in
      "(" ^ (Calendar.string_of_weekday wd) ^ (Timetable.string_of_duration d) ^ ")"
  in
  let string_of_slots slot_list =
    (List.fold_left (fun s sl -> s ^ ", " ^ (string_of_slot sl)) "" slot_list)
  in
  try
    let slots =
      let lexbuf = Lexing.from_string "Monday(11:15-12:45),  WED(11:15-12:45), FRIDAY(11:15-12:45)" in
        Ttparser.slots Lexer.scan lexbuf
    in print_string ((string_of_slots slots) ^ "\n")
  with End_of_file -> exit 0
 
let test_dateparser () =
  try
    let cd1 =
      let lexbuf = Lexing.from_string "2 January 2015" in
        Ttparser.calendarday Lexer.scan lexbuf
    and cd2 =
      let lexbuf = Lexing.from_string "2 January 2015-10 January 2015" in
        Ttparser.calendarday Lexer.scan lexbuf
    in print_string ((Lecture.string_of_calendarday cd1) ^ "\n"),
       print_string ((Lecture.string_of_calendarday cd2) ^ "\n")
  with End_of_file -> exit 0

let main () =
  test_ttparser ();
  test_dateparser ()

let _ = main ()
