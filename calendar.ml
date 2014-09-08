type month =
    January
  | February
  | March
  | April
  | May
  | June
  | July
  | August
  | September
  | October
  | November
  | December 

type weekDay =
    Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday

let nextWeekDay = function
    Sunday    -> Monday
  | Monday    -> Tuesday
  | Tuesday   -> Wednesday
  | Wednesday -> Thursday
  | Thursday  -> Friday
  | Friday    -> Saturday
  | Saturday  -> Sunday

let prevWeekDay = function
    Sunday    -> Saturday
  | Monday    -> Sunday
  | Tuesday   -> Monday
  | Wednesday -> Tuesday
  | Thursday  -> Wednesday
  | Friday    -> Thursday
  | Saturday  -> Friday

let string_of_weekday = function
    Sunday    -> "Sunday"
  | Monday    -> "Monday"
  | Tuesday   -> "Tuesday"
  | Wednesday -> "Wednesday"
  | Thursday  -> "Thursday"
  | Friday    -> "Friday"
  | Saturday  -> "Saturday"

(*
  Given a year y, return true if y is a leap year; false otherwise.
  Example:
    2000 --> true
    2001 --> false
    2012 --> true
    1900 --> false
*)
let isLeapYear y =
  if (y mod 100) = 0 then
    (y mod 400) = 0
  else
    (y mod 4) = 0

let daysInMonth m y =
  match m with
    January   -> 31
  | February  -> if(isLeapYear y) then 29 else 28
  | March     -> 31
  | April     -> 30
  | May       -> 31
  | June      -> 30
  | July      -> 31
  | August    -> 31
  | September -> 30
  | October   -> 31
  | November  -> 30
  | December  -> 31

let nextMonth m =
  match m with
    January   -> February
  | February  -> March
  | March     -> April
  | April     -> May
  | May       -> June
  | June      -> July
  | July      -> August
  | August    -> September
  | September -> October
  | October   -> November
  | November  -> December
  | December  -> January

let string_of_month = function
    January   -> "January"
  | February  -> "February"
  | March     -> "March"
  | April     -> "April"
  | May       -> "May"
  | June      -> "June"
  | July      -> "July"
  | August    -> "August"
  | September -> "September"
  | October   -> "October"
  | November  -> "November"
  | December  -> "December"

let string_of_date (d, m, y) =
  (string_of_month m) ^ " " ^ (string_of_int d) ^ ", " ^ (string_of_int y)

(*
  Given a date, return its next date.
  Example:
    (1, January, 2014)   --> (2, January, 2014)
    (31, December, 2013) --> (1, January, 2014)
    (28, February, 2013) --> (1, March, 2013)
    (28, February, 2012) --> (29, February, 2012)
*)
let nextDate (d, m, y) =
  if d = (daysInMonth m y) then
    if(m = December) then
      (1, January, y + 1)
    else
      (1, (nextMonth m), y)
  else
    (d + 1, m, y)

(*
  Given two dates dd1 and dd2, return true if dd1 is strictly later than dd2
  Example:
    (1, January, 2014) (1, January, 2014)   --> false
    (1, January, 2014) (2, January, 2014)   --> false
    (1, January, 2014) (31, December, 2013) --> false
*)
let isLater (d1, m1, y1) (d2, m2, y2) =
  if y1 = y2 then
    if m1 = m2 then
      d1 > d2
    else if m1 > m2 then true
    else false
  else if y1 > y2 then true
  else false

(*
  Given two dates d1 and d2, count how many days elapse between the two.
  Whether d1 occurs later than d2 shouldn't matter.
  Example:
    (1, January, 2014) (1, January, 2014) --> 0
    (1, January, 2014) (2, January, 2014) --> 1
    (1, January, 2014) (31, December, 2013) --> -1
*)
let rec daysInBetween d1 d2 =
  let rec iter d1 d2 n =
    if d1 = d2 then
      n
    else
      (iter (nextDate d1) d2 (n + 1))
  in
    if (isLater d1 d2) then
      -(daysInBetween d2 d1)
    else (iter d1 d2 0)

(*
  Given a weekday wd and a number n, return the weekday of the date
  n days after a wd.
*)
let countWeekDays wd n =
  let rec aux wd n =
      if n = 0 then wd
      else if n > 0 then aux (nextWeekDay wd) (n - 1)
      else               aux (prevWeekDay wd) (n + 1)
  and n' = n mod 7
  in
  aux wd n'

let getWeekDay d =
  let refDate = (21, July, 2014)
  and refWeekDay = Monday
  in
    let delta = daysInBetween refDate d
    in
      let deltaWeekDay = delta mod 7
      in
        countWeekDays refWeekDay deltaWeekDay

(*
  Given two dates d1 and d2, return the list of all dates from d1 to d2, d1 and d2 included.
  Example:
    (1, January, 2014) (5, January, 2014) -->
      [(1, January, 2014); (2, January, 2014); (3, January, 2014);
       (4, January, 2014); (5, January, 2014)]
*)
let rec dateRange d1 d2 =
  let rec iter d1' d2' range =
    if (isLater d1' d2') then (dateRange d2' d1')
    else if (d1' = d2') then (d2' :: range)
    else (iter (nextDate d1') d2' (d1' :: range))
  in
  (List.rev (iter d1 d2 []))
