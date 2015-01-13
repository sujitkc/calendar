from calendar import *

# Examples (To be commented out)
# Call to getWeekDay
# print "Today is " + string_of_weekday(getWeekDay((30, September, 2014))) + "."
# Call to nextDate
# print "Tomorrow is " + string_of_date(nextDate((30, September, 2014))) + "."

# Implement your code below this line.

'''
  Given two dates d1 and d2, return the list of all dates from d1 to d2, d1 and d2 included.
  date * date -> date list
  Example:
    (1, January, 2014) (5, January, 2014) -->
      [(1, January, 2014), (2, January, 2014), (3, January, 2014),
       (4, January, 2014), (5, January, 2014)]
'''
def dateRange(d1, d2):
  if(isLater(d1, d2)): return dateRange(d2, d1)
  r = []
  d = d1
  while(True):
    r.append(d)
    if(d != d2):
      d = nextDate(d)
    else:
      break
  return r

'''
  Given a pair of a date d and weekday wd, convert it to its equivalent string representation and return.
  date * weekday -> string
  Example:
    ((1, October, 2014), Wednesday) --> "October 1, 2014, Wednesday"
'''
def string_of_date_weekday((d, wd)):
  return string_of_date(d) + ", " + string_of_weekday(wd)

'''
  Given a lecture plan lp, print it.
  (date, weekday) list -> _
'''
def printLecturePlan(lp):
  sl = [string_of_date_weekday(e) for e in lp]
  for s in sl: print s

'''
  Given two dates d1, and d2, and a list of weekdays wdays, return a lecture plan which is a list
  of date weekday pairs such that all dates in the list are between d1 and d2, and fall on a
  weekday in wdays.
  date * date * weekday list -> (date, weekday) list
  Example:
    (4, August, 2014), (31, August, 2014), [Monday, Wednesday]) -->
      [
        (( 4, August, 2014), Monday   ),
        (( 6, August, 2014), Wednesday),
        ((11, August, 2014), Monday   ),
        ((13, August, 2014), Wednesday),
        ((18, August, 2014), Monday   ),
        ((20, August, 2014), Wednesday),
        ((25, August, 2014), Monday   ),
        ((27, August, 2014), Wednesday)
      ]
'''
def getLecturePlan(d1, d2, wdays):
  lst = [(d, getWeekDay(d)) for d in dateRange(d1, d2)]
  return [(d, wd) for (d, wd) in lst if wd in wdays]

def t1():
  printLecturePlan(getLecturePlan((4, August, 2014), (31, August, 2014), [Monday, Wednesday]))

def t2():
  printLecturePlan(getLecturePlan((4, August, 2014), (13, December, 2014), [Monday, Wednesday]))

if __name__ == "__main__":
  t1()
