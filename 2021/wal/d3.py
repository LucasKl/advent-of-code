def toInt(xs):
    return int(''.join([str(1 if x else 0) for x in xs]), 2)
