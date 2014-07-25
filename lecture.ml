(*
  This file contains an example of application of the calendar library. The objective of this program
  is to print the list of dates (along with their weekdays) on which the lectures of a particular
  course will be held. Inputs to this program are: the duration of the semester in terms of its 
  starting and ending dates, and the week days on which the lectures are held for the course.
  See test cases at the bottom of the file for examples.
*)

(*
  Given a pair (d, wd) where d is a date and wd is a weeday, return its string representation.
  Example:
    ((2, January, 2014), Thursday) --> "January 2, 2014, Thursday"
*)
let string_of_date_weekday (d, wd) =
  (Calendar.string_of_date d) ^ ", " ^ (Calendar.string_of_weekday wd)

(*
  Given a list lst of dates, return a list where each element is a date in the lst, coupled with its weekday.
  Example:
     [(2, January, 2014); (3, January, 2014)]--> [((2, January, 2014), Thursday); ((3, January, 2014), Friday)]
*)
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
    List.iter (fun s -> (print_string (string_of_date_weekday s ^ "\n"))) l

let test () =
  let l1 = (getLectureDates (2, Calendar.January, 2014) (30, Calendar.May, 2014) [Calendar.Monday; Calendar.Friday])
  and l2 = (getLectureDates (4, Calendar.August, 2014) (13, Calendar.December, 2014) [Calendar.Monday; Calendar.Wednesday])
  in
  printDateList l1; print_string "\n\n";
  printDateList l2; print_string "\n\n"

let _ = test()
