========================
#
#UNCOMMENT the lines below if you do have the packages already installed
#
#install.packages("RVAideMemoire")
#install.packages("multcomp")
============================  

#loads required packages
require(survival)
require(RVAideMemoire)
require(multcomp)

setwd("**your directory here**")

#reads in  Kaplan Meier formatted survival data
kmdab=read.csv("./data/KMdataDabob.csv")

#shows names
names(kmdab) 

#Finds the mean and variance for each population at site
with(kmdab, tapply(Death[Status==1],Population[Status==1],mean))
with(kmdab, tapply(Death[Status==1],Population[Status==1],var))

#Generates summary statistics and survival info for Kaplan Meier
fit1=with(kmdab,survfit(Surv(Death,Status)~Population))

#Shows summary statistics for Survival
summary(fit1)

#Plots Kaplan Meier graph
plot(fit1,xlim=c(0,11), col=c("blue","purple","orange"), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving", lwd=10)
legend("bottomleft", title="Population", c("Hood Canal","Northern","Southern"), fill=c("blue","purple","orange"))


#reads in  Kaplan Meier formatted survival data
kmman=read.csv("./data/KMdataMan.csv")

#shows names
names(kmman)

#Finds the mean and variance for each population at site
with(kmman, tapply(Death[Status==1],Population[Status==1],mean))
with(kmman, tapply(Death[Status==1],Population[Status==1],var))

#Generates summary statistics and survival info for Kaplan Meier
fit2=with(kmman, survfit(Surv(Death,Status)~Population))

#Shows summary statistics for Survival
summary(fit2)

#Plots Kaplan Meier graph
plot(fit2, col=c("blue","purple","orange"), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving", lwd=2)


#reads in  Kaplan Meier formatted survival data
kmfid=read.csv("./data/KMdataFid.csv")

#Finds the mean and variance for each population at site
with(kmfid, tapply(Death[Status==1],Population[Status==1],mean))
with(kmfid, tapply(Death[Status==1],Population[Status==1],var))

#Generates summary statistics and survival info for Kaplan Meier
fit3=with(kmfid, survfit(Surv(Death,Status)~Population))

#Shows summary statistics for Survival
summary(fit3)

#Plots Kaplan Meier graph
plot(fit3, col=c("blue","purple","orange"), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving", lwd=2)


#reads in  Kaplan Meier formatted survival data
kmoys=read.csv("./data/KMdataOys.csv")

#Finds the mean and variance for each population at site
with(kmoys, tapply(Death[Status==1],Population[Status==1],mean))
with(kmoys, tapply(Death[Status==1],Population[Status==1],var))

#Generates summary statistics and survival info for Kaplan Meier
fit4=with(kmoys, survfit(Surv(Death,Status)~Population))

#Shows summary statistics for Survival
summary(fit4)

#Plots Kaplan Meier graph
plot(fit4, col=c("blue","purple","orange"), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving", lwd=10)


#Summary of Survival Information
mansum<-summary(survfit(Surv(Death,Status)~Population,data=kmman))
print(mansum)

#calculates p-values for differences in Survival between groups
mansurv<-survdiff(Surv(Death,Status)~Population,data=kmman,rho=1)
#prints survdiff statistics to show significant differences between groups
print(mansurv)

#Summary of Survival Information
dabsum<-summary(survfit(Surv(Death,Status)~Population,data=kmdab))
print(dabsum)

#calculates p-values for differences in Survival between groups
dabsurv<-survdiff(Surv(Death,Status)~Population,data=kmdab)

#prints survdiff statistics to show significant differences between groups
print(dabsurv)

#calculates p-values for differences in Survival between groups
fidsurv<-survdiff(Surv(Death,Status)~Population,data=kmfid)

#prints survdiff statistics to show significant differences between groups
print(fidsurv)

#Summary of Survival Information
fidsum<-summary(survfit(Surv(Death,Status)~Population,data=kmfid))
print(fidsum)

#calculates p-values for differences in Survival between groups
oyssurv<-survdiff(Surv(Death,Status)~Population,data=kmoys)

#prints survdiff statistics to show significant differences between groups
print(oyssurv)

#Summary of Survival Information
oyssum<-summary(survfit(Surv(Death,Status)~Population,data=kmoys))
print(oyssum)

#Exploratory Statistics for all data
kmall=read.csv("./data/KMdataAll.csv")
names(kmall)

allfit<-coxph(Surv(Death,Status)~Site+Population+Site:Population,data=kmall)
thingy<-cox.zph(allfit)
plot(thingy[5])
allaov<-anova(allfit)

allaov
summary(allfit)

allsurv<-survdiff(Surv(Death,Status)~Site+Population,data=kmall)
print(allsurv)
plot(allsurv)
fitall2=(Surv(Death,Status)~as.factor(Site)+as.factor(Population),data=kmall)
anova(fitall2)
TukeyHSD(allfit)


#Code for developing publication quality figures.
tiff(file = "survsiteA.tiff", units="in", width=10, height=10, res = 600)
plot(fit1,xlim=c(0,11), col=gray.colors(3,start=0, end=0.9), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving",cex.axis=2,cex.lab=1.5,lwd=10)
legend("bottomleft", title="Population", c("Hood Canal","Northern","Southern"), fill=gray.colors(3,start=0, end=0.9))
text(0.8, 0.8, "C", cex=6)
text(7, 0.7, "a", cex=2)
text(7, 0.52, "b", cex=2)
text(7, 0.33, "c", cex=2)
dev.off()
tiff(file = "survsiteb.tiff", units="in", width=10, height=10, res = 600)
plot(fit2, col=gray.colors(3,start=0, end=0.9), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving",cex.axis=2,cex.lab=1.5,lwd=10)
text(0.8, 0.8, "B", cex=6)
text(11, 1.01, "a", cex=2)
dev.off()
tiff(file = "survsiteC.tiff", units="in", width=10, height=10, res = 600)
plot(fit3, col=gray.colors(3,start=0, end=0.9), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving",cex.axis=2,cex.lab=1.5,lwd=10)
text(0.8, 0.8, "D", cex=6)
dev.off()
tiff(file = "survsited.tiff", units="in", width=10, height=10, res = 600)
plot(fit4, col=gray.colors(3,start=0, end=0.9), xlab="Survival Time from Outplant in Months", ylab="Proportion Surviving",cex.axis=2,cex.lab=1.5,lwd=10)
text(0.8, 0.8, "A", cex=6)
text(11, 0.8, "a", cex=2)
text(11, 0.63, "b", cex=2)
text(11, 0.48, "c", cex=2)
dev.off()
