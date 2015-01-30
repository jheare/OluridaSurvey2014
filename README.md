_Ostrea lurida_ Survey - Puget Sound, WA - 2014
=====================

This repository includes raw data and R scripts used to generate figures for Heare et al. "[**Evidence of _Ostrea lurida_ population structure in Puget Sound, WA**](https://peerj.com/preprints/704v1/)" 
```
Heare JE, Blake B, Davis JP, Vadopalas B, Roberts SB. (2014) Evidence of Ostrea lurida (Carpenter 1894) population structure in Puget Sound, WA. PeerJ PrePrints 2:e704v1 http://dx.doi.org/10.7287/peerj.preprints.704v1
```

Specific release that is supplemental to the manuscript - [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.13201.svg)](http://dx.doi.org/10.5281/zenodo.13201)

---


**To use these scripts:**

1. Download the entire repository to your local drive. 
2. Open scripts with R Studio
3. Replace path to working directory to reflect location on your machine.
4. Load any required packages not already installed. Packages needed to perform each script are included at the top of the page, simply uncomment if you do not already have the packages.
6. Highlight the commands and run. 

If everything works right you should create the figures in the manuscript!

---

##File Desciptions

**Files Contained in _data_ directory**

Brood-numbers-all-2014.csv  -  brooder information collected over the summer

Dabob-temp-2014.csv  -  raw temperature data for Dabob

Fidalgo-temp-2014.csv  -  raw temperature data for Fidalgo Bay

KMdataDabob.csv  -  survival data for Dabob

KMdataFid.csv  -  survival data for Fidalgo Bay

KMdataMan.csv  -  survival data for Manchester

KMdataOys.csv  -  survival data for Oyster Bay

Manchester-temp-2014.csv  - raw temperature data for Manchester

OysterBay-temp-2014.csv -  raw temperature data for Oyster Bay

Size-outplant-end-all-2013-14.csv  -  raw size data for outplant oysters and for Year 1 terminal sampling 
          
--- 
**Files Contained in _script_ directory**

Figure002-003-temperature-plots.R  -  R script tp create minimum and maximum temperature graphs for all 4 sites combined

Figure004ABCD-Kaplan-meier-stats-plot-all.R  -  R script to produce Kaplan meier figures.(Makes 4 individual figures that were combined to make Figure 4)

Figure005-006-007-sizedist-stats-plot.R  -   R script to create boxplots for size at all sites.

Figure008-percbrood-temp-plot-OysterBay.R  -- R script to generate percent brooding with temperature overlay for Oyster Bay (Does not produce second Y axis label. Must be manually added)
    
Figure009-percbrood-temp-plot-Fidalgo.R  - R script to generate percent brooding with temperature overlay for Fidalgo Bay (Does not produce second Y axis label. Must be manually added)
   
Figure010-percbrood-temp-plot-ClamBay.R  -- R script to generate percent brooding with temperature overlay for Manchester (Does not produce second Y axis label. Must be manually added)


    

    

