#1
m = [1, 2, 3, 4, 5, 6, 7]
print(m[0], m[2], m[-1])
#2
m = [1, 2, 3, 4, 5, 6, 7]
n = 0
for i in m:
    n += 1
print(n)
#3
m = [1, 2, 3, 4, 5, 6, 7]
for i in range(len(m)):
    m[i] += 1
print(m)
#4
l = [100, 50, 200, 300, 50, 100]
m =[]
for i in l:
    if i <=100:
        m.append(i)
print(m)
#5
m = [1, 2, 2, 3, 4]
m_sum, m_avg = 0, 0
for i in m:
    m_sum += i
m_avg = m_sum / len(m)
print(m_sum, m_avg)
#6
m = []
for i in range(1, 11):
    m.append(i*i)
print(m)
#7
a = [1, 2]
b = [3, 5]
m = a + b
print(m)
#8
m = [1, 2, 3, 4, 5, 6, 7]
m = m[1:5]
print(m)
#9
m = [1, 2, 3, 4, 5, 6, 7]
n = []
p = []
for i in range(len(m)):
    n.append(m[len(m)-1 - i])
p = m[::-1]
print(n, p)
#10
m = [1, 2, 3, 4, 0, 6, 7]
m_min = m[0]
m_index = 0
for i in range(len(m)):
    if m[i] < m_min:
        m_min = m[i]
        m_index = i
print(m_index, m_min)




