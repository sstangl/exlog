#!/usr/bin/env python3
# vim: syntax=python ts=4 et sw=4 sts=4:

import datetime
import sys

from common import *

def error(text):
    print("Error: " + text)
    sys.exit(1)


#####################################################################


def from_kg(x):
    return float(x) * 2.20462262


def weight2float(x):
    # Used for chain notation.
    if "+" in x:
        sum = 0
        for k in x.split('+'):
            sum += weight2float(k)
        return sum

    if "kg" in x:
        return from_kg(x.replace("kg",""))
    return float(x)


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
        return [Set(weight2float(text), 5)]

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
            rpe = float(rpestr)

        # Remaining string should just be weight x reps.
        [weight, reps] = lowertext.split('x')

        # Case of 200xf
        if not reps:
            reps = 0

        return [Set(weight2float(weight), int(reps), rpe, failure)]

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
                rpe = 0.0

                # A set can have individual RPE notation:
                # 45x(1,2,3,4@9)
                if '@' in reps:
                    [reps, rpe] = reps.split('@')

                if reps == '':
                    reps = 0
                sets.append(Set(weight2float(weight), int(reps), float(rpe), failure))
            return sets

        # List is across RPE.
        if text[-1] == '@':
            [weight, reps] = text[0:-1].split('x')
            return [Set(weight2float(weight), int(reps), float(x)) for x in parens]

    # Multiple sets across without RPE.
    # Failure is still sometimes denoted by "325x3fx3". Then all sets failed.
    if xcount == 2:
        failure = 'f' in text
        text = text.replace('f', '')

        [weight, reps, nsets] = text.split('x')
        if reps == '': # Then there were no successful reps.
            reps = 0
        return [Set(weight2float(weight), int(reps), 0, failure) for x in range(0,int(nsets))]

    error("Could not parse sets: " + text)


# Main log parser function.
def parse(filename):

    # Open the file and remove all comments.
    with open(filename) as fd:
        lines = [x.split('#')[0].rstrip() for x in fd.readlines()]

    exlog = []

    # Zero'th level of indentation: dates.
    # First level of indentation: lift or bodyweight.
    # Second level of indentation: weights, reps, etc.

    session = None
    lift = None

    for linenum, line in enumerate(lines):
        if len(line) == 0:
            continue

        try:
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
                        session.setbodyweight(weight2float(maybeweight))

                # The earliest entries do some jogging for warmup.
                elif name == "warmup":
                    continue

                else:
                    lift = Lift(name)
                    session.addlift(lift)

            # List of sets for the current lift.
            elif level == 2:
                # Can't just split by comma, since a line may be "155x3, 175x(2,2,1)".
                for x in line.split(', '):
                    sets = makesets(x.strip())
                    lift.addsets(sets)
        except Exception as err:
            print("Error on line %s (%s): %s" % (linenum+1, line, err))
            sys.exit(1)
            
    return exlog


if __name__ == '__main__':
    exlog = parse(sys.argv[1])

    try:
        for session in exlog:
            for lift in session.lifts:
                print(str(session.date) + ' ' + lift.name + " " + str(lift.e1rm() or lift.epley()))
    except BrokenPipeError:
        pass
