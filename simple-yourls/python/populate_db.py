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

        if len(argv) != 1 and argv[1].lower() == 'false':
            backup_list = sorted(backup_list, reverse=True)
            for i in range(118):
                backup_list.pop(0)
        elif len(argv) != 1 and argv[1].lower() == 'true':
            backup_list = sorted(backup_list)
            for i in range(162):
                backup_list.pop(0)
        else:
            for i in range(124):
                backup_list.pop(0)

    except:
        print('Usage: python populate_db.py [optional_bool:sorted_in_order]')
        exit()

    for filename in backup_list:
        t = time.time()
        try:
            # print('Opening ', filename)
            tree = ET.parse(path + filename)
            root = tree.getroot()
        except ET.ParseError:
            print('Bad encoding', path + filename)
            continue

        entries = {'success': 0, 'fail': 0, 'preexisting': 0}
        for child in root:
            print('\r', child[0].text.replace('/', '', 1), end='')
            try:
                urls.expand(child[0].text.replace('/', '', 1))
                entries['preexisting'] += 1
            except KeyError:
                try:
                    urls.shorten(child[4][2].text, keyword=child[0].text.replace('/', '', 1), title=child[2].text)
                    entries['success'] += 1
                except:
                    entries['fail'] += 1

        print('\r', filename, ': % .2f seconds :' % (time.time()-t), entries)


if __name__ == "__main__":
    main(sys.argv)
