library(tidyverse)
library(cluster)
library(languageR)
library(factoextra)
library(FactoMineR)
library(ggfortify)
library(plyr)
to_analyze <- read_csv('to_analyze.csv')
to_analyze = select(to_analyze, -mean_pause, -HDRS, -Y2RS, -cluster_degree)
only_analyze = select(to_analyze, -binary_diagnosis, -diagnosis, -ID)
only_analyze %>% 
  scale(center = TRUE, scale = TRUE) -> only_analyze
dd <- na.omit(to_analyze)
dd$diagnosis = revalue(as.factor(dd$diagnosis), c("1"="schizophrenia", "0"="control", "2"='schizoaffective disorder', '3'='control with schizo-spectrum tendencies'))
dd <- column_to_rownames(dd, var = "ID")
### CA using factoextra & FactoMineR
autoplot(prcomp(na.omit(only_analyze)), data = dd, 
         colour = 'diagnosis', label = TRUE, label.size = 3, label.repel = TRUE,
         loadings = TRUE, loadings.colour = 'black', loadings.label.repel = TRUE,
         loadings.label = TRUE, loadings.label.size = 3)+ggtitle('Principal Correspondence Analysis using ggfortify, biplot on verbal fluency task with PANSS')+ theme(
           legend.text = element_text(size = 10))
ggsave("PCA_PANSS_animals_small.jpeg", width = 35, height = 15, units = "cm")

only_analyze = select(to_analyze, -education, -binary_diagnosis, -diagnosis, -PANSS_Total, -PANSS_O, -PANSS_P, -PANSS_N, -TD, -ID, -sex, -age)
only_analyze %>% 
  scale(center = TRUE, scale = TRUE) -> only_analyze
dd <- na.omit(select(to_analyze, -PANSS_Total, -PANSS_O, -PANSS_P, -PANSS_N, -TD))
dd$diagnosis = revalue(as.factor(dd$diagnosis), c("1"="schizophrenia", "0"="control", "2"='schizoaffective disorder', '3'='control with schizo-spectrum tendencies'))
dd <- column_to_rownames(dd, var = "ID")
### CA using factoextra & FactoMineR
autoplot(prcomp(na.omit(only_analyze)), data = dd, 
         colour = 'diagnosis', label = TRUE, label.size = 3, label.repel = TRUE,
         loadings = TRUE, loadings.colour = 'black', loadings.label.repel = TRUE,
         loadings.label = TRUE, loadings.label.size = 3)+ggtitle('Principal Correspondence Analysis using ggfortify, biplot on verbal fluency task')+ theme(
           legend.text = element_text(size = 10))
ggsave("PCA_animals_small.jpeg", width = 35, height = 15, units = "cm")
