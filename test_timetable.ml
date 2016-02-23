open Timetable

let s2015sem = {
  Lecture.semStartDate = Calendar.Date(1, Calendar.January, 2015);
  Lecture.semEndDate   = Calendar.Date(3, Calendar.May, 2015)
}

(* Timetable for semester of Spring 2015 at IIITB *)
let fSR  = { fname = "Shrisha Rao";              empNum = 1  }
let fGSR = { fname = "Srinivas Raghavan";        empNum = 2  }
let fMD  = { fname = "Meenakshi D'Souza";        empNum = 3  }
let fSS  = { fname = "Srinath Srinivasa";        empNum = 4  }
let fJSN = { fname = "Jaya Sreevalsan Nair";     empNum = 5  }
let fTKS = { fname = "T K Srikanth";             empNum = 6  }
let fAC  = { fname = "Ashish Choudhury";         empNum = 7  }
let fMVN = { fname = "Muralidhara V N";          empNum = 8  }
let fDJ  = { fname = "Dinesh J";                 empNum = 9  }
let fNS  = { fname = "Neelam Sinha";             empNum = 10 }
let fRC  = { fname = "Chandrashekar Ramanathan"; empNum = 11 }
let fVS  = { fname = "V Sridhar";                empNum = 12 }
let fSM  = { fname = "Saikat Mukherjee";         empNum = 13 }
let fJTL = { fname = "L T Jay Prakash";          empNum = 14 }
let fKVD = { fname = "Dinesha K V";              empNum = 15 }
let fSKC = { fname = "Sujit Kumar Chakrabarti";  empNum = 15 }
let fDD  = { fname = "Debabrata Das";            empNum = 16 }
let fJB  = { fname = "Jyotsna Bapat";            empNum = 17 }
let fPGP = { fname = "P G Poonacha";             empNum = 18 }
let fMR  = { fname = "Madhav Rao";               empNum = 19 }
let fSRN = { fname = "Srinath R Naidu";          empNum = 20 }
let fSS  = { fname = "Subhajit Sen";             empNum = 21 }
let fBG  = { fname = "Balwant Godara";           empNum = 22 }
let fSR  = { fname = "Subir Roy";                empNum = 23 }
let fJP  = { fname = "Joy Prabhakaran";          empNum = 24 }
let fBP  = { fname = "Balaji Parthasarathy";     empNum = 25 }
let fBA  = { fname = "Balakrishnan Ashok";       empNum = 26 }

let ts1 = let st = { hr = 9; min = 30; sec = 0 } and et = { hr = 11; min = 0; sec = 0 }
in {startTime = st; endTime = et }
    
let ts2 = let st = { hr = 11; min = 15; sec = 0 } and et = { hr = 12; min = 45; sec = 0 }
in {startTime = st; endTime = et }
    
let ts3 = let st = { hr = 14; min = 0; sec = 0 } and et = { hr = 15; min = 30; sec = 0 }
in {startTime = st; endTime = et }
    
let ts4 = let st = { hr = 15; min = 30; sec = 0 } and et = { hr = 17; min = 0; sec = 0 }
in {startTime = st; endTime = et }
    
let mon1 = { weekday = Calendar.Monday;    timespan = ts1 }
let mon2 = { weekday = Calendar.Monday;    timespan = ts2 }
let mon3 = { weekday = Calendar.Monday;    timespan = ts3 }
let mon4 = { weekday = Calendar.Monday;    timespan = ts4 }
let tue1 = { weekday = Calendar.Tuesday;   timespan = ts1 }
let tue2 = { weekday = Calendar.Tuesday;   timespan = ts2 }
let tue3 = { weekday = Calendar.Tuesday;   timespan = ts3 }
let tue4 = { weekday = Calendar.Tuesday;   timespan = ts4 }
let wed1 = { weekday = Calendar.Wednesday; timespan = ts1 }
let wed2 = { weekday = Calendar.Wednesday; timespan = ts2 }
let wed3 = { weekday = Calendar.Wednesday; timespan = ts3 }
let wed4 = { weekday = Calendar.Wednesday; timespan = ts4 }
let thu1 = { weekday = Calendar.Thursday;  timespan = ts1 }
let thu2 = { weekday = Calendar.Thursday;  timespan = ts2 }
let thu3 = { weekday = Calendar.Thursday;  timespan = ts3 }
let thu4 = { weekday = Calendar.Thursday;  timespan = ts4 }
let fri1 = { weekday = Calendar.Friday;    timespan = ts1 }
let fri2 = { weekday = Calendar.Friday;    timespan = ts2 }
let fri3 = { weekday = Calendar.Friday;    timespan = ts3 }
let fri4 = { weekday = Calendar.Friday;    timespan = ts4 }
let sat1 = { weekday = Calendar.Saturday;  timespan = ts1 }
let sat2 = { weekday = Calendar.Saturday;  timespan = ts2 }

(* Courses -- MTech Spring semester 2015 *)
let cs551  = { crscode = "CS 551";          instructors = [fSR]                   }
let cs601  = { crscode = "CS/DS 601";       instructors = [fGSR; fMD]             }
let cs604  = { crscode = "CS 604";          instructors = [fSR]                   }
let ds608  = { crscode = "DS 608";          instructors = [fSS]                   }
let cs606  = { crscode = "CS 606";          instructors = [fJSN; fTKS]            }
let cs704  = { crscode = "CS/DS 704";       instructors = [fSS]                   }
let cs812  = { crscode = "CS/DS 812";       instructors = [fGSR]                  }
let cs813  = { crscode = "CS/NC 813";       instructors = [fAC]                   }
let cs814  = { crscode = "CS 814";          instructors = [fTKS; fGSR; fAC; fMVN] }
let cs854  = { crscode = "CS/NC 854";       instructors = [fDJ; fNS]              }
let ds603  = { crscode = "DS/SE 603";       instructors = [fRC]                   }
let ds615  = { crscode = "DS/NC 615";       instructors = [fVS]                   }
let ds815  = { crscode = "DS 815";          instructors = [fSM]                   }
let se510  = { crscode = "SE 510";          instructors = [fJTL]                  }
let se601  = { crscode = "SE 601";          instructors = [fKVD]                  }
let se602  = { crscode = "SE 602";          instructors = [fSKC; fMD]             }
let nc601  = { crscode = "NC 601";          instructors = [fDD]                   }
let nc812  = { crscode = "NC 812/ESD 812";  instructors = [fJB; fDD]              }
let nc603  = { crscode = "NC 603/ESD 608";  instructors = [fPGP]                  }
let esd605 = { crscode = "ESD 605";         instructors = [fMD]                   }
let esd711 = { crscode = "ESD 711";        instructors = [fSRN]                  }
let esd704 = { crscode = "ESD 704";         instructors = [fSS]                   }
let nc805  = { crscode = "NC 805";          instructors = [fSS; fBG]              }
let esd602 = { crscode = "ESD 602";         instructors = [fSR]                   }
let esd601 = { crscode = "ESD 601";         instructors = [fSR]                   }
let esd607 = { crscode = "ESD 607/NCE 801"; instructors = [fJP]                   }
let its601 = { crscode = "ITS 601";         instructors = [fBP]                   }
let gen601 = { crscode = "GEN 601";         instructors = [fJSN]                  }
let gen602 = { crscode = "GEN 602";         instructors = [fBA]                   }

(* Lectures -- MTech Spring semester 2015 *)
let lcs551  = { crse = cs551;   venue = "309" } (* 1 *)
let lcs601  = { crse = cs601;   venue = "106" } (* 2 *) 
let lcs604  = { crse = cs604;   venue = "102" } (* 3 *)
let lds608  = { crse = ds608;   venue = "133" } (* 4 *)
let lcs606  = { crse = cs606;   venue = "132" } (* 5 *)
let lcs704  = { crse = cs704;   venue = "133" } (* 6 *)
let lcs812  = { crse = cs812;   venue = "106" } (* 7 *)
let lcs813  = { crse = cs813;   venue = "132" } (* 8 *)
let lcs814  = { crse = cs814;   venue = "102" } (* 9 *)
let lcs854  = { crse = cs854;   venue = "132" } (* 10 *)
let lds603  = { crse = ds603;   venue = "106" } (* 11 *)
let lds615  = { crse = ds615;   venue = "132" } (* 12 *)
let lds815  = { crse = ds815;   venue = "106" } (* 13 *)
let lse510  = { crse = se510;   venue = "106" } (* 14 *)
let lse601  = { crse = se601;   venue = "106" } (* 15 *)
let lse602  = { crse = se602;   venue = "133" } (* 16 *)
let lnc601  = { crse = nc601;   venue = "102" } (* 17 *)
let lnc812  = { crse = nc812;   venue = "102" } (* 18 *)
let lnc603  = { crse = nc603;   venue = "103" } (* 19 *)
let lesd605 = { crse = esd605;  venue = "310" } (* 20 *)
let lesd711 = { crse = esd711;  venue = "310" } (* 21 *)
let lesd704 = { crse = esd704;  venue = "310" } (* 22 *)
let lnc805  = { crse = nc805;   venue = "102" } (* 23 *)
let lesd602 = { crse = esd602;  venue = "310" } (* 24 *)
let lesd601 = { crse = esd601;  venue = "310" } (* 25 *)
let lesd607 = { crse = esd607;  venue = "102" } (* 26 *)
let lits601 = { crse = its601;  venue = "103" } (* 27 *)
let lgen601 = { crse = gen601;  venue = "132" } (* 28 *)
let lgen602 = { crse = gen602;  venue = "132" } (* 29 *)

(* Periods -- MTech Spring semester 2015 *)
let pmon1 = { lectures = [lcs813; lds603; lnc601; lesd704];          slt = mon1 }
let pmon2 = { lectures = [lcs551; lcs601; lcs854];                   slt = mon2 }
let pmon3 = { lectures = [lse510];                                   slt = mon3 }
let pmon4 = { lectures = [lds615; lesd602];                          slt = mon4 }
let ptue1 = { lectures = [lcs812; lnc812; lesd605];                  slt = tue1 }
let ptue2 = { lectures = [lcs604; lse602; lnc603; lesd711; lgen601]; slt = tue2 }
let ptue3 = { lectures = [lds608; lcs606; lesd601; lits601];         slt = tue3 }
let ptue4 = { lectures = [lds608; lesd607; lits601; lgen602];        slt = tue4 }
let pwed1 = { lectures = [lcs813; lds603; lnc601; lesd704];          slt = wed1 }
let pwed2 = { lectures = [lcs551; lcs601; lcs854];                   slt = wed2 }
let pwed3 = { lectures = [];                                         slt = wed3 }
let pwed4 = { lectures = [lds615];                                   slt = wed4 }
let pthu1 = { lectures = [lcs812; lnc812; lesd605];                  slt = thu1 }
let pthu2 = { lectures = [lcs604; lse602; lnc603; lesd711; lgen601]; slt = thu2 }
let pthu3 = { lectures = [lcs606; lnc805; lgen602];                  slt = thu3 }
let pthu4 = { lectures = [lse601; lesd602];                          slt = thu4 }
let pfri1 = { lectures = [lnc805];                                   slt = fri1 }
let pfri2 = { lectures = [lse510];                                   slt = fri2 }
let pfri3 = { lectures = [lcs704; lcs814; lesd601];                  slt = fri3 }
let pfri4 = { lectures = [lcs704; lesd607];                          slt = fri4 }
let psat1 = { lectures = [lse601];                                   slt = sat1 }
let psat2 = { lectures = [lcs814];                                   slt = sat2 }

(* Time-table -- MTech Spring semester 2015 *)
let ttspr15 = Timetable([
  pmon1; pmon2; pmon3; pmon4;
  ptue1; ptue2; ptue3; ptue4;
  pwed1; pwed2; pwed3; pwed4;
  pthu1; pthu2; pthu3; pthu4;
  pfri1; pfri2; pfri3; pfri4;
  psat1; psat2;
])

let holidayList2015IIITB = [
  Lecture.Holiday(Calendar.Date(14, Calendar.January, 2015),   "Makar Sankranti");
  Lecture.Holiday(Calendar.Date(26, Calendar.January, 2015),   "Republic Day");
  Lecture.Holiday(Calendar.Date(17, Calendar.February, 2015),  "Mahashivaratri");
  Lecture.Holiday(Calendar.Date(3, Calendar.April, 2015),      "Good Friday");
  Lecture.Holiday(Calendar.Date(1, Calendar.May, 2015),        "May Day");
  Lecture.Holiday(Calendar.Date(17, Calendar.September, 2015), "Ganesh Chaturthi");
  Lecture.Holiday(Calendar.Date(2, Calendar.October, 2015),    "Gandhi Jayanti");
  Lecture.Holiday(Calendar.Date(21, Calendar.October, 2015),   "Ayudha Puja");
  Lecture.Holiday(Calendar.Date(22, Calendar.October, 2015),   "Vijaya Dashami");
  Lecture.Holiday(Calendar.Date(11, Calendar.November, 2015),  "Deepawali");
  Lecture.Holiday(Calendar.Date(24, Calendar.December, 2015),  "Milad-Un-Nabi");
  Lecture.Holiday(Calendar.Date(25, Calendar.December, 2015),  "Christmas");
  Lecture.Vacation(Calendar.Date(23, Calendar.February, 2015), Calendar.Date(9, Calendar.March, 2015), "Mid-term Break");
  Lecture.Vacation(Calendar.Date(4, Calendar.May, 2015), Calendar.Date(31, Calendar.May, 2015),        "Summer Break")
]

let test_tt1 () =
  Timetable.mapCourseToWeekdays ttspr15

let test_readFacultyList () =
  Timetable.readFacultyList "data/s2015/faculty.csv"

let _ = test_readFacultyList ()
