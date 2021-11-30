#!/usr/bin/env python3
"""
Author : madelinemelichar <madelinemelichar@localhost>
Date   : 2021-11-29
Purpose: BE 502 Lab 3

Using Python, write at least two functions (one main function
and other(s) being support functions). The main function takes
two time periods, and return a tuple (or dictionary) of the
total amount of good quality rain for each of the two periods,
the number of gauges for recording the rains, and the number of
shared gauges between the two time periods. 
Submit a source file with ".py" as the file extension name and
a report briefly summarizing the function design and the results. 

"""

import argparse
import numpy as np
import pandas as pd


# --------------------------------------------------
def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='Rain data for given time periods',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('timeperiod',
                        type=str,
                        help='Time period in the form "yyyy-yyyy"')
    
    parser.add_argument('file',
                        type=str,
                        default=None,
                        help='Input file (.csv)')

    return parser.parse_args()


# --------------------------------------------------
def get_summary(data,timeperiod):
    summary = {}
    gauges = []
    for year in timeperiod:
        year_dt = data[(data['readingDate'].str.contains(year)) & (data['quality']=='Good')]
        total_rain = round(sum(year_dt['rainAmount']),3)
        total_gauges = len(np.unique(year_dt['gaugeId']))
        gauges.append(list(year_dt['gaugeId']))
        summary[year] = ["Total rain = {}".format(total_rain), "Total gauges = {}".format(total_gauges)]

    gauge_set1 = set(gauges[0])
    gauge_set2 = set(gauges[1])
    shared_gauges = len(gauge_set1.intersection(gauge_set2))
    summary[timeperiod[0]].append("Shared gauges = {}".format(shared_gauges))
    summary[timeperiod[1]].append("Shared gauges = {}".format(shared_gauges))

    return summary


# --------------------------------------------------
def main():
    """Run main"""
    args=get_args()
    rain_dt = pd.read_csv(args.file, index_col=0)
    print(get_summary(rain_dt, args.timeperiod.split("-")))
    

# --------------------------------------------------
if __name__ == '__main__':
    main()