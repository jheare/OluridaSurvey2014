

========================
#
#UNCOMMENT the lines below if you do have the packages already installed
#
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("splitstackshape")
#install.packages("nparcomp")
#install.packages("PMCMR")
=============================
  
#loads required packages
require(ggplot2)
require(plyr)
require(splitstackshape)
require(nparcomp)
require(PMCMR)

#set working directory
setwd("**your directory here**")

#creates dataframe and reads in the CSV file for sizes
y1size=read.csv('./data/Size-outplant-end-all-2013-14.csv')

#check data
View(y1size)

#make R understand dates
y1size$Date<-as.Date(y1size$Date, "%m/%d/%Y")

#create table of ave size for outplant and year one for each pop at each site
y1meansize<-ddply(y1size,.(Date,Site,Pop),summarise, mean_size=mean(Length.mm,na.rm=T))

#print it out
print(y1meansize)


#now we need to create subsets for each site for out plant and end of year 1
outmany1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2013-08-16"&Site=="Manchester")
outfidy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2013-08-16"&Site=="Fidalgo")
outoysy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2013-08-16"&Site=="Oyster Bay")
endmany1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2014-10-24"&Site=="Manchester")
endfidy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2014-10-17"&Site=="Fidalgo")
endoysy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2014-09-19"&Site=="Oyster Bay")


#using ggplot2 to create Boxplots
ggplot()+
  geom_boxplot(data=outmany1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_manual(values=c("blue","purple","orange"))+
  scale_fill_manual(values=c("blue","purple","orange"))

ggplot()+
  geom_boxplot(data=endmany1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_manual(values=c("blue","purple","orange"),guide=F)+
  scale_fill_manual(values=c("blue","purple","orange"), guide=F)+
  ylim(c(0,50))+
  labs(x="Population",y="Length (mm)")+
  scale_x_discrete(labels=c("Dabob","Fidalgo","Oyster Bay"))+
  annotate("text", x=c("4N","4H","4S"),y=50, label=c("A","B","A"),size=10)+
  theme_bw()+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))

ggplot()+
  geom_boxplot(data=outfidy1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_manual(values=c("blue","purple","orange"))+
  scale_fill_manual(values=c("blue","purple","orange"))

ggplot()+
  geom_boxplot(data=endfidy1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_manual(values=c("blue","purple","orange"),guide=F)+
  scale_fill_manual(values=c("blue","purple","orange"),guide=F)+
  ylim(c(0,50))+
  labs(x="Population",y="Length (mm)")+
  scale_x_discrete(labels=c("Dabob","Fidalgo","Oyster Bay"))+
  annotate("text", x=c("2N","2H","2S"),y=50, label=c("A","B","A"),size=10)+
  theme_bw()+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))

ggplot()+
  geom_boxplot(data=outoysy1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_manual(values=c("blue","purple","orange"))+
  scale_fill_manual(values=c("blue","purple","orange"))

ggplot()+
  geom_boxplot(data=endoysy1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_manual(values=c("blue","purple","orange"),guide=F)+
  scale_fill_manual(values=c("blue","purple","orange"),guide=F)+
  ylim(c(0,50))+
  labs(x="Population",y="Length (mm)")+
  scale_x_discrete(labels=c("Dabob","Fidalgo","Oyster Bay"))+
  annotate("text", x=c("1N","1H","1S"),y=50, label=c("B","A","A"),size=10)+
  theme_bw()+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))


#Check Data for Normality
normality<-ddply(y1size,.(Date,Site,Pop),summarize,n=length(Length.mm),sw=shapiro.test(as.numeric(Length.mm))[2])
#Data is not normally distributed based on P-Values from Shapiro Wilkes test.

#Create New column with Pop labels for analysis
y1size$Pop2<-y1size$Pop
y1size$Pop2<-revalue(y1size$Pop2,c("1H"="H","2H"="H","4H"="H","1N"="N","2N"="N","4N"="N","1S"="S","2S"="S","4S"="S"))


#Here we subset the data set to only include data from the end of year 1
endy1<-ddply(y1size,.(Length.mm,Site,Pop,Tray,Sample,Area,Pop2),subset,Date>="2014-09-19")

#check for Normality again
normality<-ddply(endy1,.(Date,Site,Pop),summarize,n=length(Length.mm),sw=shapiro.test(as.numeric(Length.mm))[2])
#Still Not normal, must use nonparametric test. 


#using size data from the final sampling for Kruskal Wallis test to compare size versus site
sizekw<-kruskal.test(endy1$Length.mm~endy1$Site,endy1)
print(sizekw)

#using size data from the final sampling for Kruskal Wallis test to compare size versus Population
sizekwpop<-kruskal.test(endy1$Length.mm~endy1$Pop2,endy1)
print(sizekwpop)


#Using the size data to produce a Post Hoc Nemenyi Test to generate p-values for each comparison for Size vs Site
sizenemenyi1<-posthoc.kruskal.nemenyi.test(x=endy1$Length.mm,g=endy1$Site, method="Tukey")
sizenemenyi1

#Using the size data to produce a Post Hoc Nemenyi Test to generate p-values for each comparison for Size vs Population
sizenemenyi2<-posthoc.kruskal.nemenyi.test(x=endy1$Length.mm,g=endy1$Pop2, method="Tukey")
sizenemenyi2


#Using the size data to produce a Post Hoc Nemenyi Test to generate p-values for each comparison for Size vs Site/Population Interaction
sizenemenyi3<-posthoc.kruskal.nemenyi.test(x=endy1$Length.mm,g=endy1$Site:endy1$Pop2, method="Tukey")
sizenemenyi3


