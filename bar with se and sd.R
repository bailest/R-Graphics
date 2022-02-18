df <- read.delim(".txt", header = TRUE)
library(ggplot2)
library(plyr)

#function to calculate standard deviation and slap it into the dataframe
#varname is your measurable variable (y axis), groupnames are your categorical variables
data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- plyr::rename(data_sum, c("mean" = varname))
  return(data_sum)
}
#using the function to add sd
sd <- data_summary(df, varname="", 
                          groupnames=c("", ""))


#function to calculate standard error and slap it into the data frame
data_error <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      se = sd(x[[col]])/sqrt(length(x)), na.rm=TRUE)
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- plyr::rename(data_sum, c("mean" = varname))
  return(data_sum)
}

#using the function to add standard error
se <- data_error(df, varname="", 
                        groupnames=c("", ""))

#paired bar plot with error bars using sd
#replace "y" in geom_errorbar with your y variable
ggplot(sd, aes(x=, y=, fill=)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  geom_errorbar(aes(ymin=y-sd, ymax=y+sd), width=.2, 
                position=position_dodge(.9)) +
  labs(x="x", y = "y") +
  scale_fill_brewer(palette="Paired") + 
  theme_minimal()
#with error bars using se
ggplot(se, aes(x=, y=, fill=)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  geom_errorbar(aes(ymin=y-se, ymax=y+se), width=.2, 
                position=position_dodge(.9)) +
  labs(x="x", y = "y") +
  scale_fill_brewer(palette="Paired") + 
  theme_minimal()