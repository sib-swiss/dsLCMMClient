#' @title  Remote "hlme"
#' @description Executes "hlme" from the library "lcmm" on the remote nodes
#' @param data, first argument to be sent to hlme on the remote nodes. Please check the original function documentation for details. data should be a character, enclosed in quotes.
#' @param ...,  remainder of the hlme arguments. If specified as the option 3) in the original hlme documentation, 
#' the argument B should also be sent a a character, the name of and object in the remote session,
#'  possibly the saved result of a previous call of the function (newObj, see below). Otherwise it can be sent as a normal vector (c(....)).
#' It is recommended to pass all the arguments by name.
#' @param newObj, if specified the result of the function call will be saved in its entirety in the remote session under this name
#' @param async same as in datashield.aggregate
#' @param datasources same as in datashield.aggregate
#' 
#' @return a list, same as the original function hlme without the $call element and with the resid_m and resid_ss columns set to NA

ds.hlme <- function(data, ..., newObj = NULL, async = TRUE, datasources = NULL){
  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  } 
  argList <- list(data = data, ...)
  if(!is.null(newObj)){
    argList$newObj <- newObj
  }
  expr <- c(as.symbol('hlmeDS'), 
              sapply(argList, .encode.arg, TRUE, simplify = FALSE))
  ret <- datashield.aggregate(datasources, as.call(expr), async)            
  return(ret)          
  }