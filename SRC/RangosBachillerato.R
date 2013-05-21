###Rangos Bachillerato
Bachillerato2011 <- read.csv("Data/Bachillerato.csv")
Bachillerato2011$puntaje_espaniol <- as.numeric(
  as.character(Bachillerato2011$puntaje_espaniol))
Bachillerato2011$puntaje_matematicas <- as.numeric(
  as.character(Bachillerato2011$puntaje_matematicas))
Bachillerato2011$puntaje_espaniol <- ifelse(is.na(Bachillerato2011$puntaje_espaniol)
                                            ==TRUE, 0,
                                            Bachillerato2011$puntaje_espaniol)
Bachillerato2011$puntaje_matematicas <- ifelse(is.na(Bachillerato2011$puntaje_matematicas)
                                            ==TRUE, 0,
                                            Bachillerato2011$puntaje_matematicas)
Bachillerato2011$PromedioGeneral <- (Bachillerato2011$puntaje_espaniol + 
                                       Bachillerato2011$puntaje_matematicas) /
                                        2
Bachillerato <- subset(Bachillerato2011, puntaje_espaniol != 0 & puntaje_matematicas != 0)


###Rangos Español
EspNormal <- rnorm(n=12750, mean= mean(Bachillerato$puntaje_espaniol), sd=sd(Bachillerato$puntaje_espaniol))
dat <- data.frame(dens = c(Bachillerato$puntaje_espaniol, EspNormal), Distribución = rep(c("Observado", "Normalizado"), each=12750))
ggplot(dat, aes(x = dens, fill = Distribución)) +
  geom_density(alpha = 0.5) + 
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 (Español) Bachillerato")

###Rangos Matematicas
MatNormal <- rnorm(n=12750, mean= mean(Bachillerato$puntaje_matematicas), sd=sd(Bachillerato$puntaje_matematicas))
dat <- data.frame(dens = c(Bachillerato$puntaje_matematicas, MatNormal), Distribución = rep(c("Observado", "Normalizado"), each=12750))
ggplot(dat, aes(x = dens, fill = Distribución)) +
  geom_density(alpha = 0.5) + 
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 (Matematicas) Bachillerato")

###Rangos General
GeneralNormal <- rnorm(n=12750, mean= mean(Bachillerato$PromedioGeneral), sd=sd(Bachillerato$PromedioGeneral))
dat <- data.frame(dens = c(Bachillerato$PromedioGeneral, GeneralNormal), Distribución = rep(c("Observado", "Normalizado"), each=12750))
ggplot(dat, aes(x = dens, fill = Distribución)) +
  geom_density(alpha = 0.5) + 
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 Bachillerato")

###Definir Rangos
EspGrupos <- sort(unique(cut2(EspNormal, g=10)))
MatGrupos <- sort(unique(cut2(MatNormal, g=10)))
GeneralGrupos <- sort(unique(cut2(GeneralNormal, g=10)))
Grupos <- data.frame(Espanol=EspGrupos, Matematicas=MatGrupos, General=GeneralGrupos)


write.csv(Grupos,"Grupos/GruposBachillerato2011.csv")

###Summary Table for Bachillerato

Bachillerato1 <- data.frame(cct=Bachillerato2011$cctt, promedioEsp=Bachillerato2011$puntaje_espaniol, promedioMat=Bachillerato2011$puntaje_matematicas, promedioGeneral=Bachillerato2011$PromedioGeneral)

write.csv(Bachillerato1, "Out-Data/Bachillerato2011Resumen.csv")