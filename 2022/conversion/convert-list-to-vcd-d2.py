#!/usr/bin/python3

with open('../res/d2', 'r') as puzzle_file:
    puzzle = [x.split() for x in puzzle_file.read().splitlines()]

    mapping = {
        'A': 1,
        'X': 1,
        'B': 2,
        'Y': 2,
        'C': 3,
        'Z': 3
    }

    with open(f'../res/d2.vcd', 'w') as f:
        f.write('$var wire 2 opponent opponent $end\n')
        f.write('$var wire 2 end end $end\n')

        for n, round in enumerate(puzzle):
            if n == 0:
                f.write('#0\n$dumpvars\n')
            else:
                f.write(f'#{n}\n')
            opponent = mapping[round[0]]
            you = mapping[round[1]]
            f.write(f'b{opponent:b} opponent\n')
            f.write(f'b{you:b} end\n')

        f.write(f'#{n+1}\n')
