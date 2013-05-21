####
rxImport(inData="Data/Enlace_2011_nacional.csv",
         outFile="XData/Enlace2011",
         overwrite=TRUE, type="text",
         colClasses=c(cct="factor",
                      nofolio="factor", nivel="factor",
                      turno="factor", grado="factor", grupo="factor"))

rxImport(inData="Data/Enlace_2010_nacional.csv",
         outFile="XData/Enlace2010",
         overwrite=TRUE,
         colClasses=c(cct="factor",
                      nofolio="factor", nivel="factor",
                      turno="factor", grado="factor", grupo="factor")  ) 

rxImport(inData="Data/Enlace_2009_nacional.csv",
         outFile="XData/Enlace2009",
         overwrite=TRUE,
         colClasses=c(cct="factor",
                      nofolio="factor", nivel="factor",
                      turno="factor", grado="factor", grupo="factor") ) 

rxImport(inData="Data/Enlace_2008_nacional.sav",
         outFile="XData/Enlace2008",
         overwrite=TRUE,
         colClasses=c(cct="factor",
                      nofolio="factor", nivel="factor",
                      turno="factor", grado="factor", grupo="factor") )

rxImport(inData="Data/Enlace_2007_nacional.sav",
         outFile="XData/Enlace2007",
         overwrite=TRUE,
         colClasses=c(cct="factor",
                      nofolio="factor", nivel="factor",
                      turno="factor", grado="factor", grupo="factor") )


         
rxFactors(inData="XData/Enlace2011.xdf", factorInfo=("cct"), outFile="XData/Enlace2011F.xdf")
rxFactors(inData="XData/Enlace2011F.xdf", factorInfo=("nivel"), outFile="XData/Enlace2011F1.xdf")