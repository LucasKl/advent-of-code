data = '''start-A
start-b
A-c
A-b
b-d
A-end
b-end'''

data = '''lg-GW
pt-start
pt-uq
nx-lg
ve-GW
start-nx
GW-start
GW-nx
pt-SM
sx-GW
lg-end
nx-SM
lg-SM
pt-nx
end-ve
ve-SM
TG-uq
end-SM
SM-uq'''

def puzzle():
    return list(map(lambda x: x.split('-'), data.split('\n')))


def is_small(cave):
    return cave.islower()

