#!/usr/bin/python

with open('../res/d9', 'r') as puzzle_file:
    #puzzle = list(map(lambda line: line., puzzle_file.readlines()))
    puzzle = puzzle_file.read().splitlines()

    with open(f'../res/d9.vcd', 'w') as f:
        for i, row in enumerate(puzzle):
            f.write(f'$var wire 4 l{i} l{i} $end\n')


        f.write('''$enddefinitions $end\n$dumpvars\n''')

        def print_time(time):
            for i, row in enumerate(puzzle):
                f.write('b{0:b} l{1}\n'.format(int(row[time]), i))

        print_time(0)
        f.write('$end\n')

        for time in range(len(puzzle[0])):
            f.write('#' + str(time) + '\n')
            print_time(time)

        #f.write('#' + str(i) + '\n')

