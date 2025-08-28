library(DSLite)
library(dsBase)
library(dsBaseClient)
pkgload::load_all('/mnt/shareddisk/datashield/dsLCMM')

dslite.server1 <- newDSLiteServer(config = defaultDSConfiguration(include=c('dsBase', 'dsLCMM')))




builder <- newDSLoginBuilder()
builder$append(server="server1", url='dslite.server1',driver = "DSLiteDriver")

logindata <- builder$build()


opals <- datashield.login(logins = logindata)
session1 <- dslite.server1$getSession(dslite.server1$getSessionIds())
session2 <- dslite.server2$getSession(dslite.server2$getSessionIds())
data('paquid', envir = session1)
session1$paquid$age65 <- (session1$paquid$age - 65)/10

