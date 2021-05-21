# =================================================================
#
# Author: Ben Webb
# File: yourls_client.py
# Date: 4/1/2021
#
# =================================================================

import os
import yourls_api
import argparse

def walk_path(path):
    """
    Walks os directory path collecting all CSV files.

    :param path: required, string. os directory.
    :return: list. List of csv paths.
    """
    file_list = []
    for root, _, files in os.walk(path, topdown=False):
        for name in files:
            if name.startswith('example'):
                continue
            elif name.endswith('.csv'):
                file_list.append(os.path.join(root, name))

    return file_list

def make_parser():
    """
    Creates and argv parser object.

    :return: ArgumentParser. with defaults if not specified.
    """
    parser = argparse.ArgumentParser(description='Upload csv files to yourls database')

    parser.add_argument('path', type=str, nargs='+',
                        help='path to csv files. accepts directory, url, and .csv paths')
    parser.add_argument('-s','--uri_stem', action='store', dest='uri_stem', type=str,
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
    
    urls = yourls_api.yourls( **vars(kwargs) )
    
    for p in kwargs.path:
        if p.endswith('.csv'):
            urls.handle_csv( p )
        else:
            urls.handle_csv( walk_path(p) )

if __name__ == "__main__":
    main()
