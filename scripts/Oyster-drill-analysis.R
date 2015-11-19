========================
#
#UNCOMMENT the lines below if you do have the packages already installed
#
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("dispmod")
#install.packages("lme4")

=============================

#loads required packages
require(lme4)
require(plyr)
require(ggplot2)
require(dispmod)

#set working directory
setwd("**your directory here**")

#reads in data csv
drill<-read.csv("./data/Drill-mortality-2013-2014.csv",header=T)

#tells R to register date notation as Dates
drill$Date<-as.factor(as.Date(drill$Date, "%m/%d/%Y"))

#creates summary of all drill data
drsum<-ddply(drill,.(Date,Pop),summarise,drill1shell=sum(Drill.1.Shell,na.rm=T),
             drill2shell=sum(Drill.2.shell,na.rm=T),
             nodrill1shell=sum(No.Drill.1,na.rm=T),
             nodrill2shell=sum(No.Drill.2,na.rm=T),
             drills=(drill1shell/2+drill2shell),
             nodrills=(nodrill1shell/2+nodrill2shell),
             N=round(drills+nodrills),
             prop=(drills/N))

#creates bargraph plot to visualize drill data
ggplot(drsum,aes(x=Date,y=prop,colour=Pop, fill=Pop))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_text(aes(label=N), color="black",
            stat="identity",position=position_dodge(width=0.9),
            vjust=-0.25)+
  scale_colour_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  scale_fill_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  theme_bw()+labs(x="Observation Date",y="Oysters with Drill Holes (proportion)")+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))+
  theme(legend.justification=c(0,1),
        legend.position=c(0,1),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20),
        legend.title=element_text(size=20),
        legend.text=element_text(size=20)) 
  

#runs a general linear model on drill data
drglm<-glm((cbind(round(drills),round(nodrills)))~Pop,family=binomial(logit),data=drsum)
summary(drglm)

#corrects for overdispersion in GLM
drglm.mod<-glm.binomial.disp(drglm)

