(* Record representing a faculty member *)
type faculty = {
  fname  : string;
  empNum : int;
}

(* Record representing a student *)
type student = {
  sname   : string;
  rollNum : string;
}

type course = {
  crscode     : string;
  instructors : faculty list;
}

type lecture = { 
  crse  : course;
  venue : string;
}

type oclock = {
  hr  : int;
  min : int;
  sec : int;
}

type duration = {
  startTime : oclock;
  endTime   : oclock;
}

type slot = {
  weekday  : Calendar.weekDay;
  timespan : duration;
}

type period = {
  lectures : lecture list;
  slt      : slot;
}

type timetable = Timetable of period list

exception TimetableError of string

type participant =
    Instructor of faculty
  | Student    of student


(* To String Functions *)
let string_of_oclock t =
  (string_of_int t.hr) ^ ":" ^
  (string_of_int t.min) ^ 
  (if t.sec = 0 then "" else (":" ^ string_of_int t.sec))

let string_of_duration d =
  "(" ^ (string_of_oclock d.startTime) ^ "-" ^ (string_of_oclock d.endTime) ^ ")"

let readFacultyList (fn : string) : (string, int) Hashtbl.t =
  let parseRow = function
      [ fname; fnum_str ] -> { fname = fname; empNum = (int_of_string fnum_str) }
    | _ -> raise (TimetableError ("readFacultyList: malformed row '"))
  and flist_csv = Csv.load fn in
  let flist = (List.map parseRow flist_csv)
  and ftable = Hashtbl.create 30 in
  List.iter (fun { fname; empNum } -> (Hashtbl.add ftable fname empNum)) flist;
  ftable

(* Given a name fn of file containing the holiday list, return a list of calendar days
  representing the holiday list *)
let readHolidayList (fn : string) : Lecture.calendarday list =
  let parseRow row =
    let parseDay sd = try (int_of_string sd) with Failure _ -> raise (TimetableError ("parseDay : invalid day field " ^ sd))
    and parseMonth sm =
      match sm with 
        "January"   -> Calendar.January
      | "February"  -> Calendar.February
      | "March"     -> Calendar.March
      | "April"     -> Calendar.April
      | "May"       -> Calendar.May
      | "June"      -> Calendar.June
      | "July"      -> Calendar.July
      | "August"    -> Calendar.August
      | "September" -> Calendar.September
      | "October"   -> Calendar.October
      | "November"  -> Calendar.November
      | "December"  -> Calendar.December
      | _           -> raise (TimetableError ("parseMonth : Invalid month string '" ^ sm ^ "'"))
    and parseYear sy = try (int_of_string sy) with Failure _ -> raise (TimetableError ("parseYear : invalid day field " ^ sy))
    in
    let parseHoliday str_d str_m str_y msg =
      let d = (parseDay str_d)
      and m = (parseMonth str_m)
      and y = (parseYear str_y) in
      Lecture.Holiday(Calendar.Date(d, m, y), msg)
    and parseVacation str_d1 str_m1 str_y1 str_d2 str_m2 str_y2 msg =
      let d1 = (parseDay str_d1)
      and m1 = (parseMonth str_m1)
      and y1 = (parseYear str_y1)
      and d2 = (parseDay str_d2)
      and m2 = (parseMonth str_m2)
      and y2 = (parseYear str_y2) in
      let startDate = Calendar.Date(d1, m1, y1) 
      and endDate = Calendar.Date(d2, m2, y2) in
      Lecture.Vacation(startDate, endDate, msg)
    and prunedRow = (List.filter (fun s -> s <> "") row) in
    match prunedRow with
      [sd; sm; sy; msg] ->
      begin
(*        (print_string (sd ^ " " ^ sm ^ " " ^ sy ^ msg ^ "\n"));            *)
        (parseHoliday sd sm sy msg)
      end
    | [sd1; sm1; sy1; sd2; sm2; sy2; msg] ->
      begin
(*        (print_string (sd1 ^ " " ^ sm1 ^ " " ^ sy1 ^ " " ^ sd2 ^ " " ^ sm2 ^ " " ^ sy2 ^ msg ^ "\n")); *)
        (parseVacation sd1 sm1 sy1 sd2 sm2 sy2 msg)
      end
    | _ ->
      raise (TimetableError (
        "holiday list csv not well-formed. Read a row with length " ^
        (string_of_int (List.length row)) ^
        ". Make sure the rows have either 3 or 6 columns."
      ))
  and hlist = Csv.load fn
  in
  List.map parseRow hlist

let weekday_of_string swd =
  match swd with
    "MON" -> Calendar.Monday
  | "TUE" -> Calendar.Tuesday
  | "WED" -> Calendar.Wednesday
  | "THU" -> Calendar.Thursday
  | "FRI" -> Calendar.Friday
  | "SAT" -> Calendar.Saturday
  | "SUN" -> Calendar.Sunday
  | _     -> raise (TimetableError ("weekday_of_string : Invalid weekday string " ^ swd))

(* Given a list lst, return a new list with all duplicate entries removed *)
let rec removeDuplicates lst =
  match lst with
    []
  | _ :: [] -> lst
  | h :: t  ->
    let trimmed = removeDuplicates t in
    if List.mem h trimmed then trimmed
    else h :: trimmed

(* Read the timetable from CSV file named fn *)
let readTimetable (fn : string) : timetable =
  let slottable = Hashtbl.create 30 in
  let parseRow (ttrow : string list) : unit =
    let sltlist =
      (* parser for a slot field - begin *)
      let parseSlot (sl : string) : slot =
        let wd   = weekday_of_string (String.sub sl 0 3)
        and dur =
          let st =
            let hr1  = let s = (String.sub sl 4 2) in
              try int_of_string s with
                Failure _ -> raise (TimetableError ("parseSlot : invalid value for hr1 " ^ s))
            and min1 = let s = (String.sub sl 7 2) in
              try int_of_string s with
                Failure _ -> raise (TimetableError ("parseSlot : invalid value for min1 " ^ s))
            in
            { hr = hr1; min = min1; sec = 0 }
          and et = 
            let hr2  = int_of_string (String.sub sl 10 2)
            and min2 = int_of_string (String.sub sl 13 2) in
            { hr = hr2; min = min2; sec = 0 } in
          { startTime = st; endTime = et } in
        { weekday = wd; timespan = dur } (* slot *)
      (* parser for a slot field -   end *)
      and str_slots  = List.nth ttrow 4 in
      List.map parseSlot (Str.split (Str.regexp_string ",") str_slots) (* sltlist : slot list *)
    and lec =
      let crse =
        let courseCode = List.nth ttrow 0
        and facList =
          let instrList  = (Str.split (Str.regexp_string "/") (List.nth ttrow 2)) in
            (List.map (fun i -> {fname = i; empNum = 0}) instrList) in
        { crscode = courseCode; instructors = facList } (* course *)
      and venue      = List.nth ttrow 3 in
      { crse = crse; venue = venue } in (* lec : lecture *)
    List.iter (fun slt -> Hashtbl.add slottable slt lec) sltlist
  and tt_csv = Csv.load fn
  in
  (List.iter parseRow tt_csv);
  let slotList = (removeDuplicates (Hashtbl.fold (fun k v acc -> k :: acc) slottable [])) in
  let plist = List.map (fun slt -> {lectures = (Hashtbl.find_all slottable slt); slt = slt }) slotList in
  Timetable(plist)
 
(* Given a timetable, return a map from course to week days. *)
let mapCourseToWeekdays (tt : timetable) =
  let Timetable(plst) = tt and table = Hashtbl.create 50 in (* table : hashtable: course -> weekday *)
  List.iter (* Iterate over the list of periods in timetable tt. *)
  (
    fun p ->
      let llst = p.lectures and wd = p.slt.weekday in
        List.iter (fun l -> (Hashtbl.add table l.crse wd)) llst;
  ) plst;
  table

(* Given timetable tt, return the list of courses. *)
let getCourseList (tt : timetable) =
  let Timetable(plst) = tt in
  let crses = List.map (
    fun p ->
      let llst = p.lectures in
      (List.map (fun l -> l.crse) llst)
  ) plst in
  removeDuplicates crses

(*
  Given:
  - crslist: a list of courses
  - cwdmap : course to weekday map
  - hlist  : a list of holidays
  Return a map from courses to lecture dates.
*)
let getLectureDatesAllCourses (crslist : course list) cwdmap sem (hlist : Lecture.calendarday list) =
  let table = Hashtbl.create 30 in
  List.iter
  (
    fun c ->
      let wd = Hashtbl.find_all cwdmap c in
      Hashtbl.add table c (Lecture.getLectureDatesWithHolidayList sem wd hlist);
  ) crslist;
  table
