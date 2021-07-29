# Wordcloud with Twitter hashtags - Text Analytics

rm(list = ls(all = TRUE))

### set the working directory

# Libraries
library(rtweet) ; library(tidyverse)
#Rest of the libraries will be automatically load with a function

# Acquire tweets from specific topic

query <- "(#datascience)" 
#"(#WORD)" for advanced Twitter serach of hashtags

tweet = search_tweets(query, n=10000, include_rts = FALSE, `-filter` = "replies", lang = "en", 
                      retryonratelimit = FALSE)
# retryonratelimit = TRUE will permit acquire after 15 minutes the rest of the tweets 
# that remains from the 18000 tweets permitted.
# lang = "es" for spanish

# NOTE: the first time, you will have to authorise Twitter's REST API via your web browser!

# Export our tweets as a CSV
# write_as_csv(tweet, "tweets.csv")

# Function
wordcloud <- function(data, stop_words = c(), num_words = 100, background = "white",  mask = NULL) {
  # Check if Pacman is installed: it will download all packages required automatically.
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(wordcloud2, tm, stringr)
  
  # Pre-Function to remove question marks
  quitar_signos <- function(x)  stringr::str_remove_all(x, pattern = rebus::char_class("¿¡"))
  
  # If text is provided, convert it to a dataframe of word frequencies
  if (is.character(data)) {
    # Convert to Corpus
    corpus <- Corpus(VectorSource(data))
    # Convert to lowercase
    corpus <- tm_map(corpus, tolower)
    # Remove punctuation (.,-!?)
    corpus <- tm_map(corpus, removePunctuation)
    # Remove numbers
    corpus <- tm_map(corpus, removeNumbers)
    # Remove marks
    corpus <- tm_map(corpus, quitar_signos)    
    # Remove stopwords (very common words in a language)
    corpus <- tm_map(corpus, removeWords, c(stopwords("spanish"), stop_words))
    corpus <- tm_map(corpus, removeWords, c(stopwords("english"), stop_words))
    # Generate an array to do the count
    tdm <- as.matrix(TermDocumentMatrix(corpus))
    # Get the frequency of each word
    data <- sort(rowSums(tdm), decreasing = TRUE)
    # Generate a table with the word in one column and its frequency of use in another
    data <- data.frame(word = names(data), freq = as.numeric(data))
  }
  
  freq_palabras <<- data
  
  # Make sure a proper num_words is provided
  if (!is.numeric(num_words) || num_words < 3) {
    num_words <- 3
  }  
  
  # Grab the top n most common words
  # Cut the database of words to a specified number n
  data <- head(data, n = num_words)
  if (nrow(data) == 0) {
    return(NULL)
  }
  wordcloud2(data, backgroundColor = background, color = "random-dark", fontFamily = "Asap", size = 3) 
}


# Wordcloud
wordcloud(data = tweet$text)


# Export our word frequency as a CSV
# write_as_csv(freq_palabras, "freq_palabras.csv")


# Other information
# Top 5 tweeting locations
tweet %>% 
  filter(!is.na(place_full_name)) %>% 
  count(place_full_name, sort = TRUE) %>% 
  top_n(5)


# Most retweeted tweet
tweet %>% 
  arrange(-retweet_count) %>%
  slice(1) %>% 
  select(created_at, screen_name, text, retweet_count)


# Most 5 liked tweets
tweet %>% 
  arrange(-favorite_count) %>%
  top_n(5, favorite_count) %>% 
  select(created_at, screen_name, text, favorite_count)
