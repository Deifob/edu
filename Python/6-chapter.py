#1
def greet(name):
    print(f"Hello, {name}!")
#2
def square(x): 
    return x * x
#3 
def if_even(num) :
    if num % 2 ==0:
        return True
    else:
        return False
#4
def max_of_three(a,b,c):
    if a >= b and c <=a:  
        return a
    if b>=a and b>=c :  
        return b
    if c>=b and c>=a:
        return c 
#5
def if_polindrom(str):
    for i in range(round( len (str)/2)):
        if str [i]!= str[-i]:
            return False
    return True
#6
def delivery_cost(total):
    if total > 1500:
        return 0
    else:
        return 199
#7
def list_average(numbers):
    sum = 0
    for number in numbers:
        sum +=number
    return round(sum/len(number))
#8
def count_char(text, char):
    n = 0
    for letter in text.lower():
        if(letter==char):
            n += 1
    return n
#9
def normalize_name(name):
    name = name.strip()
    a = name[0]
    b = name[1::]
    a = a.upper()
    b = b.lower()
    return a + b
#10
def line_total(price, quantity):
    print("Total price is", price * quantity)
def order_total(quantity):
    print("Order Total:", quantity)
