_Ostrea lurida_ Survey - Puget Sound, WA - 2014
=====================

This repository includes raw data and R scripts used to generate figures for the Heare et al 2014 - TITLE OF MANUSCRIPT


**To use these scripts:**

1. Download the entire repository to your local drive. 
2. Open scripts with R Studio
3. Replace path to working directory to reflect location on your machine.
4. Load any required packages not already installed. Packages needed to perform each script are included at the top of the page, simply uncomment if you do not already have the packages.
6. Highlight the commands and run. 

If everything works right you should create the figures in the manuscript!

**Files Contained in Repository w/ Description**




*data folder contains:*
==========================================================================
Brood-numbers-all-2014.csv
    Contains brooder information collected over the summer
    Used in scripts:
          percbrood-temp-plot-Fidalgo.R
          percbrood-temp-plot-Manchester.R
          percbrood-temp-plot-OysterBay.R

Dabob-temp-2014.csv
    Contains raw temperature data for Dabob
    Used in Scripts:
          temperature-plots.R

Fidalgo-temp-2014.csv
    Contains raw temperature data for Fidalgo Bay
    Used in scripts:
          temperature-plots.R
          percbrood-temp-plot-Fidalgo.R

KMdataDabob.csv
    Contains KM formatted survival data for Dabob
    Used in scripts:
          Kaplan-meier-stats-plot-all.R

KMdataFid.csv
    Contains KM formatted survival data for Fidalgo Bay
    Used in scripts:
          Kaplan-meier-stats-plot-all.R

KMdataMan.csv
    Contains KM formatted survival data for Manchester
    Used in scripts:
          Kaplan-meier-stats-plot-all.R

KMdataOys.csv
    Contains KM formatted survival data for Oyster Bay
    Used in scripts:
          Kaplan-meier-stats-plot-all.R

Manchester-temp-2014.csv
    Contains raw temperature data for Manchester
    Used in scripts:
          temperature-plots.R
          percbrood-temp-plot-Manchester.R

OysterBay-temp-2014.csv
    Contains raw temperature data for Oyster Bay
    Used in scripts:
          temperature-plots.R
          percbrood-temp-plot-OysterBay.R
          
Size-outplant-end-all-2013-14.csv
    Contains raw size data for outplant oysters and for Year 1 end sampling measurements
    Used in scripts:
          sizedist-stats-plot.R
          
=================================================================
*scripts folder contains:*
====================================================================
Kaplan-meier-stats-plot-all.R
    Used to generate Kaplan Meier graphs for all 4 sites at once
    
percbrood-temp-plot-Fidalgo.R
    Used to generate percent brooding with temperature overlay for Fidalgo Bay
    *Note* Does *NOT* produce second Y axis label. Must be manually added in. 
    
percbrood-temp-plot-Manchester.R
    Used to generate percent brooding with temperature overlay for Manchester
    *Note* Does *NOT* produce second Y axis label. Must be manually added in. 
    
percbrood-temp-plot-OysterBay.R
    Used to generate percent brooding with temperature overlay for Oyster Bay
    *Note* Does *NOT* produce second Y axis label. Must be manually added in. 
    
sizedist-stats-plot.R
    Used to create boxplots for size at all sites.
    
temperature-plots.R
    Used to create minimum and maximum temperature graphs for all 4 sites combined
