# __author__ = "Eric Allen Youngson"
# __email__ = "eric@scneco.com"
# __copyright__ = "Copyright Dec. 2015, Succession Ecological Services"
# __license__ = "GNU Affero (GPLv3)"
# 
# 

# install.packages("lubridate") ## Comment out after first calsource()
# library("lubridate")


SelectCurrentMnth <- function(fname, start.date){
  bank.tx = read.csv(fname, header = TRUE, sep = ",", stringsAsFactors = FALSE)
  
  month.tx = bank.tx[which(bank.tx$Date >= start.date), ]
  return(month.tx)
}