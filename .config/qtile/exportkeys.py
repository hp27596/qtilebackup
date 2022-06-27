#!/usr/bin/env python3
from config import keys

keys.sort(key=lambda x: x.modifiers)
clnlist = {}

for i in keys:
    if 'XF86' in i.key:
        continue
    else:
        keybind = ''
        for j in i.modifiers:
            if j == 'mod4':
                j = 'Meta'
            if j == 'mod1':
                j = 'Alt'
            if j == 'shift':
                j = 'Shift'
            if j == 'control':
                j = 'Ctrl'

            keybind = keybind + j + ' '

        if i.key == 'space':
            i.key = 'Space'
            pass
        else:
            pass

        keybind = keybind + i.key
        clnlist.update( {keybind : i.desc} )


for key, desc in clnlist.items():
    print(key, '=', desc)
