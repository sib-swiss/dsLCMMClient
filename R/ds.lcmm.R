#' @title  Remote "lcmm"
#' @description Executes "lcmm" from the library "lcmmm" on the remote nodes
#' @param data, first argument to be sent to lcmm on the remote nodes. Please check the original function documentation for details. data should be a character, enclosed in quotes.
#' @param ...,  remainder of the lcmm arguments.

#' @param async same as in datashield.aggregate
#' @param datasources same as in datashield.aggregate

ds.lcmm <- function(data, ..., async = TRUE, datasources = NULL){
  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  } 
  argList <- list(data = data, ...)
  expr <- c(as.symbol('lcmmDS'), 
              sapply(argList, .encode.arg, TRUE, simplify = FALSE))
  ret <- datashield.aggregate(datasources, as.call(expr), async)            
  return(ret)          
  }