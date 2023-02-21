import base64
import codecs
import json

import pwn
from Crypto.Util.number import long_to_bytes

io = pwn.remote("socket.cryptohack.org", 13377)
while True:
    inp = json.loads(io.recvline())
    pwn.info(f"input: {inp}")
    if "flag" in inp:
        print(inp["flag"])
        break
    encoded = inp["encoded"]
    if inp["type"] == "base64":
        out = base64.b64decode(encoded).decode()
    elif inp["type"] == "hex":
        out = long_to_bytes(int(encoded, 16)).decode()
    elif inp["type"] == "rot13":
        out = codecs.decode(encoded, "rot_13")
    elif inp["type"] == "bigint":
        out = long_to_bytes(int(encoded, 16)).decode()
    elif inp["type"] == "utf-8":
        out = bytes(encoded).decode()
    else:
        raise NotImplemented
    out_json = json.dumps({"decoded": out})
    pwn.info(f"output: {out_json}")
    io.sendline(out_json.encode())
