

========================
#
#UNCOMMENT the lines below if you do have the packages already installed
#
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("splitstackshape")
#install.packages("nparcomp")
#install.packages("PMCMR")
#install.packages("afex")
=============================

#loads required packages
require(ggplot2)
require(plyr)
require(splitstackshape)
require(nparcomp)
require(PMCMR)
require(pastecs)
require(afex)

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

#create at DF with Average size for Each Site
y1sitemeansize<-ddply(y1size,.(Date,Site),summarise, mean_size=mean(Length.mm,na.rm=T))

#print it out
print(y1sitemeansize)

#produce some descriptive statistics using stat describe
y1sitestats<-ddply(y1size,.(Date, Site),summarise, stats=stat.desc(Length.mm)[c(9,10,11,12,13)])

#print it out, stats are in the order (mean, STD Error, 95% Confidence Interval, Variance, STD Deviation)
print(y1sitestats)

#now we need to create subsets for each site for out plant and end of year 1
outmany1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2013-08-16"&Site=="Manchester")
outfidy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2013-08-16"&Site=="Fidalgo")
outoysy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2013-08-16"&Site=="Oyster Bay")
endmany1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2014-10-24"&Site=="Manchester")
endfidy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2014-10-17"&Site=="Fidalgo")
endoysy1<-ddply(y1size,.(Length.mm,Pop,Tray,Sample,Area),subset,Date=="2014-09-19"&Site=="Oyster Bay")


#using ggplot2 to create Boxplots
tiff(file = "Endmansize.tiff", units="in", width=10, height=10, res = 600)
ggplot()+
  geom_boxplot(data=endmany1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_grey(start=0, end=0.9,guide=F)+
  scale_fill_grey(start=0, end=0.9, guide=F)+
  ylim(c(0,50))+
  labs(x="Population",y="Length (mm)")+
  scale_x_discrete(labels=c("Dabob Bay","Fidalgo Bay","Oyster Bay"))+
  annotate("text", x=c("4N","4H","4S"),y=50, label=c("A","B","A"),size=10)+
  theme_bw()+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))
dev.off()

tiff(file = "Endfidsize.tiff", units="in", width=10, height=10, res = 600)
ggplot()+
  geom_boxplot(data=endfidy1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_grey(start=0, end=0.9,guide=F)+
  scale_fill_grey(start=0, end=0.9, guide=F)+
  ylim(c(0,50))+
  labs(x="Population",y="Length (mm)")+
  scale_x_discrete(labels=c("Dabob Bay","Fidalgo Bay","Oyster Bay"))+
  annotate("text", x=c("2N","2H","2S"),y=50, label=c("A","B","A"),size=10)+
  theme_bw()+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))
dev.off()

tiff(file = "Endoyssize.tiff", units="in", width=10, height=10, res = 600)
ggplot()+
  geom_boxplot(data=endoysy1,aes(x=Pop,y=Length.mm,fill=Pop))+
  scale_colour_grey(start=0, end=0.9,guide=F)+
  scale_fill_grey(start=0, end=0.9, guide=F)+
  ylim(c(0,50))+
  labs(x="Population",y="Length (mm)")+
  scale_x_discrete(labels=c("Dabob Bay","Fidalgo Bay","Oyster Bay"))+
  annotate("text", x=c("1N","1H","1S"),y=50, label=c("B","A","A"),size=10)+
  theme_bw()+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))
dev.off()


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

#Brooder Size Data
broodersizes<-read.csv('./data/Brooder-sizes-2014.csv')
#Let R know what format dates are in
broodersizes$Date<-as.Date(broodersizes$Date,"%m/%d/%Y")

#Run ANOVA on Brooding female size
brdszaov<-aov(broodersizes$Size~broodersizes$Site+broodersizes$Population+broodersizes$Site:broodersizes$Population,broodersizes)
print(brdszaov)
summary(brdszaov)
#Run TukeyHSD post hoc on Brooding Female Sizes
tkbrdsz<-TukeyHSD(brdszaov)
print(tkbrdsz)

#Dotplot for Brooding Female Sizes
tiff(file = "broodsize.tiff", units="in", width=10, height=10, res = 600)
ggplot(broodersizes, aes(x=Site, fill=Population, y=Size))+
  geom_dotplot(binwidth=0.5,binaxis='y',stackdir="center", position=position_dodge(width=0.5))+
  scale_fill_grey(start=0, end=.9, labels=c("Dabob","Fidalgo","Oyster Bay"))+
  theme_bw()+
  labs(x="Site",y="Length (mm)")+
  scale_x_discrete(labels=c("Northern","Central","Southern"))+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20),
        legend.justification=c(0,1),
        legend.position=c(0,1), 
        legend.title=element_text(size=15),
        legend.text=element_text(size=15))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))
dev.off()
 
#mixed effects models with p-value generation
sizelme<-lmer(Length.mm~Pop2*Site+(~Pop2|Tray))
sizelme
sizep<-mixed(Length.mm~Pop2*Site+(Pop2|Tray),data=endy1)
sizep

