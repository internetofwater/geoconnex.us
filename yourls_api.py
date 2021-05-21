# =================================================================
#
# Author: Ben Webb
# File: yourls_api.py
# Date: 4/1/2021
#
# =================================================================

from pyourls3.client import *
import csv

class yourls(Yourls):
    def __init__(self, **kwargs):
        self.kwargs = kwargs
        _ = self._check_kwargs(('addr', 'user', 'passwd', 'key'))
        Yourls.__init__(self, *[v for k, v in _])

    def _check_kwargs(self, keys):
        """
        Parses kwargs for desired keys.

        :param keys: required, list. List of keys to retried from **kwargs.
        :return: generator. Generator of key value pairs for each key in **kwargs.

        :raises: pyourls3.exceptions.Pyourls3ParamError
        """
        for key in keys:
            if key in self.kwargs.keys():
                yield key, self.kwargs.get(key)
            else:
                raise exceptions.Pyourls3ParamError(key)

    def check_kwargs(self, keys, **kwargs):
        """
        Parses kwargs for desired keys.

        :param keys: required, list. List of keys to retried from **kwargs.
        :param **kwargs: required, dict.
        :return: generator. Generator of key value pairs for each key in **kwargs.

        :raises: pyourls3.exceptions.Pyourls3ParamError
        """
        for key in keys:
            if key in kwargs.keys():
                yield key, kwargs.get(key)
            else:
                raise exceptions.Pyourls3ParamError(key)

    def shorten_quick(self, **kwargs):
        """
        Sends an API request to shorten a specified URL.

        :param **kwargs: required, dict. Expects url, keyword, and title to be specified.
        :return: dictionary. Full JSON response from the API, parsed into a dict

        :raises: pyourls3.exceptions.Pyourls3ParamError, pyourls3.exceptions.Pyourls3HTTPError,
          pyourls3.exceptions.Pyourls3APIError
        """
        _ = self.check_kwargs(('url', 'keyword', 'title'), **kwargs)
        specific_args = {'action': 'shorten_quick', **{k: v for k, v in _}}

        r = requests.post(self.api_endpoint, data={**self.global_args, **specific_args})
        try:
            j = r.json()
        except json.decoder.JSONDecodeError:
            raise exceptions.Pyourls3HTTPError(r.status_code, self.api_endpoint)

        if j.get("status") == "success":
            return j
        else:
            raise exceptions.Pyourls3APIError(j["message"], j.get("code", j.get("errorCode")))


    def shorten_csv(self, filename, csv = ''):
        """
        Sends an API request to shorten a specified CSV.

        :param filename: required, string. Name of CSV to be shortened.
        :param csv: optional, list. Pre-parsed csv as list of strings.
        :return: dictionary. Full JSON response from the API, parsed into a dict

        :raises: pyourls3.exceptions.Pyourls3ParamError, pyourls3.exceptions.Pyourls3HTTPError,
          pyourls3.exceptions.Pyourls3APIError
        """
        if not filename:
            raise exceptions.Pyourls3ParamError('filename')

        specific_args = {'action': 'shorten_csv'}

        if csv:
            file = {'import': (filename, csv, 'text/csv')}
        else:
            file = {'import': (filename, open(filename, 'r'), 'text/csv')}

        r = requests.post(self.api_endpoint,
                          data={**self.global_args, **specific_args},
                          files=file)

        try:
            j = r.json()
        except json.decoder.JSONDecodeError:
            raise exceptions.Pyourls3HTTPError(r.status_code, self.api_endpoint)

        if j.get("status") == "success":
            return j
        else:
            raise exceptions.Pyourls3APIError(j["message"], j.get("code", j.get("errorCode")))

    def _handle_csvs(self, files):
        """
        Splits list of csv files into individual csv files.

        :param files: required, string. URL to be shortened.
        """
        for f in files:
            self.handle_csv(f)

    def handle_csv(self, file):
        """
        Parses and shortens CSV file.

        :param file: required, string or list of strings. Name of csv files to be shortened
        """
        if isinstance(file, list):
            self._handle_csvs(file)
            return

        parsed_csv = self.parse_csv(file)
        chunky_parsed = self.chunkify( parsed_csv )

        for chunk in chunky_parsed:
            r = self.shorten_csv(file, chunk)      

    def parse_csv(self, filename):
        """
        Parse CSV file into yourls-friendly csv.

        :param filename: required, string. URL to be shortened.
        :return: list. Parsed csv.
        """
        _ = self._check_kwargs(('url', 'keyword', 'title'))
        vals = {k: v for k, v in _}

        try:
            r = requests.get(filename)
            fp = r.content.decode().splitlines()
        except requests.exceptions.MissingSchema:
            r = None
            fp = open(filename, mode='r')

        csv_reader = csv.reader(fp)
        headers = [h.strip() for h in next(csv_reader)]
        ret_csv = []
        for line in csv_reader:
            parsed_line = []
            for k, v in vals.items():
                try:
                    parsed_line.append( line[headers.index(v)].strip() )
                except (ValueError, IndexError):
                    continue
            _ = self._check_kwargs(['uri_stem',])
            ret_csv.append((','.join(parsed_line) + '\n').replace(*[v for k, v in _], ''))

        if not r:
            fp.close()

        return ret_csv

    def chunkify(self, input, n=500):
        """
        Breaks a list of strings into chunks.

        :param input: required, list. List to be chunkified.
        :param n: optional, int. Size of each chunk.
        :return: list. Input list with each sublist length up to the size of n.
        """
        return [''.join(input[i:i + n]) for i in range(0, len(input), n)]
