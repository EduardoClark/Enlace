#####Secundaria
### Espanol
#Tercero
Pri3Esp2011 <- rxCube( cal_mat ~ cct, 
                       data="XData/Enlace2011F.xdf",
                       rowSelection= (grado == 1) & (nivel == "SECUNDARIA"))
Pri3Esp2011 <- rxResultsDF(Pri3Esp2011)

#Cuarto
Pri4Esp2011 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2011F.xdf",
                       rowSelection= (grado == 2) & (nivel=="SECUNDARIA"))
Pri4Esp2011 <- rxResultsDF(Pri4Esp2011) 

#Quinto
Pri5Esp2011 <- rxCube( cal_mat ~ cct,
                       data="XData/Enlace2011F.xdf",
                       rowSelection= (grado == 3) & (nivel=="SECUNDARIA"))
Pri5Esp2011 <- rxResultsDF(Pri5Esp2011) 


colnames(Pri3Esp2011) <- c("cct", "cal_mat1", "N1")
colnames(Pri4Esp2011) <- c("cct", "cal_mat2", "N2")
colnames(Pri5Esp2011) <- c("cct", "cal_mat3", "N3")
SecundariaEspanol <- merge(Pri3Esp2011, Pri4Esp2011, by="cct")
SecundariaEspanol <- merge(SecundariaEspanol, Pri5Esp2011, by="cct")
SecundariaEspanol <- arrange(SecundariaEspanol, cct)
SecundariaEspanol$cal_mat1 <- 
  ifelse(is.na(SecundariaEspanol$cal_mat1)==TRUE, 0, SecundariaEspanol$cal_mat1)
SecundariaEspanol$cal_mat2 <- 
  ifelse(is.na(SecundariaEspanol$cal_mat2)==TRUE, 0, SecundariaEspanol$cal_mat2)
SecundariaEspanol$cal_mat3 <- 
  ifelse(is.na(SecundariaEspanol$cal_mat3)==TRUE, 0, SecundariaEspanol$cal_mat3)
SecundariaEspanol$PromedioSecundaria <- (SecundariaEspanol$cal_mat1 + 
                                           SecundariaEspanol$cal_mat2 + SecundariaEspanol$cal_mat3 
) / 3 
SecundariaEspanol$NTotal <- (SecundariaEspanol$N1 + 
                               SecundariaEspanol$N2 + SecundariaEspanol$N3)
SecundariaEspanol <- subset(SecundariaEspanol, PromedioSecundaria != 0)


write.csv(SecundariaEspanol, "Out-Data/SecundariaMat2011.csv")