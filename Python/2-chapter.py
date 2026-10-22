#1
a = int(input())
if a > 0:
    print("Положительное")
elif a == 0:
    print("ноль")
elif a < 0:
    print("Отрицательное")
#2
sum = int(input())
dev = 0
if sum < 1500:
    sum += 199
    dev += 199
print(sum, dev)
#3
b = int(input())
b = b % 2
if b == 0:
    print("четное")
else:
    print("не четное")
#4
y = int(input())
if y < 13:
    print("ребенок")
elif 13 <= y < 18:
    print("подросток")
elif 18 <= y < 65:
    print("взрослый")
else:
    print("пенсионер")
#5
c, d, e = int(input()), int(input()), int(input())
if c >= d and c >= e:
    print("max = c")
elif d >= c and d >= e:
    print("max = d")
else:
    print("max = e")
#6
t = int(input())
if 18 <= t <= 25 :
    print("yes")
else:
    print("no")
#7
str1 = input()
bool1 = (str1=="авторизован")
str2 = input()
parol = "parol"
bool2 = (str2 == parol)
if bool1 and bool2:
    print("sucses")
else:
    print("no")
#8
balance = int(input())
bool3 = ('rain' == input())
if balance > 2000 and bool3:
    print("taxi")
else:
    print("metro")
#9
bal = int(input())
if bal > 90:
    print("A")
elif bal > 80:
    print("B")
elif bal > 60:
    print("C")
elif bal > 40:
    print("D")
else:
    print("E")
#10
price = int(input())
day = input()
person = input()
if day == "weekend":
    price *= 1.2
if person == "kid" or person == "пенсионер":
    price -= 100
print(price)