#####Primaria
### Matematicas
#Tercero
Pri3Esp2009 <- rxCube( cal_mat ~ cct, 
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == 3) & (nivel == "P"))
Pri3Esp2009 <- rxResultsDF(Pri3Esp2009)

#Cuarto
Pri4Esp2009 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == "4") & (nivel=="P"))
Pri4Esp2009 <- rxResultsDF(Pri4Esp2009) 

#Quinto
Pri5Esp2009 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == "5") & (nivel=="P"))
Pri5Esp2009 <- rxResultsDF(Pri5Esp2009) 

#Sexto
Pri6Esp2009 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == "6") & (nivel=="P"))
Pri6Esp2009 <- rxResultsDF(Pri6Esp2009)


colnames(Pri3Esp2009) <- c("cct", "cal_mat3", "N3")
colnames(Pri4Esp2009) <- c("cct", "cal_mat4", "N4")
colnames(Pri5Esp2009) <- c("cct", "cal_mat5", "N5")
colnames(Pri6Esp2009) <- c("cct", "cal_mat6", "N6")
PrimariaEspanol <- merge(Pri3Esp2009, Pri4Esp2009, by="cct")
PrimariaEspanol <- merge(PrimariaEspanol, Pri5Esp2009, by="cct")
PrimariaEspanol <- merge(PrimariaEspanol, Pri6Esp2009, by="cct")
PrimariaEspanol <- arrange(PrimariaEspanol, cct)
PrimariaEspanol$cal_mat3 <- 
  ifelse(is.na(PrimariaEspanol$cal_mat3)==TRUE, 0, PrimariaEspanol$cal_mat3)
PrimariaEspanol$cal_mat4 <- 
  ifelse(is.na(PrimariaEspanol$cal_mat4)==TRUE, 0, PrimariaEspanol$cal_mat4)
PrimariaEspanol$cal_mat5 <- 
  ifelse(is.na(PrimariaEspanol$cal_mat5)==TRUE, 0, PrimariaEspanol$cal_mat5)
PrimariaEspanol$cal_mat6 <- 
  ifelse(is.na(PrimariaEspanol$cal_mat6)==TRUE, 0, PrimariaEspanol$cal_mat6)
PrimariaEspanol$PromedioPrimaria <- (PrimariaEspanol$cal_mat3 + 
                                       PrimariaEspanol$cal_mat4 + PrimariaEspanol$cal_mat5 + 
                                       PrimariaEspanol$cal_mat6) / 4 
PrimariaEspanol$NTotal <- (PrimariaEspanol$N3 + 
                             PrimariaEspanol$N4 + PrimariaEspanol$N5 + 
                             PrimariaEspanol$N6)
PrimariaEspanol <- subset(PrimariaEspanol, PromedioPrimaria != 0)


write.csv(PrimariaEspanol, "Out-Data/PrimariaMat2009.csv")