#' @title  Remote "hlme"
#' @description Executes "hlme" from the library "lcmmm" on the remote nodes
#' @param data, first argument to be sent to hlme on the remote nodes. Please check the original function documentation for details. data should be a character, enclosed in quotes.
#' @param ...,  remainder of the hlme arguments.

#' @param async same as in datashield.aggregate
#' @param datasources same as in datashield.aggregate

ds.hlme <- function(data, ..., async = TRUE, datasources = NULL){
  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  } 
  argList <- list(data = data, ...)
  expr <- c(as.symbol('hlmeDS'), 
              sapply(argList, .encode.arg, TRUE, simplify = FALSE))
  ret <- datashield.aggregate(datasources, as.call(expr), async)            
  return(ret)          
  }