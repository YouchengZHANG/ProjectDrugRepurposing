

# Gene set enrichment analysis
# Package: piano
# https://github.com/sysmedicine/phd2018/blob/master/Workshop/TranscriptomicsWorkshop/Part2/Rcode.R

GSE_input_Table <- as.data.frame(read_excel("./Dataset_liv_kid_hepa/GSE_Table/atorvastatin.xlsx"))


if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("piano")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("snowfall")


library(piano)
library(snowfall)

##################### Save objects/ variable ######


# Save an object to a file
saveRDS(gsaRes, file = "./gsaRes_liver_fenofibrate.rds")
# Restore the object
readRDS(file = "./gsaRes_liver_fenofibrate.rds")



######################## Three tissues GSE table ################################

list_common <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)
#gset=loadGSC('./Rattus_norvegicus_GSEA_GO_symbols_highquality.gmt')
gset=loadGSC('./Rattus_norvegicus_GSEA_GO_sets_bp_symbols.gmt')




for (c in 1:length(list_common)) {

  tCDname <- paste("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")    # Rename !
  tCDname <- paste(tCDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(tCDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:10]                                    # col number

  rownames(GSE_input_Table) <- toupper(rownames(GSE_input_Table))
  
  
  # Liver  
  pval= as.matrix(GSE_input_Table[ ,2]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,1])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
  #gset=loadGSC('./Rattus_norvegicus_GSEA_GO_sets_bp_symbols.gmt') 
  #gset=loadGSC('./Rattus_norvegicus_GSEA_GO_symbols_highquality.gmt') 
    #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 4)
  gsa_l <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_l) <- gsa_l[,1]
  
  
  # Kidney
  pval= as.matrix(GSE_input_Table[ ,5]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,4])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
    #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 4)
  gsa_k <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_k) <- gsa_k[,1]
  
  
  # Hepatocyte
  pval= as.matrix(GSE_input_Table[ ,8]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,7])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
    #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 4)
  gsa_h <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_h) <- gsa_h[,1]
  


  table_GSE_all <- cbind(gsa_l[c(2,4,5,7,8,10,11,12,14,15,16,18,19)],gsa_k[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(gsa_l), rownames(gsa_k)),])  #Rename!
  table_GSE_all <- cbind(table_GSE_all,gsa_h[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(table_GSE_all), rownames(gsa_h)),])
  
  #table_GSE_all <- cbind(gsa_k[c(2,4,5,7,8,10,11,12,14,15,16,18,19)],gsa_h[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(gsa_k), rownames(gsa_h)),])  #Rename!
  
  
  tGSEname <- paste("./Dataset_liv_kid_hepa/GSE_Table/",list_common[c], sep = "")             # Rename !
  tGSEname <- paste(tGSEname,'.xlsx', sep = "")
  
  write.xlsx(table_GSE_all, file = tGSEname)
}



##############################################################################################

######################## Two tissues GSE table (Liver and Kidney) ################################


list_common <- list.files("./Dataset_liv_kid/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)


for (c in 1:length(list_common)) {
  
  tCDname <- paste("./Dataset_liv_kid/DE_Table_adjPvalue/",list_common[c], sep = "")    # Rename !
  tCDname <- paste(tCDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(tCDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:7]
  
  rownames(GSE_input_Table) <- toupper(rownames(GSE_input_Table))
  
  
  # Liver  
  pval= as.matrix(GSE_input_Table[ ,2]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,1])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
  #gset=loadGSC('./Rattus_norvegicus_GSEA_GO_sets_bp_symbols.gmt') 
  #gset=loadGSC('./Rattus_norvegicus_GSEA_GO_symbols_highquality.gmt') 
  #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 2)
  gsa_l <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_l) <- gsa_l[,1]
  
  
  # Kidney
  pval= as.matrix(GSE_input_Table[ ,5]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,4])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
  #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 2)
  gsa_k <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_k) <- gsa_k[,1]
  

  
  table_GSE_all <- cbind(gsa_l[c(2,4,5,7,8,10,11,12,14,15,16,18,19)],gsa_k[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(gsa_l), rownames(gsa_k)),])  #Rename!
  #table_GSE_all <- cbind(table_GSE_all,gsa_h[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(table_GSE_all), rownames(gsa_h)),])
  #table_GSE_all <- cbind(gsa_k[c(2,4,5,7,8,10,11,12,14,15,16,18,19)],gsa_h[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(gsa_k), rownames(gsa_h)),])  #Rename!
  
  
  tGSEname <- paste("./Dataset_liv_kid/GSE_Table/",list_common[c], sep = "")             # Rename !
  tGSEname <- paste(tGSEname,'.xlsx', sep = "")
  
  write.xlsx(table_GSE_all, file = tGSEname)
}


###############################################################################################################

######################## Two tissues GSE table (Kidney and hepatocyte) ################################




list_common <- list.files("./Dataset_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)



for (c in 1:length(list_common)) {
  
  tCDname <- paste("./Dataset_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")    # Rename !
  tCDname <- paste(tCDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(tCDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:7]
  
  rownames(GSE_input_Table) <- toupper(rownames(GSE_input_Table))
  

  # Kidney
  pval= as.matrix(GSE_input_Table[ ,2]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,1])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
  #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 2)
  gsa_k <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_k) <- gsa_k[,1]
  
  
  # Hepatocyte
  pval= as.matrix(GSE_input_Table[ ,5]) #extract P as a matrix                        # Column !
  fc= as.matrix(GSE_input_Table[ ,4])  #extract fold changes as a matrix              # Column !
  row.names(pval)=row.names(GSE_input_Table)
  row.names(fc)=row.names(GSE_input_Table)
  #gsaRes <- runGSA(pval,fc,gsc=gset, nPerm = 1000, adjMethod = "fdr", gsSizeLim = c(1,Inf))
  gsaRes <- runGSA(geneLevelStats = pval, directions = fc, gsc = gset,nPerm = 4000, adjMethod = "fdr", ncpus = 2)
  gsa_h <- GSAsummaryTable(gsaRes, save=FALSE)
  rownames(gsa_h) <- gsa_h[,1]
  
  
  
  #table_GSE_all <- cbind(gsa_l[c(2,4,5,7,8,10,11,12,14,15,16,18,19)],gsa_k[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(gsa_l), rownames(gsa_k)),])  #Rename!
  #table_GSE_all <- cbind(table_GSE_all,gsa_h[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(table_GSE_all), rownames(gsa_h)),])
  
  table_GSE_all <- cbind(gsa_k[c(2,4,5,7,8,10,11,12,14,15,16,18,19)],gsa_h[c(2,4,5,7,8,10,11,12,14,15,16,18,19)][match(rownames(gsa_k), rownames(gsa_h)),])  #Rename!
  
  
  tGSEname <- paste("./Dataset_kid_hepa/GSE_Table/",list_common[c], sep = "")             # Rename !
  tGSEname <- paste(tGSEname,'.xlsx', sep = "")
  
  write.xlsx(table_GSE_all, file = tGSEname)
}










































############################# intersect Table ######################################


list_common <- list.files("./Dataset_liv_kid_hepa/GSE_Table/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)

#GSE_input_Table <-  as.data.frame(read_excel("./Dataset_liv_kid_hepa/GSE_Table/azathioprine.xlsx"))

GSE_intersect_table <- data.frame('Compound'= c('Compound') ,
                                 'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),
                                 'GO term'= c('GO term'), 
                                 'Direction'= c('Direction'))

for (c in 1:length(list_common)) {
  
  c_GSEname <- paste("./Dataset_liv_kid_hepa/GSE_Table/",list_common[c], sep = "")
  c_GSEname <- paste(c_GSEname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_GSEname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:40]
  
  GO_UP <- which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05 & GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05 & GSE_input_Table$`p adj (dist.dir.up)__2` < 0.05)
  g_UP <- rownames(GSE_input_Table[GO_UP,])
  GO_DOWN <- which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05 & GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05 & GSE_input_Table$`p adj (dist.dir.dn)__2` < 0.05)
  g_DOWN <- rownames(GSE_input_Table[GO_DOWN,])
  GO_NON <- which(GSE_input_Table$`p adj (non-dir.)` < 0.05 & GSE_input_Table$`p adj (non-dir.)__1` < 0.05 & GSE_input_Table$`p adj (non-dir.)__2` < 0.05)
  g_NON <- rownames(GSE_input_Table[GO_NON,])
  
  if (length(g_UP) > 0) {
    GSE_summary_table_up <- data.frame('Compound'= c(rep(list_common[c],length(GO_UP))) ,'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),'GO term'= c(rownames(GSE_input_Table[GO_UP,])), 'Direction'= c(rep('UP',length(GO_UP))))
  }
  if (length(g_DOWN) > 0) {
    GSE_summary_table_dn <- data.frame('Compound'= c(rep(list_common[c],length(GO_DOWN))) ,'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),'GO term'= c(rownames(GSE_input_Table[GO_DOWN,])), 'Direction'= c(rep('DOWN',length(GO_DOWN))))
  }
  if (length(g_NON) > 0) {
    GSE_summary_table_non <- data.frame('Compound'= c(rep(list_common[c],length(GO_NON))) ,'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),'GO term'= c(rownames(GSE_input_Table[GO_NON,])), 'Direction'= c(rep('DOWN',length(GO_NON))))
  }
   
  if (length(g_UP) > 0) {GSE_intersect_table <- rbind(GSE_intersect_table,GSE_summary_table_up)
  }
  if (length(g_DOWN) > 0) {GSE_intersect_table <- rbind(GSE_intersect_table,GSE_summary_table_dn)
  }
  if (length(g_NON) > 0) {GSE_intersect_table <- rbind(GSE_intersect_table,GSE_summary_table_non)
  }
  
  
}


write.xlsx(GSE_intersect_table, file = './Dataset_liv_kid_hepa/GSE_intersect_table_0.05_correct.xlsx')








#############################  Summary Table (3 Tissues)  ################################################


list_common <- list.files("./Dataset_liv_kid_hepa/GSE_Table/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)

DE_summary_table <- data.frame('FactorValue [COMPOUND]'= c('FactorValue [COMPOUND]') ,
                               'Characteristics [organism part]'= c('Characteristics [organism part]'),
                               'Num. of GO up (P.adj<0.05)'= c('Num. of GO up (P.adj<0.05)'), 
                               'Num. of GO down (P.adj<0.05)'= c('Num. of GO down (P.adj<0.05)'),
                               'Num. of GO non-dir (P.adj<0.05)'= c('Num. of GO non-dir (P.adj<0.05)'),
                               'List of GO up (P.adj<0.05)'= c('List of GO up (P.adj<0.05)'),
                               'List of GO down (P.adj<0.05)'= c('List of GO down (P.adj<0.05)'),
                               'List of GO non-dir (P.adj<0.05)'= c('List of GO non-dir (P.adj<0.05)'))


for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_liv_kid_hepa/GSE_Table/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:40]
  
  # Liver
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)` < 0.05)], collapse=";") 
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('liver'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Kidney
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)__1` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)__1` < 0.05)], collapse=";")
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('kidney'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Hepatocyte
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)__2` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)__2` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)__2` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)__2` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)__2` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)__2` < 0.05)], collapse=";")
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('hepatocyte'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
}




###################################################################################################




#############################  Summary Table (2 Tissues)  ################################################

list_liv_kid_hepa <- list.files("./Dataset_liv_kid_hepa/GSE_Table/")          # Rename !!!1
list_liv_kid_hepa <- gsub('.{5}$', '', list_liv_kid_hepa)
list_liv_kid <- list.files("./Dataset_liv_kid/GSE_Table/")          # Rename !!!1
list_liv_kid <- gsub('.{5}$', '', list_liv_kid)
list_kid_hepa <- list.files("./Dataset_kid_hepa/GSE_Table/")          # Rename !!!1
list_kid_hepa <- gsub('.{5}$', '', list_kid_hepa)


list_common <- list_liv_kid[! list_liv_kid %in% list_liv_kid_hepa]

for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_liv_kid/GSE_Table/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:27]
  
  # Liver
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)` < 0.05)], collapse=";")
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('liver'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Kidney
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)__1` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)__1` < 0.05)], collapse=";")
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('kidney'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
}



list_common <- list_kid_hepa[! list_kid_hepa %in% list_liv_kid_hepa]
list_common <- list_common[! list_common %in% list_liv_kid]

for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_kid_hepa/GSE_Table/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:27]
  
  # Kidney
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)` < 0.05)], collapse=";")
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('kidney'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Hepatocyte
  NoGU_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05)))
  NoGN_Padj <- as.character(length(which(GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05)))
  NoNon_Padj <- as.character(length(which(GSE_input_Table$`p adj (non-dir.)__1` < 0.05)))
  LoGU_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.up)__1` < 0.05)], collapse=";") 
  LoGD_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (dist.dir.dn)__1` < 0.05)], collapse=";") 
  LoNon_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$`p adj (non-dir.)__1` < 0.05)], collapse=";")
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= list_common[c] ,
                                     'Characteristics [organism part]'= c('hepatocyte'),
                                     'Num. of GO up (P.adj<0.05)'= NoGU_Padj, 
                                     'Num. of GO down (P.adj<0.05)'= NoGN_Padj,
                                     'Num. of GO non-dir (P.adj<0.05)'= NoNon_Padj,
                                     'List of GO up (P.adj<0.05)'= LoGU_Padj,
                                     'List of GO down (P.adj<0.05)'= LoGD_Padj,
                                     'List of GO non-dir (P.adj<0.05)'= LoNon_Padj)
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
}


write.xlsx(DE_summary_table, file = './Dataset_liv_kid_hepa/GSE_Summary_Table_new_correct.xlsx')       # Rename !!!1











#
