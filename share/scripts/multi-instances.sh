#!/bin/sh

# This file contains example scenarios for 
# running the plot utilities over a grid of paramaters.
# This example aims to mimic a typical 'data exploration'
# task, by first looking at underlying data distributions with
# a histogram, and then considering the data in a time-series
# format.

binDir=../../bin
dataDir=../data
paramset_1="a b c"
paramset_2="1 2 3"

for param_1 in $paramset_1; do

    for param_2 in $paramset_2; do

	# Look at a histogram of all values
	$binDir/hist --nbins=64 --yrange=0:0.2 --xrange=-3:7 \"-2\" 6 $dataDir/$param_1.$param_2.txt \
	    > $param_1.$param_2.hist.png

	# Plot the data series
	$binDir/series --title="A Series Of Data" $dataDir/$param_1.$param_2.txt \
	    > $param_1.$param_2.series.png
	
	# Make a spark line 'summary' of the series
	$binDir/spark $dataDir/$param_1.$param_2.txt \
	    > $param_1.$param_2.spark.png
    done

   
done

# A time series over slices of params
paste $dataDir/*.3.txt \
    | $binDir/series --series=lines \
    > all-param2-2.series.png

# Scatter two of the params
paste $dataDir/b.3.txt $dataDir/c.3.txt \
    | $binDir/scatter --fit-line \
    > b3-c3-scatter.png
