#---
#title: "MusicPrePro"
#author: "SSD"
#date: "2022-02-05"
#output: html_document
#---
# Siddharth, EDA, Music Emotion Recommendation
# NLP, Exploratory Data analysis, Pre-Processing.   

  
library(dplyr)
library(mice)
library(tidyverse)
library(readr)
  
  
# For NLP
library(tidyverse) # metapackage with lots of helpful functions
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
library(tidytext)
library(RColorBrewer)
library(reshape2)
#install.packages("wordcloud")
library(wordcloud)
#install.packages("igraph")
library(igraph)
#install.packages("widyr")
library(widyr)
#install.packages("ggraph")
library(ggraph)
#install.packages("ngram")
#install.packages("wordcloud2")
library(ngram)
library(wordcloud2)
  



  
data=read.csv('aa_songdata.csv')
  
# PreProcessing
  
head(data,n=2)
## Viewing summaries of the datasets
summary(data)
  
# Checking Null Values
  
#is.na(data)
sum(is.na(data))
  


  
head(data,n=1)
  
### As we can see, that in the link, it's unplayable, so we'll add the domain in it
  
library('stringr')

  

  
#d1$link<-paste("https://www.lyricsfreak.com",d1$link)
# Checking for null values, 
data$link<-str_c("https://www.lyricsfreak.com",'',data$link)
  

  
head(data,n=1)

  
## The correct domain link has been added
  
#Exporting it, and then Downloading it for our further process
 w
  

  
md.pattern(data)
  

  
glimpse(data)
# Dealing with categorical data
#is.integer()
  

  
library(gplots)
#install.packages("ggthemes")
library(ggthemes)
  

  
d1 <- data %>%
  group_by(artist) %>%
  summarize(count=n()) %>%
  arrange(desc(count))
  

  
ggplot(d1, aes(artist, count, fill=count)) + geom_bar(stat="identity") + 
  ggtitle("Projects by Category") + xlab("Artists freq.") + ylab("No. of songs") + 
  geom_text(aes(label=count), vjust=-0.5)
  

  
ggplot(d1, aes(artist, count, fill=count)) + geom_bar(stat="identity")+theme(plot.title=element_text(hjust=0.5), axis.title=element_text(size=12, face="bold"), 
        axis.text.x=element_text(size=12, angle=90), legend.position="null") + 
  scale_fill_gradient(low="skyblue1", high="royalblue4")
  





















## Adding the NLP, for knowing the Emotions as well.
  
song=data
song$text<-as.character(song$text)
song_freq<-song%>%
  group_by(artist)%>%
  summarise(song=unique(length(song)))%>%arrange(desc(song))
head(song_freq,n=5)
  
# SIngers freq.

  
library(wordcloud)
wordcloud2(song_freq[1:600,],size = .5)

  

  
library(tidyr)
library(tidytext)
tidy_lyrics<-tidy_lyrics <- song%>% unnest_tokens(word,text)
head(tidy_lyrics,n=3)

  

  
song_wrd_count<-tidy_lyrics %>%count(song)
head(song_wrd_count,n=3)

  

# Visualizing more features.
  
# Counting total no. of words
lyric_counts <- tidy_lyrics%>%
  left_join(song_wrd_count, by =
              "song")%>%rename(total_words=n)
tail(lyric_counts,n=1)
  

  
song_wrd_count %>%
  arrange(desc(n))%>%top_n(n=10)%>%
  ggplot(aes(x=factor(song,levels=song),y=n))+
  geom_col(col="yellow",fill="blue",size=1)+
  labs(x="song",y="word count",
       title="Words per song-Top 10")
  

  
song_wrd_count %>%
  arrange(desc(n))%>%tail(n=10)%>%
  ggplot(aes(x=factor(song,levels=song),y=n))+
  geom_col(col="green",fill="blue",size=1)+
  labs(x="song",y="word count",title="Songs, which have very less words")+
  theme(axis.text.x = element_text(angle=90))


  
  
song_wrd_count %>% arrange(desc(n))%>%tail(n=10)%>%ggplot(aes(x=factor(song,levels=song),y=n))+geom_col(col="yellow",fill="darkorange",size=1)+labs(x="song",y="word count",title="Which song has very less words")+theme(axis.text.x = element_text(angle=90))
  
  
#install.packages("textdata")
library(textdata)

#textdata::lexicon_afinn(manual_download = TRUE) 
  

  
head(get_sentiments("afinn"))
unique(get_sentiments("afinn")$word)
  
  
lyric_counts <- tidy_lyrics%>%
  left_join(song_wrd_count, by ="song")%>%
  rename(total_words=n)
  

  

# library(tidytext)
# get_sentiments("nrc")
# lyric_sentiment<-try %>%
#   inner_join(get_sentiments("nrc"),by="word")
  

  
#remotes::install_github("EmilHvitfeldt/textdata")
  

  {r warning=FALSE}
library(remotes)
#install_github("EmilHvitfeldt/textdata")
#install_github("juliasilge/tidytext")
  

  {r warning=FALSE}
lyric_sentiment<-tidy_lyrics %>% inner_join(get_sentiments("nrc"),by="word")
head(lyric_sentiment)
  


  
lyric_sentiment %>%filter(!sentiment %in% c("positive","negative"))%>%count(word,sentiment,sort=TRUE)%>%group_by(sentiment)%>%top_n(n=10)%>%ungroup() %>%
ggplot(aes(x=reorder(word,n),y=n,fill=sentiment))+geom_col(show.legend = FALSE)+facet_wrap(~sentiment,scales="free")+coord_flip()
  


  
lyric_sentiment %>%count(song,sentiment,sort=TRUE)%>%group_by(sentiment)%>%top_n(n=5)%>%ggplot(aes(x=reorder(song,n),y=n,fill=sentiment))+geom_bar(stat="identity",show.legend = FALSE)+facet_wrap(~sentiment,scales="free")+coord_flip()

  

  
lyric_sentiment %>%count(artist,sentiment,sort=TRUE)%>%group_by(sentiment)%>%filter(sentiment %in% c("joy","sadness","anger"))%>% top_n(n=5)%>%ggplot(aes(x=reorder(artist,n),y=n,fill=sentiment))+geom_bar(stat="identity",show.legend = FALSE)+facet_wrap(~sentiment,scales="free")+coord_flip()
  

  
nc<-get_sentiments("nrc")
unique(nc)
  

  
song_lex<-tidy_lyrics %>%inner_join(nc,by="word")
head(song_lex)
  

  
backu=song_lex
song_sent<-song_lex %>%count(song,sentiment)
tail(song_sent)
  

  
song_sent%>%filter(sentiment=="joy")%>%arrange(desc(n))%>%head(10)%>%ggplot(aes(x=reorder(song,n),y=n))+geom_col(fill="orange")+labs(title="Top Songs - Joy words",x="song",y="+ve Word Count")+coord_flip()
  


  
song_sent%>%filter(sentiment=="sadness")%>%arrange(desc(n))%>%head(10)%>%ggplot(aes(x=reorder(song,n),y=n))+geom_col(fill="red")+labs(title="Top Songs - sad words",x="song",y="+ve Word Count")+coord_flip()
  

  
uncommon_wrd<-tidy_lyrics%>%count(song,word)%>%bind_tf_idf(word, song, n)%>%arrange(desc(tf_idf))
head(uncommon_wrd)
  

  
uncommon_wrd %>%arrange(desc(tf_idf))%>%head(20)%>%
ggplot(aes(x=word,y=tf_idf,fill=song))+geom_col()+labs(x="words",title="top 20- Associated words to songs in Lyrics")+theme(axis.text.x=element_text(angle=90))
  

  {r warning=FALSE}
tidy_lyrics %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),
                   max.words = 300)
  

  
lyrics_bigram <- unnest_tokens(data, input = text, output = bigram, token = "ngrams", n=2)
head(lyrics_bigram)
  
  
bigram_filtered<-lyrics_bigram %>%separate(bigram,c("word1","word2",sep=" "))%>%
filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)
head(bigram_filtered)
  

  
# Ram issue.  https://www.kaggle.com/code/srisudheera/nlp-song-data-set/notebook
# bigram_united <- bigram_filtered %>%unite(bigram, word1, word2, sep = " ")
# head(bigram_united)
  
  
# bigram_counts <- bigram_united %>% count(bigram, sort = TRUE)
# head(bigram_counts)
  


  
# bigram_counts %>% arrange(desc(n))%>% head(20)%>%ggplot(aes(x=factor(bigram,levels=bigram),y=n))+geom_bar(stat="identity",fill="#FF3E45")+labs(title="Top 20 bigram words in Songs")+coord_flip()
  











# Now, for Million Song Dataset.

  
library(dplyr)
library(magrittr)
library(stringr)
library(tidyr)
library(knitr)
#install.packages("kableExtra")
library(kableExtra)
library(ggplot2)
library(devtools)
#devtools::install_github("nicolewhite/RNeo4j")
#install.packages("RNeo4j")
#library(RNeo4j)
library(recommenderlab)
#install.packages("psych")
library(psych)
library(rstudioapi)
library(knitr)
library(kableExtra)
  

  
# install.packages("C:/Users/SSD/Downloads/RNeo4j-1.6.1.tar.gz", repos=NULL, type="source")
# library(RNeo4j)
  

# The Data analytics approach
* **Problem Understanding:** Creating a song recommender system, based on KNN. and observing the alalytics
* **Data Understanding:** The previous dataset doesnt have all the extra factors, that's why we have chosed this one(MSD)
* **Data Prep.:** Pre-Processing, calculating the song ratings, and doing random sample downstream analysis, along with the Rankings graph.
* **Models:** KNNs with different algorithms, along with different metrics.

  

# Reading in the ratings dataframe and rename the columns
#, link now working, 
#u1 <- "https://static.turi.com/datasets/millionsong/10000.txt"
df1 <- as.data.frame(read.table("10000.txt", header = F, stringsAsFactors = F))
# Adding the column names
names(df1) <- c("user_id", "song_id", "listen_count")
  

  
# Read in the metadata dataframe
#u2 <- "https://static.turi.com/datasets/millionsong/song_data.csv"
metadata <- as.data.frame(read.csv("MSD_song_data.csv", header = T, sep = ",", stringsAsFactors = F))
  

  
head(metadata)
  

  
# Joining the two datasets
# Join data by song ID. Remove duplicate song ratings.
joined <- distinct(inner_join(df1, metadata, by = "song_id"))


# Group and summarize joined dataframe by user ID
grouped_id <- joined %>%
  select(user_id, listen_count) %>%
  group_by(user_id) %>%
  summarise(number_songs = n(), 
            mean_listen_count = mean(listen_count), 
            sum_listen_count = sum(listen_count))

grouped_song <- joined %>% 
  select(song_id, title, artist_name) %>% 
  group_by(title)
  

  
describe(grouped_id)
  

  
msd=grouped_id
# High-level statistics on listeners
describe(grouped_id) %>% kable()
  
### Checking null values. 
  
sum(is.null(msd))
  

  
md.pattern(msd)
  

  
# Compare total songs and listeners
ggplot(data = grouped_id, aes(number_songs)) + 
  geom_histogram(binwidth = 1) +
  labs(title = "How people listen: songs vs. listeners", x = "Unique songs", y = "Total listeners")
  
The above Histogram depicts the remarkable skew of the dataset,
  
# Comparing total songs and listeners below 100 songs
ggplot(data = grouped_id, aes(number_songs)) + 
  geom_histogram(breaks = seq(1, 100, by = 1)) +
  labs(title = "How people listen: songs vs. listeners", subtitle = "<100 songs (detail)", x = "Unique songs", y = "Total listeners")
  

  
# Compare total songs and total listens
ggplot(data = grouped_id, aes(x = number_songs, y = sum_listen_count)) +
  geom_point() +
  geom_smooth(method = "loess", se = F) +
  xlim(c(0, 8000)) +
  ylim(c(0, 8000)) +
  labs(title = "How people listen: songs vs. listens", x = "Unique songs", y = "Total listens")
  

  

  

  
# Number of unique songs.
length(unique(joined$song_id))
  

  
# Earliest recordings (correcting for null values coded as 0)
min(joined$year[which(joined$year > 0)])
  

  
# Total number of listens
sum(joined$listen_count)
  

  
# High-level statistics on songs
describe(joined$listen_count)
  

  {r warning=FALSE}
# Compare total listens and unique listeners
joined %>% 
  select(user_id, song_id, listen_count) %>% 
  group_by(song_id) %>% 
  summarise(total_listens = sum(listen_count), unique_listeners = n_distinct(user_id)) %>%
  ggplot(aes(x = total_listens, y = unique_listeners)) +
  geom_point() +
  geom_smooth(method = "loess", se = F) +
  xlim(c(0, 8500)) +
  ylim(c(0, 6000)) +
  labs(title = "How songs are listened to: unique songs vs. total listens", x = "Total listens", y = "Unique listeners")
  

# Calculating the reating and filters, 
  
# Join total listen count to the full dataframe.
joined2 <- left_join(joined, grouped_id, by = "user_id")

# Create a new column to hold a calculated implicit rating (as a number from 0 to 100) of user preference for a song. 
joined_final <- mutate(joined2, rating = round((joined2$listen_count / joined2$sum_listen_count)*100, 2))
  
  
# Filter out users with a single song rating. Include users who have a diverse set of ratings.
joined_final <- filter(joined_final, rating<100, mean_listen_count>2, number_songs>=15, year>0)

head(joined_final)  %>% 
  kable("html")     %>% 
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
  
  
hist(joined_final$rating)
  

  
head(joined_final,n=2)
  

  
md.pattern(joined_final)
  




# Observing the outliers
  
boxp1<-ggplot(joined_final, aes(x =number_songs, y=sum_listen_count))
# Adding the geometric object box plot
boxp1+geom_boxplot()
  


  
boxplot(joined_final$listen_count)
  
  
boxplot(joined_final$rating)
  

  
temp=joined_final
outlierKD <- function(dt, var) {
  var_name <- eval(substitute(var),eval(dt))
  tot <- sum(!is.na(var_name))
  na1 <- sum(is.na(var_name))
  m1 <- mean(var_name, na.rm = T)
  par(mfrow=c(2, 2), oma=c(0,0,3,0))
  boxplot(var_name, main="With outliers")
  hist(var_name, main="With outliers", xlab=NA, ylab=NA)
  outlier <- boxplot.stats(var_name)$out
  mo <- mean(outlier)
  var_name <- ifelse(var_name %in% outlier, NA, var_name)
  boxplot(var_name, main="Without outliers")
  hist(var_name, main="Without outliers", xlab=NA, ylab=NA)
  title("Outlier Check", outer=TRUE)
  na2 <- sum(is.na(var_name))
  message("Outliers identified: ", na2 - na1, " from ", tot, " observations")
  message("Proportion (%) of outliers: ", (na2 - na1) / tot*100)
  message("Mean of the outliers: ", mo)
  m2 <- mean(var_name, na.rm = T)
  message("Mean without removing outliers: ", m1)
  message("Mean if we remove outliers: ", m2)
  response <- readline(prompt="Do you want to remove outliers and to replace with NA? [yes/no]: ")
  if(response == "y" | response == "yes"){
    dt[as.character(substitute(var))] <- invisible(var_name)
    assign(as.character(as.list(match.call())$dt), dt, envir = .GlobalEnv)
    message("Outliers successfully removed", "\n")
    return(invisible(dt))
  } else{
    message("Nothing changed", "\n")
    return(invisible(var_name))
  }
}
  


  
outlierKD(temp, rating)
  

  
outlierKD(temp, number_songs)
  
  
outlierKD(temp, sum_listen_count)
  

  
outlierKD(temp, year)
  
## As, we'll be using KNN Algo for our Recommendation, so these outliners will also be necessary in this scenario, as we cannot excludo those people who have a different taste of music. 

  
cor(temp$listen_count, temp$rating)
  

The total no. of listening and the song song ratings are highly correlated.

  
s<-temp%>%dplyr::select(listen_count,year,number_songs,mean_listen_count,sum_listen_count,rating)
  


  
library(lattice)
library(reshape2)
# rounding to 2 decimal places
corr_mat <- round(cor(s),2) 
melted_corr_mat <- melt(corr_mat)
  

  
# plotting the correlation heatmap
library(ggplot2)
ggplot(data = melted_corr_mat, aes(x=Var1, y=Var2,
                                   fill=value)) +
geom_tile() +
geom_text(aes(Var2, Var1, label = value),
          color = "black", size = 4)
  

  
# Load and install heatmaply package
#install.packages("heatmaply")
library(heatmaply)
 
# plotting corr heatmap
heatmaply_cor(x = cor(s), xlab = "Features",
              ylab = "Features", k_col = 2, k_row = 2)
  

  
#Exporting it, and then Downloading it for our further process
write.csv(joined_final,file="MSD_PrePrcsd_SSD.csv", row.names = FALSE)
  



So, In our preprocessing, we have combined the dataset, checked null values, plotted necessary graphs, and saw their relations etc.




















































  
#RNeo4j not installing
# Addin# Create subdirectory in working directory to house Shiny app
dir <- getwd()
dir.app <- (file.path(dir, "App"))
if (!dir.exists(dir.app)){
  dir.create(dir.app)
  print(paste0("Shiny app directory created: ", dir.app))
} else {
    print("Shiny app directory already exists")
}

  

  
library(magrittr)
library(stringr)
library(tidyr)
library(knitr)
#install.packages("kableExtra")
library(kableExtra)
library(ggplot2)
library(devtools)
#devtools::install_github("nicolewhite/RNeo4j")
#install.packages("RNeo4j")
#library(RNeo4j)
library(recommenderlab)
#install.packages("psych")
library(psych)
library(rstudioapi)
library(knitr)
library(kableExtra)
  

  

  

  

  

  

  

  

  

  

  

  

  



