require(plyr)
require(ggplot2)

#set working directory to local copy of repository
setwd<-("/Users/sr320/git-repos/Temp-Data-And-Scripts")

daby1edit<-read.csv("../data/dabY1.csv")
#reads in edited CSV with raw data.


daby1edit$Date<-as.Date(daby1edit$Date,"%m/%d/%Y")
#Tells R that the date column contains dates so it knows how to deal with them


dabmeantemp<-ddply(daby1edit,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
#finds the mean, minimum, and maximum daily temps from raw data and creates dataframe with them for Dabob

many1v3<-read.csv('../data/many1v3_3.csv')
#reads in edited CSV with raw data.

many1v3$Date<-as.Date(many1v3$Date,"%m/%d/%Y")
#Tells R that the date column contains dates so it knows how to deal with them


manmeantemp<-ddply(many1v3,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
#finds the mean, minimum, and maximum daily temps from raw data and creates dataframe with them for Manchester


fidy1v3<-read.csv("../data/fidy1v3.csv")
#reads in edited CSV with raw data.


fidy1v3$Date<-as.Date(fidy1v3$Date,"%m/%d/%Y")
#Tells R that the date column contains dates so it knows how to deal with them


fidmeantemp<-ddply(fidy1v3,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
#finds the mean, minimum, and maximum daily temps from raw data and creates dataframe with them for Fidalgo


oysy1edit<-read.csv("../data/oysY1fixed.csv")
#reads in edited CSV with raw data.


oysy1edit$Date<-as.Date(oysy1edit$Date, "%m/%d/%Y")
#Tells R that the date column contains dates so it knows how to deal with them


oysmeantemp<-ddply(oysy1edit,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
#finds the mean, minimum, and maximum daily temps from raw data and creates dataframe with them for Oyster Bay


ggplot()+
  geom_line(data=dabmeantemp, aes(x=Date, y=mean_temp, group=1),col="forestgreen",size=1,guide=T)+
  geom_line(data=manmeantemp, aes(x=Date, y=mean_temp, group=1),col="blue",size=1)+
  geom_line(data=fidmeantemp, aes(x=Date, y=mean_temp, group=1),col="purple",size=1)+
  geom_line(data=oysmeantemp, aes(x=Date, y=mean_temp, group=1),col="orange",size=1)+
  labs(x="Date",y="Average Daily Temperature (C)")+
  theme_bw()
#Creates a graph with each line representing average daily temps for each site


ggplot()+
  geom_line(data=dabmeantemp, aes(x=Date, y=mean_temp, group=1, colour="1"),size=1)+
  geom_line(data=manmeantemp, aes(x=Date, y=mean_temp, group=1, colour="2"),size=1)+
  geom_line(data=fidmeantemp, aes(x=Date, y=mean_temp, group=1, colour="3"),size=1)+
  geom_line(data=oysmeantemp, aes(x=Date, y=mean_temp, group=1, colour="4"),size=1)+
  geom_hline(aes(yintercept=12.5,colour="5"),size=1)+
  scale_colour_manual(values=c("forestgreen","blue","purple","orange","red"),
                      name="Site",
                      labels=c("Dabob Bay","Manchester","Fidalgo Bay","Oyster Bay","Spawn Thresh"))+
  labs(x="Date",y="Average Daily Temperature (C)")+
  theme_bw()+
  theme(legend.position=c(0.13,0.15),
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.y=element_text(size=20))
#Creates a graph with each line representing average daily temps for each site also adds red line to indicate Spawning threshold


ggplot()+
  geom_line(data=dabmeantemp, aes(x=Date, y=min_temp, group=1, colour="1"),size=1)+
  geom_line(data=manmeantemp, aes(x=Date, y=min_temp, group=1, colour="2"),size=1)+
  geom_line(data=fidmeantemp, aes(x=Date, y=min_temp, group=1, colour="3"),size=1)+
  geom_line(data=oysmeantemp, aes(x=Date, y=min_temp, group=1, colour="4"),size=1)+
  scale_colour_manual(values=c("forestgreen","blue","purple","orange"),
                      name="Site",
                      labels=c("Dabob Bay","Manchester","Fidalgo Bay","Oyster Bay","Spawn Thresh"))+
  labs(x="Date",y="Minimum Daily Temperature (C)")+
  theme_bw()+
  theme(legend.position=c(0.13,0.18),
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.y=element_text(size=20))
#Creates a graph with each line representing observed minimum daily temps for each site


ggplot()+
  geom_line(data=dabmeantemp, aes(x=Date, y=max_temp, group=1, colour="1"),size=1)+
  geom_line(data=manmeantemp, aes(x=Date, y=max_temp, group=1, colour="2"),size=1)+
  geom_line(data=fidmeantemp, aes(x=Date, y=max_temp, group=1, colour="3"),size=1)+
  geom_line(data=oysmeantemp, aes(x=Date, y=max_temp, group=1, colour="4"),size=1)+
  scale_colour_manual(values=c("forestgreen","blue","purple","orange"),
                      name="Site",
                      labels=c("Dabob Bay","Manchester","Fidalgo Bay","Oyster Bay","Spawn Thresh"))+
  labs(x="Date",y="Maximum Daily Temperature (C)")+
  theme_bw()+
  theme(legend.position=c(0.25,0.8),
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.y=element_text(size=20))
#Creates a graph with each line representing observed maximum daily temps for each site


rmarkdown::render("avgtemp4site.R","md_document")
