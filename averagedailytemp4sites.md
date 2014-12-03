    require(plyr)
    require(ggplot2)
    daby1edit<-read.csv("dabY1.csv")
    #reads in edited CSV to correct for outliers.
    daby1edit$Date<-as.Date(daby1edit$Date,"%m/%d/%Y")
    #Dates as DATES in r
    dabmeantemp<-ddply(daby1edit,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
    many1v3<-read.csv('many1v3_3.csv')
    many1v3$Date<-as.Date(many1v3$Date,"%m/%d/%Y")
    manmeantemp<-ddply(many1v3,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
    fidy1v3<-read.csv("fidy1v3.csv")
    #reads in editted temp file
    fidy1v3$Date<-as.Date(fidy1v3$Date,"%m/%d/%Y")
    #turns dates into DATES in r
    fidmeantemp<-ddply(fidy1v3,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
    oysy1edit<-read.csv("oysY1fixed.csv")
    #reads in edited oysy1 data
    oysy1edit$Date<-as.Date(oysy1edit$Date, "%m/%d/%Y")
    #Date as Dates in R
    oysmeantemp<-ddply(oysy1edit,.(Date),summarise,mean_temp=mean(Temp,na.rm=T),min_temp=min(Temp,na.rm=T),max_temp=max(Temp,na.rm=T))
    ggplot()+
      geom_line(data=dabmeantemp, aes(x=Date, y=mean_temp, group=1),col="forestgreen",size=1,guide=T)+
      geom_line(data=manmeantemp, aes(x=Date, y=mean_temp, group=1),col="blue",size=1)+
      geom_line(data=fidmeantemp, aes(x=Date, y=mean_temp, group=1),col="purple",size=1)+
      geom_line(data=oysmeantemp, aes(x=Date, y=mean_temp, group=1),col="orange",size=1)+
      labs(x="Date",y="Average Daily Temperature (C)")+
      theme_bw()

![plot of chunk
unnamed-chunk-1](./averagedailytemp4sites_files/figure-markdown_strict/unnamed-chunk-11.png)

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

![plot of chunk
unnamed-chunk-1](./averagedailytemp4sites_files/figure-markdown_strict/unnamed-chunk-12.png)

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

![plot of chunk
unnamed-chunk-1](./averagedailytemp4sites_files/figure-markdown_strict/unnamed-chunk-13.png)

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

![plot of chunk
unnamed-chunk-1](./averagedailytemp4sites_files/figure-markdown_strict/unnamed-chunk-14.png)
