#' @title  Remote "gridsearch"
#' @description Executes "gridsearch" from the library "lcmm" on the remote nodes
#' @param m, first argument to be sent to gridsearch on the remote nodes, a call to the hlme function. Please check the original documetation of the function gridsearch.
#' The call should be protected by quote(...) to protect from early, local evaluation. Ex: gridsearch(m = quote(hlme(...)), mint = 'obj', ...)
#' @param minit, a character, the name of the object on the server that was created with the newObj argument of a previous call of the function ds.hlme.
#' pPlease check the documentation of that function.
#' @param ...,  remainder of the gridsearch arguments. It is recommended to pass all the arguments by name.

#' @param async same as in datashield.aggregate
#' @param datasources same as in datashield.aggregate

ds.gridsearch <- function(m, minit, ..., async = TRUE, datasources = NULL){
  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  } 
  argList <- list(m = m, minit = minit, ...)
  expr <- c(as.symbol('gridsearchDS'), 
              sapply(argList, .encode.arg, TRUE, simplify = FALSE))
  ret <- datashield.aggregate(datasources, as.call(expr), async)            
  return(ret)          
  }