(* Record representing a faculty member *)
type faculty = {
  fname  : string;
  empNum : int;
}

let string_of_faculty { fname; empNum } = "faculty(" ^ fname ^ ", " ^ string_of_int empNum ^ ")"

(* Record representing a student *)
type student = {
  sname   : string;
  rollNum : string;
}

type course = {
  crscode     : string;
  instructors : faculty list;
}

let string_of_course { crscode; instructors } = 
  "course(" ^ crscode ^ ", " ^ (List.fold_left (fun s1 s2 -> s1 ^ ", " ^ (string_of_faculty s2)) "" instructors) ^ ")"

type lecture = { 
  crse  : course;
  venue : string;
}

let string_of_lecture { crse; venue } =
  "lecture(" ^ (string_of_course crse) ^ ", " ^ venue ^ ")"

type oclock = {
  hr  : int;
  min : int;
  sec : int;
}

let string_of_oclock t =
  (string_of_int t.hr) ^ "." ^
  (string_of_int t.min) ^ 
  (if t.sec = 0 then "" else ("." ^ string_of_int t.sec))

type duration = {
  startTime : oclock;
  endTime   : oclock;
}

let string_of_duration d =
  "(" ^ (string_of_oclock d.startTime) ^ "-" ^ (string_of_oclock d.endTime) ^ ")"

type slot = {
  weekday  : Calendar.weekDay;
  timespan : duration;
}

let string_of_slot { weekday; timespan } = "slot(" ^ (Calendar.string_of_weekday weekday) ^ ", " ^ (string_of_duration timespan) ^ ")"

type period = {
  lectures : lecture list;
  slt      : slot;
}

let string_of_period { lectures; slt } =
  "period(" ^ (List.fold_left (fun s1 s2 -> s1 ^ ", " ^ (string_of_lecture s2)) "" lectures ) ^ ", " ^ (string_of_slot slt) ^ ")"
  
type timetable = Timetable of period list

let string_of_timetable = function
  Timetable(plist) ->
    "timetable (\n" ^
    (List.fold_left (fun s1 s2 -> s1 ^ "\t" ^ (string_of_period s2) ^ "\n") "" plist) ^ ")"

exception TimetableError of string

type participant =
    Instructor of faculty
  | Student    of student
