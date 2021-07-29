# Wordcloud with Twitter hashtags: Project Overview 
* Code that returns a wordcloud of a specific topic or hashtag of Twitter.
* Scraped tweets from Twitter API using rtweet package.
* Text analytics. 
* Created a wordcloud with the most frequent words of the hashtag.

## Code and Resources Used 
**R Version:** 3.6.3
**Packages:** rtweet, tidyverse, tm, stringr, wordcloud2

## Web Scraping
Scraped tweets from Twitter’s API using rtweet package.
* #datascience
* #covidvaccine

## Text Analytics
After scraping the data, a function to clean and manipulate the tweets was used based on Text Mining (tm) and stringr packages. The question marks, punctuation, numbers and most common words of a language were removed. A DataFrame with the words and their frequency was returned. This function also permitted to build a wordcloud graphic using wordcloud2.

## Displaying Data
A wordcloud with the most frequent words was constructed.

# #datascience

![#datascience_wordcloud](https://github.com/melisadigiacomo/tweets_wordcloud/blob/master/%23datascience_wordcloud.png)

It is observed that there was strong association between **BigData, Analytics, Deeplearning, IoT, Python, Javascript**, as expected.

# #covidvaccine

![#covidvaccine_wordcloud](https://github.com/melisadigiacomo/tweets_wordcloud/blob/master/%23covidvaccine_wordcloud.png)

Tweets citing #covidvaccine have been returned covering the period between 22 July 2021 and 28 July 2021. People associated words like **health, dose, free, delta variant and availability** with covid vaccines. The most mentioned vaccines in decreased order were: **Pfizer, Covishield, Covaxin, Sputnik V, Moderna and AstraZeneca**.
