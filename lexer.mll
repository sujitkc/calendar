{
exception Lexer_exception of string
(* open Ttparser *)
}

let digit = ['0'-'9']
let integer = ['0'-'9']['0'-'9']*
let id = ['a'-'z''A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9']*

rule scan = parse
  | [' ' '\t']+  { (* print_string "scanned ws"; flush stdout;      *)  scan lexbuf        }
  | '('          { (* print_string "scanned (\n"; flush stdout;     *)  Ttparser.LPAREN                     }
  | ')'          { (* print_string "scanned )\n"; flush stdout;     *)  Ttparser.RPAREN                     }
  | ':'          { (* print_string "scanned :\n"; flush stdout;     *)  Ttparser.COLON                      }
  | '-'          { (* print_string "scanned -\n"; flush stdout;     *)  Ttparser.HYPHEN                     }
  | integer as s { (* print_string "scanned int\n"; flush stdout;   *)  try Ttparser.INTEGER((int_of_string s)) with Failure(_) -> print_string "failed here"; exit(0) }
  | id as s      { (* print_string "scanned id\n"; flush stdout;    *)  Ttparser.ID(s)                      }
  | ','          { (* print_string "scanned comma\n"; flush stdout; *)  Ttparser.COMMA                      }
  | '\n'         {                                                      Ttparser.NEWLINE                    }
  | eof          {  (* print_string "scanned eof\n"; flush stdout;  *)  Ttparser.EOF                        }

{
}
