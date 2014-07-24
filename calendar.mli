type weekDay
val nextWeekDay : weekDay -> weekDay
val prevWeekDay : weekDay -> weekDay
val string_of_weekday : weekDay -> string

type month
val daysInMonth : month -> int -> int
val nextMonth : month -> month
val string_of_month : month -> string

val nextDate : int * month * int -> int * month * int
val isLater : 'a * 'b * 'c -> 'a * 'b * 'c -> bool
val string_of_date : int * month * int -> string

val isLeapYear : int -> bool
