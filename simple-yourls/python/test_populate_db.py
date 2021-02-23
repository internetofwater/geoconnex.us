import pyourls3, os, time
import xml.etree.ElementTree as ET

def main():
    db_host = 'http://localhost:8082'
    db_user = 'yourls-admin'
    db_pass = 'apassword'
    path = '../../BACKUP/backup_current/'

    try:
        urls = pyourls3.Yourls(db_host, user=db_user, passwd=db_pass)
        backup_list = sorted(os.listdir(path), reverse=False)
        backup_list.remove('.DS_Store')
    except:
        print('Usage: python python/populate_db.py')
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
            try:
                urls.expand(child[0].text)
                entries['preexisting'] += 1
                continue
            except KeyError:
                try:
                    urls.shorten(child[4][2].text, keyword=child[0].text, title=child[2].text)
                    entries['success'] += 1
                    continue
                except pyourls3.exceptions.Pyourls3URLAlreadyExistsError:
                    entries['fail'] += 1
                    continue

        print(filename, ': %2.2f seconds :' % (time.time()-t), entries)


if __name__ == "__main__":
    main()
