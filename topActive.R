
library(ggplot2)
library(stringr)
library(tm)

library(wordcloud)

library(syuzhet) 
#text <- readLines("C:/Users/others/Documents/bdc analysis/WhatsApp_Chat_BigData_group.txt")or
text <- readLines("chat.txt")
print(text)
text <- str_extract(text, "-\\s*([^:]*)")
print(text)
text <- gsub("-", "", text)
text <- gsub(" ", "_", text)
docs <- Corpus(VectorSource(text))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("icon"))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)
print(text)
#document term matrix
dtm <- TermDocumentMatrix(docs)
mat <- as.matrix(dtm)
v <- sort(rowSums(mat),decreasing=TRUE)

names(v) <- gsub("mca", "_mca", names(v))
#Data frame
data <- data.frame(word = names(v),freq=v)
head(data, 10)

#wordcloud
set.seed(1056)
wordcloud(words = data$word, freq = data$freq, min.freq = 8,
          max.words=500, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

H <- v 
print(H)
M <- names(v)
print(names(v))
barplot(data[1:25,]$freq, las = 2, names.arg = data[1:25,]$word,
        col ="lightblue", main ="Top Active Members",
        ylab = "frequencies")
