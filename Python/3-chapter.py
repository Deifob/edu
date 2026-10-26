#1
for i in range(1, 11):
    print(i)
#2
n = int(input())
sum = 0
for i in range(n+1):
    sum += i
print(sum)
#3
n = int(input())
for i in range(1, 11):
    print(i * n)
#4
n = 0
for i in range(101):
    if i%3 == 0 and i % 5 == 0:
        n+=1
print(n)
#5
for i in range(20, 1, -2):
    print(i)
#6
a_str = 'aaakkkagkja'
n = 0
for i in range(len(a_str)):
    if a_str[i] == "a":
        n+=1
print(n)
#7
a = [1, 2, 0, 0]
n = 0
for i in a:
    if i > 0:
        n += 1
print(n)
#8
n = 100
while True:
    n += 1
    if n % 17 == 0:
        print(n)
        break
#9
for i in range(1, 31):
    if i % 4 == 0:
        continue
    print(i)
#10
amount = 372
delta = 55
n = 0
while amount > 0:
    n += 1
    amount -= delta
print(n)













