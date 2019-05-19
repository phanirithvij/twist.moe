import sys
import json

sources = json.load(sys.stdin)
[print(s['source']) for s in sources]
