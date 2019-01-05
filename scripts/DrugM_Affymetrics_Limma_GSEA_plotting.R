



if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggplot2")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("gridExtra")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RColorBrewer")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("reshape2")

library(ggplot2)
library(gridExtra)
library(RColorBrewer)
library(reshape2)







####################   Differential expression Ploting  #######################################



########  Plot 01  ##################   adju P value boxplot

DE_Summary_Table <- as.data.frame(read_excel("./Dataset_liv_kid_hepa/DE_Summary_Table.xlsx"))
DE_Summary_Table <- DE_Summary_Table[-1,2:11]
DE_Summary_Table$Num..of.genes..P.adj.0.05. <- as.numeric(DE_Summary_Table$Num..of.genes..P.adj.0.05.)
DE_Summary_Table$Num..of.genes..P.0.05. <- as.numeric(DE_Summary_Table$Num..of.genes..P.0.05.)
#DE_Summary_Table_l <- DE_Summary_Table[which(DE_Summary_Table$Characteristics..organism.part.== 'liver'),]
#DE_Summary_Table_k <- DE_Summary_Table[which(DE_Summary_Table$Characteristics..organism.part.== 'kidney'),]
#DE_Summary_Table_h <- DE_Summary_Table[which(DE_Summary_Table$Characteristics..organism.part.== 'hepatocyte'),]
DE_Summary_Table$Category <- as.factor(DE_Summary_Table$Characteristics..organism.part.)

DE_Summary_Table$Category <- factor(DE_Summary_Table$Category, levels = c("liver", "kidney", "hepatocyte",'intersect'))

b <- ggplot(DE_Summary_Table, aes(DE_Summary_Table$Category, DE_Summary_Table$Num..of.genes..P.adj.0.05.)) +
  theme_minimal() +
  theme(plot.title = element_text(color='gray16'),
        axis.title.x = element_blank() ,
        #axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(color='gray45',size=15,family="Times",margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text.x = element_text(color='gray45',size=15,family="Times"),
        legend.position="right",
        legend.title=element_text(color='gray45',size=15,family="Times"),
        legend.text=element_text(color='gray45',size=15,family="Times") ) +
  geom_boxplot(width=0.3,aes(fill=Category,colour = Category)) +
  xlab("Organism part") + 
  ylab("Number of significant gene (FDR)")  +
  scale_colour_manual(values = c("brown4", "orangered3","tomato", "red3")) +
  scale_fill_manual(values = c("brown4", "orangered3","tomato", "red3")) +
  geom_dotplot(binaxis='y', stackdir='centerwhole', dotsize=0.2,binwidth=55,aes(fill=DE_Summary_Table$Category,colour = DE_Summary_Table$Category)) +
  scale_x_discrete()
b  
  

#geom_dotplot(binaxis='y', stackdir='center', dotsize=0.1) +
# scale_fill_brewer(palette="Dark2",direction = -1,type = "seq")   
# scale_colour_brewer(palette="Dark2",direction = -1)
  




########  Plot 02  #################### Volcano plot (gene name and p value) !!!


# ggplot for volcano: http://bioinformatics.knowledgeblog.org/2011/06/21/volcano-plots-of-microarray-data/
# http://www.gettinggeneticsdone.com/2014/05/r-volcano-plots-to-visualize-rnaseq-microarray.html 
# https://ggplot2.tidyverse.org/reference/
# https://www.rdocumentation.org/packages/ggplot2/versions/3.1.0
# color : http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
#   http://sape.inf.usi.ch/quick-reference/ggplot2/colour
  # color pattate : http://moderndata.plot.ly/create-colorful-graphs-in-r-with-rcolorbrewer-and-plotly/ 
# multiple plot: https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html


list_common <- list.files("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/")          # Rename !!!1
list_common <- gsub('.{5}$', '', list_common)
#length(list_common)

for (c in 7:7) {
  
  tCDname <- paste("./Dataset_liv_kid_hepa/DE_Table_adjPvalue/",list_common[c], sep = "")    # Rename !
  tCDname <- paste(tCDname,'.xlsx', sep = "")
  GSE_input_Table <- as.data.frame(read_excel(tCDname))
  rownames(GSE_input_Table) <- GSE_input_Table$X__1
  GSE_input_Table <- GSE_input_Table[2:10]                    
  
  ## Liver
  gene_list <- GSE_input_Table[c(1,3)]
  gene_list$threshold = as.factor(gene_list$adj.P.Val < 0.05)
  ##Construct the plot object
  g1 <- ggplot(data=gene_list, aes(x=gene_list$logFC, y=-log10(gene_list$adj.P.Val)) )+
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5,color='gray16'),
          axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
          axis.title.y = element_text(color='gray45',size=15,family="Times",margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.text.x = element_text(color='gray45',size=15,family="Times"),
          legend.title=element_text(color='gray45',size=15,family="Times"),
          legend.text=element_text(color='gray45',size=15,family="Times"),
          legend.position="none") +
    geom_point(alpha=0.7, size=1.75,shape=16, aes(colour = gene_list$threshold)) +
    scale_color_manual(values = c("grey", "coral")) +
    geom_text(aes(label = ifelse(gene_list$threshold == TRUE, rownames(gene_list),"")),size=3,check_overlap = TRUE,hjust = 0, nudge_x = 0.05) +
    xlim(c(-3, 3)) + ylim(c(0, 7.5)) +
    xlab("log2 fold change") + 
    ylab("-log10 adjusted P-value")  +
    ggtitle(paste(list_common[c],' (liver)',sep = "")) 
  
  ## Kidney
  gene_list2 <- GSE_input_Table[c(4,6)]
  gene_list2$threshold = as.factor(gene_list2$adj.P.Val__1 < 0.05)
  ##Construct the plot object
  g2 <- ggplot(data=gene_list2, aes(x=gene_list2$logFC__1, y=-log10(gene_list2$adj.P.Val__1)) )+
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5,color='gray16'),
          axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
          axis.title.y = element_text(color='gray45',size=15,family="Times",margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.text.x = element_text(color='gray45',size=15,family="Times"),
          legend.title=element_text(color='gray45',size=15,family="Times"),
          legend.text=element_text(color='gray45',size=15,family="Times"),
          legend.position="none") +
    geom_point(alpha=0.7, size=1.75,shape=16, aes(colour = gene_list2$threshold)) +
    scale_color_manual(values = c("grey", "coral")) +
    geom_text(aes(label = ifelse(gene_list2$threshold == TRUE, rownames(gene_list2),"")),size=3,check_overlap = TRUE,hjust = 0, nudge_x = 0.05) +
    xlim(c(-3, 3)) + ylim(c(0, 7.5)) +
    xlab("log2 fold change") + 
    ylab("-log10 adjusted P-value")  +
    ggtitle(paste(list_common[c],' (kidney)',sep = "")) 
  
  ## Hepatocyte
  gene_list3 <- GSE_input_Table[c(7,9)]
  gene_list3$threshold = as.factor(gene_list3$adj.P.Val__2 < 0.05)
  ##Construct the plot object
  g3 <- ggplot(data=gene_list3, aes(x=gene_list3$logFC__2, y=-log10(gene_list3$adj.P.Val__2)) )+
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5,color='gray16'),
          axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
          axis.title.y = element_text(color='gray45',size=15,family="Times",margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.text.x = element_text(color='gray45',size=15,family="Times"),
          legend.title=element_text(color='gray45',size=15,family="Times"),
          legend.text=element_text(color='gray45',size=15,family="Times"),
          legend.position="none") +
    geom_point(alpha=0.7, size=1.75,shape=16, aes(colour = gene_list3$threshold)) +
    scale_color_manual(values = c("grey", "coral")) +
    geom_text(aes(label = ifelse(gene_list3$threshold == TRUE, rownames(gene_list3),"")),size=3,check_overlap = TRUE,hjust = 0, nudge_x = 0.05) +
    xlim(c(-3, 3)) + ylim(c(0, 7.5)) +
    xlab("log2 fold change") + 
    ylab("-log10 adjusted P-value")  +
    ggtitle(paste(list_common[c],' (Hepatocyte)',sep = "")) 
  
  
  tGSEname <- paste("./Dataset_liv_kid_hepa/DE_Table_plot/",list_common[c], sep = "")             # Rename !
  tGSEname <- paste(tGSEname,'.png', sep = "")
  #png(tGSEname,width = 1858, height = 1057)
  grid.arrange(g1,g2,g3, nrow = 1)
  #dev.off()
  #ggsave(tGSEname,g_all)
  
}


######  Plot 03  #####################  heatmap plot  Gene

# https://learnr.wordpress.com/2010/01/26/ggplot2-quick-heatmap-plotting/
# geom_tile
# https://rstudio-pubs-static.s3.amazonaws.com/215319_ac67755c296b441dac7b24b48fc30156.html

HM_summary_table <- as.data.frame(read_excel('./Dataset_liv_kid_hepa/HM_summary_Table.xlsx'))
rownames(HM_summary_table) <- HM_summary_table$X__1

HM_summary_table <- HM_summary_table[apply(HM_summary_table[,-1], 1, function(x) !all(x==0)),]
HM_summary_table <- HM_summary_table[-1]

HM_summary_table <- as.data.frame(t(HM_summary_table))
HM_summary_table$drugid <- rownames(HM_summary_table)

HM_melted <- melt(HM_summary_table, id.vars=c("drugid"))
colnames(HM_melted)[c(1,2)] <- c('Drug','Gene')


hm <- ggplot(data = HM_melted, aes(x = Drug, y = Gene)) + 
  geom_tile(aes(fill = value),colour = "white") + 
  scale_fill_gradient(low = "white",high = "steelblue") 

hm <- hm + 
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5,color='gray16'),
        axis.title.x = element_text(color='gray45'),
        axis.title.y = element_text(color='gray45'),
        legend.position="right",
        axis.text.x = element_text(size = 12 * 0.8, angle = 340, hjust = 0, colour = "grey50"),
        axis.text.y = element_blank()) 
hm



#scale_x_discrete(expand = c(0, 0)) +
#scale_y_discrete(expand = c(0, 0)) + 
#
# theme(plot.title = element_text(hjust = 0.5,color='gray16'),
#      axis.title.x = element_text(color='gray45'),
#      axis.title.y = element_text(color='gray45'),
#      legend.position="right",
#      axis.text.x = theme_text(size = 9 * 0.8, angle = 330, hjust = 0, colour = "grey50")) +
#  scale_color_manual(values = c("orangered3", "wheat2")) + 
# xlab("Compound Name (Drugs)") +
#  ylab("Gene Name")  




###################################################################################################################################


####    Plot 04     ###  Gene -Go term  heatplot heatmap ##############3


gghp <- ggplot(data=, aes(x=Gene, y=GOterm)) +
  geom_tile(aes_(fill = foldChange), color = "white") +
  scale_fill_continuous(low="blue", high="red", name = "fold change")
gghp












###################################################################################################################################




####################   GSEA Ploting  #######################################
# "brown4", "orangered3","tomato", "red3"

####  Plot 05  ##########  multiple box plot: https://stackoverflow.com/questions/14604439/plot-multiple-boxplot-in-one-graph
# https://stackoverflow.com/questions/46913890/ggplot2-width-of-boxplot

GSE_Summary_Table <-  as.data.frame(read_excel("./Dataset_liv_kid_hepa/GSE_Summary_Table_new_02.xlsx"))
GSE_Summary_Table <- GSE_Summary_Table[-1,2:9]
GSE_Summary_Table1 <- GSE_Summary_Table
GSE_Summary_Table2 <- GSE_Summary_Table
colnames(GSE_Summary_Table)[3] <- 'num'
colnames(GSE_Summary_Table1)[4] <- 'num'
colnames(GSE_Summary_Table2)[5] <- 'num'
numrow <- as.numeric(length(rownames(GSE_Summary_Table)))
GSE_Summary_Table_tmp <- rbind(GSE_Summary_Table[,c(2,3)],GSE_Summary_Table1[,c(2,4)],GSE_Summary_Table2[,c(2,5)])
GSE_Summary_Table_tmp$num <- as.numeric(GSE_Summary_Table_tmp$num)
GSE_Summary_Table_tmp$Category <- c(rep('UP',numrow),rep('DOWN',numrow),rep('non-dir',numrow))
GSE_Summary_Table_tmp$Characteristics..organism.part. <- as.factor(GSE_Summary_Table_tmp$Characteristics..organism.part)
GSE_Summary_Table_tmp$Characteristics..organism.part. <- factor(GSE_Summary_Table_tmp$Characteristics..organism.part, levels = c("liver", "kidney", "hepatocyte", "intersect"))
GSE_Summary_Table_tmp$Category <- factor(GSE_Summary_Table_tmp$Category, levels = c("UP", "DOWN", "non-dir"))


bm <- ggplot(GSE_Summary_Table_tmp, aes(GSE_Summary_Table_tmp$Characteristics..organism.part., GSE_Summary_Table_tmp$num)) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.8,color='gray16'),
        axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(color='gray45',size=15,family="Times",margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text.x = element_text(color='gray45',size=15,family="Times"),
        legend.position="right",
        legend.title=element_text(color='gray45',size=15,family="Times"),
        legend.text=element_text(color='gray45',size=15,family="Times") ) +
  geom_boxplot(width=0.5,aes(fill=Category,colour = Category)) +
  ylim(c(0,600)) +
  xlab("Organism part") + 
  ylab("Number of significant gene (FDR)")  +
  scale_colour_manual(values = c("brown4", "tomato", "red3")) +
  scale_fill_manual(values = c("brown4", "tomato", "red3")) +
  geom_dotplot(binaxis='y', stackdir='centerwhole', dotsize=0.1,binwidth=13,aes(fill=GSE_Summary_Table_tmp$Category,colour = GSE_Summary_Table_tmp$Category)) 
bm  



########  Plot 06  ####################   bar plot
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# http://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization

# https://ggplot2.tidyverse.org/reference/geom_bar.html
# https://rstudio-pubs-static.s3.amazonaws.com/215319_ac67755c296b441dac7b24b48fc30156.html 


GSE_intersect_table <- as.data.frame(read_excel("./Dataset_liv_kid_hepa/GSE_intersect_table_0.05.xlsx"))
GOlist <- GSE_intersect_table$GO.term[which(GSE_intersect_table$Compound=='fenofibrate')]

GSE_input_Table <-  as.data.frame(read_excel("./Dataset_liv_kid_hepa/GSE_Table/fenofibrate.xlsx"))
rownames(GSE_input_Table) <- GSE_input_Table$X__1
colnames(GSE_input_Table)[1] <- "Biological Process"
#GSE_input_Table <- GSE_input_Table[1:40]
#GSE_input_Table_UP <- GSE_input_Table[order(GSE_input_Table$`p adj (dist.dir.up)`),][which(GSE_input_Table$`p adj (dist.dir.up)`<0.05),]
#GSE_input_Table_DN <- GSE_input_Table[order(GSE_input_Table$`p adj (dist.dir.dn)`),][which(GSE_input_Table$`p adj (dist.dir.dn)`<0.05),][1:11]
#GSE_input_Table_NON <- GSE_input_Table[order(GSE_input_Table$`p adj (dist.dir.dn)`),][which(GSE_input_Table$`p adj (dist.dir.dn)`<0.05),]

GSE_input_Table_DN <- GSE_input_Table[order(GSE_input_Table$`p adj (dist.dir.dn)`),][1:11,]
GOlist <- c(GOlist,GSE_input_Table_DN$`Biological Process`)
#write.xlsx(GOlist, file = './Dataset_liv_kid_hepa/GOlist.xlsx')


BarGOlist <- GSE_input_Table[c(GOlist),]
BarGOlist$`Genes (tot)`<-as.numeric(BarGOlist$`Genes (tot)`)
BarGOlist$`p adj (dist.dir.up)`<- as.numeric(BarGOlist$`p adj (dist.dir.up)`)
BarGOlist$`p adj (dist.dir.dn)`<-as.numeric(BarGOlist$`p adj (dist.dir.dn)`)
BarGOlist$`p adj (non-dir.)`<-as.numeric(BarGOlist$`p adj (non-dir.)`)
BarGOlist$Category <- '0'
BarGOlist$Category[which(BarGOlist$`p adj (non-dir.)`<0.05)] <- 'NON'
BarGOlist$Category[which(BarGOlist$`p adj (dist.dir.up)`<0.05)] <- 'UP'
BarGOlist$Category[which(BarGOlist$`p adj (dist.dir.dn)`<0.05)] <- 'DOWN'
#write.xlsx(BarGOlist, file = './Dataset_liv_kid_hepa/BarGOlist.xlsx')

#BarGOlist_UP <- BarGOlist[which(BarGOlist$Category == 'UP'),]
#BarGOlist_DN <- BarGOlist[which(BarGOlist$Category == 'DOWN'),]
#BarGOlist_DN <- BarGOlist_DN[7:22,]
#BarGOlist <- rbind(BarGOlist_UP,BarGOlist_DN)


GO_term_Direction <- BarGOlist$Category
GO_term_Direction <- as.factor(GO_term_Direction)
GO_term_Direction <- factor(GO_term_Direction, levels = c('UP','DOWN','NON'))

bp <- ggplot(data=BarGOlist, aes(x=BarGOlist$`Biological Process`,y=BarGOlist$`Genes (tot)`,fill = GO_term_Direction))+ 
  geom_bar(stat = "identity") + 
  coord_flip() +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.8,color='gray16'),
        axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(color='gray45',family="Times",margin = margin(t = 0, r = 0, b = 0, l = 0)),
        axis.text.x = element_text(color='gray45',size=10,family="Times"),
        legend.position="right",
        legend.title=element_text(color='gray45',size=10,family="Times"),
        legend.text=element_text(color='gray45',size=10,family="Times")) +
  scale_fill_manual(values = c("wheat2","orangered3")) + 
  ylab("Gene Counts") +
  xlab("Biological Process")  
bp



#########  Plot 07  ################## dot plot

# Final gene/gene-set association: 10315 genes and 5193 gene sets
#Details:
#  Calculating gene set statistics from 10315 out of 14956 gene-level statistics
#Using all 14956 gene-level statistics for significance estimation


BarGOlist <- BarGOlist[order(BarGOlist$`Genes (tot)`),]
BarGOlist$GeneRatio <- BarGOlist$`Genes (tot)` / 10315
GeneRatio <- BarGOlist$GeneRatio

dp <- ggplot(data=BarGOlist, aes(x=BarGOlist$GeneRatio,y=BarGOlist$`Biological Process`,color = GO_term_Direction,size=GeneRatio))+ 
  geom_point() + 
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.8,color='gray16'),
        axis.title.x = element_text(color='gray45',size=15,family="Times",margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(color='gray45',family="Times",margin = margin(t = 0, r = 0, b = 0, l = 0)),
        axis.text.x = element_text(color='gray45',size=10,family="Times"),
        legend.position="right",
        legend.title=element_text(color='gray45',size=10,family="Times"),
        legend.text=element_text(color='gray45',size=10,family="Times")) +
  scale_color_manual(values = c("orangered3", "wheat2")) + 
  xlab("Gene Ratio") +
  ylab("Biological Process")  
dp




########  Plot 08  ###################  heatmap plot  GO terms 

# https://learnr.wordpress.com/2010/01/26/ggplot2-quick-heatmap-plotting/
# geom_tile




GOhm <- ggplot(data = , aes(x = , y = , fill = )) + 
  geom_tile() +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5,color='gray16'),
        axis.title.x = element_text(color='gray45'),
        axis.title.y = element_text(color='gray45'),
        legend.position="right") +
  scale_color_manual(values = c("orangered3", "wheat2")) + 
  xlab("Compound Name (Drugs)") +
  ylab("Biological Process")  
GOhm








#########  Plot 09  ##################  Network plot 

#BarGOlist_UP <- BarGOlist[which(BarGOlist$Category == 'UP'),]
#BarGOlist_DN <- BarGOlist[which(BarGOlist$Category == 'DOWN'),]
#BarGOlist_DN <- BarGOlist_DN[order(BarGOlist_DN$`Genes (tot)`,decreasing = TRUE),]
#BarGOlist_DN <- BarGOlist_DN[7:22,]
#BarGOlist_tmp <- rbind(BarGOlist_UP,BarGOlist_DN)

gsaRes <- readRDS(file = "./Dataset_liv_kid_hepa/gsaRes_liver_fenofibrate.rds")

nwp <- networkPlot(gsaRes, "distinct", "both", adjusted=TRUE, significance=0.05,
            geneSets=BarGOlist$`Biological Process`, 
            nodeSize=c(1,20), edgeWidth=c(1,15), overlap=50,
            ncharLabel=40,
            lay =5,
            cexLegend = 1.0,
            cexLabel=1,
            scoreColors=c("wheat3",'tan2',"orangered3","brown4"),
            main = 'Gene set Network - fenofibrate')


#write.xlsx(BarGOlist,file = 'BarGOlist.xlsx')



###############################################################################


#http://bioconductor.org/packages/release/bioc/manuals/piano/man/piano.pdf
#https://scilifelab.github.io/courses/rnaseq/labs/GSA_tutorial
networkPlot(gsaRes, "distinct", "both", adjusted=T, ncharLabel=10, significance=0.05,
            nodeSize=c(3,20), edgeWidth=c(1,5), overlap=10,
            scoreColors=c("red", "orange", "yellow", "blue", "lightblue", "lightgreen"))

# http://web.mit.edu/~r/current/arch/i386_linux26/lib/R/library/limma/html/volcanoplot.html

networkPlot(gsaRes, "distinct", "both", adjusted=T, significance=0.05,
            overlap=1,labe = 'numbers',
            scoreColors=c("red", "orange", "yellow", "blue", "lightblue", "lightgreen"))

# https://www.rdocumentation.org/packages/piano/versions/1.12.0/topics/networkPlot
networkPlot(gsaRes, class, direction, adjusted=FALSE, significance=0.001,  geneSets=NULL, overlap=1, lay=1, label="names", cexLabel=0.9,  ncharLabel=25, cexLegend=1, nodeSize=c(10,40), edgeWidth=c(1,15),  edgeColor=NULL, scoreColors=NULL, main)


####################################################################################
# https://bioconductor.org/packages/release/bioc/vignettes/enrichplot/inst/doc/enrichplot.html
# R package: enrichplot
# https://bioconductor.org/packages/release/bioc/html/enrichplot.html
# 
# https://www.bioconductor.org/packages/release/bioc/vignettes/enrichplot/inst/doc/enrichplot.html#visualization-methods

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("enrichplot")

  library(enrichplot)

barplot(height = gsa_l$Name , showCategory=20)  #gene ratio
dotplot()                                         #gene ratio

emapplot()


# Gene-Concept Network
# https://bioconductor.org/packages/release/bioc/vignettes/enrichplot/inst/doc/enrichplot.html

# https://github.com/GuangchuangYu/DOSE/issues/20
# https://github.com/GuangchuangYu/enrichplot/tree/master/R
#$ https://bioconductor.org/packages/release/bioc/vignettes/enrichplot/inst/doc/enrichplot.html
# https://guangchuangyu.github.io/2016/12/dotplot-for-gsea-result/



# Use ggplot without the enrichplot package!!!!! : https://github.com/GuangchuangYu/DOSE/issues/2
###############################################

# piano ploting






GSAheatmap(gsaRes,cutoff = 50,adjusted = TRUE,columnnames = "abbr")






###################################################


# enrichment map r


####################################################################################



# InterMineR
# https://www.bioconductor.org/packages/devel/bioc/vignettes/InterMineR/inst/doc/Enrichment_Analysis_and_Visualization.html



################################################################

#Use gmt in clusterProfiler for GSEA

# https://bioconductor.org/packages/devel/bioc/vignettes/clusterProfiler/inst/doc/clusterProfiler.html
# http://bioconductor.org/packages/release/bioc/manuals/clusterProfiler/man/clusterProfiler.pdf

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("clusterProfiler")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("GSEABase")


library(clusterProfiler)
library(GSEABase)



gmtfile <- system.file("extdata", "Rattus_norvegicus_GSEA_GO_sets_bp_symbols.gmt", package="clusterProfiler")
gmtfile <- "./Rattus_norvegicus_GSEA_GO_sets_bp_symbols.gmt"
c5 <- read.gmt(gmtfile)
#file.exists("Rattus_norvegicus_GSEA_GO_sets_bp_symbols.gmt")
egmt <- enricher(gene, TERM2GENE=c5)
head(egmt)

egmt2 <- GSEA(geneList, TERM2GENE=c5, verbose=FALSE)
head(egmt2)


## how to create genelists:
# https://github.com/GuangchuangYu/DOSE/wiki/how-to-prepare-your-own-geneList
# http://bioconductor.org/packages/release/bioc/vignettes/clusterProfiler/inst/doc/clusterProfiler.R


#########################################







#Visualizing the reactome based analysis results
#The top pathways can be displayed as a bar chart that displays all categories with a p-value below the specified cutoff (Figure 17).

barplot(reactome_enrich)
emaplot







