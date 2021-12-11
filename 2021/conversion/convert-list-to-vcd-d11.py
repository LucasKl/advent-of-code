data = '''5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526'''

data = data.split('\n')

with open('../res/d11.wal', 'w') as f:
    f.write(f'(set [mx {len(data[0])}])\n')
    f.write(f'(set [my {len(data)}])\n\n')
    f.write('(defun init []\n')
    f.write('  (set [init (array)])\n')
    for y, row in enumerate(data):
        for x, v in enumerate(row):
            f.write(f'  (seta init {x} {y} {v})\n')


    f.write('  init)\n')
