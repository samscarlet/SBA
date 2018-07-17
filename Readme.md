# SBA: Semantic Behavior Analisys

# About SBA

"SBA" is a web system for  sentiment analisys of social networks through the comments. The methodology implements an knowledge base, graph theory, semantic processing.This repository containts the results obtained by the methodology implemented.
The main developer / maintainer is Julio Vizcarra(vzro@hotmail.com).

# Features
- Sentiment Analysis.
- Semantic Processing.
- Disambiguation process.
- Knowledge base expansion.

# Documents

- Resultant datasets computed by the methodology:
  - Datasets produced by the desambiguation : 10 experiments using only lexical processing choosing random senses.
  - Datasets produced by Sentiment analisys on Twitter.
  - Datasets produced by Sentiment analisys on Amazon Reviews.

# Folder Structure
- AutomaticExperimentsAmazonReviews. Folder with results of the methodology on Amazon reviews.
- DisambiguationExperiments. Folder with results of the methodology comparong disamgiguation: 
  - LexRandom[1-10]. 10 experiments using only lexical processing in 10 subfolders.
  - AutoLex. Experiment using disambiguation automatic weights in semantic relations
  - ManualLex. Experiment using disambiguation manual weights in semantic relations
  - ManualExperimentsonTwitter. Manual labeling of sentiment on comments obtained from Twitter. it is presented a xls file with the results of the methodology and our labeling alongside the curves of precision,recall and F-measure.
    
# Data files structure (results of the methodology)
  -results.txt(file that contains the results obtained by the methodology) Format [number of comment|Amazon Reviews score (label_1:1-2starts,Label_2:4-5starts)|Polarity_Value|NRS_Sentiment|(flag if methodology was correct 1:true,0:false)|Text of the Comment ]
  -statisticsPol.txt(Precision,Recall,Fmeasure using only Polarity) if Polarity is positive and comment label_label=2 results is correct:1,if Polarity is negative and comment label_label=1 implies correct:1, other cases 0, curves or performance format: number of comment|Acuraccy|Precision|Recall|F-Measure  
  -statisticsPolSSA.txt(Precision,Recall,Fmeasure using only Sentiment label) if Sentiment is (Joy,Anticipation,Trust,Surprise) and comment label_label=2 results is correct:1,if sentiment is (Sadness,anger,disgust,fear)and comment label_label=1 implies correct:1, other cases 0, curves or performance format: number of comment|Acuraccy|Precision|Recall|F-Measure  
# References

-