#!/usr/bin/python3

with open('../res/d1', 'r') as puzzle_file:
    puzzle = puzzle_file.read()
    elves = list(map(lambda e: e.split('\n'), puzzle.split('\n\n')))

    with open(f'../res/d1.vcd', 'w') as f:
        for eid, elve in enumerate(elves):
            f.write(f'$scope module elve{eid} $end\n')
            for fid, food in enumerate(elve):
                f.write(f'$var wire 32 e{eid}f{fid} e{eid}f{fid} $end\n')
                
            f.write(f'$upscope $end\n')

        f.write('#0\n$dumpvars\n')
        for eid, elve in enumerate(elves):
            for fid, food in enumerate(elve):
                food = int(food)
                f.write(f'b{food:b} e{eid}f{fid}\n')
    
#         f.write('''
# $var wire 32 # data $end
# $enddefinitions $end
# $dumpvars''')

#         f.write("b{0:b} #\n$end\n".format(puzzle[0]))

#         i = 0
#         for number in puzzle:
#             f.write('#' + str(i) + '\n')
#             f.write("b{0:b} #\n".format(number))
#             i += 1

#         #f.write('#' + str(i) + '\n')
#         #f.write('b00000000000000000000000000000000 #')
