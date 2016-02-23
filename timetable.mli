type faculty = { fname : string; empNum : int; }

type student = { sname : string; rollNum : string; }

type course = { crscode : string; instructors : faculty list; }

type lecture = { crse : course; venue : string; }

type oclock = { hr : int; min : int; sec : int; }

type duration = { startTime : oclock; endTime : oclock; }

type slot = { weekday : Calendar.weekDay; timespan : duration; }

type period = { lectures : lecture list; slt : slot; }

type timetable = Timetable of period list

exception TimetableError of string

type participant = Instructor of faculty | Student of student

val string_of_oclock : oclock -> string

val string_of_duration : duration -> string

val readFacultyList : string -> (string, int) Hashtbl.t

val readHolidayList : string -> Lecture.calendarday list

val weekday_of_string : string -> Calendar.weekDay

val readTimetable : string -> timetable

val mapCourseToWeekdays : timetable -> (course, Calendar.weekDay) Hashtbl.t

val getCourseList : timetable -> course list list

val getLectureDatesAllCourses :
  course list ->
  (course, Calendar.weekDay) Hashtbl.t ->
  Lecture.semester ->
  Lecture.calendarday list ->
  (course, (Lecture.calendarday * Calendar.weekDay) list) Hashtbl.t
