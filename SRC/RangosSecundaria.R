### Create Ranges for Secundaria
Esp <- read.csv("Out-Data/SecundariaEsp2011.csv")
Mat <- read.csv("Out-Data/SecundariaMat011.csv")

Secundaria <- data.frame(cct=Esp$cct, Esp=Esp$PromedioSecundaria,
                       Mat=Mat$PromedioSecundaria,
                       NEsp= Esp$NTotal, NMat= Mat$NTotal) ###Write more concise df.

Secundaria$PromedioGeneral <- (Secundaria$Mat + Secundaria$Esp) / 2

### Get observed distribution omitting zeroes
Esp <- subset(Esp, cal_esp1 !=0 & cal_esp2 != 0 & cal_esp3 !=0)
EspNormal <- rnorm(n=31216, mean= mean(Esp$PromedioSecundaria), sd=sd(Esp$PromedioSecundaria))
dat <- data.frame(dens = c(Secundaria$Esp, EspNormal), Distribución = rep(c("Observado", "Normalizado"), each=31216))
ggplot(dat, aes(x = dens, fill = Distribución)) +
  geom_density(alpha = 0.5) + 
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 (Español) Secundaria")

Mat <- subset(Mat, cal_mat1 !=0 & cal_mat2 != 0 & cal_mat3 != 0)
General <- merge(Esp, Mat, by="cct", all=FALSE)
General$PromedioGeneral <- (General$PromedioSecundaria.x + General$PromedioSecundaria.y) / 2 
GeneralNormal <- rnorm(n=31216, mean= mean(General$PromedioGeneral), sd=sd(General$PromedioGeneral))
dat3 <- data.frame(dens = c(Secundaria$PromedioGeneral, GeneralNormal), Distribución = rep(c("Observado", "Normalizado"), each=31216))
ggplot(dat3, aes(x = dens, fill = Distribución)) +
  geom_density(alpha = 0.5) + 
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 Secundaria")


###Create Groups
EspGrupos <- sort(unique(cut2(EspNormal, g=10)))
MatGrupos <- sort(unique(cut2(MatNormal, g=10)))
GeneralGrupos <- sort(unique(cut2(GeneralNormal, g=10)))
Grupos <- data.frame(Espanol=EspGrupos, Matematicas=MatGrupos, General=GeneralGrupos)

write.csv(Grupos,"Grupos/GruposSecundaria2011.csv")
write.csv(Secundaria, "Out-Data/Secundaria2011Resumen.csv")


