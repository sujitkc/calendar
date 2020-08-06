type calendarday =
    Working of Calendar.date
  | Holiday of Calendar.date * string
  | Vacation of Calendar.date * Calendar.date * string

type semester = {
  semStartDate : Calendar.date;
  semEndDate   : Calendar.date
}

exception LectureException of string

val string_of_calendarday : calendarday -> string

val string_of_date_weekday : Calendar.date * Calendar.weekDay -> string

val flattenCalendarDayList : calendarday list -> calendarday list

val weekdayMap : Calendar.date list -> (Calendar.date * Calendar.weekDay) list

val printDateWeekdayList : (Calendar.date * Calendar.weekDay) list -> unit

val getLectureDates : semester -> Calendar.weekDay list -> (Calendar.date * Calendar.weekDay) list

val getLectureDatesWithoutHolidayList : semester -> Calendar.weekDay list -> calendarday list -> (Calendar.date * Calendar.weekDay) list

val getLectureDatesWithHolidayList : semester -> Calendar.weekDay list -> calendarday list -> (calendarday * Calendar.weekDay) list
