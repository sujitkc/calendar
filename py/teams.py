#!/usr/bin/python

import random
import csv
import sys

def getNamesFromCSV(csvfilename):
  with open(csvfilename, 'rb') as csvfile:
    reader = csv.reader(csvfile)
    names = [row[1] for row in reader]
    return names

def makeTeam(l, n):
  if(len(l) < n):
    return (l, [])
  else:
    return(l[:n], l[n:])

def makeTeams(l, n):
  lst = l
  teams = []
  while lst != []:
    f, lst = makeTeam(lst, n)
    teams.append(f)
  return teams

if __name__ == "__main__":
  filename = sys.argv[1]
  numStudents = int(sys.argv[2])
  students = getNamesFromCSV(filename)
  random.shuffle(students)
  teams = makeTeams(students, numStudents)
  for team in teams:
    print ", ".join(team)
