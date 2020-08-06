(*
  This file contains an example of application of the calendar library. The objective of this program
  is to print the list of dates (along with their weekdays) on which the lectures of a particular
  course will be held. Inputs to this program are: the duration of the semester in terms of its 
  starting and ending dates, and the week days on which the lectures are held for the course.
  See test cases at the bottom of the file for examples.
*)

(* DATA DEFINITIONS *)
(*
The calendarday type may be either a single holiday or a vacation having a range of contiguous dates.
*)

(* #use "calendar.ml" *)

type calendarday =
    Working  of Calendar.date
  | Holiday  of Calendar.date * string
  | Vacation of Calendar.date * Calendar.date * string

type semester = {
  semStartDate : Calendar.date;
  semEndDate   : Calendar.date
}

exception LectureException of string

(* Functions *)
(*
  Given a pair (d, wd) where d is a date and wd is a weeday, return its string representation.
  Example:
    ((2, January, 2014), Thursday) --> "January 2, 2014, Thursday"
*)
let string_of_date_weekday (d, wd) =
  (Calendar.string_of_date d) ^ ", " ^ (Calendar.string_of_weekday wd)

let string_of_calendarday = function
    Working(d) -> (Calendar.string_of_date d)
  | Holiday(d, msg) -> ("(" ^ (Calendar.string_of_date d) ^ ", " ^ msg ^ ")")
  | Vacation(s, e, msg) -> ("(" ^ (Calendar.string_of_date s) ^ " - " ^ (Calendar.string_of_date e) ^ ", " ^ msg ^ ")")

let string_of_calendarday_weekday cd wd =
  ("(" ^ (string_of_calendarday cd) ^ ", " ^ Calendar.string_of_weekday wd ^ ")") 
(*
  Given a list of calendardays, return a list that contains only individual calendardays, i.e., all instances of
  Vacation are replaced with Holiday.
*)
let flattenCalendarDayList hlist =
  let flatten d =
    match d with
    Working(_)
  | Holiday(_, _)       -> [d]
  | Vacation(d1, d2, s) -> (List.map (fun d -> Holiday(d, s)) (Calendar.dateRange d1 d2))
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

let printCalendardayWeekdayList l =
    List.iter (fun d -> let (cd, wd) = d in (print_string ((string_of_calendarday_weekday cd wd) ^ "\n"))) l

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
let getLectureDates sem lec =
  let d1 = sem.semStartDate and d2 = sem.semEndDate in
  let f lst =
    List.filter (fun (_, wd) -> List.mem wd lec) lst
  in
    let dr (d1', d2') = (Calendar.dateRange d1' d2')
    in
  (dr |> weekdayMap |> f) (d1, d2)

(*
  Given:
    1) a semester sem
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

let getLectureDatesWithoutHolidayList sem lec hlist =
  let ldates = (getLectureDates sem lec)
  and hlist' = (flattenCalendarDayList hlist)
  in
    let f = function
      Holiday(d, s) -> d
    | Working(_)
    | Vacation(_, _, _) -> raise (LectureException "getLectureDatesWithoutHolidayList : All calendardays passed to this function must all be of the type Holiday(_)")
    in
    let hdlist = (List.map f hlist') (* Holiday list without message *)
    in
    (List.filter (fun (d, _) -> (not (List.mem d hdlist))) ldates)

let getLectureDatesWithHolidayList sem lec hlist =
  let ldates = (getLectureDates sem lec)
  and hlist' = (flattenCalendarDayList hlist)
  in
    let o_or_h (d, wd) = (* Office day or holiday *)
      let rec iter d' = function
          [] -> (Working(d'), wd)
        | Holiday(d, msg) :: t -> if d = d' then (Holiday(d, msg), wd) else iter d' t
        | _ -> raise (LectureException "getLectureDatesWithHolidayList : All calendardays passed to this function must all be of the type Holiday(_)")
      in
      iter d hlist'
  in
  (List.map o_or_h ldates)

let getLectureDatesWithoutHolidayList sem lec hlist =
  let ldates = (getLectureDates sem lec)
  and hlist' = (flattenCalendarDayList hlist)
  in
    let f = function
      Holiday(d, s) -> d
    | Working(_)
    | Vacation(_, _, _) -> raise (LectureException "getLectureDatesWithoutHolidayList : All calendardays passed to this function must all be of the type Holiday(_)")
    in
    let hdlist = (List.map f hlist') (* Holiday list without message *)
    in
    (List.filter (fun (d, wd) -> (not (List.mem d hdlist))) ldates)


        
(*
[Date: 03 Jan. 2017]
To generate lecture plan:
On the OCaml top-level ...
#load "Calendar.cmo";;
# use "lecture.ml";;
*)

(* TEST CASES *)
(*
let spring2014IIITB = { semStartDate = Calendar.Date(2, Calendar.January, 2014); semEndDate = Calendar.Date(30, Calendar.May, 2014)}
let autumn2014IIITB = { semStartDate = Calendar.Date(4, Calendar.August, 2014) ; semEndDate = Calendar.Date(13, Calendar.December, 2014)}
let spring2015IIITB = { semStartDate = Calendar.Date(1, Calendar.January, 2015); semEndDate = Calendar.Date(3, Calendar.May, 2015)}
*)
let autumn2015IIITB = { semStartDate = Calendar.Date(3, Calendar.August, 2015) ; semEndDate = Calendar.Date(6, Calendar.December, 2015)}

let holidayList2015IIITB = [
  Holiday(Calendar.Date(14, Calendar.January, 2015),   "Makar Sankranti");
  Holiday(Calendar.Date(26, Calendar.January, 2015),   "Republic Day");
  Holiday(Calendar.Date(17, Calendar.February, 2015),  "Mahashivaratri");
  Holiday(Calendar.Date(3, Calendar.April, 2015),      "Good Friday");
  Holiday(Calendar.Date(1, Calendar.May, 2015),        "May Day");
  Holiday(Calendar.Date(17, Calendar.September, 2015), "Ganesh Chaturthi");
  Holiday(Calendar.Date(2, Calendar.October, 2015),    "Gandhi Jayanti");
  Holiday(Calendar.Date(21, Calendar.October, 2015),   "Ayudha Puja");
  Holiday(Calendar.Date(22, Calendar.October, 2015),   "Vijaya Dashami");
  Holiday(Calendar.Date(11, Calendar.November, 2015),  "Deepawali");
  Holiday(Calendar.Date(24, Calendar.December, 2015),  "Milad-Un-Nabi");
  Holiday(Calendar.Date(25, Calendar.December, 2015),  "Christmas");
  Vacation(Calendar.Date(23, Calendar.February, 2015), Calendar.Date(9, Calendar.March, 2015), "Spring Mid-term Break");
  Vacation(Calendar.Date(4, Calendar.May, 2015), Calendar.Date(31, Calendar.May, 2015),        "Summer Break");
  Vacation(Calendar.Date(18, Calendar.October, 2015), Calendar.Date(25, Calendar.October, 2015), "Spring Mid-term Break");
]

let autumn2016IIITB = { semStartDate = Calendar.Date(2, Calendar.August, 2016) ; semEndDate = Calendar.Date(5, Calendar.December, 2016)}

let holidayList2016IIITB = [
  Holiday(Calendar.Date(15, Calendar.January, 2016  ), "Makara Sankranti"   );
  Holiday(Calendar.Date(26, Calendar.January, 2016  ), "Republic Day"       );
  Holiday(Calendar.Date(7,  Calendar.March, 2016    ), "Maha Shivarathri"   );
  Holiday(Calendar.Date(25, Calendar.March, 2016    ), "Good Friday"        );
  Holiday(Calendar.Date(8,  Calendar.April, 2016    ), "Ugadi"              );
  Holiday(Calendar.Date(6,  Calendar.July, 2016     ), "Ramzan"             );
  Holiday(Calendar.Date(15, Calendar.August, 2016   ), "Independence day"   );
  Holiday(Calendar.Date(5,  Calendar.September, 2016), "Ganesh Chaturthi"   );
  Holiday(Calendar.Date(10, Calendar.October, 2016  ), "Ayudhapuja"         );
  Holiday(Calendar.Date(11, Calendar.October, 2016  ), "Vijaya Dashami"     );
  Holiday(Calendar.Date(31, Calendar.October, 2016  ), "Balipadyami"        );
  Holiday(Calendar.Date(1,  Calendar.November, 2016 ), "Kannada Rajyothsava");
]

let spring2017IIITB = { semStartDate = Calendar.Date(2, Calendar.January, 2017) ; semEndDate = Calendar.Date(30, Calendar.April, 2017)}

let holidayList2017IIITB = [
  Holiday(Calendar.Date(26, Calendar.January, 2017  ), "Republic Day"       );
  Holiday(Calendar.Date(14,  Calendar.February, 2017    ), "Maha Shivarathri"   );
  Holiday(Calendar.Date(14, Calendar.April, 2017    ), "Good Friday"        );
  Holiday(Calendar.Date(26,  Calendar.June, 2017     ), "Ramzan"             );
  Holiday(Calendar.Date(15, Calendar.August, 2017   ), "Independence day"   );
  Holiday(Calendar.Date(25,  Calendar.August, 2017), "Ganesh Chaturthi"   );
  Holiday(Calendar.Date(29, Calendar.September, 2017  ), "Durga Puja/Mahanavami"         );
  Holiday(Calendar.Date(2, Calendar.October, 2017  ), "Gandhi Jayanti"         );
  Holiday(Calendar.Date(19, Calendar.October, 2017  ), "Diwali"        );
  Holiday(Calendar.Date(20, Calendar.October, 2017  ), "Balipadyami"        );
  Holiday(Calendar.Date(1,  Calendar.November, 2017 ), "Kannada Rajyothsava");
  Holiday(Calendar.Date(1,  Calendar.November, 2017 ), "Christmas");
]


(*
let pl2014 = (getLectureDates spring2014IIITB [Calendar.Monday; Calendar.Friday])
let py2014 = (getLectureDates autumn2014IIITB [Calendar.Monday; Calendar.Wednesday])
let st2015 =
    (getLectureDatesWithHolidayList spring2015IIITB [Calendar.Tuesday; Calendar.Thursday] holidayList2015IIITB) (* Software Testing Spring 2015 *)

let sriganesh_spr_2015 =
    (getLectureDatesWithoutHolidayList spring2015IIITB [Calendar.Tuesday] holidayList2015IIITB) (* PE with Sriganesh and Rishab, Spring 2015 *)
let sriganesh_aut_2015 =
    (getLectureDatesWithoutHolidayList autumn2015IIITB [Calendar.Tuesday] holidayList2015IIITB) (* PE with Sriganesh and Rishab, Spring 2015 *)

let py2015 = (getLectureDatesWithoutHolidayList autumn2015IIITB [Calendar.Thursday; Calendar.Friday] holidayList2015IIITB)
let java_aut_2015 = (getLectureDatesWithoutHolidayList autumn2015IIITB [Calendar.Monday; Calendar.Tuesday] holidayList2015IIITB)
let py2016 = (getLectureDatesWithoutHolidayList autumn2016IIITB [Calendar.Monday; Calendar.Tuesday; Calendar.Friday] holidayList2016IIITB)
let compiler2016 = (getLectureDatesWithoutHolidayList autumn2016IIITB [Calendar.Thursday; Calendar.Friday] holidayList2016IIITB)
let compiler_samsung_2016 = (getLectureDatesWithoutHolidayList autumn2016IIITB [Calendar.Saturday] holidayList2016IIITB)
*) 
let pl_2017 = (getLectureDatesWithoutHolidayList spring2017IIITB [Calendar.Tuesday; Calendar.Wednesday] holidayList2017IIITB)
(*
let test () =
  printDateList l1; print_string "\n\n";
  printDateList l2; print_string "\n\n";
  printCalendardayWeekdayList st2015; print_string "\n\n";
  printDateWeekdayList sriganesh2015; print_string "\n\n"
  printDateWeekdayList py2015; print_string "\n\n";
  printDateWeekdayList sriganesh_aut_2015; print_string "\n\n";
  printDateWeekdayList java_aut_2015; print_string "\n\n"
*)

(* let _ = test() *)
