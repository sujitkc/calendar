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

(*
  Given two dates d1 and d2, and a list lec of weekdays on which the lectures are 
  to be held, return the list of pairs (date, weekday) for each lecture day.
  Example:
    getLectureDates
      (2, Calendar.January, 2014)
      (15, Calendar.January, 2014)
      [Calendar.Monday; Calendar.Friday];;
    --> [((2, Calendar.January, 2014), Calendar.Friday);
      ((6, Calendar.January, 2014), Calendar.Monday);
      ((9, Calendar.January, 2014), Calendar.Friday);
      ((13, Calendar.January, 2014), Calendar.Monday)] 
*)
let getLectureDates d1 d2 lec =
  let f lst =
    List.filter (fun (_, wd) -> List.mem wd lec) lst
  in
    let dr (d1', d2') = (Calendar.dateRange d1' d2')
    in
  (dr |> weekdayMap |> f) (d1, d2)

(* TEST CASES *)
let printDateList l =
    List.iter (fun s -> (print_string (string_of_date_weekday s ^ "\n"))) l

let test () =
  let 
  (* l1 = (getLectureDates (2, Calendar.January, 2014) (30, Calendar.May, 2014) [Calendar.Monday; Calendar.Friday])
  and l2 = (getLectureDates (4, Calendar.August, 2014) (13, Calendar.December, 2014) [Calendar.Monday; Calendar.Wednesday])
  and *)
  l3 = (getLectureDates (1, Calendar.January, 2015) (3, Calendar.May, 2015) [Calendar.Tuesday; Calendar.Thursday])
  in
(*
  printDateList l1; print_string "\n\n";
  printDateList l2; print_string "\n\n";
*)
  printDateList l3; print_string "\n\n"

let _ = test()
