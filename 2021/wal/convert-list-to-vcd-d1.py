import sys

if len(sys.argv) < 2:
    print('No input file specified')
    exit()

with open(sys.argv[1], 'r') as puzzle_file:
    puzzle = list(map(int, puzzle_file.readlines()))

    with open(f'{sys.argv[1]}.vcd', 'w') as f:
        f.write('''
$scope module d1 $end
$var wire 32 # data $end
$upscope $end
$enddefinitions $end
$dumpvars''')

        f.write("b{0:b} #\n$end\n".format(puzzle[0]))

        i = 0
        for number in puzzle:
            f.write('#' + str(i) + '\n')
            f.write("b{0:b} #\n".format(number))
            i += 1

        #f.write('#' + str(i) + '\n')
        #f.write('b00000000000000000000000000000000 #')
