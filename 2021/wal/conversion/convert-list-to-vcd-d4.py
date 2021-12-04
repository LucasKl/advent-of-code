#!/usr/bin/python

with open('../res/d4', 'r') as puzzle_file:
    puzzle = list(map(lambda line: line.split(), puzzle_file.readlines()))
    numbers = puzzle[0][0]

    print('(set [all-numbers \'( ' + ' '.join(numbers.split(',')) + ')])')
    
    puzzle.pop(0)
    puzzle = list(filter(lambda x: x, puzzle))

    with open(f'../res/d4.vcd', 'w') as f:
        f.write('''
$var wire 8 a d1 $end
$var wire 8 b d2 $end
$var wire 8 c d3 $end
$var wire 8 d d4 $end
$var wire 8 e d5 $end
$enddefinitions $end
$dumpvars\n''')

        getarg = lambda i: int(i)

        row = puzzle[0]
        f.write("b{0:b} a\n".format(getarg(row[0])))
        f.write("b{0:b} b\n".format(getarg(row[1])))
        f.write("b{0:b} c\n".format(getarg(row[2])))
        f.write("b{0:b} d\n".format(getarg(row[3])))
        f.write("b{0:b} e\n$end\n".format(getarg(row[4])))            


        i = 0
        for row in puzzle:
            f.write('#' + str(i) + '\n')
            f.write("b{0:b} a\n".format(getarg(row[0])))
            f.write("b{0:b} b\n".format(getarg(row[1])))
            f.write("b{0:b} c\n".format(getarg(row[2])))
            f.write("b{0:b} d\n".format(getarg(row[3])))
            f.write("b{0:b} e\n".format(getarg(row[4])))            
            i += 1

        #f.write('#' + str(i) + '\n')

