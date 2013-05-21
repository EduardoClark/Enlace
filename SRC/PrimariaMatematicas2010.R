#####Primaria
### Matematicas
#Tercero
Pri3Esp2010 <- rxCube( cal_mat ~ cct, 
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == 3) & (nivel == "PRIMARIA"))
Pri3Esp2010 <- rxResultsDF(Pri3Esp2010)

#Cuarto
Pri4Esp2010 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == "4") & (nivel=="PRIMARIA"))
Pri4Esp2010 <- rxResultsDF(Pri4Esp2010) 

#Quinto
Pri5Esp2010 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == "5") & (nivel=="PRIMARIA"))
Pri5Esp2010 <- rxResultsDF(Pri5Esp2010) 

#Sexto
Pri6Esp2010 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2010.xdf",
                       rowSelection= (grado == "6") & (nivel=="PRIMARIA"))
Pri6Esp2010 <- rxResultsDF(Pri6Esp2010)


colnames(Pri3Esp2010) <- c("cct", "cal_mat3", "N3")
colnames(Pri4Esp2010) <- c("cct", "cal_mat4", "N4")
colnames(Pri5Esp2010) <- c("cct", "cal_mat5", "N5")
colnames(Pri6Esp2010) <- c("cct", "cal_mat6", "N6")
PrimariaEspanol <- merge(Pri3Esp2010, Pri4Esp2010, by="cct")
PrimariaEspanol <- merge(PrimariaEspanol, Pri5Esp2010, by="cct")
PrimariaEspanol <- merge(PrimariaEspanol, Pri6Esp2010, by="cct")
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


write.csv(PrimariaEspanol, "Out-Data/PrimariaMat2010.csv")