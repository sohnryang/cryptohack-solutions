import json

from Crypto.Util.number import long_to_bytes

with open("messages.json") as f:
    messages = json.load(f)

exp_pub = 11
N = messages[0]["modulus"]
Z_N = Zmod(N)
R.<x> = PolynomialRing(Z_N)

def get_poly(message_info):
    alpha, beta = message_info["padding"]
    ciphertext = message_info["encrypted_flag"]
    return (alpha * x + beta)^exp_pub - ciphertext

poly_a = get_poly(messages[0])
poly_b = get_poly(messages[1])

while poly_b != 0:
    poly_a, poly_b = poly_b , poly_a % poly_b

poly_gcd = poly_a / poly_a.lc()
print(f"[+] GCD = {poly_gcd}")

roots = poly_gcd.small_roots(multiplicities=False)
assert len(roots) == 1
message = roots[0]
print(f"[+] Recovered message: {long_to_bytes(int(message))}")
