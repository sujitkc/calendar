%{
%}

%token WS COMMA HYPHEN LPAREN RPAREN COLON EOF NEWLINE
%token <int> INTEGER
%token <string> ID

%start periods
%type <(Calendar.weekDay * Timetable.duration) list> periods

%% /* Grammar rules and actions follow */
periods: period COMMA periods 	{ $1 :: $3 }
  | period EOF                  { [$1] }
;

period : weekday LPAREN duration RPAREN { $1, $3 }
;

weekday : ID { Calendar.weekday_of_string $1 }
;

duration : time HYPHEN time { { Timetable.startTime = $1; Timetable.endTime = $3 } }

time : INTEGER COLON INTEGER { { Timetable.hr = $1; Timetable.min = $3; Timetable.sec = 0 } }

%%
let parse_periods (str_periods) =
  try
    let lexbuf = Lexing.from_string str_periods in
      periods Lexer.scan_periods lexbuf
  with End_of_file -> exit 0
 
