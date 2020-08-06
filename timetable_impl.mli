val readFacultyList : string -> (string, int) Hashtbl.t

val readHolidayList : string -> Lecture.calendarday list

val readTimetable : string -> Timetable.timetable

val mapCourseToWeekdays : Timetable.timetable -> (Timetable.course, Calendar.weekDay) Hashtbl.t

val getCourseList : Timetable.timetable -> Timetable.course list list

val getLectureDatesAllCourses :
  Timetable.course list ->
  (Timetable.course, Calendar.weekDay) Hashtbl.t ->
  Lecture.semester ->
  Lecture.calendarday list ->
  (Timetable.course, (Lecture.calendarday * Calendar.weekDay) list) Hashtbl.t
