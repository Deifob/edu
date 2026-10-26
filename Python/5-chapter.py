#1
a_str = 'teshdcfvgkbh'
for i in a_str:
    print(i)
#2
a_str = 'teshdcfvgkbh'
n = 0
for i in a_str:
    n += 1
print(n)
#3
a_str = 'tesh dcfvg kbh'
n = 0
for i in a_str:
    if i == ' ':
        n += 1
print(n)
#4
a_str = 'teshd cfvgkbh'
a = round(len(a_str)/2)
print(a_str[1], a_str[-1], a_str[a])
#5
a_str = ' teshd cfVVgkbh '
a_str = a_str.lower().strip()
print(a_str)
#6
a_str = 'teshducfvgkbh'
a_str = a_str.lower()
n = 0
for i in a_str:
    if i in 'eyuoaj':
        n += 1
print(n)
#7
a_str = 'teshducfvgkbh'
a_str = a_str[::-1]
print(a_str)
#8
a_str = ' teshd cfVVgkbh '
a_str = a_str.lower().strip()
print(a_str == a_str[::-1])
#9
a_str = ' teshd cfVVgkbh '
n = 0
for i in range(round(len(a_str)/2)):
    if a_str[i] == a_str[i * -1]:
        n += 1
print(n == round(len(a_str)/2))
#10
a_str = ' teshd cfVVgkbh '
a = 'f'
n = -1
p = 0
for i in a_str:
    if i == a:
        n = p
    p += 1
print(n)














