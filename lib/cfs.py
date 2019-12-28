import csv
import os
import sys

import cfscrape

scraper = cfscrape.create_scraper()

filename = 'nazm_urls.csv'
with open(filename, 'rb') as f:
    reader = csv.reader(f)
    try:
        for row in reader:
            if 'http' in row[0]:
                reverse = row[0][::-1]
                i = reverse.index('/')
                tmp = reverse[0:i]
                cfurl = scraper.get(row[0]).content
                if not os.path.exists("./"+tmp[::-1]):
                    with open(tmp[::-1], 'wb') as f:
                        f.write(cfurl)
                        f.close()
                else:
                    print("file: ", tmp[::-1], "already exists")
    except csv.Error as e:
        sys.exit('file %s, line %d: %s' % (filename, reader.line_num, e))
