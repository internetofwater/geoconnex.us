import pyourls3, os, time, sys
import xml.etree.ElementTree as ET

def main(argv):
    db_host = 'http://localhost:8082'
    db_user = 'yourls-admin'
    db_pass = 'apassword'
    path = '../../BACKUP/backup_current/'

    try:
        urls = pyourls3.Yourls(db_host, user=db_user, passwd=db_pass)
        backup_list = os.listdir(path)
        backup_list.remove('.DS_Store')

        if len(argv) > 1:
            for i in argv:
                if i.lower() == '-s':
                    backup_list = sorted(backup_list)
                elif i.lower() == '-r':
                    backup_list = [backup_list.pop() for f in backup_list]

    except:
        print('Usage: python populate_db.py [optional flags -S -R]')
        print('-s|S\tSort alphabetically\n-r|R\tReverse order')
        exit()

    for filename in backup_list:
        t = time.time()
        root = ET.parse(path + filename).getroot()
        entries = {'success': 0, 'preexisting': 0}

        for child in root:
            long_url = child[4][2].text
            short_url = child[0].text.replace('/', '', 1)
            title = child[2].text
            print('\r', short_url, end='')
            try:
                urls.expand(short_url)
                entries['preexisting'] += 1
            except KeyError:
                urls.shorten(long_url, keyword=short_url, title=title)
                entries['success'] += 1

        print('\r', filename, 'in % .2f seconds :' % (time.time()-t), entries)

if __name__ == "__main__":
    main(sys.argv)
