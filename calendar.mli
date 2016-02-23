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
val weekday_of_string: string -> weekDay

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

type date = Date of int * month * int

val daysInMonth : month -> int -> int
val nextMonth : month -> month
val string_of_month : month -> string

val nextDate : date -> date
val isLater : date -> date -> bool
val string_of_date : date -> string

val getWeekDay : date -> weekDay
val dateRange : date -> date -> date list
val isLeapYear : int -> bool
