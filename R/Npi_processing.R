library(dplyr)

setwd("W:/proj/HPDW/staff/das22/CurrentData")

ohio_matches <- read.csv(
  file = "npi/npi_20180909-ohio_matches.csv", header = TRUE,  na.strings=c(""," ","NA")
)

ohio <- read.csv(
  file = "npi/npi_20180909-ohio.csv", header = TRUE,  na.strings=c(""," ","NA")
)

provider <- read.csv(
  file = "PROVIDER.csv", header = TRUE,  na.strings=c(""," ","NA")
)

npi_columns <- c("npi", "entitytypecode", "providerlastnamelegalname", "providerfirstname", "providermiddlename", "providerfirstlinebusinessmailing",
                 "providerbusinessmailingaddressst", "providerfirstlinebusinesspractic", "v32", "providerenumerationdate", "lastupdatedate",
                 "hcp_taxonomy_code_1", "providerlicensenumber_1", "healthcareproviderprimarytaxonom",
                 "hcp_taxonomy_code_2", "v55", "otherprovideridentifier_1", "otherprovideridentifiertypecode_", "otherprovideridentifierstate_1",
                 "otherprovideridentifier_2", "v113", "otherprovideridentifierstate_2", "mailing_ohio", "practice_ohio")

ohio_subset <- ohio[, (names(ohio) %in% npi_columns)]

ohio_subset <- ohio_subset %>%
                rename(providerlastname = providerlastnamelegalname,
                       businessMailing = providerfirstlinebusinessmailing,
                       businessState = providerbusinessmailingaddressst,
                       practiceMailing = providerfirstlinebusinesspractic,
                       practiceState =  v32,
                       primaryTaxonomy = healthcareproviderprimarytaxonom,
                       secondaryTaxonomy = v55,
                       otherId = otherprovideridentifier_1, 
                       otherType = otherprovideridentifiertypecode_, 
                       otherState = otherprovideridentifierstate_1,
                       otherId2 = otherprovideridentifier_2, 
                       otherType2 = v113, 
                       otherState2 = otherprovideridentifierstate_2) 
  