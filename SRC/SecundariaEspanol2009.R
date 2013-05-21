#####Secundaria
### Espanol
#Tercero
Pri3Esp2009 <- rxCube( cal_esp ~ cct, 
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == 1) & (nivel == "S"))
Pri3Esp2009 <- rxResultsDF(Pri3Esp2009)

#Cuarto
Pri4Esp2009 <- rxCube( cal_esp ~ cct,
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == 2) & (nivel=="S"))
Pri4Esp2009 <- rxResultsDF(Pri4Esp2009) 

#Quinto
Pri5Esp2009 <- rxCube( cal_esp ~ cct,
                       data="XData/Enlace2009.xdf",
                       rowSelection= (grado == 3) & (nivel=="S"))
Pri5Esp2009 <- rxResultsDF(Pri5Esp2009) 


colnames(Pri3Esp2009) <- c("cct", "cal_esp1", "N1")
colnames(Pri4Esp2009) <- c("cct", "cal_esp2", "N2")
colnames(Pri5Esp2009) <- c("cct", "cal_esp3", "N3")
SecundariaEspanol <- merge(Pri3Esp2009, Pri4Esp2009, by="cct")
SecundariaEspanol <- merge(SecundariaEspanol, Pri5Esp2009, by="cct")
SecundariaEspanol <- arrange(SecundariaEspanol, cct)
SecundariaEspanol$cal_esp1 <- 
  ifelse(is.na(SecundariaEspanol$cal_esp1)==TRUE, 0, SecundariaEspanol$cal_esp1)
SecundariaEspanol$cal_esp2 <- 
  ifelse(is.na(SecundariaEspanol$cal_esp2)==TRUE, 0, SecundariaEspanol$cal_esp2)
SecundariaEspanol$cal_esp3 <- 
  ifelse(is.na(SecundariaEspanol$cal_esp3)==TRUE, 0, SecundariaEspanol$cal_esp3)
SecundariaEspanol$PromedioSecundaria <- (SecundariaEspanol$cal_esp1 + 
                                           SecundariaEspanol$cal_esp2 + SecundariaEspanol$cal_esp3 
) / 3 
SecundariaEspanol$NTotal <- (SecundariaEspanol$N1 + 
                               SecundariaEspanol$N2 + SecundariaEspanol$N3)
SecundariaEspanol <- subset(SecundariaEspanol, PromedioSecundaria != 0)


write.csv(SecundariaEspanol, "Out-Data/SecundariaEsp2009.csv")