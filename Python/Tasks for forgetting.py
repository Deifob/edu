#1
def solve(nums):
    m = []
    for i in range(len(nums)):
        m.append(nums[len(nums) - 1 - i])
    return m
#2
def solve(s):
    m = s[::-1]
    if m == s:
        return True
    else:
        return False
#3
def solve(nums):
    if len(nums) == 0:
        return None
    else:
        nums_max = nums[0]
        for x in nums:
            if (x > nums_max):
                nums_max=x
        return nums_max

