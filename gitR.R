library(httr)
library(jsonlite)

options(stringsAsFactors = FALSE)

url<-"https://api.github.com"
path<-"/users/starship9"

raw.result<-GET(url=url, path=path)
#names(raw.result)

#head(raw.result)

this.raw.content<-rawToChar(raw.result$content)
#head(this.raw.content)

#nchar(this.raw.content)

this.json.content<-fromJSON(this.raw.content)
#head(this.json.content)

repoURL <- this.json.content$repos_url
repoRawData<-GET(url=repoURL)
#names(repoRawData)

#head(repoRawData$content)

repoContent<-rawToChar(repoRawData$content)
#head(repoContent)

repoJSON<-fromJSON(repoContent)
#head(repoJSON)

#class(repoJSON$language)

repoLanguages<-repoJSON$language
#repoLanguages
#class(repoLanguages)

repoNames<-repoJSON$name
#head(repoNames)
#repoNames
#class(repoNames)

library(dplyr)

repoLanguagesDF<-tbl_df(repoLanguages)
repoNamesDF<-tbl_df(repoNames)
#class(repoLanguagesDF)
#class(repoNamesDF)

#dim(repoLanguagesDF)
#dim(repoNamesDF)
#length(repoNamesDF)

#combining the previous data gathered
repoDataLN<-cbind(repoNamesDF, repoLanguagesDF)
#head(repoDataLN)
#View(repoDataLN)
#class(repoDataLN)
#repoDataLN
#class(repoDataLN)
#head(repoDataLN)

#Adding columns for easier manipulation
colnames(repoDataLN)<-c("Repos","Language")
#repoDataLN
#repoDataLN$Repos
languageCount<-plyr::count(repoDataLN$Language)
#class(languageCount)
#repoDataTable<-table(repoDataLN)
#repoDataTable
#tbl_df(repoDataTable)
#repoDataTable
#dim(repoDataTable)


#names(repoDataTable)
#repoLanguagesTable<-read.table(repoLanguages,header=TRUE,row.names=1)
#table(unlist(repoDataTable))

library(ggplot2)
ggplot(languageCount,aes(languageCount$x,languageCount$freq,fill=languageCount$x)) + geom_bar(stat="identity") + labs(x = "Language", y = "Count")
