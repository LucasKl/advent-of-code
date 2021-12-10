#!/usr/bin/python

with open('../res/d10', 'r') as puzzle_file:
    #puzzle = list(map(lambda line: line., puzzle_file.readlines()))
    puzzle = puzzle_file.read().splitlines()

    with open(f'../res/d10.vcd', 'w') as f:
        f.write(f'$var wire 4 # data $end\n')
        f.write(f'$var wire 4 ; start $end\n')
        f.write('''$enddefinitions $end\n$dumpvars\n''')

        def print_line(line, time, init=False):
            mapping = {
                '(': 1,
                '[': 2,
                '{': 3,
                '<': 4,
                ')': 11,
                ']': 12,
                '}': 13,
                '>': 14
            }
            i = 0
            for i, c in enumerate(line):
                if not init:
                    f.write('#' + str(time + i) + '\n')
                f.write('b{0:b} #\n'.format(mapping[c]))
                f.write('b{0:b} ;\n'.format(1 if i == 0 else 0))
                i += 1

            return time + i
            
        print_line(puzzle[0], 0, True)
        f.write('$end\n')

        time = 0
        for i, line in enumerate(puzzle):
            time = print_line(line, time)
