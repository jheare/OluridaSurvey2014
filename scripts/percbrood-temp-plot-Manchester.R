#install.packages("plyr")
#install.packages("ggplot2")
#install.packages("scales")
#install.packages("grid")
#install.packages("gtable")

#Loads required packages
require(plyr)
require(ggplot2)
require(scales)
require(grid)
require(gtable)

#set working directory
setwd("/Users/sr320/git-repos/Temp-Data-And-Scripts")

#read in brood numbers csv with all brooding data
brood<-read.csv("./data/Brood-numbers-all-2014.csv")

#Make sure dates are understood to be Dates
brood$Date<-as.Date(brood$Date, "%m/%d/%Y")

#subset only the data for Manchester
manrep<-subset(brood, Site=="Manchester")

#The script below creates an object out of the percent brooding graph which will be stitched to the
#temperature graph we will create to make a double Y axis graph.


grid.newpage()
p1<-ggplot(data=manrep, aes(x=Date, weight=Percent, colour=Pop, fill=Pop))+
  geom_bar(binwidth=3, position=position_dodge())+
  ylim(c(0,20))+
  theme(axis.text.x=element_text(angle=90, size=10, vjust=0.5))+
  scale_colour_manual(values=c("blue","purple","orange"),labels=c("Dabob","Fidalgo","Oyster Bay"))+
  scale_fill_manual(values=c("blue","purple","orange"),labels=c("Dabob","Fidalgo","Oyster Bay"))+
  labs(x="Sample Date", y="Percent Brooding")+
  theme_bw()+
  theme(legend.justification=c(0,1),
        legend.position=c(0,1),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20),
        legend.title=element_text(size=20),
        legend.text=element_text(size=20))



#reads in temperature csv for Manchester
manch<-read.csv('./data/Manchester-temp-2014.csv')

#Makes sure Dates are understood as Dates 
manch$Date<-as.Date(manch$Date,"%m/%d/%Y")

#Finds daily minimum temps for Manchester
manmintemp<-ddply(manch,.(Date),summarise,min_temp=min(Temp,na.rm=T))

#Subsets temperature data for our sampling period
manmintemprep<-subset(manmintemp, Date>="2014-04-30"& Date<="2014-08-06")

#creates an object out of our temperature data graph that will be overlaid on the percent brooding graph
p2<-ggplot()+geom_line(data=manmintemprep,
                       aes(x=Date, y=min_temp), color="red")+
  ylim(c(8,18))+
  theme_bw() %+replace% 
  theme(panel.background = element_rect(fill = NA),
        panel.grid.major.x=element_blank(),
        panel.grid.minor.x=element_blank(),
        panel.grid.major.y=element_blank(),
        panel.grid.minor.y=element_blank(),
        axis.text.y=element_text(size=20,color="red"),
        axis.title.y=element_text(size=20))


#this code tells R to overlay the temperature graph on the percent brooding graph
g1<-ggplot_gtable(ggplot_build(p1))
g2<-ggplot_gtable(ggplot_build(p2))

pp<-c(subset(g1$layout,name=="panel",se=t:r))
g<-gtable_add_grob(g1, g2$grobs[[which(g2$layout$name=="panel")]],pp$t,pp$l,pp$b,pp$l)

ia<-which(g2$layout$name=="axis-l")
ga <- g2$grobs[[ia]]
ax <- ga$children[[2]]
ax$widths <- rev(ax$widths)
ax$grobs <- rev(ax$grobs)
ax$grobs[[1]]$x <- ax$grobs[[1]]$x - unit(1, "npc") + unit(0.15, "cm")
g <- gtable_add_cols(g, g2$widths[g2$layout[ia, ]$l], length(g$widths) - 1)
g <- gtable_add_grob(g, ax, pp$t, length(g$widths) - 1, pp$b)


#generates the final graph
grid.draw(g)
