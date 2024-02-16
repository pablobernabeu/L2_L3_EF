
# A bibliometric analysis of the prevalence of three executive functions 
# in the literatures on second and third language learning.


library(rscopus)
# set_api_key('your_key_here')  # (see https://cran.r-project.org/web/packages/rscopus/vignettes/api_key.html)

library(dplyr)
library(patchwork)


# Load in Scopus search functions
source('https://raw.githubusercontent.com/pablobernabeu/rscopus_plus/main/scopus_comparison.R')
source('https://raw.githubusercontent.com/pablobernabeu/rscopus_plus/main/plot_scopus_comparison.R')


# General parameters
search_period = 2000:2023
quota = 20


# Prevalence of three executive functions in second language studies from 2000 to 2023. 

# In addition to "second language", the reference query includes the terms 
# "learning" and "cognition" to make the scope of the search more relevant to 
# the topic of interest. 

reference_query = '"second language" learning cognition'

comparison_terms = c( '"working memory"', 'inhibition', '"implicit learning"' )

N_comparison_terms = length(comparison_terms)

L2_EF = 
  scopus_comparison(reference_query, comparison_terms, 
                    search_period, quota, verbose = TRUE, 
                    reference_query_field_tag = 'TITLE-ABS-KEY')

saveRDS(L2_EF, paste0('L2_EF', '_', Sys.Date(), '.rds'))

plot_L2_EF = 
  plot_scopus_comparison(L2_EF, 
                         pub_count_in_legend = FALSE, 
                         pub_count_in_lines = TRUE) +
  scale_color_manual(
    values = c( "[ref.] + '\"working memory\"'" = scales::hue_pal()(N_comparison_terms)[1],
                "[ref.] + 'inhibition'" = scales::hue_pal()(N_comparison_terms)[2], 
                "[ref.] + '\"implicit learning\"'" = scales::hue_pal()(N_comparison_terms)[3] )
  ) + 
  guides(colour = guide_legend(override.aes = list(alpha = 1))) +
  # Prepare layout for the multi-plot combination
  theme(axis.text.x = element_blank(), legend.position = 'none')


# Prevalence of three executive functions in third language studies from 2000 to 2023. 

# In addition to "third language", the reference query includes the terms "learning" 
# and "cognition" to make the scope of the search more relevant to the topic of 
# interest. 

reference_query = '"third language" learning cognition'

comparison_terms = c( '"working memory"', 'inhibition', '"implicit learning"' )

N_comparison_terms = length(comparison_terms)

L3_EF = 
  scopus_comparison(reference_query, comparison_terms, 
                    search_period, quota, verbose = TRUE, 
                    reference_query_field_tag = 'TITLE-ABS-KEY')

saveRDS(L3_EF, paste0('L3_EF', '_', Sys.Date(), '.rds'))

plot_L3_EF = 
  plot_scopus_comparison(L3_EF, 
                         pub_count_in_legend = FALSE, 
                         pub_count_in_lines = TRUE) +
  scale_color_manual(
    values = c( "[ref.] + '\"working memory\"'" = scales::hue_pal()(N_comparison_terms)[1],
                "[ref.] + 'inhibition'" = scales::hue_pal()(N_comparison_terms)[2], 
                "[ref.] + '\"implicit learning\"'" = scales::hue_pal()(N_comparison_terms)[3] )
  ) + 
  guides(colour = guide_legend(override.aes = list(alpha = 1))) +
  # Prepare layout for the multi-plot combination
  theme(axis.text.x = element_text(margin = margin(7, 0, 0, 0, 'pt')),
        legend.position = c(.87, .8))


# Combine plots

plot_L2_EF + plot_L3_EF + 
  plot_layout(ncol = 1, axes = 'collect') &
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(vjust = 0.5, size = 12), 
        plot.title = element_markdown(hjust = 0.5, size = 12),
        legend.text = element_text(size = 11),
        legend.background = element_rect(color = 'grey30', fill = 'grey98'), 
        legend.margin = margin(0, 8, 6, 6))