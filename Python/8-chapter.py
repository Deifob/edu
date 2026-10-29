#1
products = {
    'milk' : 95,
    'juce' : 110,
    'meet' : 200,
    'tomatos' : 155,
    'orange' : 145
}
#2
products['potato'] = 50
products['meet'] = 210
#3
for x in products:
    print(x)
for x in products:
    print(products[x])
#4
a_str = 'edrftgygyfxd'
a_dict = {}
for x in a_str:
    a_dict[x] = 0
for x in a_str:
    a_dict[x] +=1
print(a_dict)
#5
a_listword = ['word1', 'word2', 'word2', 'word3']
a_dict = {}
for x in a_listword:
    a_dict[x] = 0
for x in a_listword:
    a_dict[x] += 1
print(a_dict)
#6
sale_dict = {
    'manager1' : 11,
    'manager2' : 9,
    'manager3' : 12,
    'manager4' : 13
}
max_sale = -1
top_manager = 'None'
for key in sale_dict:
    if sale_dict[key] > max_sale:
        top_manager = key
print(top_manager)
#7
dict_numbers = {}
for i in range(1,11):
    dict_numbers[i] = i * i
print(dict_numbers)
#8
uniqe_dict = {
    'manager1' : 11,
    'manager2' : 9,
    'manager3' : 12,
    'manager4' : 13
}
dict_revers = {}
for x in uniqe_dict:
    dict_revers[uniqe_dict[x]] = x

print(dict_revers)
#9
sale_dict1 = {
    'manager1' : 11,
    'manager2' : 9,
    'manager3' : 12,
    'manager4' : 13
}
sale_dict2 = {
    'manager3' : 11,
    'manager4' : 9,
    'manager5' : 14
}
keys = set(list(sale_dict1.keys()) + list(sale_dict2.keys()))

new_dict = {}
for x in keys:
    new_dict[x] = 0
for x in sale_dict1:
    new_dict[x] += sale_dict1[x]
for x in sale_dict2:
    new_dict[x] += sale_dict2[x]
print(new_dict)
#10
dict_profile = {
    'name' : 'Mike',
    'email' : 'mike34@pochta.com'
}
print(dict_profile.get('name', -1))
print(dict_profile.get('email', -1))
print(dict_profile.get('age', -1))







