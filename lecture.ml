let string_of_date_weekday (d, wd) =
  (Calendar.string_of_date d) ^ ", " ^ (Calendar.string_of_weekday wd)

let weekdayMap lst =
  List.map (fun d -> (d, (Calendar.getWeekDay d))) lst

let (|>) f g x = g(f x)

let getLectureDates d1 d2 lec =
  let f lst =
    List.filter (fun (_, wd) -> List.mem wd lec) lst
  in
    let dr (d1', d2') = (Calendar.dateRange d1 d2)
    in
  (dr |> weekdayMap |> f) (d1, d2)


(* TEST CASES *)
let printDateList l =
    let slist = List.map string_of_date_weekday l
    in
      let s = (List.fold_left (fun s1 s2 -> (s1 ^ "\n" ^ s2)) "" slist)
      in
        (print_string (s ^ "\n"))

let test () =
  let l1 = (getLectureDates (2, Calendar.January, 2014) (30, Calendar.May, 2014) [Calendar.Monday; Calendar.Friday])
  and l2 = (getLectureDates (4, Calendar.August, 2014) (13, Calendar.December, 2014) [Calendar.Monday; Calendar.Wednesday])
  in
  printDateList l1; print_string "\n\n";
  printDateList l2; print_string "\n\n"

let _ = test()
