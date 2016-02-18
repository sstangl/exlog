#!/usr/bin/env python3
# vim: syntax=python ts=4 et sw=4 sts=4:

import datetime
import sys


#####################################################################


class Set:
    def __init__(self, weight, reps, rpe=0, failure=False):
        self.weight = float(weight)
        self.reps = int(reps)
        self.rpe = int(rpe)
        self.failure = bool(failure)


class Lift:
    def __init__(self, name):
        self.name = name
        self.sets = []

    def addset(self, s):
        self.sets.append(s)

    def addsets(self, slist):
        for s in slist:
            self.addset(s)


class TrainingSession:
    def __init__(self, year, month, day):
        self.date = datetime.date(year, month, day)
        self.bodyweight = 0.0
        self.lifts = []

    def setbodyweight(self, bodyweight):
        self.bodyweight = bodyweight

    def addlift(self, l):
        self.lifts.append(l)


#####################################################################


def from_kg(x):
    return x * 2.205


def error(text):
    print("Error: " + text)
    sys.exit(1)


# Returns the number of 2-space tabs on the line.
def get_indentation_level(line):
    return (len(line) - len(line.lstrip())) >> 1


# Given text like "425x5x3" or "415x3@9", return a list of sets.
def makesets(text):
    xcount = text.count('x')

    # FIXME: For the moment, we'll just discard old pause notation.
    text = text.replace('p', '')
    # FIXME: Also some weirdo one-off "block" notation.
    text = text.replace('b', '')

    # If nothing special is noted, then it's probably a warmup set of 5.
    if xcount == 0:
        return [Set(float(text), 5)]

    # Single set, maybe with RPE or failure.
    if xcount == 1 and not '(' in text:
        # Check for failure and remove it from the string.
        lowertext = text.lower()
        failure = 'f' in lowertext
        lowertext = lowertext.replace('f', '')

        # Check for RPE and remove it from the string.
        rpe = 0
        if '@' in lowertext:
            [lowertext, rpestr] = lowertext.split('@')
            rpe = int(rpe)

        # Remaining string should just be weight x reps.
        [weight, reps] = lowertext.split('x')

        # Case of 200xf
        if not reps:
            reps = 0

        return [Set(float(weight), int(reps), rpe, failure)]

    # Multiple sets with individual notation.
    # With failure: 225x(5,5,4f)
    # With RPE: 225x5@(7,8,9)
    if xcount == 1 and '(' in text:
        parens = text[text.index('(')+1 : -1].split(',')
        text = text[0 : text.index('(')]

        # List is across reps.
        if text[-1] == 'x':
            weight = text[0:-1]

            sets = []
            for k in parens:
                failure = 'f' in k
                reps = k.replace('f', '')
                sets.append(Set(float(weight), int(reps), 0, failure))
            return sets

        # List is across RPE.
        if text[-1] == '@':
            [weight, reps] = text[0:-1].split('x')
            return [Set(float(weight), int(reps), int(x)) for x in parens]

    # Multiple sets across without RPE.
    # Failure is still sometimes denoted by "325x3fx3". Then all sets failed.
    if xcount == 2:
        failure = 'f' in text
        text = text.replace('f', '')

        [weight, reps, nsets] = text.split('x')
        return [Set(float(weight), int(reps), 0, failure) for x in nsets]

    error("Could not parse sets: " + text)


def import_exlog(filename):

    # Open the file and remove all comments.
    with open(filename) as fd:
        lines = [x.split('#')[0].rstrip() for x in fd.readlines()]

    exlog = []

    # Zero'th level of indentation: dates.
    # First level of indentation: lift or bodyweight.
    # Second level of indentation: weights, reps, etc.

    session = None
    lift = None

    for line in lines:
        if len(line) == 0:
            continue

        level = get_indentation_level(line)

        # New training session.
        if level == 0:
            [year, month, day] = [int(x) for x in (line.split()[0]).split('-')]
            session = TrainingSession(year, month, day)
            exlog.append(session)

        # New lift for the current session, or bodyweight declaration.
        elif level == 1:
            name = line.lstrip().split(':')[0]
            if name == "weight":
                maybeweight = line.split(':')[1].strip()
                if maybeweight:
                    session.setbodyweight(float(maybeweight))
            else:
                lift = Lift(name)
                session.addlift(lift)

        # List of sets for the current lift.
        elif level == 2:
            # Can't just split by comma, since a line may be "155x3, 175x(2,2,1)".
            for x in line.split(', '):
                sets = makesets(x.strip())
                lift.addsets(sets)
            
    return exlog


if __name__ == '__main__':
    import sys
    exlog = import_exlog(sys.argv[1])
    
    for session in exlog:
        for lift in session.lifts:
            print(lift.name)
