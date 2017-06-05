#!/usr/bin/env python3
# vim: syntax=python ts=4 et sw=4 sts=4:

# Common supporting classes and calculations.

import datetime

PercentageTable = [
    [100.00, 97.80, 95.50, 93.90, 92.20, 90.70, 89.20, 87.80, 86.30], # 1 rep
    [95.50,  93.90, 92.20, 90.70, 89.20, 87.80, 86.30, 85.00, 83.70], # 2 reps
    [92.20,  90.70, 89.20, 87.80, 86.30, 85.00, 83.70, 82.40, 81.10], # 3 reps
    [89.20,  87.80, 86.30, 85.00, 83.70, 82.40, 81.10, 79.90, 78.60], # 4 reps
    [86.30,  85.00, 83.70, 82.40, 81.10, 79.90, 78.60, 77.40, 76.20], # 5 reps
    [83.70,  82.40, 81.10, 79.90, 78.60, 77.40, 76.20, 75.10, 73.90], # 6 reps
    [81.10,  79.90, 78.60, 77.40, 76.20, 75.10, 73.90, 72.30, 70.70], # 7 reps
    [78.60,  77.40, 76.20, 75.10, 73.90, 72.30, 70.70, 69.40, 68.00], # 8 reps
    [76.20,  75.10, 73.90, 72.30, 70.70, 69.40, 68.00, 66.70, 65.30], # 9 reps
    [73.90,  72.30, 70.70, 69.40, 68.00, 66.70, 65.30, 64.00, 62.60], # 10 reps
    [70.70,  69.40, 68.00, 66.70, 65.30, 64.00, 62.60, 61.30, 59.90], # 11 reps
    [68.00,  66.70, 65.30, 64.00, 62.60, 61.30, 59.90, 58.60, 00.00], # 12 reps
]


# Not used, but kept around for future error checking.
def percentage_tabular(reps, rpe):
    # Insufficient reps to accurately predict RPE or E1RM.
    if reps > 12 or reps < 1:
        return 0.0

    if rpe == 10.0: return PercentageTable[reps - 1][0]
    if rpe == 9.5:  return PercentageTable[reps - 1][1]
    if rpe == 9.0:  return PercentageTable[reps - 1][2]
    if rpe == 8.5:  return PercentageTable[reps - 1][3]
    if rpe == 8.0:  return PercentageTable[reps - 1][4]
    if rpe == 7.5:  return PercentageTable[reps - 1][5]
    if rpe == 7.0:  return PercentageTable[reps - 1][6]
    if rpe == 6.5:  return PercentageTable[reps - 1][7]
    if rpe == 6.0:  return PercentageTable[reps - 1][8]
    return 0.0


# This is the above chart expressed as a piecewise function.
# This enables using a larger set of real numbers for RPEs, like 8.75.
def percentage(reps, rpe):
    # No prediction if failure occurred, or if RPE is unreasonably low.
    if reps < 1 or rpe < 4:
        return 0

    # Handle the obvious case early to avoid error margins.
    if reps == 1 and rpe == 10:
        return 100

    # x is defined such that 1@10 = 0, 1@9 = 1, 1@8 = 2, etc.
    # By definition of RPE, then also:
    #  2@10 = 1@9 = 1
    #  3@10 = 2@9 = 1@8 = 2
    # And so on. That pattern gives the equation below.
    x = (10 - rpe) + (reps - 1)

    # The logic breaks down for super-high numbers,
    # and it's too hard to extrapolate an E1RM from super-high-rep sets anyway.
    if x >= 16:
        return 0

    intersection = 2.92

    # The highest values follow a quadratic.
    # Parameters were resolved via GNUPlot and match extremely closely.
    if x <= intersection:
        a = 0.347619
        b = -4.60714
        c = 99.9667
        return a*x*x + b*x + c

    # Otherwise it's just a line, since Tuchscherer just guessed.
    m = -2.64249
    b = 97.0955
    return m*x + b


def calc_weight(e1rm, reps, rpe):
    # weight / percentage(reps, rpe) * 100 = e1rm
    # weight = e1rm / 100 * percentage(reps, rpe);
    return e1rm / 100 * percentage(reps, rpe)


def calc_e1rm(weight, reps, rpe):
    if rpe == 0:
        return 0
    return weight / percentage(reps, rpe) * 100


#####################################################################


class Set:
    def __init__(self, weight, reps, rpe=0, failure=False):
        self.weight = float(weight)
        self.reps = int(reps)
        self.rpe = float(rpe)
        self.failure = bool(failure)

        if self.reps < 0:
            error("Negative reps")
        if self.reps == 0 and not self.failure:
            error("Invalid set: no reps done and no failure.")

    def e1rm(self):
        factor = percentage(self.reps, self.rpe)

        # Use the Tuchscherer chart.
        if factor > 0:
            return self.weight / factor * 100

        # If RPEs are missing or the chart is inadequate, don't mislead.
        return 0.0

    # For cases that the RPE chart doesn't cover, we have the Epley formula.
    def epley(self):
        if self.reps == 0:
            return 0.0

        # Use RPE to include any reps not done.
        reps = self.reps
        if self.rpe:
            reps += 10 - self.rpe

        if reps == 1:
            return self.weight
        return self.weight + ((self.weight * reps) / 30)

    # Compared to the specified E1RM, how much fatigue did this set demonstrate?
    # Numbers returned are in units of "fatigue percents".
    def fatigue(self, best_e1rm):
        set_e1rm = self.e1rm()
        if set_e1rm == 0 or best_e1rm == 0:
            return 0
        return max(0, (1 - (set_e1rm / best_e1rm)) * 100)


class Lift:
    def __init__(self, name):
        self.name = name
        self.sets = []

    def addsets(self, slist):
        self.sets += slist

    # Get a list of non-warmup, actual training sets.
    def get_worksets(self):
        # Lifts that track RPE track them for every set.
        highrpe = list(filter(lambda x: x.rpe >= 6.0, self.sets))
        if len(highrpe) > 0:
            return highrpe

        # If this is one of the earlier lifts that didn't track RPE,
        # just take some of the heaviest sets of what's present.
        topweight = max([0] + list(map(lambda x: x.weight, self.sets)))
        cutoff = topweight * 0.85
        return filter(lambda x: x.weight >= cutoff, self.sets)

    # TODO: Should trust higher RPEs more.
    def e1rm(self):
        return max([0] + list(map(lambda x: x.e1rm(), self.get_worksets())))

    def epley(self):
        return max([0] + list(map(lambda x: x.epley(), self.get_worksets())))

    def volume(self):
        return sum(map(lambda x: x.reps, self.get_worksets()))

    def tonnage(self):
        return sum(map(lambda x: x.weight * x.reps, self.get_worksets()))

    def fatigue(self):
        best_e1rm = self.e1rm()
        if best_e1rm == 0:
            return 0
        # Compare to the most recent set that had an e1rm.
        for i in range(len(self.sets), 0, -1):
            e1rm = self.sets[i-1].e1rm()
            if e1rm == 0:
                continue
            return self.sets[i-1].fatigue(best_e1rm)
        return 0


class TrainingSession:
    def __init__(self, year, month, day):
        self.date = datetime.date(year, month, day)
        self.bodyweight = 0.0
        self.lifts = []

    def setbodyweight(self, bodyweight):
        self.bodyweight = bodyweight

    def addlift(self, l):
        self.lifts.append(l)

    def e1rm(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return max([0] + list(map(Lift.e1rm, lifts)))

    def epley(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return max([0] + list(map(Lift.epley, lifts)))

    def volume(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return sum(x.volume() for x in lifts)

    def tonnage(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return sum(x.tonnage() for x in lifts)

    def fatigue(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return sum(x.fatigue() for x in lifts)


# Handles the case of multiple TrainingSessions on the same day,
# but really just exists so that the code between daily/weekly
# uses the same types and the same interface.
class DailyIterator:
    def __init__(self, sessions):
        self.sessions = sessions

    def __iter__(self):
        self.idx = 0
        return self

    def __sameday(self, a, b):
        return a.toordinal() == b.toordinal()

    def __next__(self):
        if self.idx >= len(self.sessions):
            raise StopIteration

        startdate = self.sessions[self.idx].date
        acc = []
        for i in range(self.idx, len(self.sessions)):
            if self.__sameday(startdate, self.sessions[i].date):
                acc.append(self.sessions[i])
            else:
                break

        self.idx += len(acc)
        return acc


class WeeklyIterator:
    def __init__(self, sessions):
        self.sessions = sessions

    def __iter__(self):
        self.idx = 0
        return self

    # Whether the two given dates are in the same training week.
    # A training week is Sunday through Saturday (inclusive).
    def __sameweek(self, a, b):
        # Canonicalize each date according to the last Sunday.
        # isoweekday() gives 1 for Monday, 7 for Sunday.
        # So in terms of mapping how much to subtract:
        #  isoweekday -> subtract_amount
        #  [1,2,3,4,5,6,7] -> [1,2,3,4,5,6,0]
        week_a = a.toordinal() - (a.isoweekday() % 7)
        week_b = b.toordinal() - (b.isoweekday() % 7)
        return week_a == week_b

    def __next__(self):
        if self.idx >= len(self.sessions):
            raise StopIteration

        # Generate a list of sessions from here until Saturday (inclusive).
        # In terms of weekday(), Saturday is a return value of 6.
        startdate = self.sessions[self.idx].date
        acc = []

        for i in range(self.idx, len(self.sessions)):
            if self.__sameweek(startdate, self.sessions[i].date):
                acc.append(self.sessions[i])
            else:
                break

        self.idx += len(acc)
        return acc


# Return a single date as representative of the list of dates.
# For choosing a date on which to mark weekly volume, etc.
def canonical_date(sessionlist):
    return sessionlist[-1].date

