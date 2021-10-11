
library(dplyr)
library(ggplot2)
install.packages('wordcloud')
library(wordcloud)
install.packages('tm')
library(tm)
courses_df <- readr::read_csv(
  file.path('data','courses.csv'), 
  show_col_types = FALSE
)
view(courses_collapse)
courses_collapse<-paste(courses_df$course,collapse=" ")
courses_source<-VectorSource(courses_collapse)
corpus<-Corpus(courses_source)
corpus<-tm_map(corpus,content_transformer(tolower))
corpus<-tm_map(corpus,removePunctuation)
corpus<-tm_map(corpus,stripWhitespace)
corpus<-tm_map(corpus,removeWords,stopwords("english"))
corpus<-tm_map(corpus,removeNumbers)
dtm<-DocumentTermMatrix(corpus)
dtm2<-as.matrix(dtm)
frequency<-colSums(dtm2)
frequency
frequency<-sort(frequency,decreasing=TRUE)
words<-names(frequency)
wordcloud(words[1:100],frequency[1:100])


#most frequenct words
words1<-data.frame(word=names(frequency),freq=frequency)
barplot(words1[1:5,]$freq,las=2,names.arg=words1[1:5,]$word,
        col="blue",main="Top 5 most frequenct words",
        ylab="Word frequencies")