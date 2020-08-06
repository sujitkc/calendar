let readFacultyList (fn : string) : (string, int) Hashtbl.t =
  let parseRow = function
      [ fname; fnum_str ] -> { Timetable.fname = fname; Timetable.empNum = (int_of_string fnum_str) }
    | _ -> raise (Timetable.TimetableError ("readFacultyList: malformed row '"))
  and flist_csv = Csv.load fn in
  let flist = (List.map parseRow flist_csv)
  and ftable = Hashtbl.create 30 in
  List.iter (fun { Timetable.fname; Timetable.empNum } -> (Hashtbl.add ftable fname empNum)) flist;
  ftable

(* Given a name fn of file containing the holiday list, return a list of calendar days
  representing the holiday list *)
let readHolidayList (fn : string) : Lecture.calendarday list =
  let parseRow row =
    let prunedRow = (List.filter (fun s -> s <> "") row) in
      match prunedRow with
        [str_cd; msg] ->
        begin
        try
          let lexbuf = Lexing.from_string str_cd in
          let parsed = Ttparser.calendarday Lexer.scan lexbuf in
            match parsed with
              Lecture.Holiday(h, _) -> Lecture.Holiday(h, msg)
            | Lecture.Vacation(s, e, _) -> Lecture.Vacation(s, e, msg)
            | _ -> raise (Timetable.TimetableError ("*^#*&^@"))
        with Failure(f) ->
          print_string (f ^ str_cd); exit(0)
        end
      | _ ->
        raise (Timetable.TimetableError (
          "holiday list csv not well-formed. Read a row with length " ^
          (string_of_int (List.length row)) ^
          ". Make sure the rows have either 3 or 6 columns."
        ))
  and hlist = Csv.load fn
  in
  List.map parseRow hlist

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
let readTimetable (fn : string) : Timetable.timetable =
  let slottable = Hashtbl.create 30 in
  let faculty_table = readFacultyList "data/s2015/faculty.csv" in
  let parseRow (ttrow : string list) : unit =
    let sltlist = 
      let lexbuf = Lexing.from_string (List.nth ttrow 4) in
        Ttparser.slots Lexer.scan lexbuf
  and lec =
      let crse =
        let courseCode = List.nth ttrow 0
        and facList =
          let instrList  = (Str.split (Str.regexp_string "/") (List.nth ttrow 2)) in
            (List.map (
                fun i ->
                  try
                  {
                      Timetable.fname = i;
                      Timetable.empNum = (Hashtbl.find faculty_table i)
                   
                  } with Not_found -> print_string i; exit(0)
              ) instrList)
          in
          { 
            Timetable.crscode = courseCode;
            Timetable.instructors = facList
          } (* crse : course *)
      and venue      = List.nth ttrow 3 in
      {
        Timetable.crse = crse;
        Timetable.venue = venue
      }
    in (* lec : lecture *)
    List.iter (fun slt -> Hashtbl.add slottable slt lec) sltlist (* Add the slot 'slt' to the slot list against the lecture 'lec' *)
  and tt_csv = Csv.load fn
  in
  (List.iter parseRow tt_csv);
  let slotList = (removeDuplicates (Hashtbl.fold (fun k v acc -> k :: acc) slottable [])) in
  let plist = List.map
    (
      fun slt -> {
        Timetable.lectures = (Hashtbl.find_all slottable slt);
        Timetable.slt = slt }
    ) slotList
  in
  Timetable.Timetable(plist)
 
(* Given a timetable, return a map from course to week days. *)
let mapCourseToWeekdays (tt : Timetable.timetable) =
  let Timetable.Timetable(plst) = tt and table = Hashtbl.create 50 in (* table : hashtable: course -> weekday *)
  List.iter (* Iterate over the list of periods in timetable tt. *)
  (
    fun p ->
      let llst = p.Timetable.lectures and wd = p.Timetable.slt.Timetable.weekday in
        List.iter (fun l -> (Hashtbl.add table l.Timetable.crse wd)) llst;
  ) plst;
  table

(* Given timetable tt, return the list of courses. *)
let getCourseList (tt : Timetable.timetable) =
  let Timetable.Timetable(plst) = tt in
  let crses = List.map (
    fun p ->
      let llst = p.Timetable.lectures in
      (List.map (fun l -> l.Timetable.crse) llst)
  ) plst in
  removeDuplicates crses

(*
  Given:
  - crslist: a list of courses
  - cwdmap : course to weekday map
  - hlist  : a list of holidays
  Return a map from courses to lecture dates.
*)
let getLectureDatesAllCourses (crslist : Timetable.course list) cwdmap sem (hlist : Lecture.calendarday list) =
  let table = Hashtbl.create 30 in
  List.iter
  (
    fun c ->
      let wd = Hashtbl.find_all cwdmap c in
      Hashtbl.add table c (Lecture.getLectureDatesWithHolidayList sem wd hlist);
  ) crslist;
  table
