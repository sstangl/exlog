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


def percentage(reps, rpe):
    # Too many reps to accurately predict RPE or E1RM.
    if reps > 12:
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


def calc_weight(e1rm, reps, rpe):
    # weight / percentage(reps, rpe) * 100 = e1rm
    # weight = e1rm / 100 * percentage(reps, rpe);
    return e1rm / 100 * percentage(reps, rpe)


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

    # For cases that the RPE chart doesn't cover, we have the Wendler formula.
    def wendler(self):
        if self.reps == 0:
            return 0.0
        if self.reps == 1:
            return self.weight
        return self.weight + ((self.weight * self.reps) / 30)

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
        # Only include the top 20% of weights.
        topweight = max([0] + list(map(lambda x: x.weight, self.sets)))
        cutoff = topweight * 0.8
        return filter(lambda x: x.weight >= cutoff, self.sets)

    # TODO: Should trust higher RPEs more.
    def e1rm(self):
        return max([0] + list(map(lambda x: x.e1rm(), self.get_worksets())))

    def wendler(self):
        return max([0] + list(map(lambda x: x.wendler(), self.get_worksets())))

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

    def volume(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return sum(x.volume() for x in lifts)

    def tonnage(self, matchfn):
        lifts = filter(matchfn, self.lifts)
        return sum(x.tonnage() for x in lifts)
