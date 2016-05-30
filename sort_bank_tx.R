# __author__ = "Eric Allen Youngson"
# __email__ = "eric@scneco.com"
# __copyright__ = "Copyright Dec. 2015, Succession Ecological Services"
# __license__ = "GNU Affero (GPLv3)"
# 

# install.packages("lubridate") ## Comment out after first calsource()
library("lubridate")


ImportTx <- function(f.name, date.col, tx.col, start.date, end.date){
  # Reads exported bank transaction data from online sources and return a
  # dataframe with usefule R types for sorting
  # 
  # Args:
  #   f.name (String): Name of file to be processed
  #   date.col (String): Name of the dataframe's column to be used for dates
  #   tx.col (String): Name of the dataframes' column to be used for
  #                    transaction type 
  #   date.range (Date): Starting date for transactions to be subset
  # 
  # Returns:
  #   A dataframe containing transaction data for the time period specified by
  #   parameters, with useful R datatypes for date & factors
  tx.data = read.csv(f.name, header = TRUE, sep = ",",
                     stringsAsFactors = FALSE) 
  
  tx.data[,date.col] = as.Date(tx.data[,date.col])
  if(!missing(tx.col)){
    tx.data[,tx.col]= factor(tx.data[,tx.col])
  }
  if(!missing(start.date) & !missing(end.date)){
    tx.data = tx.data[which(tx.data[,date.col] >= start.date &
                            tx.data[,date.col] <= end.date), ]
  }

  return(tx.data)
}
