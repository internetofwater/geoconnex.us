# =================================================================
#
# Author: Ben Webb
# File: populate_db.py
# Date: 4/1/2021
#
# =================================================================

import yourls_api
import os
import time
import xml.etree.ElementTree as ET
import argparse

def make_parser():
    """
    Creates and argv parser object.

    :return: ArgumentParser. with defaults if not specified.
    """
    parser = argparse.ArgumentParser(description='Upload csv files to yourls database')

    parser.add_argument('path', type=str, nargs='+',
                        help='path to csv files. accepts directory, url, and .csv paths')
    parser.add_argument('-s','--sort', dest='sort', action='store_const', const=sorted,
                        default=sorted,
                        help='Sort csv files')
    parser.add_argument('-r','--rev', dest='rev', action='store_const', const=reversed,
                        default=reversed,
                        help='Reverse sort files')
    parser.add_argument('--uri_stem', action='store', dest='uri_stem', type=str,
                        default='https://geoconnex.us/',
                        help='uri stem to be removed from short url for keyword')
    parser.add_argument('-k','--keyword', action='store', dest='keyword', type=str,
                        default='id',
                        help='field in CSV to be used as keyword')
    parser.add_argument('-l','--long_url', action='store', dest='url', type=str,
                        default='target',
                        help='field in CSV to be used as long url')
    parser.add_argument('-t','--title', action='store', dest='title', type=str,
                        default='description',
                        help='field in CSV to be used as title')
    parser.add_argument('-a','--addr', action='store', dest='addr', type=str,
                        default='http://localhost:8082/',
                        help='yourls database hostname')
    parser.add_argument('-u','--user', action='store', dest='user', type=str,
                        default='yourls-admin',
                        help='user for yourls database')
    parser.add_argument('-p','--pass', action='store', dest='passwd', type=str,
                        default='apassword',
                        help='password for yourls database')  
    parser.add_argument('--key', action='store', dest='key', 
                        default=None,
                        help='password for yourls database') 
    return parser

def main():

    parser = make_parser()
    kwargs = parser.parse_args()

    urls = yourls_api.yourls(**vars(kwargs))

    path = str(*kwargs.path)
    backup_list = os.listdir(path)
    backup_list.remove('.DS_Store')

    backup_list = kwargs.sort(backup_list)
    backup_list = kwargs.rev(backup_list)

    for filename in backup_list:
        t = time.time()
        root = ET.parse(path + filename).getroot()
        entries = {'success': 0, 'preexisting': 0}

        for child in root:
            long_url = child[4][2].text
            short_url = child[0].text.replace('/', '', 1)
            title = child[2].text
            try:
                urls.shorten_quick(url=long_url, keyword=short_url, title=title)
                entries['success'] += 1
            except yourls_api.exceptions.Pyourls3HTTPError:
                entries['preexisting'] += 1
        # print('\r', filename, 'in % .2f seconds :' % (time.time()-t), entries)

if __name__ == "__main__":
    main()
