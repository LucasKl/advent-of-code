data = '''start-A
start-b
A-c
A-b
b-d
A-end
b-end'''


def puzzle():
    return list(map(lambda x: x.split('-'), data.split('\n')))


def is_small(cave):
    return cave.islower()

