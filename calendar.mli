type weekDay =
    Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
val nextWeekDay : weekDay -> weekDay
val prevWeekDay : weekDay -> weekDay
val string_of_weekday : weekDay -> string

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
val daysInMonth : month -> int -> int
val nextMonth : month -> month
val string_of_month : month -> string

val nextDate : int * month * int -> int * month * int
val isLater : 'a * 'b * 'c -> 'a * 'b * 'c -> bool
val string_of_date : int * month * int -> string

val getWeekDay : int * month * int -> weekDay
val dateRange : int * month * int -> int * month * int -> (int * month * int) list
val isLeapYear : int -> bool
