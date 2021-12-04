keys = {'up': 0,
        'down': 1,
        'forward': 2}

with open('../res/d2', 'r') as puzzle_file:
    puzzle = list(map(lambda line: line.split(), puzzle_file.readlines()))

    with open(f'../res/d2.vcd', 'w') as f:
        f.write('''
$var wire 2 ; command $end
$var wire 8 # arg $end
$enddefinitions $end
$dumpvars\n''')

        getcommand = lambda i: keys[puzzle[i][0]]
        getarg = lambda i: int(puzzle[i][1])
        
        f.write("b{0:b} ;\n".format(getcommand(0)))
        f.write("b{0:b} #\n$end\n".format(getarg(0)))    

        i = 0
        for number in puzzle:
            f.write('#' + str(i) + '\n')
            f.write("b{0:b} ;\n".format(getcommand(i)))
            f.write("b{0:b} #\n".format(getarg(i)))
            i += 1

        #f.write('#' + str(i) + '\n')

