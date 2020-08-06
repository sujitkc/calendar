%{

%}

%token WS COMMA HYPHEN LPAREN RPAREN COLON EOF NEWLINE
%token <int> INTEGER
%token <string> ID

%start slots calendarday

%type <Timetable.slot list> slots
%type <Lecture.calendarday> calendarday

%% /* Slots */
slots: slot COMMA slots 	{ $1 :: $3 }
  | slot EOF                  { [$1] }
;

slot : weekday LPAREN duration RPAREN { {Timetable.weekday = $1; Timetable.timespan = $3 } }
;

weekday : ID { Calendar.weekday_of_string $1 }
;

duration : time HYPHEN time { { Timetable.startTime = $1; Timetable.endTime = $3 } }

time : INTEGER COLON INTEGER { { Timetable.hr = $1; Timetable.min = $3; Timetable.sec = 0 } }

/* calendarday */
calendarday : holiday { $1 }
  | vacation  { $1 }
;

holiday : date { Lecture.Holiday($1, "Holiday") }

vacation : date HYPHEN date { Lecture.Vacation($1, $3, "Vacation") }

date:   INTEGER  ID INTEGER
    { Calendar.Date($1, (Calendar.month_of_string $2), $3) }
;
%%

