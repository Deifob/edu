#№1
print("Привет, Python!", "\n", "Михаил")
#2
name, age, city = "Mike", 22, "Moscow"
print(f"{name} live in {city} {age} years")
#3
price = 3490
discount = 700
all = price - discount
print(all)
#4
time = 135
hours = time//60
minute = time%60
print(hours, minute)
#5
a, b = 8.5, 4
S = a * b
P = 2 * (a + b)
print(S, P)
#6
balance = 2500
delta = 499
balance -= delta
print(balance)
delta = 120
balance -= delta
print(balance)
delta = 850
balance -= delta
print(balance)
#7
a_str = "125"
a_int = int(a_str)
a_int += 25
print(a_int, type(a_int))
#8
C = 23.6
F = C * 9 / 5 + 32
print(F)
#9
first_name = "Mike"
last_name = "Korotnev"
print(f"{first_name} {last_name}")
#10
product = "product"
price = 9.95
count = 8
all = price * count
print(f"Product:{product}\nPrice:{price}\nCount:{count}\nAll:{all}")

