install.packages("dplyr")
library(dplyr)

aamc_sub <- read.csv(
  file = "aamc_deid_sub_0831.csv", header = TRUE, sep = "|",  na.strings=c(""," ","NA")
)
dim(aamc_sub)      #113542     24

aamc_gme <- read.csv(
  file = "AAMC_GME_CAPS_OHIO.csv", header = TRUE,  sep = "|",  na.strings=c(""," ","NA")
)
dim(aamc_gme)     #5    9

medicare <- read.csv(
  file = "MEDICARE_GME_US_STATES.csv",  header = TRUE,  sep = "|",  na.strings=c(""," ","NA")
)
dim(medicare)    #260    13

gme <- read.csv(
  file = "ohio_gme_2013.csv",  header = TRUE,  sep = "|",  na.strings=c(""," ","NA")
)
dim(gme)    #66   15

sort(unique(aamc_sub$SURVEY_YEAR))    #2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014

