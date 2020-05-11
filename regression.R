library(tidyverse)
to_analyze <- read_csv('to_analyze.csv')
lm_panss <- lm(PANSS_Total ~ repeat_num:age:sex + no_pos_mean_cos_sim:age:sex + no_pos_min_cos_sim:age:sex + mean_cluster_len:age:sex + mean_pause:age:sex, data = to_analyze)
summary(lm_panss)
lm_panss_o <- lm(PANSS_O ~ repeat_num:age:sex + no_pos_mean_cos_sim:age:sex + no_pos_min_cos_sim:age:sex + mean_cluster_len:age:sex + mean_pause:age:sex, data = to_analyze)
summary(lm_panss_o)
lm_panss_p <- lm(PANSS_P ~ repeat_num:age:sex + no_pos_mean_cos_sim:age:sex + no_pos_min_cos_sim:age:sex + mean_cluster_len:age:sex + mean_pause:age:sex, data = to_analyze)
summary(lm_panss_p)
lm_panss_n <- lm(PANSS_N ~ repeat_num:age:sex + no_pos_mean_cos_sim:age:sex + no_pos_min_cos_sim:age:sex + mean_cluster_len:age:sex + mean_pause:age:sex, data = to_analyze)
summary(lm_panss_n)
plot(lm_panss_n)


library(cluster)
library(languageR)
library(factoextra)
library(FactoMineR)
library(ggfortify)
library(plyr)

only_analyze = select(to_analyze, -binary_diagnosis, -diagnosis, -HDRS, -Y2RS, -cluster_degree, -ID)
only_analyze %>% 
  scale(center = TRUE, scale = TRUE) -> only_analyze
dd <- na.omit(select(to_analyze, -HDRS, -Y2RS))
dd$diagnosis = revalue(as.factor(dd$diagnosis), c("1"="schizophrenia", "0"="control", "2"='schizoaffective disorder', '3'='control with schizo-spectrum tendencies'))
dd <- column_to_rownames(dd, var = "ID")
### CA using factoextra & FactoMineR
autoplot(prcomp(na.omit(only_analyze)), data = dd, 
         colour = 'diagnosis', label = TRUE, label.size = 5,
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 5)+ggtitle('Principal Correspondence Analysis using ggfortify, biplot on verbal fluency task')

only_analyze = select(to_analyze, -education, -binary_diagnosis, -diagnosis, -HDRS, -Y2RS, -ID, -PANSS_Total, -PANSS_O, -PANSS_P, -PANSS_N, -TD, -cluster_degree)
only_analyze %>% 
  scale(center = TRUE, scale = TRUE) -> only_analyze
dd <- na.omit(select(to_analyze, -HDRS, -Y2RS, -PANSS_Total, -PANSS_O, -PANSS_P, -PANSS_N))
dd$diagnosis = revalue(as.factor(dd$diagnosis), c("1"="schizophrenia", "0"="control", "2"='schizoaffective disorder', '3'='control with schizo-spectrum tendencies'))
dd <- column_to_rownames(dd, var = "ID")
### CA using factoextra & FactoMineR
autoplot(prcomp(na.omit(only_analyze)), data = dd, 
         colour = 'diagnosis', label = TRUE, label.size = 5,
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 5)+ggtitle('Principal Correspondence Analysis using ggfortify, biplot on verbal fluency task')
