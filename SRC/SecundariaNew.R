#####Secundaria
### Espanol
#Tercero
Pri3Esp2011 <- rxCube( cal_new ~ cct, 
                       data="XData/Enlace2011F.xdf",
                       rowSelection= (grado == 1) & (nivel == "SECUNDARIA"))
Pri3Esp2011 <- rxResultsDF(Pri3Esp2011)

#Cuarto
Pri4Esp2011 <- rxCube( cal_new ~ cct,
                       data="XData/Enlace2011F.xdf",
                       rowSelection= (grado == 2) & (nivel=="SECUNDARIA"))
Pri4Esp2011 <- rxResultsDF(Pri4Esp2011) 

#Quinto
Pri5Esp2011 <- rxCube( cal_new ~ cct,
                       data="XData/Enlace2011F.xdf",
                       rowSelection= (grado == 3) & (nivel=="SECUNDARIA"))
Pri5Esp2011 <- rxResultsDF(Pri5Esp2011) 


colnames(Pri3Esp2011) <- c("cct", "cal_new1", "N1")
colnames(Pri4Esp2011) <- c("cct", "cal_new2", "N2")
colnames(Pri5Esp2011) <- c("cct", "cal_new3", "N3")
SecundariaEspanol <- merge(Pri3Esp2011, Pri4Esp2011, by="cct")
SecundariaEspanol <- merge(SecundariaEspanol, Pri5Esp2011, by="cct")
SecundariaEspanol <- arrange(SecundariaEspanol, cct)
SecundariaEspanol$cal_new1 <- 
  ifelse(is.na(SecundariaEspanol$cal_new1)==TRUE, 0, SecundariaEspanol$cal_new1)
SecundariaEspanol$cal_new2 <- 
  ifelse(is.na(SecundariaEspanol$cal_new2)==TRUE, 0, SecundariaEspanol$cal_new2)
SecundariaEspanol$cal_new3 <- 
  ifelse(is.na(SecundariaEspanol$cal_new3)==TRUE, 0, SecundariaEspanol$cal_new3)
SecundariaEspanol$PromedioSecundaria <- (SecundariaEspanol$cal_new1 + 
                                           SecundariaEspanol$cal_new2 + SecundariaEspanol$cal_new3 
) / 3 
SecundariaEspanol$NTotal <- (SecundariaEspanol$N1 + 
                               SecundariaEspanol$N2 + SecundariaEspanol$N3)
SecundariaEspanol <- subset(SecundariaEspanol, PromedioSecundaria != 0)


write.csv(SecundariaEspanol, "Out-Data/SecundariaNew011.csv")