#### Primaria Matematicas
lista <- list.files("Out-Data/", pattern="PrimariaMat*")
for (i in 1: length(lista)){
  assign(gsub(".csv", "", lista[i]), read.csv(paste("Out-Data/", lista[i], sep="")))}
remove(i, lista)
lista <- ls(pattern="PrimariaMat*")
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  tmp <- data.frame(cct=tmp[2], promedio=tmp[11])
  assign(lista[i], tmp)
  remove(tmp)
}
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  colnames(tmp) <- c("cct", paste("Promedio", substr(lista[i], 12,17), sep=""))
  assign(lista[i], tmp)
  remove(tmp)
}
remove(i)

ResumenPrimariaMatematicas <- merge(PrimariaMat2011, PrimariaMat2010, by="cct", all=TRUE)
ResumenPrimariaMatematicas <- merge(ResumenPrimariaMatematicas, PrimariaMat2009, by="cct", all=TRUE)

write.csv(ResumenPrimariaMatematicas, file="Out-Data/ResumenPrimariaMatematicas.csv")

#### Primaria Español
lista <- list.files("Out-Data/", pattern="PrimariaEsp*")
for (i in 1: length(lista)){
  assign(gsub(".csv", "", lista[i]), read.csv(paste("Out-Data/", lista[i], sep="")))}
remove(i, lista)
lista <- ls(pattern="PrimariaEsp*")
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  tmp <- data.frame(cct=tmp[2], promedio=tmp[11])
  assign(lista[i], tmp)
  remove(tmp)
}
for(i in 1: length(lista)){
  tmp <- get(lista[i])
  colnames(tmp) <- c("cct", paste("Promedio", substr(lista[i], 12,17), sep=""))
  assign(lista[i], tmp)
  remove(tmp)
}
remove(i)

ResumenPrimariaEspanol <- merge(PrimariaEsp2011, PrimariaEsp2010, by="cct", all=TRUE)
ResumenPrimariaEspanol <- merge(ResumenPrimariaEspanol, PrimariaEsp2009, by="cct", all=TRUE)

write.csv(ResumenPrimariaEspanol, file="Out-Data/ResumenPrimariaEspanol.csv")


#### Primaria General
P2009 <- merge(PrimariaEsp2009, PrimariaMat2009, by="cct", all=TRUE)
P2010 <- merge(PrimariaEsp2010, PrimariaMat2010, by="cct", all=TRUE)
P2011 <- merge(PrimariaEsp2011, PrimariaMat2011, by="cct", all=TRUE)
P2009$PromedioGeneral2009 <- (P2009$Promedio2009.x + P2009$Promedio2009.y) / 2
P2010$PromedioGeneral2010 <- (P2010$Promedio2010.x + P2010$Promedio2010.y) / 2
P2011$PromedioGeneral2011 <- (P2011$Promedio2011.x + P2011$Promedio2011.y) / 2
P2009[2] <- NULL; P2009[2] <- NULL; P2010[2] <- NULL; P2010[2] <- NULL 
P2011[2] <- NULL; P2011[2] <- NULL
ResumenPrimariaGeneral <- merge(P2009, P2010, by="cct", all=TRUE)
ResumenPrimariaGeneral <- merge(ResumenPrimariaGeneral, P2011, by="cct", all=TRUE)

write.csv(ResumenPrimariaGeneral, file="Out-Data/ResumenPrimanariaGeneral")

remove(list=ls())