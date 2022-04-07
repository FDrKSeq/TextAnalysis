load.lib<-c("tm","SnowballC","wordcloud","stringr","syuzhet")#give your own package name to install
install.lib<-load.lib[!load.lib %in% installed.packages()]
for(lib in install.lib) install.packages(lib,dependencies=TRUE)
sapply(load.lib,require,character=TRUE)
