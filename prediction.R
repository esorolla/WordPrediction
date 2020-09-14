prediction <- function(inputString){
    library(stringr)

    # We trim the input string to catch only the input word (no spaces)
    inputString <- trimws(inputString, which = "right")

    # We define the function to set the strategy for dealing with the input:
    sepString <- strsplit(inputString, " ")
    case <- sapply(sepString, length) + 1

    #We search for the n-grams:
    if(case ==1){#For empty string
        prediction <- " "
    }
    else if(case == 2){#For bigrams:
        # We add a space to avoid the input being the last word of the n-gram:
        x2 <- bigram$ngrams[grep(paste0(inputString, " "), bigram$ngrams)][1]
        aux <- str_split(x2[1], " ")[[1]][2]

        if(is.na(x2)){#if no prediction can be done
            prediction <- " "
        }
        else{          #if prediction can be done
            prediction <- aux
        }
    }
    else if(case == 3){#For trigrams:
        # We add a space to avoid the input being the last word of the n-gram:
        x3 <- trigram$ngrams[grep(paste0(inputString, " "), trigram$ngrams)][1]
        aux <- str_split(x3[1], " ")[[1]][3]

        if(is.na(x3)){#if no prediction can be done
            prediction <- " "
        }
        else{          #if prediction can be done
            prediction <- aux
        }
    }
    else if(case == 4){#For fourgrams:
        # We add a space to avoid the input being the last word of the n-gram:
        x4 <- fourgram$ngrams[grep(paste0(inputString, " "), fourgram$ngrams)][1]
        aux <- str_split(x4[1], " ")[[1]][4]

        if(is.na(x4)){#if no prediction can be done
            prediction <- " "
        }
        else{          #if prediction can be done
            prediction <- aux
        }
    }
    else if(case > 4){
        prediction <- longString(sepString, case-1)
    }
    return(prediction)
}



### Function to predict next word when the number of words of the input string is larger
### than 4:

longString <- function(sepString,nWords){
    library(stringr)

    testString <- paste(sepString[[1]][c((nWords-2):nWords)], collapse = " ")
    # We add a space to avoid the input being the last word of the n-gram:
    matches4 <- fourgram$ngrams[grep(paste0(testString, " "), fourgram$ngrams)][1]

    if(!is.na(matches4)){
        longstring <- str_split(matches4[1], " ")[[1]][4]
    }
    else{
        testString <- paste(sepString[[1]][c((nWords-1):nWords)], collapse = " ")
        # We add a space to avoid the input being the last word of the n-gram:
        matches3 <- trigram$ngrams[grep(paste0(testString, " "), trigram$ngrams)][1]
        if(!is.na(matches3)){
            longstring <- str_split(matches3[1], " ")[[1]][3]
        }
        else{
            testString <- paste(sepString[[1]][c(nWords)], collapse = " ")
            # We add a space to avoid the input being the last word of the n-gram:
            matches2 <- bigram$ngrams[grep(paste0(testString, " "), bigram$ngrams)][1]
            if(!is.na(matches2)){
                longstring <- str_split(matches2[1], " ")[[1]][2]
            }
            else{
                longstring <- " "
            }
        }
    }
}


prediction2 <- function(inputString){

    prediction2 <-bigram$ngrams[1]

}