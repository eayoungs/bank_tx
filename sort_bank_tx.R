# __author__ = "Eric Allen Youngson"
# __email__ = "eric@scneco.com"
# __copyright__ = "Copyright Dec. 2015, Succession Ecological Services"
# __license__ = "GNU Affero (GPLv3)"
# 


# install.packages("lubridate") ## Comment out after first calsource()
# library("lubridate")


SelectCurrentMnth <- function(fname, start.date){
  # Reads exported transaction data from Simple (online bank) and return a
  # dataframe with correct R types for sorting
  # 
  # Args:
  #   fname (String): Name of file to be processed
  #   start.date (Date): Starting date for transactions to be subset
  # 
  # Returns:
  #   A dataframe containing transaction data fro the time period specified by
  #   parameters, with useful R datatypes for date & factors
  bank.tx = read.csv(fname, header = TRUE, sep = ",", stringsAsFactors = FALSE)
  
  month.tx = bank.tx[which(bank.tx$Date >= start.date), ]
  month.tx$Date = as.Date(month.tx$Date)
  month.tx$Activity = factor(month.tx$Activity)
  month.tx$Category = factor(month.tx$Category)

  return(month.tx)
}