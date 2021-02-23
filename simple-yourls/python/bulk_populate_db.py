import pyourls3, sys, os

def main(argv):
    db_host = 'http://localhost:8082'
    db_user = 'yourls-admin'
    db_pass = 'apassword'
    path = 'www.google.com/'
    try:
        rand_list = list(range(int(argv[1]), int(argv[2])))
        urls = pyourls3.Yourls(db_host, user=db_user, passwd=db_pass)
    except:
        print('Usage: python python/bulk_populate.py range_start range_end')
        exit()

    for ele in list(rand_list):
        ele = str(ele)
        try:
            urls.shorten(path + ele, keyword=ele, title='filler entry' + ele)
        except pyourls3.exceptions.Pyourls3APIError:
            continue
        except KeyboardInterrupt:
            print('Ended on ', ele)
            exit()
    print('Added files: ' + argv[1] + ' - ' + argv[2])

if __name__ == "__main__":
    main(sys.argv)
