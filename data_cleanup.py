#!/usr/bin/env python
#-*- coding: utf-8 -*-

import re
import os


def clean(lines):
    """Convert encoded characters to ascii because eff that noise.
    Also convert ^ to tab, get rid of ~, etc. Basically do whatever
    it takes to get postgres to import the data.
    """
    for line in lines:
        line = line.decode('latin-1')
        line = (
            line
            .replace("~", "")
            .replace("^", "\t")
            .replace(u"µ", "u")
            .replace(u"é", "e"))

        line = re.sub(r'(\d)"', r'\1 inch', line)
        line = line.replace('"', '')

        yield line.encode('ascii')


def main():
    import sys
    import argparse

    parser = argparse.ArgumentParser(
        description="Make clean TSV data from USDA nutrient db text files.")
    parser.add_argument(
        "path", metavar="PATH", help="Text file containing USDA nutrient data.")

    args = parser.parse_args(sys.argv[1:])

    with open(args.path, 'r') as f:
        for line in clean(f):
            print line


if __name__ == "__main__":
    main()
