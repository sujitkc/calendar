let main () =
  let string_of_period p =
    let wd, d = p in
      "(" ^ (Calendar.string_of_weekday wd) ^ (Timetable.string_of_duration d) ^ ")"
  in
  let string_of_periods plist =
    (List.fold_left (fun s p -> s ^ ", " ^ (string_of_period p)) "" plist)
  in
  try
    let periods =
      let lexbuf = Lexing.from_string "Monday(11:15-12:45), Friday(11:15-12:45)" in
        Ttparser.periods Lexer.scan_periods lexbuf
    in print_string (string_of_periods periods)
  with End_of_file -> exit 0
      
let _ = main ()
