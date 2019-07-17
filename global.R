# Load libraries
library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(ggthemes)
library(shinyjs)
library(shinyWidgets)
library(shinythemes)
library(markdown)
library(dplyr)
library(shinyjqui)
library(bsplus)
library(htmltools)
library(shinyBS)
library(aTSA)
library(MASS)
library(leaflet)

# set options to take away scientific notation in graphs
options(scipen=999)

# create a dataframe for users (physicians)
coders <- data.frame(physician_name = c('Dr.Jones', 'Dr.Jones','Dr.Brown','Dr.Brown', 'Dr. Kelly', 'Dr. Kelly', 'Dr.Smith', 'Dr.Smith'),
                     deceased_name = c('tim', 'james', 'laura', 'casey', 'karen', 'ben', 'sarah', 'edward'),
                     id = c('1', '2', '3', '4', '5', '6', '7', '8'),
                     dob = c('01-14-1976','01-15-1977', '01-16-1978', '01-17-1979', '02-01-1968', '02-01-1969', '05-14-1991', '10-20-1965'),
                     dod = c('07-17-2012','08-15-2013', '11-01-1999', '03-02-2001', '07-29-1999', '01-20-2005', '01-01-2000', '12-27-2002'),
                     pod_lat = c(0,30, 20, 15, 10, 5, -10, -20),
                     pod_long = c(20, 0, -10, 20, 40, 20, 20, 30),
                     age_of_death = c(36, 36, 21, 22, 31, 36, 9, 37),
                     season_of_death = c('winter', 'summer', 'autumn','winter', 'summer', 'winter', 'winter', 'winter'),
                     symptoms = c('cough', 'diarrhea', 'diarrhea', 'nausea', 'fever', 'headache', 'abdominal_pain', 'profuse_sweating'),
                     description = c('heavy cough for 3 days', 'malnutrition', 'malnutrition', 'vomitting for several days', 'high fever of 103 F', 'persisting migraine', 
                     'sharp pain in abdomen when swallowing', 'over heated with high temperature and sweating at night'),
                     info_death_certificat = c('10464/10465', '10466/10467','10464/10465', '10466/10467', '10468/10469', '10470/10471', '10472/10473', '10472/10473'),
                     comments = c('the individual showed serious symptoms of a pulminary infection', 
                     'watery stool in conjunction with fever and chills', 
                     'losing weight rapidly due to dysentery', 
                     'vommiting consistently during the day with signs of a high fever', 
                     'very high fever accompanied by severe migrains', 
                     'sharp pain in forehead and persistent nausea', 
                     'abdominal pain and high fever',
                     'heavy sweating from pain and fever'),
                     icd_list = c('I00-I99:Diseases of the circulatory system',
                                  'K00-K95:Diseases of the digestive system',
                                  'K00-K95:Diseases of the digestive system',
                                  'S00-T88:Injury, poisoning and certain other consequences of external causes', 
                                  'A00-B99:Certain infectious and parasitic diseases', 
                                  'F01-F99:Mental, Behavioral and Neurodevelopmental disorders',
                                  'A00-B99:Certain infectious and parasitic diseases',
                                  'S00-T88:Injury, poisoning and certain other consequences of external causes'))

# convert date variables to date object
coders$dob <- as.Date(coders$dob, '%m-%d-%Y')
coders$dod <- as.Date(coders$dod, '%m-%d-%Y')

# get coverage of systems over the function Solve


