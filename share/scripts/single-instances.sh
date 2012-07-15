#!/bin/sh

# This file contains example scenarios for using the 
# various plot utilities.  Variations of available
# command line options are tested, as well as
# different pre-processing operations.  Also,
# both stdin, and file input are considered

binDir=../../bin
dataDir=../data

#############################################################
# Histograms                                                #
#############################################################

# A simple histogram of data values
$binDir/hist 0 30 $dataDir/medium.txt \
    > hist.default.png

# Generate a random laplace distribution, then display it with a histogram 
# containing a specified number of bins
gsl-randist 1 10000 laplace 1 \
    | $binDir/hist --datatitle "Laplace Dist" --nbins 100 0 8 \
    > hist.laplace.png


#############################################################
# Time-series                                               #
#############################################################

# A simple time-series over a single column in a file
$binDir/series $dataDir/medium.txt \
    > series.default.png

# Create a more sophisticated time-series, with a titled data set
$binDir/series --keytitles --xrange=-10:110 --xlabel="Observations" --ylabel="score" --title="demo" $dataDir/title.txt \
    > series.titled.png

# Process 2-column data with a simple filter, then create a two-series plot
cat $dataDir/2-col.2.txt \
    | $binDir/series --keytitles --series=lines \
    > series.lines.png

#############################################################
# Scatter-plots                                             #
#############################################################

# Make a scatterplot of lots of data, using small points
$binDir/scatter --dotsize=small $dataDir/2-col.txt \
    > scatter.bubble.png

# Filter input data, then create a titled scatterplot
head -900 $dataDir/2-col.2.txt \
    | $binDir/scatter --title "A Scatter Plot" --datatitle "Some Observation" \
    > scatter.titled.png


#############################################################
# Sparklines                                                #
#############################################################

# A basic sparkline, from file
$binDir/spark $dataDir/small.txt \
    > spark.default.png

# Sort a numerical data set, and output to file (via tee).  Subsequently
# create a sparkline of the data with a smoothed line
sort -k1,1gr $dataDir/small.txt \
    | tee sorted.small.txt \
    | $binDir/spark --smooth $dataDir/small.txt \
    > spark.smoothed.png

# A titled sparkline
$binDir/spark --title 'Obs 1' $dataDir/small.txt \
    > spark.titled.png
