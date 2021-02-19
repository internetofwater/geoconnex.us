import pyourls3, csv
import xml.etree.ElementTree as ET
from os import listdir


def main():
    db_host = 'http://localhost:8082'
    db_user = 'example_user'
    db_pass = 'example_pass'
    try:
        urls = pyourls3.Yourls(db_host, user=db_user, passwd=db_pass)
        path = '../../BACKUP/backup_current/'
        backup_list = listdir(path)
    except:
        print('Usage: python python/populate_db.py')
        exit()

    for filename in backup_list:
        try:
            print('Opening', path + filename)
            tree = ET.parse(path + filename)
            root = tree.getroot()
        except:
            print('BAD PATH: ', path + filename)

        entries = [0,0]
        for child in root:
            try:
                urls.shorten(child[4][2].text, keyword=child[0].text, title=child[2].text)
                entries[0] += 1
            except:
                entries[1] += 1

        print(entries)

def write_to_csv(filename, data):
    with open(filename, 'w') as fp:
        csv_writer = csv.writer(fp)
        for row in range(len(data)):
            csv_writer.writerow(data[row])

if __name__ == "__main__":
    main()
