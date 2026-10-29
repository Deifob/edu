#!
point = (55.7558, 37.6173)
latitude , longitude = point
#2
list_1 = [1, 2, 3]
list_1[0] = 101
tup = (1, 2, 3)
try: 
    tup[0] = 101
except TypeError as e:
    print(e)
#3
list_1 = [1, 2, 2, 3, 4, 5, 5]
set_1 = set(list_1)
print(len(set_1))
#4
statuses = {'a', 'b', 'c'}
status = 'a'
if status in statuses :
    print('OK') 
else :  
    print('No')
#5
a = {1, 2, 3}
b = {2, 3, 4, 5}
c = a & b
#6
d = a - b
#7
tegs_a = ['a', 'b', 'c']
tags_b= ['b', 'd']
c = set(tegs_a + tags_b)
#8
values = [3, 2, 1, 3, 2]
unique = list(set(values))

print(unique)  # Порядок не следует считать гарантированным.
#9
values = [3, 2, 1, 3, 2]
unique = []
for i in values:
    if (i not in unique):    
        unique.append(i)
print(unique)
#10
answers_list = ['a', 'b', 'c', 'c', 'a', 'f']
answers_set=set(answers_list)
print(len(answers_set), len(answers_set)/len(answers_list))

















