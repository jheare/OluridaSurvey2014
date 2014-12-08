#install.packages("RVAideMemoire")
#install.packages("multcomp")

#loads required packages
require(survival)
require(RVAideMemoire)
require(multcomp)

#reads in  Kaplan Meier formatted survival data
kmdab=read.csv("KMdataDabob.csv")

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
plot(fit1,xlim=c(0,11), col=c("#3366CC","#CC66CC","#FF9900"), xlab="Survival Time from Outplant in Months", ylab="% Surviving", lwd=2)
legend("bottomleft", title="Population", c("Dabob","Fidalgo","Oyster Bay"), fill=c("#3366CC","#CC66CC","#FF9900"))


#reads in  Kaplan Meier formatted survival data
kmman=read.csv("KMdataMan.csv")

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
plot(fit2, col=c("#3366CC","#CC66CC","#FF9900"), xlab="Survival Time from Outplant in Months", ylab="% Surviving", lwd=2)
legend("bottomleft", title="Population", c("Dabob","Fidalgo","Oyster Bay"), fill=c("#3366CC","#CC66CC","#FF9900"))

#reads in  Kaplan Meier formatted survival data
kmfid=read.csv("KMdataFid.csv")

#Finds the mean and variance for each population at site
with(kmfid, tapply(Death[Status==1],Population[Status==1],mean))
with(kmfid, tapply(Death[Status==1],Population[Status==1],var))

#Generates summary statistics and survival info for Kaplan Meier
fit3=with(kmfid, survfit(Surv(Death,Status)~Population))

#Shows summary statistics for Survival
summary(fit3)

#Plots Kaplan Meier graph
plot(fit3, col=c("#3366CC","#CC66CC","#FF9900"), xlab="Survival Time from Outplant in Months", ylab="% Surviving", lwd=2)
legend("bottomleft", title="Population", c("Dabob","Fidalgo","Oyster Bay"), fill=c("#3366CC","#CC66CC","#FF9900"))

#reads in  Kaplan Meier formatted survival data
kmoys=read.csv("KMdataOys.csv")

#Finds the mean and variance for each population at site
with(kmoys, tapply(Death[Status==1],Population[Status==1],mean))
with(kmoys, tapply(Death[Status==1],Population[Status==1],var))

#Generates summary statistics and survival info for Kaplan Meier
fit4=with(kmoys, survfit(Surv(Death,Status)~Population))

#Shows summary statistics for Survival
summary(fit4)

#Plots Kaplan Meier graph
plot(fit4, col=c("#3366CC","#CC66CC","#FF9900"), xlab="Survival Time from Outplant in Months", ylab="% Surviving", lwd=2)
legend("bottomleft", title="Population", c("Dabob","Fidalgo","Oyster Bay"), fill=c("#3366CC","#CC66CC","#FF9900"))

#calculates p-values for differences in Survival between groups
mansurv<-survdiff(Surv(Death,Status)~Population,data=kmman,rho=1)

#prints survdiff statistics to show significant differences between groups
print(mansurv)

#calculates p-values for differences in Survival between groups
dabsurv<-survdiff(Surv(Death,Status)~Population,data=kmdab)

#prints survdiff statistics to show significant differences between groups
print(dabsurv)

#calculates p-values for differences in Survival between groups
fidsurv<-survdiff(Surv(Death,Status)~Population,data=kmfid)

#prints survdiff statistics to show significant differences between groups
print(fidsurv)

#calculates p-values for differences in Survival between groups
oyssurv<-survdiff(Surv(Death,Status)~Population,data=kmoys)

#prints survdiff statistics to show significant differences between groups
print(oyssurv)