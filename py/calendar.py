January   =  1
February  =  2
March     =  3
April     =  4
May       =  5
June      =  6
July      =  7
August    =  8
September =  9
October   = 10
November  = 11
December  = 12

Sunday    = 1
Monday    = 2
Tuesday   = 3
Wednesday = 4
Thursday  = 5
Friday    = 6
Saturday  = 7

'''
Given a weekday wd, gives the next weekday.
weekday -> weekday
Example:
  Monday   --> Tuesday
  Saturday --> Sunday
'''
def nextWeekDay(wd):
  if(wd == Sunday):    return Monday
  if(wd == Monday):    return Tuesday
  if(wd == Tuesday):   return Wednesday
  if(wd == Wednesday): return Thursday
  if(wd == Thursday):  return Friday
  if(wd == Friday):    return Saturday
  if(wd == Saturday):  return Sunday

'''
Given a weekday wd, gives the previous weekday.
weekday -> weekday
Example:
  Monday --> Sunday
  Sunday --> Saturday
'''
def prevWeekDay(wd):
  if(wd == Sunday ):   return Saturday
  if(wd == Monday):    return Sunday
  if(wd == Tuesday):   return Monday
  if(wd == Wednesday): return Tuesday
  if(wd == Thursday):  return Wednesday
  if(wd == Friday):    return Thursday
  if(wd == Saturday):  return Friday

'''
Given a weekday wd, gives the string representation of the same.
weekday -> string
Example:
  Monday --> "Monday"
  Sunday --> "Sunday"
'''
def string_of_weekday(wd):
  if(wd == Sunday):    return "Sunday"
  if(wd == Monday):    return "Monday"
  if(wd == Tuesday):   return "Tuesday"
  if(wd == Wednesday): return "Wednesday"
  if(wd == Thursday):  return "Thursday"
  if(wd == Friday):    return "Friday"
  if(wd == Saturday):  return "Saturday"

'''
  Given a year y, return true if y is a leap year; false otherwise.
  year -> boolean
  Example:
    2000 --> True
    2001 --> False
    2012 --> True
    1900 --> False
'''
def isLeapYear(y):
  if (y % 100) == 0:
    return (y % 400) == 0
  else:
    return (y % 4) == 0

'''
  Given a month m and a year y, return the number of days in m.
  month * year -> int
  Example:
    February, 2000 --> 29
    February, 2001 --> 28
    February, 2012 --> 29
    February, 1900 --> 28
'''
def daysInMonth(m, y):
  if(m == January):   return 31
  if(m == February):
    if(isLeapYear(y)): return 29
    else:              return 28
  if(m == March):     return 31
  if(m == April):     return 30
  if(m == May):       return 31
  if(m == June):      return 30
  if(m == July):      return 31
  if(m == August):    return 31
  if(m == September): return 30
  if(m == October):   return 31
  if(m == November):  return 30
  if(m == December):  return 31

def nextMonth(m):
  if(m == January):   return February
  if(m == February):  return March
  if(m == March):     return April
  if(m == April):     return May
  if(m == May):       return June
  if(m == June):      return July
  if(m == July):      return August
  if(m == August):    return September
  if(m == September): return October
  if(m == October):   return November
  if(m == November):  return December
  if(m == December):  return January

'''
Given a month m, gives the string representation of the same.
month -> string
Example:
  January  --> "January"
  February --> "February"
'''
def string_of_month(m):
  if(m == January):   return "January"
  if(m == February):  return "February"
  if(m == March):     return "March"
  if(m == April):     return "April"
  if(m == May):       return  "May"
  if(m == June):      return "June"
  if(m == July):      return "July"
  if(m == August):    return "August"
  if(m == September): return "September"
  if(m == October):   return "October"
  if(m == November):  return "November"
  if(m == December):  return "December"

'''
Given a date (d, m, y), gives the string representation of the same.
month -> string
Example:
  (18, September, 2014)  --> "September 18, 2014"
'''
def string_of_date((d, m, y)):
  return string_of_month(m) + " " + str(d) + ", " + str(y)

'''
  Given a date, return its next date.
  date -> date
  Example:
    (1, January, 2014)   --> (2, January, 2014)
    (31, December, 2013) --> (1, January, 2014)
    (28, February, 2013) --> (1, March, 2013)
    (28, February, 2012) --> (29, February, 2012)
'''
def nextDate((d, m, y)):
  if(d == daysInMonth(m, y)):
    if(m == December):
      return (1, January, y + 1)
    else:
      return (1, nextMonth(m), y)
  else:
    return (d + 1, m, y)

'''
  Given two dates dd1 and dd2, return true if dd1 is strictly later than dd2
  date * date -> boolean
  Example:
    (1, January, 2014) (1, January, 2014)   --> False
    (1, January, 2014) (2, January, 2014)   --> False
    (1, January, 2014) (31, December, 2013) --> False
'''
def isLater((d1, m1, y1), (d2, m2, y2)):
  if(y1 == y2):
    if(m1 == m2):  return d1 > d2
    elif(m1 > m2): return True # Bad design!
    else:          return False
  elif(y1 > y2): return True
  else:          return False

'''
  Given two dates d1 and d2, count how many days elapse between the two.
  Whether d1 occurs later than d2 shouldn't matter.
  date * date -> int
  Example:
    (1, January, 2014) (1, January, 2014)   -->  0
    (1, January, 2014) (2, January, 2014)   -->  1
    (1, January, 2014) (31, December, 2013) --> -1
'''
def daysInBetween(d1, d2):
  if(isLater(d1, d2)):
    return -1 * daysInBetween(d2, d1)
  else:
    d = d1
    count = 0
    while(isLater(d2, d)):
      d = nextDate(d)
      count += 1
    return count

'''
  Given a weekday wd and a number n, return the weekday of the date
  n days after a wd.
  weekday * int -> weekday
'''
def countWeekDays(wd, n):
  wd1 = wd
  while(n != 0):
    if(n > 0):
      wd1 = nextWeekDay(wd1)
      n -= 1
    else:
      wd1 = prevWeekDay(wd1)
      n += 1
  return wd1

'''
  Given a date d, return the weekday of the date.
  date -> weekday
'''
def getWeekDay(d):
  refDate = (18, September, 2014)
  refWeekDay = Thursday
  delta = daysInBetween(refDate, d)
  deltaWeekDay = delta % 7
  return countWeekDays(refWeekDay, deltaWeekDay)

def stringlist_of_datelist(dlist):
  return [string_of_date(d) for d in dlist]
