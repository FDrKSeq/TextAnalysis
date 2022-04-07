#Load required packages
library(ggplot2)
library(stringr)
library(tm)

library(wordcloud)

library(syuzhet) 
#options(max.print=20) do this to print min results

#text <- readLines("C:/Users/others/Documents/bdc analysis/WhatsApp_Chat_Big_Data.txt")

text <- readLines("chat.txt")
text <- str_extract(text, "-\\s*[^*]*")
text <- str_extract(text, ":\\s*[^*]*")
text <- gsub(":", "", text)
print(text)


docs <- Corpus(VectorSource(text))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))

docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
mat <- as.matrix(dtm)
v <- sort(rowSums(mat),decreasing=TRUE)

Sentiment <- get_nrc_sentiment(text)
head(Sentiment)
text <- cbind(text,Sentiment)

TotalSentiment <- data.frame(colSums(text[,c(2:11)]))
names(TotalSentiment) <- "count"
TotalSentiment <- cbind("sentiment" = rownames(TotalSentiment), TotalSentiment)
rownames(TotalSentiment) <- NULL

ggplot(data = TotalSentiment, aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  theme(legend.position = "none") +
  xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score")



