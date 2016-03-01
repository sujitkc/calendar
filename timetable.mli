type faculty = { fname : string; empNum : int; }
val string_of_faculty : faculty -> string

type student = { sname : string; rollNum : string; }

type course = { crscode : string; instructors : faculty list; }
val string_of_course : course -> string

type lecture = { crse : course; venue : string; }
val string_of_lecture : lecture -> string

type oclock = { hr : int; min : int; sec : int; }
val string_of_oclock : oclock -> string

type duration = { startTime : oclock; endTime : oclock; }
val string_of_duration : duration -> string

type slot = { weekday : Calendar.weekDay; timespan : duration; }
val string_of_slot : slot -> string

type period = { lectures : lecture list; slt : slot; }
val string_of_period : period -> string

type timetable = Timetable of period list
val string_of_timetable : timetable -> string

exception TimetableError of string

type participant = Instructor of faculty | Student of student

