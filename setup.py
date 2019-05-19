# To replace python with python3
with open("api.sh") as f:
    newText=f.read().replace('python', 'python3')

with open("api.sh", "w") as f:
    f.write(newText)
