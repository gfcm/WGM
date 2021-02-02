library(icesTAF)
library(icesSD)

sid <- getSD()
sid19 <- sid[sid$ActiveYear==2019,]

write.taf(sid19, quote=TRUE)
