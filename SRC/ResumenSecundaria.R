#### Secundaria Matematicas
lista <- list.files("Out-Data/", pattern="SecundariaMat*")
for (i in 1: length(lista)){
  assign(gsub(".csv", "", lista[i]), read.csv(paste("Out-Data/", lista[i], sep="")))}
remove(i, lista)
lista <- ls(pattern="SecundariaMat*")
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  tmp <- data.frame(cct=tmp[2], promedio=tmp[9])
  assign(lista[i], tmp)
  remove(tmp)
}
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  colnames(tmp) <- c("cct", paste("Promedio", substr(lista[i], 14,19), sep=""))
  assign(lista[i], tmp)
  remove(tmp)
}
remove(i)

ResumenSecundariaMatematicas <- merge(SecundariaMat2011, SecundariaMat2010, by="cct", all=TRUE)
ResumenSecundariaMatematicas <- merge(ResumenSecundariaMatematicas, SecundariaMat2009, by="cct", all=TRUE)

write.csv(ResumenSecundariaMatematicas, file="Out-Data/ResumenSecundariaMatematicas.csv")

#### Secundaria Español
lista <- list.files("Out-Data/", pattern="SecundariaEsp*")
for (i in 1: length(lista)){
  assign(gsub(".csv", "", lista[i]), read.csv(paste("Out-Data/", lista[i], sep="")))}
remove(i, lista)
lista <- ls(pattern="SecundariaEsp*")
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  tmp <- data.frame(cct=tmp[2], promedio=tmp[9])
  assign(lista[i], tmp)
  remove(tmp)
}
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  colnames(tmp) <- c("cct", paste("Promedio", substr(lista[i], 14,19), sep=""))
  assign(lista[i], tmp)
  remove(tmp)
}
remove(i)

ResumenSecundariaEspanol <- merge(SecundariaEsp2011, SecundariaEsp2010, by="cct", all=TRUE)
ResumenSecundariaEspanol <- merge(ResumenSecundariaEspanol, SecundariaEsp2009, by="cct", all=TRUE)

write.csv(ResumenSecundariaEspanol, file="Out-Data/ResumenSecundariaEspanol.csv")


#### Secundaria General
P2009 <- merge(SecundariaEsp2009, SecundariaMat2009, by="cct", all=TRUE)
P2010 <- merge(SecundariaEsp2010, SecundariaMat2010, by="cct", all=TRUE)
P2011 <- merge(SecundariaEsp2011, SecundariaMat2011, by="cct", all=TRUE)
P2009$PromedioGeneral2009 <- (P2009$Promedio2009.x + P2009$Promedio2009.y) / 2
P2010$PromedioGeneral2010 <- (P2010$Promedio2010.x + P2010$Promedio2010.y) / 2
P2011$PromedioGeneral2011 <- (P2011$Promedio2011.x + P2011$Promedio2011.y) / 2
P2009[2] <- NULL; P2009[2] <- NULL; P2010[2] <- NULL; P2010[2] <- NULL 
P2011[2] <- NULL; P2011[2] <- NULL
ResumenSecundariaGeneral <- merge(P2009, P2010, by="cct", all=TRUE)
ResumenSecundariaGeneral <- merge(ResumenSecundariaGeneral, P2011, by="cct", all=TRUE)

write.csv(ResumenSecundariaGeneral, file="Out-Data/ResumenSecundariaGeneral")

remove(list=ls())