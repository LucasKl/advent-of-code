#!/usr/bin/python

with open('../res/d8', 'r') as puzzle_file:
    puzzle = list(map(lambda line: list(map(lambda x: x.split(),line.split('|'))), puzzle_file.read().splitlines()))

    print(puzzle[0][0][0])
    with open(f'../res/d8.vcd', 'w') as f:
        f.write('''
$var wire 1 a a $end
$var wire 1 b b $end
$var wire 1 c c $end
$var wire 1 d d $end
$var wire 1 e e $end
$var wire 1 f f $end
$var wire 1 g g $end
$var wire 1 # output  $end
$enddefinitions $end
$dumpvars\n''')
        
        getarg = lambda i: int(puzzle[i][1])
        isset = lambda d, s: 1 if (d in s) else 0

        def print_sig(data, output):
            for c in 'abcdefg':
                f.write("b{0:b} {1}\n".format(isset(c, data), c))
            f.write("b{0:b} #\n".format(output))

        init = puzzle[0][0][0]
        print_sig(init, 0)
        f.write("$end\n")

        i = 0
        for data in puzzle:
            for number in data[0]:
                f.write(f'#{i}\n')
                print_sig(number, 0)
                i += 1

            for number in data[1]:
                f.write(f'#{i}\n')
                print_sig(number, 1)
                i += 1


        #f.write('#' + str(i) + '\n')

