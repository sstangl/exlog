#!/usr/bin/env python3
# vim: syntax=python ts=4 et sw=4 sts=4:

# This file encodes some knowledge about what the various lifts are.
# The purpose is to be able to answer questions like:
#  "How much fatigue carryover is there from SLDL to squat?"
# Since most fatigue is systemic, a rough analysis based on bodypart should suffice.
# Thinking about lifts in terms of bodyparts is usually a big mistake in terms
# of planning progression, but it should make sense in terms of planning fatigue.

from enum import Enum

class LiftType(Enum):
    # Squat and Deadlift affect each other directly.
    squat = 0
    deadlift = 1

    # Bench and Press affect each other directly.
    bench = 2
    press = 3

    bro = 4
    conditioning = 5


liftdb = {
    # Main lifts:
    "squat": LiftType.squat,
    "deadlift": LiftType.deadlift,
    "paused bench": LiftType.bench,
    "press": LiftType.press,

    # Accessories primarily affecting squat.
    "2-count paused high-bar squat": LiftType.squat,
    "2-count paused squat": LiftType.squat,
    "3-count paused squat": LiftType.squat,
    "2-count squat paused at sticking point": LiftType.squat,
    "303 tempo leg press": LiftType.squat,
    "303 tempo squat": LiftType.squat,
    "bottom-2/3rd squat": LiftType.squat,
    "chain squat": LiftType.squat,
    "db lunges": LiftType.squat,
    "dynamic effort squat": LiftType.squat,
    "leg extension": LiftType.squat,
    "leg press": LiftType.squat,
    "front squat": LiftType.squat,
    "goodmorning": LiftType.squat,
    "hack squat": LiftType.squat,
    "high-bar squat": LiftType.squat,
    "paused high-bar squat": LiftType.squat,
    "paused squat": LiftType.squat,
    "pin squat": LiftType.squat,
    "safety bar squat": LiftType.squat,
    "snatch balance": LiftType.squat,
    "squat w/wraps": LiftType.squat,

    # Accessories primarily affecting deadlift.
    "1-inch deficit deadlift": LiftType.deadlift,
    "1.5-inch deficit deadlift": LiftType.deadlift,
    "2-count paused-off-floor deadlift": LiftType.deadlift,
    "2-count paused-at-knees deadlift": LiftType.deadlift,
    "2-inch deficit deadlift": LiftType.deadlift,
    "2-inch deficit sldl": LiftType.deadlift,
    "3-count paused-at-knees deadlift": LiftType.deadlift,
    "3-inch deficit deadlift": LiftType.deadlift,
    "6-inch block pull": LiftType.deadlift,
    "303 tempo deadlift": LiftType.deadlift,
    "303 tempo sldl": LiftType.deadlift,
    "barbell row": LiftType.deadlift,
    "back extension": LiftType.deadlift,
    "bb bodyweight rows": LiftType.deadlift,
    "block pull": LiftType.deadlift,
    "block sldl": LiftType.deadlift,
    "chain deadlift": LiftType.deadlift,
    "deficit deadlift": LiftType.deadlift,
    "fat bar deadlift": LiftType.deadlift,
    "ghr": LiftType.deadlift,
    "halting deadlift": LiftType.deadlift,
    "hip thrust": LiftType.deadlift,
    "leg curl": LiftType.deadlift,
    "high pull": LiftType.deadlift,
    "kroc row": LiftType.deadlift,
    "paused deadlift": LiftType.deadlift,
    "pendlay row": LiftType.deadlift,
    "power clean": LiftType.deadlift,
    "power shrug": LiftType.deadlift,
    "power snatch": LiftType.deadlift,
    "rack pull": LiftType.deadlift,
    "reverse hyper": LiftType.deadlift,
    "romanian deadlift": LiftType.deadlift,
    "romanian deadlift to floor": LiftType.deadlift,
    "sldl": LiftType.deadlift,
    "sldl off 2-inch blocks": LiftType.deadlift,
    "snatch-grip deadlift": LiftType.deadlift,
    "sumo block pull": LiftType.deadlift,
    "sumo deadlift": LiftType.deadlift,

    # Accessories primarily affecting bench.
    "1-board paused bench": LiftType.bench,
    "2-board bench": LiftType.bench,
    "3-board bench": LiftType.bench,
    "2-board close-grip paused bench": LiftType.bench,
    "2-count paused bench": LiftType.bench,
    "3-count paused bench": LiftType.bench,
    "3-board close-grip bench": LiftType.bench,
    "303 tempo bench": LiftType.bench,
    "bench": LiftType.bench,
    "cable row": LiftType.bench,
    "cable french press": LiftType.bench,
    "chest-supported row": LiftType.bench,
    "chain bench": LiftType.bench,
    "chins": LiftType.bench,
    "close-grip bench": LiftType.bench,
    "close-grip floor press": LiftType.bench,
    "db bench": LiftType.bench,
    "face pull": LiftType.bench,
    "feet-up bench": LiftType.bench,
    "floor press": LiftType.bench,
    "flyes": LiftType.bench,
    "h-row": LiftType.bench,
    "lat pulldown": LiftType.bench,
    "lying tricep extension": LiftType.bench,
    "neutral grip chins": LiftType.bench,
    "paused close-grip bench": LiftType.bench,
    "paused close-grip floor press": LiftType.bench,
    "paused wide-grip bench": LiftType.bench,
    "pin bench": LiftType.bench,
    "seated row": LiftType.bench,
    "slingshot bench": LiftType.bench,
    "speed bench": LiftType.bench,
    "swiss bar bench": LiftType.bench,
    "tricep pulldown": LiftType.bench,
    "tricep pushdown": LiftType.bench,
    "v-grip pulldown": LiftType.bench,
    "wide-grip bench": LiftType.bench,
    "wide-grip paused bench": LiftType.bench,

    # Accessories primarily affecting press.
    "band pulldown": LiftType.press,
    "db incline bench": LiftType.press,
    "db press": LiftType.press,
    "dips": LiftType.press,
    "french press": LiftType.press,
    "front raise": LiftType.press,
    "paused halting press": LiftType.press,
    "klokov press": LiftType.press,
    "medial delt raise": LiftType.press,
    "pin press": LiftType.press,
    "pullups": LiftType.press,
    "push press": LiftType.press,
    "seated db press": LiftType.press,
    "smith machine seated press": LiftType.press,
    "strict press": LiftType.press,
    "swiss bar press": LiftType.press,
    "wide-grip pullups": LiftType.press,

    # Accessories that serve no direct main lift purpose.
    "303 tempo preacher curl": LiftType.bro,
    "cable curl": LiftType.bro,
    "calf raise": LiftType.bro,
    "curl": LiftType.bro,
    "db curl": LiftType.bro,
    "forearm twist": LiftType.bro,
    "ghd crunch": LiftType.bro,
    "hammer curl": LiftType.bro,
    "lateral raise": LiftType.bro,
    "leg raise": LiftType.bro,
    "nordic curl": LiftType.bro,
    "preacher curl": LiftType.bro,
    "preacher curl machine": LiftType.bro,
    "reverse curl": LiftType.bro,
    "situps on decline bench": LiftType.bro,
    "swiss bar hammer curl": LiftType.bro,
    "wrist curl": LiftType.bro,
    "zottman curl": LiftType.bro,

    # Accessories that are for conditioning.
    "120bpm walking": LiftType.conditioning,
    "ab roller": LiftType.conditioning,
    "farmers walk": LiftType.conditioning,
    "prowler": LiftType.conditioning,
    "rower": LiftType.conditioning,
    "sled pull": LiftType.conditioning,
    "stationary bike": LiftType.conditioning,
}


def gettype(liftname):
    # Remove some designations that don't matter for typing.
    liftname = liftname.replace('beltless','')
    liftname = liftname.replace('sleeveless','')
    liftname = liftname.replace('w/wraps','')
    liftname = liftname.replace('w/straps','')

    liftname = liftname.replace('  ',' ').strip()
    if not liftname in liftdb:
        return None
    return liftdb[liftname]


# Two lifts are related if fatigue has high carryover between them.
def related(a, b):
    atype = gettype(a)
    btype = gettype(b)
    
    if atype == btype:
        return True

    def squatdeadtype(t):
        return t == LiftType.squat or t == LiftType.deadlift
    def benchpresstype(t):
        return t == LiftType.bench or t == LiftType.press

    if squatdeadtype(atype) and squatdeadtype(btype):
        return True
    return benchpresstype(atype) and benchpresstype(btype)


# If run as a script, make sure that the entirety of exlog is handled.
if __name__ == '__main__':
    import sys
    import logparse

    if len(sys.argv) != 2:
        print(' Usage: %s logfile' % sys.argv[0], file=sys.stderr)
        sys.exit(1)

    sessions = logparse.parse(sys.argv[1])

    for session in sessions:
        for lift in session.lifts:
            if gettype(lift.name) == None:
                print("Missing: " + lift.name)
