# __author__ = "Eric Allen Youngson"
# __email__ = "eric@scneco.com"
# __copyright__ = "Copyright Dec. 2015, Succession Ecological Services"
# __license__ = "GNU Affero (GPLv3)"
# 

# install.packages("lubridate") ## Comment out after first calsource()
# library("lubridate")


TxImport <- function(f.name, date.col, tx.col, start.date){
  # Reads exported transaction data from Simple (online bank) and return a
  # dataframe with correct R types for sorting
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
  if(!missing(start.date)){
    tx.data = tx.data[which(tx.data[,date.col] >= start.date), ]
  }

  return(tx.data)
}
