library(utils)
setwd("C:/Work/Coursera/Data_Analysis/10)Capstone_Project/Week3")
fileURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
fileZIP <- "Coursera-SwiftKey.zip"

if (!file.exists(fileZIP)){
    download.file(fileURL, destfile=fileZIP, method="curl")
}

pathFiles <- "final/en_US/"
Files <- c("en_US.twitter.txt", "en_US.news.txt", "en_US.blogs.txt")

if(!dir.exists(pathFiles)){
    unzip(fileZIP, paste0(pathFiles, Files[1:3]))
}


fileTwitter <- file("final/en_US/en_US.twitter.txt", "rb")
twitter <- readLines(fileTwitter, encoding = "UTF-8", skipNul = TRUE)
close(fileTwitter)

fileNews <- file("final/en_US/en_US.news.txt", "rb")
news <- readLines(fileNews, encoding = "UTF-8", skipNul = TRUE)
close(fileNews)

fileBlogs <- file("final/en_US/en_US.blogs.txt", "rb")
blogs <- readLines(fileBlogs, encoding = "UTF-8", skipNul = TRUE)
close(fileBlogs)

rm("fileTwitter", "fileNews", "fileBlogs")

source("Scripts/clean2.R")
## We join the three datasets and sample 3% of the union
set.seed(1234)
files <- unlist(list(twitter,news,blogs))
smp <- sample(files, size = 0.03*length(files), replace = FALSE)
smp2 <- clean2(smp)

library(ngram)
smp3 <- concatenate(smp2, collapse = "")

write(smp, file = "cleanDataOriginal.txt")
write(smp2, file = "cleanData.txt")


bigram <- ngram(smp3, n = 2)
bigram <- get.phrasetable(bigram)
bigram$ngrams <- trimws(bigram$ngrams, which = "both")

trigram <- ngram(smp3, n = 3)
trigram <- get.phrasetable(trigram)
trigram$ngrams <- trimws(trigram$ngrams, which = "both")

fourgram <- ngram(smp3, n = 4)
fourgram <- get.phrasetable(fourgram)
fourgram$ngrams <- trimws(fourgram$ngrams, which = "both")

setwd("C:/Work/Coursera/Data_Analysis/10)Capstone_Project/Week7/WordPred")
library("readr")
# Writing data to a txt file
write.csv(bigram,"bigram.csv", row.names = FALSE)
write.csv(trigram,"trigram.csv", row.names = FALSE)
write.csv(fourgram,"fourgram.csv", row.names = FALSE)