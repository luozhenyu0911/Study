#coding=utf-8
from __future__ import print_function 
from __future__ import division
import sys
import pandas as pd
import argparse
example_text = '''example:
    python this.py 
'''
parser = argparse.ArgumentParser(description="The script is to .",
                                formatter_class= argparse.RawTextHelpFormatter,
                                usage = '%(prog)s [-h]',                         
                                epilog=example_text)

parser.add_argument('--expression_matrix','-e',type=str,help="Expression_matrix",required= True,metavar='')
parser.add_argument('--genome_bed_file', '-g',type= str,help="",required= True,metavar='')
parser.add_argument('--prefix', '-p',type= str,help="",required= True,metavar='')
args = parser.parse_args()

expr_=args.expression_matrix
genome_bed=args.genome_bed_file
prefix=args.prefix
