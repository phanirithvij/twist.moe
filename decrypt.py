# Code taken from
# https://github.com/vn-ki/anime-downloader
# All rights to Vishnunarayan K I

import base64
import sys
from hashlib import md5

from Cryptodome import Random
from Cryptodome.Cipher import AES
from requests.utils import quote

BLOCK_SIZE = 16
KEY = b"LXgIVP&PorO68Rq7dTx8N^lP!Fa5sGJ^*XK"
# From stackoverflow https://stackoverflow.com/questions/36762098/how-to-decrypt-password-from-javascript-cryptojs-aes-encryptpassword-passphras


def pad(data):
    print(data)
    print(type(data))
    length = BLOCK_SIZE - (len(data) % BLOCK_SIZE)
    print(type(chr(length)*length))
    print(type((chr(length)*length).encode()))
    return data + (chr(length)*length).encode()


def unpad(data):
    # print(data)
    daa = [o for o in data]
    print(daa)
    # print(len(data))
    # print(type(data))
    # print(data[-1])
    # print(type(data[-1]))
    # print(ord(data[-1]))
    return data[:-(data[-1] if type(data[-1]) == int else ord(data[-1]))]


def bytes_to_key(data, salt, output=48):
    # extended from https://gist.github.com/gsakkis/4546068
    assert len(salt) == 8, len(salt)
    print(data.__len__())
    data += salt
    print([x for x in data])
    print(data.__len__())
    print('Final----')
    key = md5(data).digest()
    final_key = key
    while len(final_key) < output:
        key = md5(key + data).digest()
        print("c", len(key))
        final_key += key
        print("s", len(final_key))
    return final_key[:output]


def decrypt(encrypted, passphrase):
    encrypted = base64.b64decode(encrypted)
    assert encrypted[0:8] == b"Salted__"
    salt = encrypted[8:16]
    # print([x for x in salt])
    key_iv = bytes_to_key(passphrase, salt, 32+16)
    key = key_iv[:32]
    iv = key_iv[32:]
    print([x for x in key_iv])
    aes = AES.new(key, AES.MODE_CBC, iv)
    return unpad(aes.decrypt(encrypted[16:]))


def decrypt_export(url):
    decrypt_ed = decrypt((url).encode('utf-8'),
                         KEY).decode('utf-8').lstrip(' ')
    escap_ed = quote(decrypt_ed, safe='~@#$&()*!+=:;,.?/\'')
    return escap_ed


if __name__ == '__main__':
    if sys.argv:
        if len(sys.argv[1:]) > 1:
            # sending a file_name as the argument
            # e.g: python3 decrypt.py file_name.txt anything ...
            file_name = sys.argv[1]
            with open(file_name) as fn:
                for l in fn.readlines():
                    decrypt_ed = decrypt(
                        l.encode('utf-8'), KEY).decode('utf-8').lstrip(' ')
                    # https://stackoverflow.com/a/6618858/8608146
                    escap_ed = quote(decrypt_ed, safe='~@#$&()*!+=:;,.?/\'')
                    print(escap_ed)
        elif len(sys.argv[1:]) == 1:
            decrypt_ed = decrypt((sys.argv[1]).encode(
                'utf-8'), KEY).decode('utf-8').lstrip(' ')
            escap_ed = quote(decrypt_ed, safe='~@#$&()*!+=:;,.?/\'')
            print(escap_ed)
