#!/usr/bin/python
with open('../res/d5', 'r') as puzzle_file:
    puzzle = list(map(lambda line: line.strip().split('->'), puzzle_file.readlines()))
    puzzle = list(map(lambda xs: list(map(lambda ys: ys.split(','), xs)), puzzle))

    with open(f'../res/d5.vcd', 'w') as f:
        f.write('''
$var wire 16 x1 x1 $end
$var wire 16 y1 y1 $end
$var wire 16 x2 x2 $end
$var wire 16 y2 y2 $end
$enddefinitions $end
$dumpvars\n''')

        getcommand = lambda i: keys[puzzle[i][0]]
        getarg = lambda i: int(puzzle[i][1])

        def points(data):
            x1 = int(data[0][0])
            y1 = int(data[0][1])
            x2 = int(data[1][0])
            y2 = int(data[1][1])
            return x1, y1, x2, y2
        
        x1, y1, x2, y2 = points(puzzle[0])
        f.write("b{0:b} x1\n".format(x1))
        f.write("b{0:b} y1\n".format(y1))
        f.write("b{0:b} x2\n".format(x2))
        f.write("b{0:b} y2\n$end\n".format(y2))

        i = 0
        for row in puzzle:
            f.write('#' + str(i) + '\n')
            x1, y1, x2, y2 = points(row)
            f.write("b{0:b} x1\n".format(x1))
            f.write("b{0:b} y1\n".format(y1))
            f.write("b{0:b} x2\n".format(x2))
            f.write("b{0:b} y2\n".format(y2))
            i += 1
