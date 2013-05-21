#####Primaria
### Espanol
#Tercero
Pri3Esp2011 <- rxCube( cal_esp ~ cct, 
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == 3) & (nivel == "PRIMARIA"))
Pri3Esp2011 <- rxResultsDF(Pri3Esp2011)

#Cuarto
Pri4Esp2011 <- rxCube( cal_esp ~ cct,
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == "4") & (nivel=="PRIMARIA"))
Pri4Esp2011 <- rxResultsDF(Pri4Esp2011) 

#Quinto
Pri5Esp2011 <- rxCube( cal_esp ~ cct,
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == "5") & (nivel=="PRIMARIA"))
Pri5Esp2011 <- rxResultsDF(Pri5Esp2011) 

#Sexto
Pri6Esp2011 <- rxCube( cal_esp ~ cct,
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == "6") & (nivel=="PRIMARIA"))
Pri6Esp2011 <- rxResultsDF(Pri6Esp2011)


colnames(Pri3Esp2011) <- c("cct", "cal_esp3", "N3")
colnames(Pri4Esp2011) <- c("cct", "cal_esp4", "N4")
colnames(Pri5Esp2011) <- c("cct", "cal_esp5", "N5")
colnames(Pri6Esp2011) <- c("cct", "cal_esp6", "N6")
PrimariaEspanol <- merge(Pri3Esp2011, Pri4Esp2011, by="cct")
PrimariaEspanol <- merge(PrimariaEspanol, Pri5Esp2011, by="cct")
PrimariaEspanol <- merge(PrimariaEspanol, Pri6Esp2011, by="cct")
PrimariaEspanol <- arrange(PrimariaEspanol, cct)
PrimariaEspanol$cal_esp3 <- 
  ifelse(is.na(PrimariaEspanol$cal_esp3)==TRUE, 0, PrimariaEspanol$cal_esp3)
PrimariaEspanol$cal_esp4 <- 
  ifelse(is.na(PrimariaEspanol$cal_esp4)==TRUE, 0, PrimariaEspanol$cal_esp4)
PrimariaEspanol$cal_esp5 <- 
  ifelse(is.na(PrimariaEspanol$cal_esp5)==TRUE, 0, PrimariaEspanol$cal_esp5)
PrimariaEspanol$cal_esp6 <- 
  ifelse(is.na(PrimariaEspanol$cal_esp6)==TRUE, 0, PrimariaEspanol$cal_esp6)
PrimariaEspanol$PromedioPrimaria <- (PrimariaEspanol$cal_esp3 + 
                                       PrimariaEspanol$cal_esp4 + PrimariaEspanol$cal_esp5 + 
                                       PrimariaEspanol$cal_esp6) / 4 
PrimariaEspanol$NTotal <- (PrimariaEspanol$N3 + 
                             PrimariaEspanol$N4 + PrimariaEspanol$N5 + 
                             PrimariaEspanol$N6)
PrimariaEspanol <- subset(PrimariaEspanol, PromedioPrimaria != 0)


write.csv(PrimariaEspanol, "Out-Data/PrimariaEsp2010.csv")