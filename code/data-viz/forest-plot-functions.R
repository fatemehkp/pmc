### Author: Fatemeh Kazemi - 01-30-2021

# Functions for plotting results of exposure ~ outcome analysis
# Hazard Ratio (HR) and 95% CI (HR.L, HR.U) (HR.Lower and HR.Upper)

library(tidyverse)
library(ggpubr)


###############################################################################
##############################  Plot.Single  ##################################
###############################################################################

### Function *** Plot.Single ***
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure and outcome
# ggtheme : customized theme

### Single Group Plot Function
Plot.Single <- function(dt, ggtheme){
  p <- ggplot(data, aes(x = HR, xmin = HR.L, xmax = HR.U, y = Index)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Index, yend = Index),
                 color = plot.cols, size = 0.25, show.legend = F) + 
    geom_point(aes(x = HR, y = Index, shape = sig), 
               color = plot.cols, size = 1.5, show.legend = F) +
    scale_shape_identity() +
    facet_wrap( ~ Cause, ncol = 5, scales = "fixed") +
    ggtheme
  return(p)
}


###############################################################################
##############################  Plot.Multi ####################################
###############################################################################

### Function *** Plot.Multi ***
# Plots subgroups with different colors and shapes
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure, outcome and subgroups
# ggtheme : customized theme
# n : desired number of rows of legends

### Multiple Group Plot Function
Plot.Multi <- function(dt, ggtheme, n) {
  
  p1 <- ggplot(data = filter(data, Cause %in% cuz.top.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig), 
               size = 1.5, show.legend = T) + 
    scale_shape_manual(
      values = plot.shapes,
      guide = F) +
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(color = guide_legend(override.aes = list(shape = guide.shapes),
                                nrow = n, byrow = T, reverse = T, 
                                direction = "vertical"))
  
  p2 <- ggplot(data = filter(data, Cause %in% cuz.bot.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig), 
               size = 1.5, show.legend = T) + 
    scale_shape_manual(
      values = plot.shapes,
      guide = F) +
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(colour = guide_legend(override.aes = list(shape = guide.shapes),
                                 nrow = n, byrow = T, reverse = T, 
                                 direction = "vertical"))
  
  p <- ggarrange(p1, p2, common.legend =T, nrow = 2, legend = "bottom")
  return(p)
}






###############################################################################
############################  Plot.Multi.Color  ###############################
###############################################################################

### Function *** Plot.Multi.Color ***
# Plots subgroups with different colors
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure, outcome and subgroups
# ggtheme : customized theme
# n : desired number of rows of legends

### Multiple Group Plot Function
Plot.Multi.Color <- function(dt, ggtheme, n) {
  
  p1 <- ggplot(data = filter(data, Cause %in% cuz.top.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig), 
               size = 1.5, show.legend = T) + 
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    scale_shape_identity() +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(color = guide_legend(nrow = n, byrow = T, reverse = T,
                                direction = "vertical")) 
  
  p2 <- ggplot(data = filter(data, Cause %in% cuz.bot.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig), 
               size = 1.5, show.legend = T) + 
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    scale_shape_identity() +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(color = guide_legend(nrow = n, byrow = T, reverse = T, 
                                 direction = "vertical"))
  
  p <- ggarrange(p1, p2, common.legend =T, nrow = 2, legend = "bottom")
  return(p)
}