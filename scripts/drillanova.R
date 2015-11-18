install.packages("dispmod")
require(lme4)
require(plyr)
require(ggplot2)
require(dispmod)


drill<-read.csv("./data/Drill.csv",header=T)

drill$Date<-as.factor(as.Date(drill$Date, "%m/%d/%Y"))

drsum<-ddply(drill,.(Date,Pop),summarise,drill1shell=sum(Drill.1.Shell,na.rm=T),
             drill2shell=sum(Drill.2.shell,na.rm=T),
             nodrill1shell=sum(No.Drill.1,na.rm=T),
             nodrill2shell=sum(No.Drill.2,na.rm=T),
             drills=(drill1shell/2+drill2shell),
             nodrills=(nodrill1shell/2+nodrill2shell),
             N=round(drills+nodrills),
             prop=(drills/N))

drsum$Date<-as.Date(drsum$Date, "%Y-%m-%d")

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
  

drill$prop<-drill$Total.Drill.Oyster/(drill$Total.Drill.Oyster+drill$Total.No.Drill.Oysters)

is.factor(drill$Tray)

drillaov<-aov(drill$prop~drill$Pop+drill$Date+drill$Pop:drill$Date,drill)
summary(drillaov)
TukeyHSD(drillaov)

model1<-lm(drill$prop~drill$Pop*drill$Date)
summary(model1)

model2<-lmer(drill$prop~drill$Pop+(1|drill$Date))
summary(model2)

model3<-lmer(drill$prop~drill$Pop+(1|drill$Date)+(1|drill$Tray))
summary(model3)

anova(model2,model3)

drglm<-glm((cbind(round(drills),round(nodrills)))~Pop,family=binomial(logit),data=drsum)
summary(drglm,dispersion=1.44627,correlation=T,symbolic.cor=T)
summary(drglm)
drglm.mod<-glm.binomial.disp(drglm)


ggplot(drill,aes(x=Date,y=prop,colour=Pop, fill=Pop))+geom_bar(stat="identity",position=position_dodge())
