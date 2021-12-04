#!/usr/bin/python3

import sys

with open('../res/d3t', 'r') as puzzle_file:
    puzzle = puzzle_file.read().splitlines()

    with open(f'../res/d3.vcd', 'w') as f:
        f.write('''
$var wire 5 # data $end
$enddefinitions $end
$dumpvars\n''')

        f.write(f"b{puzzle[0]} #\n$end\n")

        i = 0
        for number in puzzle:
            f.write('#' + str(i) + '\n')
            f.write(f"b{number} #\n")
            i += 1

        #f.write('#' + str(i) + '\n')
        #f.write('b00000000000000000000000000000000 #')
