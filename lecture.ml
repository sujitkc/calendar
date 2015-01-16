(*
  This file contains an example of application of the calendar library. The objective of this program
  is to print the list of dates (along with their weekdays) on which the lectures of a particular
  course will be held. Inputs to this program are: the duration of the semester in terms of its 
  starting and ending dates, and the week days on which the lectures are held for the course.
  See test cases at the bottom of the file for examples.
*)

(* DATA DEFINITIONS *)
(*
The holidays type may be either a single holiday or a vacation having a range of contiguous dates.
*)
type holidays =
    Holiday  of (int * Calendar.month * int)
  | Vacation of (int * Calendar.month * int) * (int * Calendar.month * int) 

(*
  Given a pair (d, wd) where d is a date and wd is a weeday, return its string representation.
  Example:
    ((2, January, 2014), Thursday) --> "January 2, 2014, Thursday"
*)
let string_of_date_weekday (d, wd) =
  (Calendar.string_of_date d) ^ ", " ^ (Calendar.string_of_weekday wd)


let flattenHolidayList hlist =
  let flatten = function
    Holiday(h)       -> [h]
  | Vacation(d1, d2) -> (Calendar.dateRange d1 d2)
  in
  let rec iter acc = function
     []       -> acc
   | hol :: t -> (iter (acc @ (flatten hol)) t)
  in
  iter [] hlist

(*
  Given a list lst of dates, return a list where each element is a date in the lst, coupled with its weekday.
  Example:
     [(2, January, 2014); (3, January, 2014)]--> [((2, January, 2014), Thursday); ((3, January, 2014), Friday)]
*)
let weekdayMap lst =
  List.map (fun d -> (d, (Calendar.getWeekDay d))) lst

let (|>) f g x = g(f x)

let printDateList l =
    List.iter (fun s -> (print_string (Calendar.string_of_date s ^ "\n"))) l

let printDateWeekdayList l =
    List.iter (fun s -> (print_string (string_of_date_weekday s ^ "\n"))) l

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

(*
  Given:
    1) two dates d1 and d2
    2) a list lec of weekdays on which the lectures are to be held
    3) A holiday list,
  Return: the list of pairs (date, weekday) for each lecture day.
  Example:
    getLectureDatesWithHolidayList            
      (2, Calendar.January, 2014)
      (15, Calendar.January, 2014)
      [Calendar.Monday; Calendar.Friday]
      [ Vacation((6, Calendar.January, 2014), (10, Calendar.January, 2014));
        Holiday(13, Calendar.January, 2014)
      ];;
    --> [((3, Calendar.January, 2014), Calendar.Friday)]
*)

let getLectureDatesWithHolidayList d1 d2 lec hlist =
  let ldates = (getLectureDates d1 d2 lec)
  and hlist' = (flattenHolidayList hlist)
  in
    begin
      print_string "Holidays - begin\n";
      printDateList hlist';
      print_string "Holidays - end\n";
      (List.filter (fun (d, wd) -> (not (List.mem d hlist'))) ldates)
    end

(* TEST CASES *)
let spring2014IIITB = ((2, Calendar.January, 2014), (30, Calendar.May, 2014))
let autumn2014IIITB = ((4, Calendar.August, 2014) , (13, Calendar.December, 2014))
let spring2015IIITB = ((1, Calendar.January, 2015), (3, Calendar.May, 2015))

let holidayList2015IIITB = [
  Holiday(14, Calendar.January, 2015);
  Holiday(26, Calendar.January, 2015);
  Holiday(17, Calendar.February, 2015);
  Holiday(3, Calendar.April, 2015);
  Holiday(1, Calendar.May, 2015);
  Holiday(17, Calendar.September, 2015);
  Holiday(2, Calendar.October, 2015);
  Holiday(21, Calendar.October, 2015);
  Holiday(22, Calendar.October, 2015);
  Holiday(11, Calendar.November, 2015);
  Holiday(24, Calendar.December, 2015);
  Holiday(25, Calendar.December, 2015);
  Vacation((23, Calendar.February, 2015), (9, Calendar.March, 2015));
  Vacation((4, Calendar.May, 2015), (31, Calendar.May, 2015))
]

let pl2014 = (getLectureDates (2, Calendar.January, 2014) (30, Calendar.May, 2014) [Calendar.Monday; Calendar.Friday])
let py2014 = (getLectureDates (4, Calendar.August, 2014) (13, Calendar.December, 2014) [Calendar.Monday; Calendar.Wednesday])
let st2015 =
  let (d1, d2) = spring2015IIITB
  in
    (getLectureDatesWithHolidayList d1 d2 [Calendar.Tuesday; Calendar.Thursday] holidayList2015IIITB) (* Software Testing Spring 2015 *)

let sriganesh2015 =
  let (d1, d2) = spring2015IIITB
  in
    (getLectureDatesWithHolidayList d1 d2 [Calendar.Tuesday] holidayList2015IIITB) (* PE with Sriganesh and Rishab, Spring 2015 *)
 
let test () =
(*
  printDateList l1; print_string "\n\n";
  printDateList l2; print_string "\n\n";
  printDateWeekdayList st2015; print_string "\n\n";
*)
  printDateWeekdayList sriganesh2015; print_string "\n\n"

let _ = test()
