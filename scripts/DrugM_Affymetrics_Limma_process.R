

df_liver <- df_final
rownames(df_liver) <- rownames(df_final)

df_kidney <- df_final
rownames(df_kidney) <- rownames(df_final)

df_hepatocyte <- df_final
rownames(df_hepatocyte) <- rownames(df_final)


#Meta_liver <- read_excel("~/R/Meta_select_liver (1).xlsx")
Meta_liver <- read_excel("~/R/Dataset_liv_kid/Meta_select_liver (1).xlsx")
Meta_kidney <- read_excel("~/R/Dataset_liv_kid/Meta_select_kidney (1).xlsx")


Meta_liver_2 <- Meta_liver[order(Meta_liver$`Source Name`),]
Meta_liver_2 <- Meta_liver_2[-ht_tmp,]
Meta_liver_2['Source Name CEL'] <- colnames(df_df)
Meta_liver_2 <- Meta_liver_2 %>% group_by(`FactorValue [COMPOUND]`) %>% filter(n() > 2)
Meta_liver_2 <- Meta_liver_2[order(Meta_liver_2$`Source Name`),]
list_liv_comp <- unique(Meta_liver_2$`FactorValue [COMPOUND]`)


Meta_kidney_2 <- Meta_kidney[order(Meta_kidney$`Source Name`),]
Meta_kidney_2 <- Meta_kidney_2[-ht_tmp,]
Meta_kidney_2['Source Name CEL'] <- colnames(df_df)
Meta_kidney_2 <- Meta_kidney_2 %>% group_by(`FactorValue [COMPOUND]`) %>% filter(n() > 2)
Meta_kidney_2 <- Meta_kidney_2[order(Meta_kidney_2$`Source Name`),]
list_kid_comp <- unique(Meta_kidney_2$`FactorValue [COMPOUND]`)

Meta_hepa_2 <- Meta_hepa[order(Meta_hepa$`Source Name`),]
Meta_hepa_2 <- Meta_hepa_2[-ht_tmp,]
Meta_hepa_2['Source Name CEL'] <- colnames(df_df)
Meta_hepa_2 <- Meta_hepa_2 %>% group_by(`FactorValue [COMPOUND]`) %>% filter(n() > 2)
Meta_hepa_2 <- Meta_hepa_2[order(Meta_hepa_2$`Source Name`),]
list_hepa_comp <- unique(Meta_hepa_2$`FactorValue [COMPOUND]`)

list_common <- intersect(intersect(list_liv_comp,list_kid_comp),list_hepa_comp)
list_common <- list_common_tmp
#list_common_tmp <-  list_common
list_common <- list_common_tmp


Meta_liver_2 <- as.data.frame(read_excel("./Dataset_liv_kid_hepa/Meta_liver_2.xlsx"))
Meta_liver_2 <- Meta_liver_2[2:9]
Meta_kidney_2 <- as.data.frame(read_excel("./Dataset_liv_kid_hepa/Meta_kidney_2.xlsx"))
Meta_kidney_2 <- Meta_kidney_2[2:9]
Meta_hepa_2 <- as.data.frame(read_excel("./Dataset_liv_kid_hepa/Meta_hepa_2.xlsx"))
Meta_hepa_2 <- Meta_hepa_2[2:9]
list_common <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)
#list_common <- list_common[2]

#################################################################################


#list_common <- intersect(list_liv_comp,list_kid_comp)
#list_common <- intersect(list_kid_comp,list_hepa_comp)
#list_common <- intersect(list_liv_comp,list_hepa_comp)
list_common <- intersect(intersect(list_liv_comp,list_kid_comp),list_hepa_comp)


for (c in 2:length(list_common)) {
  # Liver DE table
  cT_l <- Meta_liver_2[Meta_liver_2$`FactorValue [COMPOUND]`== list_common[c],][c(7,8)]
  cC_l <- Meta_liver_2[Meta_liver_2$`FactorValue [COMPOUND]`== 'not specified',][c(7,8)]
  gn_l <- rbind(cT_l,cC_l)
  gn_l <- as.data.frame(gn_l)
  rownames(gn_l) <- gn_l$`Source Name CEL`
  dn_l <- cbind(df_liver[cT_l$`Source Name CEL`],df_liver[cC_l$`Source Name CEL`])
  groups_l = gn_l$Catagory
  f_l = factor(groups_l,levels=c("Treatment","Control"))
  design_l = model.matrix(~ 0 + f_l)
  #design_l = model.matrix(~f_l)
  colnames(design_l) = c("Treatment","Control")
  data.fit_l = lmFit(dn_l,design_l)
  #data.fit.eb_l = eBayes(data.fit_l)
  contrast.matrix_l = makeContrasts(Treatment-Control,levels=design_l)
  data.fit.con_l = contrasts.fit(data.fit_l,contrast.matrix_l)
  data.fit.eb_l = eBayes(data.fit.con_l)
  table_CD_l <-  topTable(data.fit.eb_l, number = Inf)
  
  # https://www.bioconductor.org/help/course-materials/2005/BioC2005/labs/lab01/estrogen/
  
  # Kidney DE table
  cT_l <- Meta_kidney_2[Meta_kidney_2$`FactorValue [COMPOUND]`== list_common[c],][c(7,8)]
  cC_l <- Meta_kidney_2[Meta_kidney_2$`FactorValue [COMPOUND]`== 'not specified',][c(7,8)]
  gn_l <- rbind(cT_l,cC_l)
  gn_l <- as.data.frame(gn_l)
  rownames(gn_l) <- gn_l$`Source Name CEL`
  dn_l <- cbind(df_kidney[cT_l$`Source Name CEL`],df_kidney[cC_l$`Source Name CEL`])
  groups_l = gn_l$Catagory
  f_l = factor(groups_l,levels=c("Control","Treatment"))
  design_l = model.matrix(~ 0 + f_l)
  #design_l = model.matrix(~f_l)
  colnames(design_l) = c("Control","Treatment")
  data.fit_l = lmFit(dn_l,design_l)
  contrast.matrix_l = makeContrasts(Treatment-Control,levels=design_l)
  data.fit.con_l = contrasts.fit(data.fit_l,contrast.matrix_l)
  data.fit.eb_l = eBayes(data.fit.con_l)
  table_CD_k <-  topTable(data.fit.eb_l, number = Inf)
  
  # Hepatocyte DE table
  cT_l <- Meta_hepa_2[Meta_hepa_2$`FactorValue [COMPOUND]`== list_common[c],][c(7,8)]
  cC_l <- Meta_hepa_2[Meta_hepa_2$`FactorValue [COMPOUND]`== 'not specified',][c(7,8)]
  gn_l <- rbind(cT_l,cC_l)
  gn_l <- as.data.frame(gn_l)
  rownames(gn_l) <- gn_l$`Source Name CEL`
  dn_l <- cbind(df_hepatocyte[cT_l$`Source Name CEL`],df_hepatocyte[cC_l$`Source Name CEL`])
  groups_l = gn_l$Catagory
  f_l = factor(groups_l,levels=c("Control","Treatment"))
  design_l = model.matrix(~ 0 + f_l)
  colnames(design_l) = c("Control","Treatment")
  data.fit_l = lmFit(dn_l,design_l)
  contrast.matrix_l = makeContrasts(Treatment-Control,levels=design_l)
  data.fit.con_l = contrasts.fit(data.fit_l,contrast.matrix_l)
  data.fit.eb_l = eBayes(data.fit.con_l)
  table_CD_h <-  topTable(data.fit.eb_l, number = Inf)
  
  
  tCDname <- paste("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")             # Rename!!
  tCDname <- paste(tCDname,'.xlsx', sep = "")
  table_CD_all <- cbind(table_CD_l[c(1,4,5)],table_CD_k[c(1,4,5)][match(rownames(table_CD_l), rownames(table_CD_k)),]) # Rename!!
  table_CD_all <- cbind(table_CD_all,table_CD_h[c(1,4,5)][match(rownames(table_CD_all), rownames(table_CD_h)),])
  write.xlsx(table_CD_all, file = tCDname)
  
  
  #tCDname <- paste("./Dataset_liv_kid/DE_Table/",list_common[c], sep = "")
  #tCDname <- paste(tCDname,'.xlsx', sep = "")
  #table_CD_all <- cbind(table_CD_l[c(1,4)],table_CD_k[c(1,4)][match(rownames(table_CD_l), rownames(table_CD_k)),])
  #table_CD_all <- cbind(table_CD_all,table_CD_h[c(1,4)][match(rownames(table_CD_all), rownames(table_CD_h)),])
  #write.xlsx(table_CD_all, file = tCDname)
  
}




###################################   intersect table (Three Tissues )  ##############################################

# Concatnate a table 

# Initialize the DE intersect table

DE_summary_table <- data.frame('Compound'= c('Compound') ,
                               'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),
                               'Gene Symbol'= c('Gene Symbol'), 
                               'Direction'= c('Direction') )


list_common <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)
#length(list_common)
for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:10]
  
  #table(GSE_input_Table$adj.P.Val < 0.1 & GSE_input_Table$adj.P.Val__1 < 0.1 & GSE_input_Table$adj.P.Val__2 < 0.1)
  #table(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 >0 & GSE_input_Table$logFC__2 >0)
  #table(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 <0 & GSE_input_Table$logFC__2 <0)
  
  #GSE_input_Table[7:12] <- GSE_input_Table[1:6]
  #colnames(GSE_input_Table)[7:12] <- c('F1','P1','F2','P2','F3','P3')
  
  #which(GSE_input_Table$P1 > 0.1 | GSE_input_Table$P2 > 0.1 | GSE_input_Table$P3 > 0.1)
  #which(GSE_input_Table$P1 < 0.1 | GSE_input_Table$P2 < 0.1 | GSE_input_Table$P3 < 0.1)
  
  SG_UP <- intersect(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$adj.P.Val__2 < 0.05), which(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 > 0 & GSE_input_Table$logFC__2 >0) )
  SG_DOWN <- intersect(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$adj.P.Val__2 < 0.05),which(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 < 0 & GSE_input_Table$logFC__2 <0) )
  
  c_UP <- rownames(GSE_input_Table[SG_UP,])
  c_DOWN <- rownames(GSE_input_Table[SG_DOWN,])
  
  if (length(c_UP)>0){DE_summary_table_up <- data.frame('Compound'= c(rep(list_common[c],length(c_UP))) ,'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),'Gene Symbol'= c(rownames(GSE_input_Table[c_UP,])), 'Direction'= c(rep('UP',length(c_UP))))
  }
  if (length(c_DOWN)>0){DE_summary_table_dn <- data.frame('Compound'= c(rep(list_common[c],length(c_DOWN))) ,'Characteristics [organism part]'= c('liver|kidney|hepatocyte'),'Gene Symbol'= c(rownames(GSE_input_Table[c_DOWN,])), 'Direction'= c(rep('DOWN',length(c_DOWN))))
  }
  
  if (length(c_UP)>0){DE_summary_table <- rbind(DE_summary_table,DE_summary_table_up)}
  if (length(c_DOWN)>0){DE_summary_table <- rbind(DE_summary_table,DE_summary_table_dn)}
  
}

write.xlsx(DE_summary_table, file = './Dataset_liv_kid_hepa/DE_intersect_table_Padj_0.05.xlsx')

##############################################################################################



###################################     intersect table (Two Tissues )   ##############################################

# Concatnate a table 

# Initialize the DE intersect table


list_common <- list.files("./Dataset_liv_kid/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)

DE_summary_table <- data.frame('Compound'= c('Compound') ,
                               'Characteristics [organism part]'= c('liver|kidney'),
                               'Gene Symbol'= c('Gene Symbol'), 
                               'Direction'= c('Direction') )

for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_liv_kid/DE_Table_adjPvalue/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:7]
  
  #table(GSE_input_Table$adj.P.Val < 0.1 & GSE_input_Table$adj.P.Val__1 < 0.1 & GSE_input_Table$adj.P.Val__2 < 0.1)
  #table(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 >0 & GSE_input_Table$logFC__2 >0)
  #table(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 <0 & GSE_input_Table$logFC__2 <0)
  
  #GSE_input_Table[7:12] <- GSE_input_Table[1:6]
  #colnames(GSE_input_Table)[7:12] <- c('F1','P1','F2','P2','F3','P3')
  
  #which(GSE_input_Table$P1 > 0.1 | GSE_input_Table$P2 > 0.1 | GSE_input_Table$P3 > 0.1)
  #which(GSE_input_Table$P1 < 0.1 | GSE_input_Table$P2 < 0.1 | GSE_input_Table$P3 < 0.1)
  
  SG_UP <- intersect(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 ), which(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 > 0 ) )
  SG_DOWN <- intersect(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 ),which(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 < 0 ) )
  
  c_UP <- rownames(GSE_input_Table[SG_UP,])
  c_DOWN <- rownames(GSE_input_Table[SG_DOWN,])
  
  if (length(c_UP)>0){DE_summary_table_up <- data.frame('Compound'= c(rep(list_common[c],length(c_UP))) ,'Characteristics [organism part]'= c('liver|kidney'),'Gene Symbol'= c(rownames(GSE_input_Table[c_UP,])), 'Direction'= c(rep('UP',length(c_UP))))
  }
  if (length(c_DOWN)>0){DE_summary_table_dn <- data.frame('Compound'= c(rep(list_common[c],length(c_DOWN))) ,'Characteristics [organism part]'= c('liver|kidney'),'Gene Symbol'= c(rownames(GSE_input_Table[c_DOWN,])), 'Direction'= c(rep('DOWN',length(c_DOWN))))
  }
  
  if (length(c_UP)>0){DE_summary_table <- rbind(DE_summary_table,DE_summary_table_up)}
  if (length(c_DOWN)>0){DE_summary_table <- rbind(DE_summary_table,DE_summary_table_dn)}
  
}

#write.xlsx(DE_summary_table, file = './Dataset_liv_kid/DE_intersect_table_Padj_0.05.xlsx')       # Rename !!!1







# Concatnate a table 
# Initialize the DE intersect table
list_common <- list.files("./Dataset_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)

DE_summary_table <- data.frame('Compound'= c('Compound') ,
                               'Characteristics [organism part]'= c('kidney|hepatocyte'),
                               'Gene Symbol'= c('Gene Symbol'), 
                               'Direction'= c('Direction')
                               )

for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:7]
  
  #table(GSE_input_Table$adj.P.Val < 0.1 & GSE_input_Table$adj.P.Val__1 < 0.1 & GSE_input_Table$adj.P.Val__2 < 0.1)
  #table(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 >0 & GSE_input_Table$logFC__2 >0)
  #table(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 <0 & GSE_input_Table$logFC__2 <0)
  
  #GSE_input_Table[7:12] <- GSE_input_Table[1:6]
  #colnames(GSE_input_Table)[7:12] <- c('F1','P1','F2','P2','F3','P3')
  
  #which(GSE_input_Table$P1 > 0.1 | GSE_input_Table$P2 > 0.1 | GSE_input_Table$P3 > 0.1)
  #which(GSE_input_Table$P1 < 0.1 | GSE_input_Table$P2 < 0.1 | GSE_input_Table$P3 < 0.1)
  
  SG_UP <- intersect(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 ), which(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 > 0 ) )
  SG_DOWN <- intersect(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 ),which(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 < 0 ) )
  
  c_UP <- rownames(GSE_input_Table[SG_UP,])
  c_DOWN <- rownames(GSE_input_Table[SG_DOWN,])
  
  if (length(c_UP)>0){DE_summary_table_up <- data.frame('Compound'= c(rep(list_common[c],length(c_UP))) ,'Characteristics [organism part]'= c('kidney|hepatocyte'),'Gene Symbol'= c(rownames(GSE_input_Table[c_UP,])), 'Direction'= c(rep('UP',length(c_UP))))
  }
  if (length(c_DOWN)>0){DE_summary_table_dn <- data.frame('Compound'= c(rep(list_common[c],length(c_DOWN))) ,'Characteristics [organism part]'= c('kidney|hepatocyte'),'Gene Symbol'= c(rownames(GSE_input_Table[c_DOWN,])), 'Direction'= c(rep('DOWN',length(c_DOWN))))
  }
  
  if (length(c_UP)>0){DE_summary_table <- rbind(DE_summary_table,DE_summary_table_up)}
  if (length(c_DOWN)>0){DE_summary_table <- rbind(DE_summary_table,DE_summary_table_dn)}
  
}

#write.xlsx(DE_summary_table, file = './Dataset_kid_hepa/DE_intersect_table_Padj_0.05.xlsx')       # Rename !!!1



###################################################################################################




#############################  Summary Table (3 Tissues)  ################################################


list_common <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)

DE_summary_table <- data.frame('FactorValue [COMPOUND]'= c('FactorValue [COMPOUND]') ,
                               'Characteristics [organism part]'= c('Characteristics [organism part]'),
                               'Num. of genes (P.adj<0.05)'= c('Num. of genes (P.adj<0.05)'), 
                               'Num. of genes (P<0.05)'= c('Num. of genes (P<0.05)'),
                               'List of genes (P.adj<0.05)'= c('List of genes (P.adj<0.05)'),
                               'List of genes (P<0.05)'= c('List of genes (P<0.05)'),
                               'Num. of UP genes (P.adj<0.05)'= c('Num. of UP genes (P.adj<0.05)'),
                               'Num. of DOWN genes (P.adj<0.05)'= c('Num. of DOWN genes (P.adj<0.05)'),
                               'List of UP genes (P.adj<0.05)'= c('List of UP genes (P.adj<0.05)'),
                               'List of DOWN genes (P.adj<0.05)'= c('List of DOWN genes (P.adj<0.05)')
                               )



for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:10]
  
  # Liver
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('liver'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)

  # Kidney
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value__1 < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value__1 < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('kidney'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Hepatocyte
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val__2 < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value__2 < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__2 < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value__2 < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val__2 < 0.05 & GSE_input_Table$logFC__2 >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val__2 < 0.05 & GSE_input_Table$logFC__2 <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__2 < 0.05 & GSE_input_Table$logFC__2 >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__2 < 0.05 & GSE_input_Table$logFC__2 <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('hepatocyte'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
}




###################################################################################################




#############################  Summary Table (2 Tissues)  ################################################

list_liv_kid_hepa <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_liv_kid_hepa <- gsub('.{5}$', '', list_liv_kid_hepa)
list_liv_kid <- list.files("./Dataset_liv_kid/DE_Table_adjPvalue/")          # Rename !!!1
list_liv_kid <- gsub('.{5}$', '', list_liv_kid)
list_kid_hepa <- list.files("./Dataset_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_kid_hepa <- gsub('.{5}$', '', list_kid_hepa)


list_common <- list_liv_kid[! list_liv_kid %in% list_liv_kid_hepa]

for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_liv_kid/DE_Table_adjPvalue/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:7]
  
  # Liver
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('liver'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Kidney
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value__1 < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value__1 < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('kidney'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)

}



list_common <- list_kid_hepa[! list_kid_hepa %in% list_liv_kid_hepa]
list_common <- list_common[! list_common %in% list_liv_kid]

for (c in 1:length(list_common)) {
  
  c_CDname <- paste("./Dataset_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")          # Rename !!!1
  c_CDname <- paste(c_CDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(c_CDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:7]
  
  # Kidney
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$logFC <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('kidney'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
  # Hepatocyte
  NoG_Padj <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05)))
  NoG_P <- as.character(length(which(GSE_input_Table$P.Value__1 < 0.05)))
  LoG_Padj <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05)], collapse=";") 
  LoG_P <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$P.Value__1 < 0.05)], collapse=";") 
  NoG_UP <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 >0 )))
  NoG_DOWN <- as.character(length(which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 <0 )))
  LoG_UP <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 >0 )], collapse=";") 
  LoG_DOWN <- paste(rownames(GSE_input_Table)[which(GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$logFC__1 <0 )], collapse=";")
  
  DE_summary_table_tmp <- data.frame('FactorValue [COMPOUND]'= c(list_common[c]) ,
                                     'Characteristics [organism part]'= c('hepatocyte'),
                                     'Num. of genes (P.adj<0.05)'= NoG_Padj, 
                                     'Num. of genes (P<0.05)'= NoG_P,
                                     'List of genes (P.adj<0.05)'= LoG_Padj,
                                     'List of genes (P<0.05)'= LoG_P,
                                     'Num. of UP genes (P.adj<0.05)'= NoG_UP,
                                     'Num. of DOWN genes (P.adj<0.05)'= NoG_DOWN,
                                     'List of UP genes (P.adj<0.05)'= LoG_UP,
                                     'List of DOWN genes (P.adj<0.05)'= LoG_DOWN
                                     )
  DE_summary_table <- rbind(DE_summary_table,DE_summary_table_tmp)
  
}


write.xlsx(DE_summary_table, file = './Dataset_liv_kid_hepa/DE_Summary_Table.xlsx')       # Rename !!!1

################################################################################################################################




########################################## HM_summary_table 3 tissues ###########################################################


HM_summary_table <- data.frame('Gene'= rownames(GSE_input_Table))
rownames(HM_summary_table) <- HM_summary_table$Gene
write.xlsx(HM_summary_table, file = './Dataset_liv_kid_hepa/HM_summary_Rowname.xlsx')
HM_summary_table <- as.data.frame(read_excel('./Dataset_liv_kid_hepa/HM_summary_Rowname.xlsx'))
rownames(HM_summary_table) <- HM_summary_table$X__1
HM_summary_table <- HM_summary_table[2]


list_common <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)

for (c in 1:length(list_common)) {
  
  tCDname <- paste("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")    # Rename !
  tCDname <- paste(tCDname,'.xlsx', sep = "")
  
  GSE_input_Table <- as.data.frame(read_excel(tCDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:10]             
  
  GSE_input_Table$Fc <- c(rep(0,14956))
  GSE_input_Table$P <- c(rep(0,14956))
  GSE_input_Table$Padj <- c(rep(0,14956))
  GSE_input_Table$HM <- c(rep(0,14956))
  
  whichlg_up <- which(GSE_input_Table$logFC >0 & GSE_input_Table$logFC__1 >0 & GSE_input_Table$logFC__2 >0)
  whichlg_dn <- which(GSE_input_Table$logFC <0 & GSE_input_Table$logFC__1 <0 & GSE_input_Table$logFC__2 <0)
  whichP <- which(GSE_input_Table$P.Value < 0.05 & GSE_input_Table$P.Value__1 < 0.05 & GSE_input_Table$P.Value__2 < 0.05) 
  whichPadj <- which(GSE_input_Table$adj.P.Val < 0.05 & GSE_input_Table$adj.P.Val__1 < 0.05 & GSE_input_Table$adj.P.Val__2 < 0.05) 
  GSE_input_Table$Fc[whichlg_up] <- 1
  GSE_input_Table$Fc[whichlg_dn] <- -1
  GSE_input_Table$P[whichP] <- 1
  GSE_input_Table$Padj[whichPadj] <- 1
  
  which1_up <- which(GSE_input_Table$Fc == 1 & GSE_input_Table$P == 1 & GSE_input_Table$Padj ==1)
  which1_dn <- which(GSE_input_Table$Fc == -1 & GSE_input_Table$P == 1 & GSE_input_Table$Padj ==1)
  which2_up <- which(GSE_input_Table$Fc == 1 & GSE_input_Table$P == 1 & GSE_input_Table$Padj ==0)
  which2_dn <- which(GSE_input_Table$Fc == -1 & GSE_input_Table$P == 1 & GSE_input_Table$Padj ==0)
  
  GSE_input_Table$HM[which1_up] <- (1)
  GSE_input_Table$HM[which1_dn] <- (-1)
  GSE_input_Table$HM[which2_up] <- (0.5)
  GSE_input_Table$HM[which2_dn] <- (-0.5)
  
  HM_summary_table <- cbind(HM_summary_table,GSE_input_Table[c(13)][match(rownames(GSE_input_Table),rownames(HM_summary_table)),])
  colnames(HM_summary_table)[(c+1)] <- list_common[c]
  
}


write.xlsx(HM_summary_table, file = "./Dataset_liv_kid_hepa/HM_summary_table.xlsx")

################################################################################################################################























###################################################################################################















library("limma")
library("statmod")

source("http://www.bioconductor.org/biocLite.R")
biocLite()
biocLite("limma")

if (!requireNamespace("BiocManager"))
  install.packages("BiocManager")
BiocManager::install()


Meta_liver$'Catagory' <- cut(Meta_liver$`FactorValue [DOSE]`,c(-Inf,0,Inf),c("Control","Treatment") )  
#eset_liv@phenoData@data
df_pd_liv <- eset_liv@phenoData@data
Meta_liver_sort <- Meta_liver[order(Meta_liver$`Source Name`),]
df_pd_liv$'Catagory' <- Meta_liver_sort$Catagory              
df_pd_liv <- df_pd_liv[-ht_tmp,]

groups = df_pd_liv$Catagory
f = factor(groups,levels=c("Control","Treatment"))
design = model.matrix(~ 0 + f)
colnames(design) = c("Control","Treatment")
data.fit = lmFit(df_df,design)
#data.fit$coefficients[1:10,]
contrast.matrix = makeContrasts(Treatment-Control,levels=design)
data.fit.con = contrasts.fit(data.fit,contrast.matrix)
data.fit.eb = eBayes(data.fit.con)
#names(data.fit.eb)
#data.fit.eb$coefficients[1:10,]
#data.fit.eb$t[1:10,]
#data.fit.eb$p.value[1:10,]

table_CD <-  topTable(data.fit.eb, number = Inf)

