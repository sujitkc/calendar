{
exception Lexer_exception of string

type month =
    January
  | February
  | March
  | April
  | May
  | June
  | July
  | August
  | September
  | October
  | November
  | December 

let month_of_string s =
  match s with
    "January"  -> January
  | "February"  -> February
  | "March"     -> March
  | "April"     -> April
  | "May"       -> May
  | "June"      -> June
  | "July"      -> July
  | "August"    -> August
  | "September" -> September
  | "October"   -> October
  | "November"  -> November
  | "December"  -> December
  | _           -> raise (Lexer_exception (s ^ " not a valid month"))

let string_of_month m =
  match m with
    January   -> "January"
  | February  -> "February"
  | March     -> "March"
  | April     -> "April"
  | May       -> "May"
  | June      -> "June"
  | July      -> "July"
  | August    -> "August"
  | September -> "September"
  | October   -> "October"
  | November  -> "November"
  | December  -> "December"


let string_of_date (d, m, y) =
  (string_of_int d) ^ "-" ^ (string_of_month m) ^ "-" ^ (string_of_int y)

open Ttparser
}

let digit = ['0'-'9']
let integer = ['0'-'9']['0'-'9']*
let id = ['a'-'z''A'-'Z'] ['a'-'z' '0'-'9']*

rule scan_periods = parse
  | [' ' '\t']+  { (* print_string "scanned ws"; flush stdout;      *)  scan_periods lexbuf           }
  | '('          { (* print_string "scanned (\n"; flush stdout;     *)  LPAREN                     }
  | ')'          { (* print_string "scanned )\n"; flush stdout;     *)  RPAREN                     }
  | ':'          { (* print_string "scanned :\n"; flush stdout;     *)  COLON                      }
  | '-'          { (* print_string "scanned -\n"; flush stdout;     *)  HYPHEN                     }
  | integer as s { (* print_string "scanned int\n"; flush stdout;   *)  INTEGER((int_of_string s)) }
  | id as s      { (* print_string "scanned id\n"; flush stdout;    *)  ID(s)                      }
  | ','          { (* print_string "scanned comma\n"; flush stdout; *)  COMMA                      }
  | '\n'         {                                                      NEWLINE                    }
  | eof          {  (* print_string "scanned eof\n"; flush stdout;  *)  EOF                        }
{
}
