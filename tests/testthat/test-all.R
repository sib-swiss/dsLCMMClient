test_that("ds.hlme works with one class", {
  
  m1 <- ds.hlme(fixed = normMMSE ~ age65+I(age65^2)+CEP,random = ~ age65+I(age65^2), subject = 'ID', data = 'paquid', newObj = 'my_b')
  expect_true(all(c(is.na(m1$server1$pred$resid_ss), is.na(m1$server1$pred$resid_m))))
  
})


test_that("ds.hlme works with more than one class", {
  
  m2 <- ds.hlme(fixed = normMMSE ~ age65+I(age65^2)+CEP,random = ~ age65+I(age65^2), subject = 'ID', ng = 2, mixture=~age65+I(age65^2), data = 'paquid', B = 'my_b')
  expect_true(all(c(is.na(m2$server1$pred$resid_ss), is.na(m2$server1$pred$resid_m))))
  
})

test_that("ds.hlme works with more than one class with user-generated values", {
  
  m3 <- ds.hlme(fixed = normMMSE ~ age65+I(age65^2)+CEP,random = ~ age65+I(age65^2), 
                subject = 'ID', ng = 2, mixture=~age65+I(age65^2), data = 'paquid', 
                B = c(0, 60, 40, 0, -4, 0, -10, 10, 212.869397, -216.421323,456.229910, 55.713775, -145.715516, 59.351000, 10.072221))
  expect_true(all(c(is.na(m3$server1$pred$resid_ss), is.na(m3$server1$pred$resid_m))))
  

  a1 <- m1$server1
  a2 <- m2$server1
  a3 <- m3$server1
  summarytable(a1,a2,a3, which = c("G", "loglik", "conv", "npm", "AIC", "BIC", "SABIC", "entropy","ICL", "%class"))
  
  summaryplot(a1, a2, a3, which = c("BIC", "entropy","ICL"))
})




