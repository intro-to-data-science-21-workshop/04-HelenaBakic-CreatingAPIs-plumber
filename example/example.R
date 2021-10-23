library(plumber)

#* @filter logger
function(req, res){
  cat(as.character(Sys.time()), ";",
      req$REQUEST_METHOD, req$PATH_INFO, ";",
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n", append=TRUE, file="api_logs.txt")
  plumber::forward()
}

#* @filter checkAuth
function(req, res){
  if (is.null(req$username)){
    res$status <- 401 # Unauthorized
    return(list(error="Authentication required"))
  } else {
    plumber::forward()
  }
}

#* @apiTitle Plumber Example API

#* Echo back the input
#* @param msg The message to echo
#* @get /echo

function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot

function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum

function(a, b) {
  as.numeric(a) + as.numeric(b)
}


  