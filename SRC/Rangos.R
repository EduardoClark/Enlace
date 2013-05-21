### Create Ranges for Primaria
Esp <- read.csv("Out-Data/PrimariaEsp2011.csv")
Mat <- read.csv("Out-Data/PrimariaMat2011.csv")

Primaria <- data.frame(cct=Esp$cct, Esp=Esp$PromedioPrimaria, Mat=Mat$PromedioPrimaria,
                       NEsp= Esp$NTotal, NMat= Mat$NTotal) ###Write more concide df.


### Get observed distribution omitting zeroes
Esp <- subset(Esp, cal_esp3 !=0 & cal_esp4 != 0 & cal_esp5 != 0 & cal_esp6 != 0)
EspNormal <- rnorm(n=90538, mean= mean(Esp$PromedioPrimaria), sd=sd(Esp$PromedioPrimaria))
dat <- data.frame(dens = c(Primaria$Esp, EspNormal), Distribución = rep(c("Observado", "Normalizado"), each=90538))
ggplot(dat, aes(x = dens, fill = Distribución)) +
      geom_density(alpha = 0.5) + 
       ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 (Español)")
      

Mat <- subset(Mat, cal_mat3 !=0 & cal_mat4 != 0 & cal_mat5 != 0 & cal_mat6 != 0)
MatNormal <- rnorm(n=90538, mean= mean(Mat$PromedioPrimaria), sd=sd(Mat$PromedioPrimaria))
dat2 <- data.frame(dens = c(Primaria$Mat, MatNormal), Distribución = rep(c("Observado", "Normalizado"), each=90538))
ggplot(dat2, aes(x = dens, fill = Distribución)) + geom_density(alpha = 0.5) +
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011 (Matematicas)")

Primaria$PromedioGeneral <- (Primaria$Esp + Primaria$Mat) / 2 
General <- merge(Esp, Mat, by="cct", all=FALSE)
General$PromedioGeneral <- (General$PromedioPrimaria.x + General$PromedioPrimaria.y) / 2 
GeneralNormal <- rnorm(n=90538, mean= mean(General$PromedioGeneral), sd=sd(General$PromedioGeneral))      
dat3 <- data.frame(dens = c(Primaria$PromedioGeneral, GeneralNormal), Distribución = rep(c("Observado", "Normalizado"), each=90538))
ggplot(dat3, aes(x = dens, fill = Distribución)) + geom_density(alpha = 0.5) +
  ylab("Densidad") + xlab("Puntaje Promedio") + ggtitle("Enlace 2011")
                              
###Create Groups
EspGrupos <- sort(unique(cut2(EspNormal, g=10)))
MatGrupos <- sort(unique(cut2(MatNormal, g=10)))
GeneralGrupos <- sort(unique(cut2(GeneralNormal, g=10)))
Grupos <- data.frame(Espanol=EspGrupos, Matematicas=MatGrupos, General=GeneralGrupos)

write.csv(Grupos,"Grupos/GruposPrimaria2011.csv")
write.csv(Primaria, "Out-Data/Primaria2011Resumen.csv")



