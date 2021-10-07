### Author: Fatemeh Kazemi - 05-31-2021

# Functions for making table results of exposure ~ outcome analysis
# Hazard Ratio (HR) and 95% CI (HR.L, HR.U) (HR.Lower and HR.Upper)

library(tidyverse)
library(here)
library(flextable)
library(officer)





# Single Group Table Function ---------------------------------------------
Table.Single <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    slice(match(cmp, Index))
  
  ft <- flextable(dt)
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}


# Age Group Table Function ------------------------------------------------
Table.Multi.age <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Age)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Age'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Age'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# Sex Group Table Function ------------------------------------------------
Table.Multi.sex <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Sex)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Sex'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Sex'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# Race Group Table Function ------------------------------------------------
Table.Multi.race <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Race)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Race'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Race'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# SES-cat Group Table Function ------------------------------------------------
Table.Multi.sescat <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), `SES.Cat`)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'SES.Cat'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'SES.Cat'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# Region Group Table Function ------------------------------------------------
Table.Multi.region <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Region)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Region'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Region'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# BRFSS Group Table Function ------------------------------------------------
Table.Multi.brfss <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), BRFSS)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'BRFSS'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'BRFSS'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# Buffer Group Table Function ------------------------------------------------
Table.Multi.buffer <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Buffer)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Buffer'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Buffer'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}






# Exposure Window Group Table Function ------------------------------------------------
Table.Multi.expo <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    filter(Index %in% cmp,
           Cause %in% cuz) %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Window)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Window'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Window'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}







# Buffer & Exposure Group Table Function ------------------------------------------------
Table.Multi.buffer.expo <- function(dt, cmp, cuz, cpt, ftnt){
  dt <- dt %>% 
    mutate(Index = factor(Index, levels = cmp),
           Cause = factor(Cause, levels = cuz)) %>% 
    mutate_at(.vars = c("HR", "HR.L", "HR.U"), ~sprintf('%.3f', .x)) %>% 
    mutate(HR.Sum = paste(HR," (", HR.L,", ", HR.U,")", sep = "")) %>% 
    select(-(HR:HR.U)) %>% 
    drop_na() %>% 
    pivot_wider(names_from = "Cause",
                values_from = "HR.Sum") %>% 
    arrange(factor(Index, levels = cmp), Buffer, Window)
  
  ft <- flextable(dt)
  ft <- merge_v(ft, j = c('Index', 'Buffer', 'Window'))
  ft <- theme_vanilla(ft)
  ft <- vline(ft, j = c('Index', 'Buffer', 'Window'))
  ft <- padding(ft, padding = 0)
  ft <- fontsize(ft, size = 12)
  ft <- set_caption(ft, caption = cpt)
  ft <- fontsize(ft, i = 1, size = 12, part = "header")
  ft <- autofit(ft)
  
  doc <- body_add_flextable(doc, value = ft, split = T)
  doc <- body_add_par(doc, ftnt, style = "Normal")
  body_add(doc, run_pagebreak())
  
  return(doc)
}