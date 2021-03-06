library(tidyverse)
to_analyze <- read_csv('to_analyze.csv')
lm_panss <- lm(PANSS_Total ~ repeat_num + no_pos_mean_cos_sim + no_pos_min_cos_sim + no_pos_max_cos_sim + unique_num, data = to_analyze)
summary(lm_panss)
lm_panss_o <- lm(PANSS_O ~ repeat_num + no_pos_mean_cos_sim + no_pos_min_cos_sim + no_pos_max_cos_sim + unique_num, data = to_analyze)
summary(lm_panss_o)
lm_panss_p <- lm(PANSS_P ~ repeat_num + no_pos_mean_cos_sim + no_pos_min_cos_sim + no_pos_max_cos_sim + unique_num, data = to_analyze)
summary(lm_panss_p)
lm_panss_n <- lm(PANSS_N ~ repeat_num + no_pos_mean_cos_sim + no_pos_min_cos_sim + no_pos_max_cos_sim + unique_num, data = to_analyze)
summary(lm_panss_n)
plot(lm_panss_n)


lm_panss <- lm(PANSS_Total ~ repeat_num + unique_num + min_cluster_len + mean_cluster_len + max_cluster_len, to_analyze)
summary(lm_panss)
lm_panss_o <- lm(PANSS_O ~ repeat_num + unique_num + min_cluster_len + mean_cluster_len + max_cluster_len, to_analyze)
summary(lm_panss_o)
lm_panss_p <- lm(PANSS_P ~ repeat_num + unique_num + min_cluster_len + mean_cluster_len + max_cluster_len, to_analyze)
summary(lm_panss_p)
lm_panss_n <- lm(PANSS_N ~ repeat_num + unique_num + min_cluster_len + mean_cluster_len + max_cluster_len, to_analyze)
summary(lm_panss_n)
plot(lm_panss_n)