Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_131')

library(tm)
library(topicmodels)
library(openNLP)
library(openNLPdata)
library(NLP)
library(dplyr)
library(rJava)
library(RWeka)
library(RWekajars)
library(tm)
library(qdap)
library(corrplot)


data<-read.csv(file.choose())
text<-as.character(data$text)

# Data Cleaning
corpus1<-Corpus(VectorSource(text)) 

corpus1 <- tm_map(corpus1, removeNumbers)
corpus1 <- tm_map(corpus1, removePunctuation)
corpus1 <- tm_map(corpus1 , stripWhitespace)
corpus1 <- tm_map(corpus1, content_transformer(tolower))
corpus1 <- tm_map(corpus1, removeWords, c(stopwords("english"),"the","am"))
corpus1 <- tm_map(corpus1, stemDocument, language = "english")

unigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 3))
dtm<-DocumentTermMatrix(corpus1,control = list(tokenize=unigramTokenizer, 
                                               stopwords = TRUE))
dtm_keys<-inspect(dtm)

dtm_key1<-removeSparseTerms(dtm,sparse=0.9999)
inspect(dtm_key1)
tdm<-TermDocumentMatrix(corpus1,control = list(tokenize=unigramTokenizer, 
                                               stopwords = TRUE))
tdm_keys<-inspect(tdm)
