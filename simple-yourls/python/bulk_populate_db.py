import pyourls3, sys, os

def main(argv):
    try:
        rand_list = list(range(int(argv[1]), int(argv[2])))
        db_host = 'http://localhost:8082'
        db_user = 'example_user'
        db_pass = 'example_pass'
        urls = pyourls3.Yourls(db_host, user=db_user, passwd=db_pass)
    except:
        print('Usage: python python/bulk_populate.py range_start range_end')
        exit()

    for e in list(rand_list):
        e = str(e)
        try:
            urls.shorten('www.google.com/'+e, keyword=e, title='Fake entry' + e)
        except:
            continue

if __name__ == "__main__":
    main(sys.argv)
