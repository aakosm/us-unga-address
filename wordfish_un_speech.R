# script by Akos Mate
# unsupervised scaling of US Presidential addresses to the UN General Assembly
# data sources: https://2009-2017.state.gov/p/io/potusunga/index.htm and http://www.presidency.ucsb.edu/
# 2017-09-24

library(readtext)
library(quanteda)
library(readr)
library(formatR)
library(Hmisc)


rm(list=ls())

# loading the plaintext speeches and transforming it into a document-feature matrix
unga <- readtext("*.txt")
unga_dfm <- dfm(corpus(unga))


# some data cleaning: making the texts lowercase and deleting stopwords
dfm_tolower(unga_dfm)
dfm_remove(unga_dfm, stopwords("english"))


# checking the order of documents in the document-feature matrix and then estimating the model
unga_dfm@Dimnames$docs
wordfish <- textmodel_wordfish(unga_dfm, dir = c(4,7))


# plotting the word weights vs. word fixed effects, and the scale with the estimated positions
textplot_scale1d(wordfish, margin = "features",
                 highlighted = c("terror","sovereignity", "islam", "war", "nuclear", "iran"),
                 highlighted_color = "orangered2")

textplot_scale1d(wordfish, margin = "documents")