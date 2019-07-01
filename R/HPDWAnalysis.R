library(dplyr)

setwd("W:/proj/HPDW/staff/das22/CurrentData")

aamc_total <- read.csv(
  file = "trimmedDataSet.csv", header = TRUE,  na.strings=c(""," ","NA")
)
sort(unique(aamc_total$SURVEY_YEAR)) 

# Summarize the null values for each columns
aamc_total%>%
  select(everything()) %>%
  summarise_all(funs(sum(is.na(.))))

table(aamc_total$GME_SPECIALTY_DESC)


## Removing duplicat entries from the dataset. Use only the record asssociated with latest year.
# Longer method using dplyr. Though it is intuitive but highly inefficient in larger datasets.

# x <- unique(sub$AAMC_ID)
# 
# result <- data.frame()
# for(i in x){ 
#   m <- sub %>% 
#             filter(AAMC_ID == i ) %>% 
#             filter(SURVEY_YEAR == max(SURVEY_YEAR))
#   result <- rbind(result, m)
#   
# }

# tabbly gives the statistics of which survey year way the max out of each group of AAMC_ID. No need to use unique(AAMC_ID) here because we already group the dataset by this.
# tapply(sub$SURVEY_YEAR, sub$AAMC_ID, max)

# Using Aggregate function instead of dplyr as it performs much better in large datasets. Here grouping of dataset is done on AAMC_ID, so no need to use unique().
# Survey_year is then aggregated using the max function.Aggregate returns a dataframe.

m <- aggregate(aamc_total$SURVEY_YEAR, by = aamc_total["AAMC_ID"], max)

# the resultant dataframe 'm' is then right outer joined by the entire dataset. Just need to give the columns by which the join operation will be performed.
result <- right_join(aamc_total,m, by = c("AAMC_ID" = "AAMC_ID","SURVEY_YEAR" = "x"))

result%>%
  select(everything()) %>%
  summarise_all(funs(sum(is.na(.))))

filteredgroup1 <- aamc_total %>% filter(GME_STATE == "OH")

filteredgroup1 <- data.frame(lapply(filteredgroup1, as.character), stringsAsFactors=FALSE)

table(filteredgroup1$GME_PROGRAM_NAME)

result$is_MED_SCHOOL_STATE_in_Ohio <- ifelse(result$MED_SCHOOL_NAME %in% c("Case Western Reserve University School of Medicine",
                                                                "Ohio State University College of Medicine",
                                                                "Wright State University Boonshoft School of Medicine",
                                                                "Ohio University Heritage College of Osteopathic Medicine",
                                                                "University of Cincinnati College of Medicine",
                                                                "The University of Toledo College of Medicine",
                                                                "Northeast Ohio Medical University"
                                                                ),1,0)

y <- result %>% filter(is_MED_SCHOOL_STATE_in_Ohio == 1)
y <- data.frame(lapply(y, as.character), stringsAsFactors=FALSE)
table(y$MED_SCHOOL_NAME)

## Plot the histogram in ggplot2

ggplot(y, aes(x = y$MED_SCHOOL_NAME, stat = "identity")) + 
  geom_bar(fill = "light blue") +
  theme(plot.title = element_text(hjust = 0.5,
                                  size = 14,
                                  face = "bold",
                                  margin=margin(t=10,10,30,10)),
        axis.title = element_text(size=12,
                                  face="bold")) +
  labs( title = "Among candidates who studied medicine in Ohio, histogram of different medical schools they went to",
        x= "Medical Schools in Ohio",  
        y = "Frequency") + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) 

y <- y[!is.na(y$GME_STATE),]
y$residency_state_grouping <- ifelse(y$GME_STATE %in% "OH","Ohio","Non-Ohio")

## Plot stacked bar charts

ggplot(y, aes(x = y$MED_SCHOOL_NAME)) + 
  geom_bar(aes(fill = y$residency_state_grouping)) +
  theme(plot.title = element_text(hjust = 0.5,
                                  size = 14,
                                  face = "bold",
                                  margin=margin(t=10,10,30,10)),
        axis.title = element_text(size=12,
                                  face="bold")) +
  labs( title = str_wrap("Among candidates who studied medicine in Ohio, distribution of different medical schools they went to stratified by Residency states",100),
        x= "Medical Schools in Ohio",  
        y = "Counts",
        fill = "Residency Location") + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) 


result$Program_group <- result$GME_SPECIALTY_DESC  
result$Program_group <- ifelse(result$GME_SPECIALTY_DESC %in% 
                                 c("Internal Medicine","Internal Medicine/Pediatrics","Family Medicine","Psychiatry"), 
                               as.character(result$Program_group) ,"Other")

intermed_result <- result %>% filter(is_MED_SCHOOL_STATE_in_Ohio == 0)

ggplot(intermed_result, aes(x = Program_group, stat = "identity")) + 
  geom_bar(fill = "dark blue") +
  theme(plot.title = element_text(hjust = 0.5,
                                  size = 14,
                                  face = "bold",
                                  margin=margin(t=10,10,30,10)),
        axis.title = element_text(size=12,
                                  face="bold")) +
  labs( title = "Among candidates who studied medicine outside of Ohio, distribution of residency programs",
        x= "Residency programs",  
        y = "Frequency")

#Stacked bars

ggplot(result, aes(x = Program_group, stat = "identity")) + 
  geom_bar(aes(fill = is_MED_SCHOOL_STATE_in_Ohio)) +
  theme(plot.title = element_text(hjust = 0.5,
                                  size = 14,
                                  face = "bold",
                                  margin=margin(t=10,10,30,10)),
        axis.title = element_text(size=12,
                                  face="bold")) +
  labs( title = "Distribution of residency programs inside and outside of Ohio",
        x= "Residency programs",  
        y = "Counts",
        fill = "Med School Location")



write.csv(result,"HPDWData.csv", row.names = FALSE, na="")


