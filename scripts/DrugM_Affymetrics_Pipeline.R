



#
# IMPORT the libraries
library('affy')
library('GEOquery')
library("dplyr")
library("magrittr")
library("arrayQualityMetrics")
library("annotate")
library("rat2302.db")
#library("MASS")
library('readxl')
library('xlsx')
library('stringr')
library("limma")
library(piano)

Meta_liver <- read_excel("~/R/Dataset_liv_kid_hepa/Meta_select_liver (1).xlsx")

Meta_kidney <- read_excel("~/R/Dataset_liv_kid_hepa/Meta_select_kidney (1).xlsx")

Meta_hepa <- read_excel("~/R/Dataset_liv_kid_hepa/Meta_select_hepa (1).xlsx")

listGEO_liv <- list(Meta_liver$`Source Name`)
listGEO_kid <- list(Meta_kidney$`Source Name`)
listGEO_hepa <- list(Meta_hepa$`Source Name`)
#getGEO("GSM1449207",destdir="./Dataset/")
#getGEOSuppFiles("GSM1449207",baseDir = './Dataset/')

GEOlistDL <- function(x){
  getGEOSuppFiles(x, makeDirectory = FALSE, baseDir = './Dataset_liv_kid_hepa/GSMliver',fetch_files = FALSE)
}

for (G in listGEO_liv){
  lapply(G, GEOlistDL)
}

GEOlistDL <- function(x){
  getGEOSuppFiles(x, makeDirectory = FALSE, baseDir = './Dataset_liv_kid_hepa/GSMkidney',fetch_files = TRUE)
}

for (G in listGEO_kid){
  lapply(G, GEOlistDL)
}

GEOlistDL <- function(x){
  getGEOSuppFiles(x, makeDirectory = FALSE, baseDir = './Dataset_liv_kid_hepa/GSMhepa',fetch_files = TRUE)
}

for (G in listGEO_hepa){
  lapply(G, GEOlistDL)
}



######################### Liver #########################################

# Read CEL.gz files into affybatch and normalize

fls <- list.files("./Dataset_liv_kid_hepa/GSMliver", ".*CEL.gz")                                   # Rename!!
aBatch_liv <- ReadAffy(celfile.path = './Dataset_liv_kid_hepa/GSMliver/',filenames = fls)           # Rename!!
eset_liv <- rma(aBatch_liv)
#exprs(eset_liv)



# Quality control and outlier detection, remove outliers
#arrayQualityMetrics(expressionset = eset_liv,
#                    outdir = "QCreport1.pdf",
#                    force = TRUE
#                    #,
#                    #do.logtransform = TRUE
#                    )

preparedData_liv = prepdata(expressionset = eset_liv,
                            intgroup = c(),
                            do.logtransform = FALSE
                            )
ht = aqm.heatmap(preparedData_liv)
#ht@outliers@which[1]
ht_tmp <- as.data.frame(ht@outliers@which)[,1]
df_liv <- as.data.frame(exprs(eset_liv))
df_liv <- df_liv[ ,-ht_tmp]
df_tmp <- df_liv


# Annotation PROBEID and GENE SYMBOL

ae.annots <- AnnotationDbi::select(
  x       = rat2302.db,
  keys    = rownames(eset_liv),
  columns = c("PROBEID", "ENSEMBL", "ENTREZID", "SYMBOL"),
  keytype = "PROBEID"
  )

ae.annots <- ae.annots[!duplicated(ae.annots['PROBEID']),]
rownames(ae.annots) <- ae.annots$PROBEID
df_liv <- cbind(ae.annots$PROBEID,ae.annots$SYMBOL,df_liv)
colnames(df_liv)[1:2] <- c("PROBEID",'SYMBOL')


df_MAD <- df_tmp
m <- apply(X = df_MAD[,], MARGIN = 1, FUN = mad)
df_MAD <- cbind(df_MAD,MAD = m)

df_liv <- cbind(df_MAD[,'MAD'],df_liv)
colnames(df_liv)[1] <- "MAD"

df_liv <- as.data.frame(df_liv)
df_liv$MAD <- as.numeric(as.character(df_liv$MAD))
#df_liv %>% group_by(SYMBOL) %>% filter(MAD==max(MAD))
df_liv <- df_liv[with(df_liv, ave(MAD, SYMBOL, FUN=max)==MAD),]
df_liv <- df_liv[-which(is.na(df_liv$SYMBOL)),]
df_final <- df_liv[,-c(1,2,3)]
rownames(df_final) <- df_liv$SYMBOL

df_liver <- df_final
rownames(df_liver) <- rownames(df_final)

#df_final
df_df_2 <- df_liv[,-c(1,2,3)]
df_df <- df_df_2

#annot_liv <- ae.annots[-which(is.na(ae.annots$SYMBOL)),]
#annot_liv <- annot_liv[rownames(df_liv),]
#write.xlsx(annot_liv, file = "./Dataset/annot_liv.xlsx")

Meta_liver <- as.data.frame(read_excel("~/R/Dataset_liv_kid_hepa/Meta_select_liver (1).xlsx"))             # Rename!!
Meta_liver_2 <- Meta_liver[order(Meta_liver$`Source Name`),]

Long <- Meta_liver_2$`Source Name`
Short <- substr(colnames(exprs(eset_liv)),1,10)
Meta_liver_2 <- Meta_liver_2[Long %in% Short,]
Meta_liver_2 <- Meta_liver_2[-ht_tmp,]

#write.xlsx(Meta_liver_2, file = "./Dataset_liv_kid/Meta_liver_2.xlsx")
#Meta_liver <- as.data.frame(read_excel("~/R/Dataset_liv_kid/Meta_liver_2.xlsx"))
#Meta_liver_2 <- Meta_liver[order(Meta_liver$`Source Name`),]
#rownames(Meta_liver_2) <- Meta_liver_2$X__1
#Meta_liver_2 <- Meta_liver_2[,2:7]
#Long <- Meta_liver_2$`Source Name`
#Short <- substr(colnames(df_df),1,10)
#matches <- grepl(paste0(Short,collapse="|"), Long)
#Meta_liver_2 <- Meta_liver_2[match(Short,Long),]
#Meta_liver_2 <- Meta_liver_2[Meta_liver_2$`Source Name` %in% intersect(Long,Short),]
#Meta_liver_2 <- na.omit(Meta_liver_2)

Meta_liver_2$`FactorValue [DOSE]` <- as.numeric(Meta_liver_2$`FactorValue [DOSE]`)
Meta_liver_2$'Catagory' <- cut(Meta_liver_2$`FactorValue [DOSE]`,c(-Inf,0,Inf),c("Control","Treatment") )  
Meta_liver_2['Source Name CEL'] <- colnames(df_df)
Meta_liver_2 <- Meta_liver_2 %>% group_by(`FactorValue [COMPOUND]`) %>% filter(n() > 2)
Meta_liver_2 <- Meta_liver_2[order(Meta_liver_2$`Source Name`),]
list_liv_comp <- unique(Meta_liver_2$`FactorValue [COMPOUND]`)                                   # Rename!!

#write.xlsx(as.data.frame(Meta_liver_2), file = "./Dataset_liv_kid_hepa/Meta_liver_2.xlsx")           # Rename!!

#######################################################################



######################### Kidney #########################################

fls <- list.files("./Dataset_liv_kid_hepa/GSMkidney", ".*CEL.gz")                                    # Rename!!
aBatch_liv <- ReadAffy(celfile.path = './Dataset_liv_kid_hepa/GSMkidney/',filenames = fls)            # Rename!!
eset_liv <- rma(aBatch_liv)
#exprs(eset_liv)

# Quality control and outlier detection, remove outliers
#arrayQualityMetrics(expressionset = eset_liv,
#                    outdir = "QCreport1.pdf",
#                    force = TRUE
#                    #,
#                    #do.logtransform = TRUE
#                    )

preparedData_liv = prepdata(expressionset = eset_liv,
                            intgroup = c(),
                            do.logtransform = FALSE
)
ht = aqm.heatmap(preparedData_liv)
#ht@outliers@which[1]
ht_tmp <- as.data.frame(ht@outliers@which)[,1]
df_liv <- as.data.frame(exprs(eset_liv))
df_liv <- df_liv[ ,-ht_tmp]
df_tmp <- df_liv


# Annotation PROBEID and GENE SYMBOL

ae.annots <- AnnotationDbi::select(
  x       = rat2302.db,
  keys    = rownames(eset_liv),
  columns = c("PROBEID", "ENSEMBL", "ENTREZID", "SYMBOL"),
  keytype = "PROBEID"
)

ae.annots <- ae.annots[!duplicated(ae.annots['PROBEID']),]
rownames(ae.annots) <- ae.annots$PROBEID
df_liv <- cbind(ae.annots$PROBEID,ae.annots$SYMBOL,df_liv)
colnames(df_liv)[1:2] <- c("PROBEID",'SYMBOL')


df_MAD <- df_tmp
m <- apply(X = df_MAD[,], MARGIN = 1, FUN = mad)
df_MAD <- cbind(df_MAD,MAD = m)

df_liv <- cbind(df_MAD[,'MAD'],df_liv)
colnames(df_liv)[1] <- "MAD"

df_liv <- as.data.frame(df_liv)
df_liv$MAD <- as.numeric(as.character(df_liv$MAD))
#df_liv %>% group_by(SYMBOL) %>% filter(MAD==max(MAD))
df_liv <- df_liv[with(df_liv, ave(MAD, SYMBOL, FUN=max)==MAD),]
df_liv <- df_liv[-which(is.na(df_liv$SYMBOL)),]
df_final <- df_liv[,-c(1,2,3)]
rownames(df_final) <- df_liv$SYMBOL

df_kidney <- df_final
rownames(df_kidney) <- rownames(df_final)

df_df_2 <- df_liv[,-c(1,2,3)]
df_df <- df_df_2

Meta_kidney <- as.data.frame(read_excel("~/R/Dataset_liv_kid_hepa/Meta_select_kidney (1).xlsx"))           # Rename!!
Meta_kidney_2 <- Meta_kidney[order(Meta_kidney$`Source Name`),]
Long <- Meta_kidney_2$`Source Name`
Short <- substr(colnames(exprs(eset_liv)),1,10)
Meta_kidney_2 <- Meta_kidney_2[Long %in% Short,]
Meta_kidney_2 <- Meta_kidney_2[-ht_tmp,]

Meta_kidney_2$`FactorValue [DOSE]` <- as.numeric(Meta_kidney_2$`FactorValue [DOSE]`)
Meta_kidney_2$'Catagory' <- cut(Meta_kidney_2$`FactorValue [DOSE]`,c(-Inf,0,Inf),c("Control","Treatment") )  
Meta_kidney_2['Source Name CEL'] <- colnames(df_df)
Meta_kidney_2 <- Meta_kidney_2 %>% group_by(`FactorValue [COMPOUND]`) %>% filter(n() > 2)
Meta_kidney_2 <- Meta_kidney_2[order(Meta_kidney_2$`Source Name`),]
list_kid_comp <- unique(Meta_kidney_2$`FactorValue [COMPOUND]`)                                         # Rename!!

#write.xlsx(as.data.frame(Meta_kidney_2), file = "./Dataset_liv_kid_hepa/Meta_kidney_2.xlsx")                # Rename!!


#######################################################################



######################### Hepatocyte #########################################


fls <- list.files("./Dataset_liv_kid_hepa/GSMhepa", ".*CEL.gz")                                           # Rename!!
aBatch_liv <- ReadAffy(celfile.path = './Dataset_liv_kid_hepa/GSMhepa/',filenames = fls)                   # Rename!!

eset_liv <- rma(aBatch_liv)

#exprs(eset_liv)

# Quality control and outlier detection, remove outliers
#arrayQualityMetrics(expressionset = eset_liv,
#                    outdir = "QCreport1.pdf",
#                    force = TRUE
#                    #,
#                    #do.logtransform = TRUE
#                    )

preparedData_liv = prepdata(expressionset = eset_liv,
                            intgroup = c(),
                            do.logtransform = FALSE
)
ht = aqm.heatmap(preparedData_liv)
#ht@outliers@which[1]
ht_tmp <- as.data.frame(ht@outliers@which)[,1]
df_liv <- as.data.frame(exprs(eset_liv))
df_liv <- df_liv[ ,-ht_tmp]
df_tmp <- df_liv


# Annotation PROBEID and GENE SYMBOL

ae.annots <- AnnotationDbi::select(
  x       = rat2302.db,
  keys    = rownames(eset_liv),
  columns = c("PROBEID", "ENSEMBL", "ENTREZID", "SYMBOL"),
  keytype = "PROBEID"
)

ae.annots <- ae.annots[!duplicated(ae.annots['PROBEID']),]
rownames(ae.annots) <- ae.annots$PROBEID
df_liv <- cbind(ae.annots$PROBEID,ae.annots$SYMBOL,df_liv)
colnames(df_liv)[1:2] <- c("PROBEID",'SYMBOL')


df_MAD <- df_tmp
m <- apply(X = df_MAD[,], MARGIN = 1, FUN = mad)
df_MAD <- cbind(df_MAD,MAD = m)

df_liv <- cbind(df_MAD[,'MAD'],df_liv)
colnames(df_liv)[1] <- "MAD"

df_liv <- as.data.frame(df_liv)
df_liv$MAD <- as.numeric(as.character(df_liv$MAD))
#df_liv %>% group_by(SYMBOL) %>% filter(MAD==max(MAD))
df_liv <- df_liv[with(df_liv, ave(MAD, SYMBOL, FUN=max)==MAD),]
df_liv <- df_liv[-which(is.na(df_liv$SYMBOL)),]
df_final <- df_liv[,-c(1,2,3)]
rownames(df_final) <- df_liv$SYMBOL

df_hepatocyte <- df_final
rownames(df_hepatocyte) <- rownames(df_final)

df_df_2 <- df_liv[,-c(1,2,3)]
df_df <- df_df_2


Meta_hepa <- as.data.frame(read_excel("~/R/Dataset_liv_kid_hepa/Meta_select_hepa (1).xlsx"))           # Rename!!
Meta_hepa_2 <- Meta_hepa[order(Meta_hepa$`Source Name`),]
Long <- Meta_hepa_2$`Source Name`
Short <- substr(colnames(exprs(eset_liv)),1,10)
Meta_hepa_2 <- Meta_hepa_2[Long %in% Short,]
Meta_hepa_2 <- Meta_hepa_2[-ht_tmp,]

Meta_hepa_2$`FactorValue [DOSE]` <- as.numeric(Meta_hepa_2$`FactorValue [DOSE]`)
Meta_hepa_2$'Catagory' <- cut(Meta_hepa_2$`FactorValue [DOSE]`,c(-Inf,0,Inf),c("Control","Treatment") )  
Meta_hepa_2['Source Name CEL'] <- colnames(df_df)
Meta_hepa_2 <- Meta_hepa_2 %>% group_by(`FactorValue [COMPOUND]`) %>% filter(n() > 2)
Meta_hepa_2 <- Meta_hepa_2[order(Meta_hepa_2$`Source Name`),]
list_hepa_comp <- unique(Meta_hepa_2$`FactorValue [COMPOUND]`)                                     # Rename!!

#write.xlsx(as.data.frame(Meta_hepa_2), file = "./Dataset_liv_kid_hepa/Meta_hepa_2.xlsx")                # Rename!!






######################### Three tissues ################################


df_liv_kid_hepa <- cbind(df_liver,df_kidney[match(rownames(df_liver),rownames(df_kidney)),])
df_liv_kid_hepa <- cbind(df_liv_kid_hepa,df_hepatocyte[match(rownames(df_liv_kid_hepa),rownames(df_hepatocyte)),])
#write.xlsx(as.data.frame(df_liv_kid_hepa), file = "./Dataset_liv_kid_hepa/eset_liv_kid_hepa.xlsx")     
#write.table(df_liv_kid_hepa, file = "./Dataset_liv_kid_hepa/eset_liv_kid_hepa.txt", sep = "\t",row.names = TRUE, col.names = TRUE)

df_liv_kid_hepa <- read.delim(file = "./Dataset_liv_kid_hepa/eset_liv_kid_hepa.txt",header = TRUE, sep = "\t",dec = ".")



######################### Two tissues ################################

df_liv_kid <- cbind(df_liver,df_kidney[match(rownames(df_liver),rownames(df_kidney)),])
#write.xlsx(as.data.frame(df_liv_kid_hepa), file = "./Dataset_liv_kid/eset_liv_kid.xlsx")     
write.table(df_liv_kid, file = "./Dataset_liv_kid/eset_liv_kid.txt", sep = "\t",row.names = TRUE, col.names = TRUE)

df_liv_kid <- read.delim(file = "./Dataset_liv_kid/eset_Nystatin.txt",header = TRUE, sep = "\t",dec = ".")


#df_10597 <- read.delim(file = "./GPL1355-10794.txt",header = TRUE, sep = "\t")



########################################################################


# Extract Compopund "fenofibrate" expression data to a dataframe
# azathioprine in three tissues: liver, kidney and hepatoctye

Meta_liver_2 <- read_excel("~/R/Dataset_liv_kid_hepa/Meta_liver_2.xlsx")
Meta_kidney_2 <- read_excel("~/R/Dataset_liv_kid_hepa/Meta_kidney_2.xlsx")
Meta_hepa_2 <- read_excel("~/R/Dataset_liv_kid_hepa/Meta_hepa_2.xlsx")

a1 <- Meta_liver_2$`Source Name CEL`[which(Meta_liver_2$`FactorValue [COMPOUND]`== 'fenofibrate')]
a2 <- Meta_kidney_2$`Source Name CEL`[which(Meta_kidney_2$`FactorValue [COMPOUND]`== 'fenofibrate')]
a3 <- Meta_hepa_2$`Source Name CEL`[which(Meta_hepa_2$`FactorValue [COMPOUND]`== 'fenofibrate')]
c1 <- Meta_liver_2$`Source Name CEL`[which(Meta_liver_2$`FactorValue [COMPOUND]`== 'not specified')]
c2 <- Meta_kidney_2$`Source Name CEL`[which(Meta_kidney_2$`FactorValue [COMPOUND]`== 'not specified')]
c3 <- Meta_hepa_2$`Source Name CEL`[which(Meta_hepa_2$`FactorValue [COMPOUND]`== 'not specified')]
fenofibrate_CEL <- c(a1,a2,a3,c1,c2,c3)

df_fenofibrate <- df_liv_kid_hepa[,fenofibrate_CEL]
#write.xlsx(as.data.frame(df_azathioprine), file = "./Dataset_liv_kid_hepa/eset_azathioprine.xlsx") 
#write.csv(df_azathioprine, file = "./Dataset_liv_kid_hepa/eset_azathioprine.csv")
write.table(df_fenofibrate, file = "./Dataset_liv_kid_hepa/eset_fenofibrate.txt", sep = "\t",row.names = TRUE, col.names = TRUE)

#read.delim(file = "./Dataset_liv_kid_hepa/eset_azathioprine.txt",header = TRUE, sep = "\t",dec = ".")


# Extract Compopund "azathioprine" expression data to a dataframe
# azathioprine in three tissues: liver, kidney and hepatoctye


Meta_liver_2 <- read_excel("~/R/Dataset_liv_kid/Meta_liver_2.xlsx")
Meta_kidney_2 <- read_excel("~/R/Dataset_liv_kid/Meta_kidney_2.xlsx")

a1 <- Meta_liver_2$`Source Name CEL`[which(Meta_liver_2$`FactorValue [COMPOUND]`== 'Nystatin')]
a2 <- Meta_kidney_2$`Source Name CEL`[which(Meta_kidney_2$`FactorValue [COMPOUND]`== 'Nystatin')]
c1 <- Meta_liver_2$`Source Name CEL`[which(Meta_liver_2$`FactorValue [COMPOUND]`== 'not specified')]
c2 <- Meta_kidney_2$`Source Name CEL`[which(Meta_kidney_2$`FactorValue [COMPOUND]`== 'not specified')]
Nystatin_CEL <- c(a1,a2,c1,c2)

df_Nystatin <- df_liv_kid[,Nystatin_CEL]
#write.xlsx(as.data.frame(df_Nystatin), file = "./Dataset_liv_kid/eset_Nystatin.xlsx") 
#write.table(df_Nystatin, file = "./Dataset_liv_kid/eset_Nystatin.txt", sep = "\t",row.names = TRUE, col.names = TRUE)

#read.delim(file = "./Dataset_liv_kid/eset_Nystatin.txt",header = TRUE, sep = "\t",dec = ".")











# paste("A", 3, sep = "") >>>> A3


# Differential Expression analysis
# https://wiki.bits.vib.be/index.php/Analyze_your_own_microarray_data_in_R/Bioconductor#Identification_of_DE_genes
# https://f1000research.com/articles/5-1384/v1


df_df <- df_final


Meta_liver$'Catagory' <- cut(Meta_liver$`FactorValue [DOSE]`,c(-Inf,0,Inf),c("Control","Treatment") )  
eset_liv@phenoData@data
df_pd_liv <- eset_liv@phenoData@data
Meta_liver_sort <- Meta_liver[order(Meta_liver$`Source Name`),]
df_pd_liv$'Catagory' <- Meta_liver_sort$Catagory              
df_pd_liv <- df_pd_liv[-ht_tmp,]
groups = df_pd_liv$Catagory
f = factor(groups,levels=c("Control","Treatment"))
design = model.matrix(~ 0 + f)
colnames(design) = c("Control","Treatment")
data.fit = lmFit(df_df,design)
data.fit$coefficients[1:10,]
contrast.matrix = makeContrasts(Treatment-Control,levels=design)
data.fit.con = contrasts.fit(data.fit,contrast.matrix)
data.fit.eb = eBayes(data.fit.con)
names(data.fit.eb)
data.fit.eb$coefficients[1:10,]
data.fit.eb$t[1:10,]
data.fit.eb$p.value[1:10,]






