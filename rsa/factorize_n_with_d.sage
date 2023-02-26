N = Integer(int(input("N = "), 0))
e = Integer(int(input("e = "), 0))
d = Integer(int(input("d = "), 0))

k = d * e - 1
while True:
    g = randrange(2, N)
    print(f"Trying g = {g}")
    t = k
    found = False
    while True:
        if t % 2 != 0:
            break
        t //= 2
        x = Integer(pow(g, t, N))
        if x > 1 and (y := gcd(x - 1, N)) > 1:
            p = y
            assert N % y == 0
            q = N // y
            print(f"p = {p}")
            print(f"q = {q}")
            found = True
    if found:
        break
