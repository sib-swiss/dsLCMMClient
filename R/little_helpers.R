.encode.arg <- function(some.object, serialize.it = FALSE){

if(serialize.it){
  encoded <- paste0(RCurl::base64Encode(jsonlite::serializeJSON(some.object)), 'serialized')
} else {
  encoded <- RCurl::base64Encode(jsonlite::toJSON(some.object, null = 'null'))
}
  # go fishing for '+', '/' and '=', opal rejects them :
  my.dictionary <- c('\\/' = '-slash-', '\\+' = '-plus-', '\\=' = '-equals-')
  sapply(names(my.dictionary), function(x){
    encoded[1] <<- gsub(x, my.dictionary[x], encoded[1])
  })
  return(paste0(encoded[1],'base64'))

}
