library(tidyverse)
library(magrittr)
library(rvest)
library(maps)
library(ggplot2)

# read file
wd<-read.csv('/Users/User/OneDrive - Imperial College London/cause_of_deaths.csv')
df<- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")
war<-unique(df$COUNTRY)
wdr<-unique(wd$Country.Territory)
wdr[!(wdr %in% war)]
# data preprocessing

# we are going to use these to identify which country names do not match
wdr[!(wdr %in% war)]
war[!(war %in% wdr)]


# here we modify 
replacer<- function(old,new){
  return(replace(wd$Country.Territory,wd$Country.Territory==old,new))
}
wd$Country.Territory<-replacer('Bahamas','Bahamas, The')
wd$Country.Territory<-replacer('Cape Verde','Cabo Verde')
wd$Country.Territory<-replacer('Congo',"Congo, Republic of the")
wd$Country.Territory<-replacer("Democratic Republic of Congo","Congo, Democratic Republic of the")
wd$Country.Territory<-replacer("Czechia","Czech Republic" )
wd$Country.Territory<-replacer("Gambia","Gambia, The" )
wd$Country.Territory<-replacer("Micronesia","Micronesia, Federated States of" )
wd$Country.Territory<-replacer("North Korea","Korea, North" )
wd$Country.Territory<-replacer("South Korea","Korea, South" )
wd$Country.Territory<-replacer("United States Virgin Islands","Virgin Islands")
wd$Country.Territory<-replacer("North Macedonia","Macedonia")
wd$Country.Territory<-replacer("Timor","Timor-Leste")
wd$Country.Territory<-replacer("Myanmar","Burma")





wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=='Bahamas','Bahamas, The')
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=='Antigua and Barbuda','Antigua')
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=='United Kingdom','UK')
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=='Congo','Republic of Congo')
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=="Trinidad and Tobago",'Trinidad')
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=="Czechia",'Czech Republic')
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=="Democratic Republic of Congo","Democratic Republic of the Congo")
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=="United States Virgin Islands","Virgin Islands")
wd$Country.Territory<-replace(wd$Country.Territory,wd$Country.Territory=="Cote d'Ivoire","Ivory Coast")
# check to see it did what we wanted
wcr<-unique(world_coordinates$region)
wdr<-unique(wd$Country.Territory)

# we are going to use these to identify which country names do not match
wcr[!(wcr %in% wdr)]
wdr[!(wdr %in% wcr)]

# merge by world coordinates for plotting
merged_data <- merge(world_coordinates, wd, by.x = "region", by.y = "Country.Territory", all.x = TRUE)

# consider using this data instead
df<- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")
war<-unique(df$COUNTRY)
wdr[!(wdr %in% war)]
merged_data <- merge(df, wd, by.x = "COUNTRY", by.y = "Country.Territory", all.x = TRUE)



