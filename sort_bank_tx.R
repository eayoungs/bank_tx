# __author__ = "Eric Allen Youngson"
# __email__ = "eric@scneco.com"
# __copyright__ = "Copyright Dec. 2015, Succession Ecological Services"
# __license__ = "GNU Affero (GPLv3)"
# 

#install.packages("lubridate") ## Comment out after first call to source()
#library("lubridate")


ImportTx <- function(f.name, date.col, start.date, end.date){
  # Reads exported bank transaction data from online sources and return a
  # dataframe with usefule R types for sorting
  # 
  # Args:
  #   f.name (String): Name of file to be processed
  #   date.col (String): Name of the dataframe's column to be used for dates
  #   tx.col (String): Name of the dataframes' column to be used for
  #                    transaction type 
  #   start.date (Date): Optional starting date for transactions to be subset;
  #                     can be used by itself.
  #   end.date (Date): Starting date for transactions to be subset;
  #                     can only be used in conjunction with start.date
  # 
  # Returns:
  #   A dataframe containing transaction data for the time period specified by
  #   parameters, with useful R datatypes for date & factors
  tx.data = read.csv(f.name, header = TRUE, sep = ",",
                     stringsAsFactors = TRUE) 
  if(!missing(date.col))  {
    tx.data[,date.col] = as.Date(tx.data[,date.col])
  }
  if(!missing(start.date) & missing(end.date)) {
    tx.data = tx.data[which(tx.data[,date.col] >= start.date), ]
  }
  if(!missing(start.date) & !missing(end.date)) {
    tx.data = tx.data[which(tx.data[,date.col] >= start.date &
                            tx.data[,date.col] <= end.date), ]
  }

  return(tx.data)
}


ParseMonthlyExpenses <- function(d.frame, date.col, spec.month, spec.year) {
  #
  # Args:
  # 
  # Returns:
  #   A dataframe containing expenses for a specifided month, if specified, or
  #   a set of dataframes for each full month available, if not.
  if(missing(spec.year)) {
    if(year(max(d.frame$date.col)) == year(min(d.frame$date.col))) {
      spec.year = year(max(d.frame$date.col))
    } else if(year(Sys.Date()) %in% year(d.frame$date.col)) {
      spec.year = Sys.Date()
    } else {
      stop("Year is ambiguous; must be supplied by user")
    }
  }
  if(!missing(spec.month)) {
    if(as.Date(spec.month)) {
      spec.month = as.Date(spec.month)
    } else if(spec.month %in% month.name) {
      
    } else if(spec.month %in% month.abb) {
      
    } else {
      stop("Supplied parameter, 'Month' is invalid")
    }
    spec.date = Sys.Date()
    year(spec.date) = spec.year
    month(spec.date) = spec.month %m+% months(1)
    day(spec.date) = rollback(spec.date)
  } else {
    stop("Required parameter, Month, not supplied")
  }
  return(month.df)
}
#may_simple.df = simple.tx[simple.tx$Date >= "2018-04-01" & simple.tx$Date <= "2018-04-30",]
#aggregate(Amount.colnm ~ Category.colnm, may_simple.df, sum)
#may_simple.df[may_simple.df$Category.folder=="Utilities" | may_simple.df$Category.folder=="Technology",]$Description
#may_simple.df[may_simple.df$Category.folder=="Utilities" | 
#         may_simple.df$Category.folder=="Technology" | 
#         may_simple.df$Category=="Memberships",][,c("Description", "Amount")]
#sum(may_simple.df[may_simple.df$Category.folder=="Utilities" | may_simple.df$Category.folder=="Technology",]$Amount)

## Monthly
# mo_simple.tx = simple.tx[simple.tx$Date >= "2017-01-01" & simple.tx$Date < "2017-02-01",]
# mo_simple.tx$Category.folder=="Uncategorized",]
#ggplot(mo_simple.tx, aes(Date, Amount, colour=Category.folder, fill=Category.folder)) +
#  geom_bar(stat="identity") +
#  geom_text(aes(label=Number))

#interval(min(simple.tx$Date), max(simple.tx$Date)) %/% months(1)
#min(simple.tx$Date) %m+% months(1)
